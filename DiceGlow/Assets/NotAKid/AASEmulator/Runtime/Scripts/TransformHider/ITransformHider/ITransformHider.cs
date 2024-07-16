using System;

public interface ITransformHider : IDisposable
{
    bool IsActive { get; }
    bool IsValid { get; }
    bool IsHidden { get; }
    
    void HideTransform();
    void ShowTransform();
}