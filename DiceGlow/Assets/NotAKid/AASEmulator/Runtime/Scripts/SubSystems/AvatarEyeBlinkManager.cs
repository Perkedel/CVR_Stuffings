#if CVR_CCK_EXISTS
using ABI.CCK.Components;
using System.Collections.Generic;
using UnityEngine;

namespace NAK.AASEmulator.Runtime.SubSystems
{
    public class AvatarEyeBlinkManager
    {
        #region Public Properties
        
        private bool _isEnabled;
        public bool IsEnabled
        {
            get => _isEnabled;
            set
            {
                if (_isEnabled && !value)
                {
                    // reset blink blendshapes
                    Apply_BlinkBlendshapes(0f);
                }
                _isEnabled = value;
            }
        }
        
        public static Vector2 BlinkGapRange
        {
            get => _blinkGapRange;
            set => _blinkGapRange = new Vector2(
                Mathf.Clamp(value.x, BlinkGapLimitRange.x, BlinkGapLimitRange.y),
                Mathf.Clamp(value.y, BlinkGapLimitRange.x, BlinkGapLimitRange.y));
        }
        private static Vector2 _blinkGapRange = new(0.4f, 8f);
        private static readonly Vector2 BlinkGapLimitRange = new(0.5f, 30f);
        
        public static Vector2 BlinkDurationRange
        {
            get => _blinkDurationRange;
            set => _blinkDurationRange = new Vector2(
                Mathf.Clamp(value.x, BlinkDurationLimitRange.x, BlinkDurationLimitRange.y),
                Mathf.Clamp(value.y, BlinkDurationLimitRange.x, BlinkDurationLimitRange.y));
        }
        private static Vector2 _blinkDurationRange = new(0.25f, 0.35f);
        private static readonly Vector2 BlinkDurationLimitRange = new(0.1f, 3f);

        #endregion Public Properties
        
        // Blink handling
        private float _nextBlinkTime;
        private float _nextBlinkDuration;
        private bool _isBlinking;
        private float _blinkStartTime;

        // Avatar info
        private readonly CVRAvatar m_avatar;
        private int[] m_blinkingBlendShapeIndicies;

        public AvatarEyeBlinkManager(CVRAvatar avatar)
        {
            m_avatar = avatar;
            InitializeEyeBlink();
        }

        public void OnLateUpdate()
        {
            if (!IsEnabled)
                return;
            
            Handle_Blinking();
        }

        #region Private Methods

        private void InitializeEyeBlink()
        {
            if (m_avatar.bodyMesh == null)
                return;

            Mesh sharedMesh = m_avatar.bodyMesh.sharedMesh;

            const int MAX_BLINK_SHAPES = 4;
            var validBlinkIndices = new List<int>(MAX_BLINK_SHAPES);

            for (int i = 0; i < m_avatar.blinkBlendshape.Length && i < MAX_BLINK_SHAPES; i++)
            {
                string blinkShape = m_avatar.blinkBlendshape[i];
                if (string.IsNullOrEmpty(blinkShape) 
                    || blinkShape == "-none-") 
                    continue;
                
                int index = sharedMesh.GetBlendShapeIndex(blinkShape);
                if (index != -1) validBlinkIndices.Add(index);
            }

            m_blinkingBlendShapeIndicies = validBlinkIndices.ToArray();
        }

        private void Handle_Blinking()
        {
            if (Time.time > _nextBlinkTime && !_isBlinking)
            {
                _isBlinking = true;
                _blinkStartTime = Time.time;
                _nextBlinkDuration = Random.Range(BlinkDurationRange.x, BlinkDurationRange.y); // todo: ensure x < y
            }

            if (!_isBlinking) 
                return;
            
            float blinkProgress = (Time.time - _blinkStartTime) / _nextBlinkDuration;
            
            if (blinkProgress > 1f)
            {
                _isBlinking = false;
                _nextBlinkTime = Time.time + Random.Range(BlinkGapRange.x, BlinkGapRange.y);
                Apply_BlinkBlendshapes(0f);
            }
            else
            {
                float adjustedProgress = blinkProgress < 0.5f ? blinkProgress * 2 : 1 - (blinkProgress - 0.5f) * 2;
                float blinkAmount = Mathf.Lerp(0f, 100f, adjustedProgress * (2 - adjustedProgress));
                Apply_BlinkBlendshapes(blinkAmount);
            }
        }

        private void Apply_BlinkBlendshapes(float amount)
        {
            if (m_avatar.bodyMesh == null || m_blinkingBlendShapeIndicies == null) 
                return;
            
            foreach (int index in m_blinkingBlendShapeIndicies)
                m_avatar.bodyMesh.SetBlendShapeWeight(index, amount);
        }

        #endregion Private Methods
    }
}
#endif