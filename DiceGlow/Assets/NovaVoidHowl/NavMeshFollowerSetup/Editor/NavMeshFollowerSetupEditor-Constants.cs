// Version: 1.0.1
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using uk.novavoidhowl.dev.navmeshfollowersetup;

namespace uk.novavoidhowl.dev.navmeshfollowersetup
{

  public static class NMFConstants
  {

    public const string generatedAnimatorsPath = "Assets/NMF/GeneratedAnimators/";
    public const string configFilePath_primary= "Assets/Kafeijao/nmf_config.json";
    public const string configFilePath_fallback="Packages/uk.novavoidhowl.dev.navmeshfollowersetup/Assets/Resources/nmf_config.json";
    public const int maxFollowerLevel = 3;
    public const string finalIK_folder = "Assets/Plugins/RootMotion";
    public const bool debug_mode = false;

    public const string progress_bar_fill_color = "#ff4500";

  }
}
