using UnityEngine;

namespace Experiment.NewHider.Debugging
{
    public class NewHiderInit : MonoBehaviour
    {
        private void Start()
        {
            TransformHiderUtils.SetupAvatar(gameObject);
        }
    }
}