// Material Separator 1.0.0
//----------------------------------------------------------------
// Window/_lil/Material Separator
// 1. Open material separator window (Window/_lil/Material Separator)
// 2. Select mesh from scene
// 3. Select target material
// 4. Select mask texture  
//    white: copy  
//    black: separate
// 5. Press run button
// 6. Save generated mesh

#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;

public class MaterialSeparator : EditorWindow
{
    static Texture2D maskMap;
    static GameObject gameObject;
    static Mesh sharedMesh;
    static int materialID;

    [MenuItem("Window/_lil/Material Separator")]
    static void Init()
    {
        MaterialSeparator window = (MaterialSeparator)EditorWindow.GetWindow(typeof(MaterialSeparator), false, "Material Separator");
        window.Show();
    }

    void OnGUI()
    {
        gameObject = (GameObject)EditorGUILayout.ObjectField("Mesh", gameObject, typeof(GameObject), true);
        if(gameObject == null) return;

        // Get mesh data
        MeshFilter meshFilter = gameObject.GetComponent<MeshFilter>();
        MeshRenderer meshRenderer = gameObject.GetComponent<MeshRenderer>();
        SkinnedMeshRenderer skinnedMeshRenderer = gameObject.GetComponent<SkinnedMeshRenderer>();
        Material[] materials = null;
        if(meshFilter == null && skinnedMeshRenderer == null)
        {
            EditorGUILayout.HelpBox("This gameobject does not have mesh.", MessageType.Warning);
            return;
        }
        else if(AssetDatabase.Contains(gameObject))
        {
            EditorGUILayout.HelpBox("Select gameobject from scene.", MessageType.Warning);
            return;
        }
        else if(meshFilter != null)
        {
            sharedMesh = meshFilter.sharedMesh;
            if(meshRenderer != null) materials = meshRenderer.sharedMaterials;
        }
        else
        {
            sharedMesh = skinnedMeshRenderer.sharedMesh;
            materials = skinnedMeshRenderer.sharedMaterials;
        }

        // Select sub mesh
        string[] subMeshNames = new string[sharedMesh.subMeshCount];
        for(int i = 0; i < sharedMesh.subMeshCount; i++)
        {
            if(i < materials.Length && materials[i] != null)
                subMeshNames[i] = materials[i].name;
        }
        materialID = EditorGUILayout.Popup("Target Material", materialID, subMeshNames);
        maskMap = (Texture2D)EditorGUILayout.ObjectField("Mask Texture", maskMap, typeof(Texture2D), false);

        if(GUILayout.Button("Run"))
        {
            SeparateMaterial();
        }

        // Save
        GameObject newObject = null;
        if(gameObject.transform.parent != null)
        {
            for(int i = 0; i < gameObject.transform.parent.childCount; i++)
            {
                GameObject childObject = gameObject.transform.parent.GetChild(i).gameObject;
                if(childObject.name.Contains(gameObject.name + " (Separated)"))
                {
                    newObject = childObject;
                    break;
                }
            }
        }
        else
        {
            newObject = GameObject.Find(gameObject.name + " (Separated)");
        }
        if(newObject == null)
        {
            return;
        }

        MeshFilter newMeshFilter = newObject.GetComponent<MeshFilter>();
        MeshRenderer newMeshRenderer = newObject.GetComponent<MeshRenderer>();
        SkinnedMeshRenderer newSkinnedMeshRenderer = newObject.GetComponent<SkinnedMeshRenderer>();
        Mesh newMesh;
        if(newMeshFilter != null)
        {
            newMesh = newMeshFilter.sharedMesh;
        }
        else
        {
            newMesh = newSkinnedMeshRenderer.sharedMesh;
        }

        if(GUILayout.Button("Save"))
        {
            string path = "Assets/";
            if(AssetDatabase.Contains(newMesh))
            {
                path = AssetDatabase.GetAssetPath(newMesh);
                if(String.IsNullOrEmpty(path)) path = "Assets/";
                else path = Path.GetDirectoryName(path);
            }
            path = EditorUtility.SaveFilePanel("Save Mesh", path, newMesh.name, "asset");
            if(String.IsNullOrEmpty(path))
            {
                return;
            }
            AssetDatabase.CreateAsset(newMesh, FileUtil.GetProjectRelativePath(path));
            return;
        }
    }

    static void SeparateMaterial()
    {
        MeshFilter meshFilter = gameObject.GetComponent<MeshFilter>();
        MeshRenderer meshRenderer = gameObject.GetComponent<MeshRenderer>();
        SkinnedMeshRenderer skinnedMeshRenderer = gameObject.GetComponent<SkinnedMeshRenderer>();

        var indices = new List<int>[sharedMesh.subMeshCount+1];
        Texture2D maskMapCopy = maskMap;
        GetReadableTexture(ref maskMapCopy);
        int[] index = new int[3];
        float[] maskValue = new float[3];

        // Generate indices
        indices[sharedMesh.subMeshCount] = new List<int>();
        for(int mi = 0; mi < sharedMesh.subMeshCount; mi++)
        {
            indices[mi] = new List<int>();
            int[] sharedIndices = sharedMesh.GetIndices(mi);
            if(mi != materialID)
            {
                indices[mi] = new List<int>(sharedIndices);
                continue;
            }

            int polys = sharedIndices.Length / 3;
            for(int i = 0; i < polys; ++i)
            {
                for(int j = 0; j < 3; j++)
                {
                    index[j] = sharedIndices[i * 3 + j];
                    maskValue[j] = maskMapCopy.GetPixelBilinear(sharedMesh.uv[index[j]].x, sharedMesh.uv[index[j]].y).r;
                }

                int addID = maskValue[0] > 0.5f && maskValue[1] > 0.5f && maskValue[2] > 0.5f ? sharedMesh.subMeshCount : mi;
                indices[addID].Add(index[0]);
                indices[addID].Add(index[1]);
                indices[addID].Add(index[2]);
            }
        }

        // Generate mesh
        var mesh = Instantiate(sharedMesh);
        mesh.name = sharedMesh.name + " (Separated)";

        mesh.subMeshCount = sharedMesh.subMeshCount + 1;
        for(int i = 0; i < mesh.subMeshCount; i++)
        {
            int[] indicesArray = indices[i].ToArray();
            mesh.SetIndices(indicesArray, MeshTopology.Triangles, i);
        }

        // Generate new gameobject
        GameObject newObject = null;
        if(gameObject.transform.parent != null)
        {
            for(int i = 0; i < gameObject.transform.parent.childCount; i++)
            {
                GameObject childObject = gameObject.transform.parent.GetChild(i).gameObject;
                if(childObject.name.Contains(gameObject.name + " (Separated)"))
                {
                    newObject = childObject;
                    break;
                }
            }
        }
        else
        {
            newObject = GameObject.Find(gameObject.name + " (Separated)");
        }
        if(newObject == null)
        {
            newObject = Instantiate(gameObject);
            newObject.name = gameObject.name + " (Separated)";
            newObject.transform.parent = gameObject.transform.parent;
        }

        // Set new mesh
        MeshFilter newMeshFilter = newObject.GetComponent<MeshFilter>();
        MeshRenderer newMeshRenderer = newObject.GetComponent<MeshRenderer>();
        SkinnedMeshRenderer newSkinnedMeshRenderer = newObject.GetComponent<SkinnedMeshRenderer>();
        if(meshFilter != null)
        {
            newMeshFilter.sharedMesh = mesh;
            Material[] materials = new Material[meshRenderer.sharedMaterials.Length+1];
            for(int i = 0; i < meshRenderer.sharedMaterials.Length; i++)
            {
                materials[i] = meshRenderer.sharedMaterials[i];
            }
            newMeshRenderer.sharedMaterials = materials;
        }
        else
        {
            newSkinnedMeshRenderer.sharedMesh = mesh;
            Material[] materials = new Material[skinnedMeshRenderer.sharedMaterials.Length+1];
            for(int i = 0; i < skinnedMeshRenderer.sharedMaterials.Length; i++)
            {
                materials[i] = skinnedMeshRenderer.sharedMaterials[i];
            }
            newSkinnedMeshRenderer.sharedMaterials = materials;
        }
    }

    static void GetReadableTexture(ref Texture2D tex)
    {
        #if UNITY_2018_3_OR_NEWER
        if(!tex.isReadable)
        #endif
        {
            RenderTexture bufRT = RenderTexture.active;
            RenderTexture texR = RenderTexture.GetTemporary(tex.width, tex.height, 0, RenderTextureFormat.Default, RenderTextureReadWrite.Linear);
            Graphics.Blit(tex, texR);
            RenderTexture.active = texR;
            tex = new Texture2D(texR.width, texR.height);
            tex.ReadPixels(new Rect(0, 0, texR.width, texR.height), 0, 0);
            tex.Apply();
            RenderTexture.active = bufRT;
            RenderTexture.ReleaseTemporary(texR);
        }
    }
}
#endif