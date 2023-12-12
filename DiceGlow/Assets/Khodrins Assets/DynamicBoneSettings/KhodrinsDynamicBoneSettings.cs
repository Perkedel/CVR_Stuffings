using System.Collections.Generic;
using UnityEngine;

namespace KhodrinsAssets.Tools
{
    [System.Serializable]
    public class KhodrinsDynamicBoneSettings
    {
        public KhodrinsDynamicBoneSettingsTransform placement = new KhodrinsDynamicBoneSettingsTransform();
        public KhodrinsDynamicBoneSettingsTransform m_Root = new KhodrinsDynamicBoneSettingsTransform();

        public float m_UpdateRate = 60.0f;

        public DynamicBone.UpdateMode m_UpdateMode = DynamicBone.UpdateMode.Normal;

        public float m_Damping = 0.1f;
        public AnimationCurve m_DampingDistrib = null;

        public float m_Elasticity = 0.1f;
        public AnimationCurve m_ElasticityDistrib = null;

        public float m_Stiffness = 0.1f;
        public AnimationCurve m_StiffnessDistrib = null;

        public float m_Inert = 0;
        public AnimationCurve m_InertDistrib = null;

        public float m_Friction = 0;
        public AnimationCurve m_FrictionDistrib = null;

        public float m_Radius = 0;
        public AnimationCurve m_RadiusDistrib = null;

        public float m_EndLength = 0;

        public Vector3 m_EndOffset = Vector3.zero;

        public Vector3 m_Gravity = Vector3.zero;

        public Vector3 m_Force = Vector3.zero;

        public List<KhodrinsDynamicBoneSettingsCollider> m_Colliders = new List<KhodrinsDynamicBoneSettingsCollider>();

        public List<KhodrinsDynamicBoneSettingsTransform> m_Exclusions = new List<KhodrinsDynamicBoneSettingsTransform>();

        public DynamicBone.FreezeAxis m_FreezeAxis = DynamicBone.FreezeAxis.None;

        public bool m_DistantDisable = false;
        public KhodrinsDynamicBoneSettingsTransform m_ReferenceObject = new KhodrinsDynamicBoneSettingsTransform();
        public float m_DistanceToObject = 20;

        public void getSettings(DynamicBone db, Animator an)
        {
            placement.setTransform(db.transform, an);

            m_Root.setTransform(db.m_Root, an);

            m_UpdateRate = db.m_UpdateRate;

            m_UpdateMode = db.m_UpdateMode;

            m_Damping = db.m_Damping;
            m_DampingDistrib = db.m_DampingDistrib;

            m_Elasticity = db.m_Elasticity;
            m_ElasticityDistrib = db.m_ElasticityDistrib;

            m_Stiffness = db.m_Stiffness;
            m_StiffnessDistrib = db.m_StiffnessDistrib;

            m_Inert = db.m_Inert;
            m_InertDistrib = db.m_InertDistrib;

            var type = db.GetType();
            if (type.GetMethod("m_Friction") != null)
            {
                m_Friction = db.m_Friction;
            }
            if (type.GetMethod("m_FrictionDistrib") != null)
            {
                m_FrictionDistrib = db.m_FrictionDistrib;
            }


            m_Radius = db.m_Radius;
            m_RadiusDistrib = db.m_RadiusDistrib;

            m_EndLength = db.m_EndLength;

            m_EndOffset = db.m_EndOffset;

            m_Gravity = db.m_Gravity;

            m_Force = db.m_Force;

            m_Colliders.Clear();

            foreach (var collider in db.m_Colliders)
            {
                if (collider == null) continue;
                var boneSettingsCollider = new KhodrinsDynamicBoneSettingsCollider();

                if (collider.GetType().Name == "DynamicBonePlaneCollider")
                {
                    boneSettingsCollider.getCollider((DynamicBoneCollider)collider, an);
                }
                else
                {
                    boneSettingsCollider.getCollider((DynamicBoneCollider)collider, an);
                }

                if (boneSettingsCollider.bone.getTransform(an) != null)
                {
                    m_Colliders.Add(boneSettingsCollider);
                }
            }

            m_Exclusions.Clear();

            foreach (var exclusion in db.m_Exclusions)
            {
                if (exclusion == null) continue;

                var excl = new KhodrinsDynamicBoneSettingsTransform(exclusion, an);

                if (excl.getTransform(an) != null)
                {
                    m_Exclusions.Add(excl);
                }
            }

            m_FreezeAxis = db.m_FreezeAxis;

            m_DistantDisable = db.m_DistantDisable;
            m_ReferenceObject = new KhodrinsDynamicBoneSettingsTransform(db.m_ReferenceObject, an);
            m_DistanceToObject = db.m_DistanceToObject;
        }

        public void setSettings(DynamicBone db, Animator an)
        {
            setSettings(db, an, Vector3.one);
        }

        public void setSettings(DynamicBone db, Animator an, Vector3 scale)
        {
            db.m_Root = m_Root.getTransform(an);

            db.m_UpdateRate = m_UpdateRate;

            db.m_UpdateMode = m_UpdateMode;

            db.m_Damping = m_Damping;
            db.m_DampingDistrib = m_DampingDistrib;

            db.m_Elasticity = m_Elasticity;
            db.m_ElasticityDistrib = m_ElasticityDistrib;

            db.m_Stiffness = m_Stiffness;
            db.m_StiffnessDistrib = m_StiffnessDistrib;

            db.m_Inert = m_Inert;
            db.m_InertDistrib = m_InertDistrib;

            var type = db.GetType();
            if (type.GetMethod("m_Friction") != null)
            {
                db.m_Friction = m_Friction;
            }
            if (type.GetMethod("m_FrictionDistrib") != null)
            {
                db.m_FrictionDistrib = m_FrictionDistrib;
            }


            db.m_Radius = m_Radius * scale.x;
            db.m_RadiusDistrib = m_RadiusDistrib;

            db.m_EndLength = m_EndLength * scale.x;

            db.m_EndOffset = Vector3.Scale(m_EndOffset, scale);

            db.m_Gravity = m_Gravity;

            db.m_Force = m_Force;

            db.m_Colliders = new List<DynamicBoneColliderBase>();

            foreach (var collider in m_Colliders)
            {
                var addedCollider = collider.setCollider(an, scale);
                if (addedCollider != null)
                {
                    db.m_Colliders.Add(addedCollider);
                }
            }

            db.m_Exclusions = new List<Transform>();

            foreach (var exclusion in m_Exclusions)
            {
                var tranform = exclusion.getTransform(an);
                if (tranform != null)
                {
                    db.m_Exclusions.Add(tranform);
                }
            }

            db.m_FreezeAxis = m_FreezeAxis;

            db.m_DistantDisable = m_DistantDisable;
            db.m_ReferenceObject = m_ReferenceObject.getTransform(an);
            db.m_DistanceToObject = m_DistanceToObject;
        }

        public static HumanBodyBones getBone(Transform bone, Animator an)
        {
            HumanBodyBones returnBone = HumanBodyBones.LastBone;

            foreach (HumanBodyBones boneType in System.Enum.GetValues(typeof(HumanBodyBones)))
            {
                if (boneType != HumanBodyBones.LastBone && bone == an.GetBoneTransform(boneType))
                {
                    returnBone = boneType;
                }
            }

            return returnBone;
        }

        public static Transform setBone(HumanBodyBones bone, DynamicBone db, Animator an)
        {
            if (bone == HumanBodyBones.LastBone)
            {
                return db.transform;
            }
            else
            {
                return an.GetBoneTransform(bone);
            }
        }
    }

    [System.Serializable]
    public class KhodrinsDynamicBoneSettingsCollider
    {
        public enum ColliderType
        {
            DynamicBoneCollider,
            DynamicBonePlaneCollider
        }

        public ColliderType type = ColliderType.DynamicBoneCollider;

        public KhodrinsDynamicBoneSettingsTransform bone = new KhodrinsDynamicBoneSettingsTransform();

        public DynamicBoneColliderBase.Direction m_Direction = DynamicBoneColliderBase.Direction.Y;
        public Vector3 m_Center = Vector3.zero;
        public DynamicBoneColliderBase.Bound m_Bound = DynamicBoneColliderBase.Bound.Outside;

        public float m_Radius = 0.5f;
        public float m_Height = 0;

        public void getCollider(DynamicBoneCollider collider, Animator an)
        {
            type = ColliderType.DynamicBoneCollider;

            bone.setTransform(collider.transform, an);

            m_Direction = collider.m_Direction;
            m_Center = collider.m_Center;
            m_Bound = collider.m_Bound;

            m_Radius = collider.m_Radius;
            m_Height = collider.m_Height;
        }

        public void getCollider(DynamicBonePlaneCollider collider, Animator an)
        {
            type = ColliderType.DynamicBonePlaneCollider;

            bone.setTransform(collider.transform, an);

            m_Direction = collider.m_Direction;
            m_Center = collider.m_Center;
            m_Bound = collider.m_Bound;
        }

        public DynamicBoneColliderBase setCollider(Animator an, Vector3 scale)
        {
            var transform = bone.getTransform(an);
            
            if(transform == null) return null;
            
            if (type == ColliderType.DynamicBoneCollider)
            {
                var collider = (DynamicBoneCollider)transform.GetComponent(typeof(DynamicBoneCollider));

                if (collider == null)
                {
                    collider = (DynamicBoneCollider)transform.gameObject.AddComponent(typeof(DynamicBoneCollider));
                }

                collider.m_Direction = m_Direction;
                collider.m_Center = Vector3.Scale(m_Center, scale);
                collider.m_Bound = m_Bound;

                collider.m_Radius = m_Radius * scale.x;
                collider.m_Height = m_Height * scale.x;

                return collider;
            }

            if (type == ColliderType.DynamicBonePlaneCollider)
            {
                var collider = (DynamicBonePlaneCollider)transform.GetComponent(typeof(DynamicBonePlaneCollider));

                if (collider == null)
                {
                    collider = (DynamicBonePlaneCollider)transform.gameObject.AddComponent(typeof(DynamicBonePlaneCollider));
                }

                collider.m_Direction = m_Direction;
                collider.m_Center = Vector3.Scale(m_Center, scale);
                collider.m_Bound = m_Bound;

                return collider;
            }

            return null;
        }
    }

    [System.Serializable]
    public class KhodrinsDynamicBoneSettingsTransform
    {
        public HumanBodyBones bodyBone = HumanBodyBones.LastBone;
        public string name = "";
        public Transform transformOverride = null;

        public KhodrinsDynamicBoneSettingsTransform()
        {

        }

        public KhodrinsDynamicBoneSettingsTransform (Transform transform, Animator animator)
        {
            setTransform(transform, animator);
        }

        public void setTransform(Transform transform, Animator animator)
        {
            if (transform != null)
            {
                bodyBone = KhodrinsDynamicBoneSettings.getBone(transform, animator);
                name = transform.name;
            }
        }

        public Transform getTransform(Animator animator)
        {
            return getTransform(animator, true);
        }

        public Transform getTransform(Animator animator, bool allowNull)
        {
            Transform transform = null;

            if(transformOverride != null)
            {
                return transformOverride;
            }

            if (bodyBone == HumanBodyBones.LastBone)
            {
                transform = animator.transform.FindDeepChild(name);
            }
            else if (name != "")
            {
                transform = animator.GetBoneTransform(bodyBone);
            }

            if(transform == null && !allowNull)
            {
                transform = animator.transform;
            }

            return transform;
        }
    }

    [System.Serializable]
    public class KhodrinsDynamicBoneSettingsGroup
    {
        public List<KhodrinsDynamicBoneSettings> list = new List<KhodrinsDynamicBoneSettings>();
        public string name = "";
        public string description = "";
    }

    public static class TransformDeepChildExtension
    {
        //Breadth-first search
        public static Transform FindDeepChild(this Transform aParent, string aName)
        {
            Queue<Transform> queue = new Queue<Transform>();
            queue.Enqueue(aParent);
            while (queue.Count > 0)
            {
                var c = queue.Dequeue();
                if (c.name == aName)
                    return c;
                foreach (Transform t in c)
                    queue.Enqueue(t);
            }
            return null;
        }
    }
}
