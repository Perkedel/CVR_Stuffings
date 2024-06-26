using System;

namespace Furality.SDK.Editor.External.FoxApi.Models.User
{
    [Serializable]
    public class FoxPatreonDto
    {
        public string tier;

        public PatreonLevel GetTier() => Enum.TryParse(tier, true, out PatreonLevel level) ? level : PatreonLevel.None;
    }
}