using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using UnityEditor;

namespace Furality.SDK.Editor.Helpers
{
    [InitializeOnLoad]
    public class AsyncHelper
    {
        private static readonly Queue<Action> _mainThreadCallbacks = new Queue<Action>();
            
        static AsyncHelper()
        {
            EditorApplication.update += Update;
        }
        
        public static void EnqueueOnMainThread(Action action)
        {
            lock (_mainThreadCallbacks)
            {
                _mainThreadCallbacks.Enqueue(action);
            }
        }

        private static void Update()
        {
            for (int i = 0; i < _mainThreadCallbacks.Count; i++)
                _mainThreadCallbacks.Dequeue().Invoke();
        }
        
        public static Task<T> MainThread<T>(Func<T> fun)
        {
            var promise = new TaskCompletionSource<T>();
            EnqueueOnMainThread(() =>
            {
                try {
                    promise.SetResult(fun());
                } catch (Exception e) {
                    promise.SetException(e);
                }
            });

            return promise.Task;
        }
    }
}