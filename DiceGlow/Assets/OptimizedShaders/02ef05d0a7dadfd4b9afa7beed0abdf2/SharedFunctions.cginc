#ifndef INVENTORY_INCLUDED
#define INVENTORY_INCLUDED
//Shared Functions that are shared between the Base and the Shadowcaster
//We could also just include Utilities.cginc into the Shadowcaster but i don't like how Rider is disabling code highlights for #ifed code

// Inventory
uniform fixed _UseInventory;
uniform fixed _InventoryComplexity;
uniform float _InventoryStride;
uniform fixed _InventoryItem01Animated;
uniform fixed _InventoryItem02Animated;
uniform fixed _InventoryItem03Animated;
uniform fixed _InventoryItem04Animated;
uniform fixed _InventoryItem05Animated;
uniform fixed _InventoryItem06Animated;
uniform fixed _InventoryItem07Animated;
uniform fixed _InventoryItem08Animated;
uniform fixed _InventoryItem09Animated;
uniform fixed _InventoryItem10Animated;
uniform fixed _InventoryItem11Animated;
uniform fixed _InventoryItem12Animated;
uniform fixed _InventoryItem13Animated;
uniform fixed _InventoryItem14Animated;
uniform fixed _InventoryItem15Animated;
uniform fixed _InventoryItem16Animated;
uniform float4 _EmissiveDissolveColor;
uniform fixed _InventoryEmissionThickness;
uniform sampler2D _DissolvePattern;
uniform float4 _DissolvePattern_ST;
uniform float _InventoryUVSwitch;

//Dither
sampler2D _DitherMask;
float4 _DitherMask_ST;
float _DitherMaskUVSwitch;
Texture2D _DitherTexture;
float4 _DitherTexture_ST;
float4 _DitherTexture_TexelSize;
float _DitherTextureUVSwitch;
SamplerState sampler_DitherTexture;
int _DitherTextureToggle;
int _DitherAlphaToggle;
float _EndDitheringFade;
float _StartDitheringFade;
float _DitherTextureTiling;
//float _MaskClipValue; //Not used anymore


//Inventory System Source: https://gitlab.com/s-ilent/SCSS/-/wikis/Manual/Inventory-System
void InventorySystem(float2 in_texcoord, out float3 InventoryEmission)
{
    // Initialise mask. This will cut things out.
    float inventoryMask = 0.0;
    // Which UV section are we in?
    const uint itemID = floor((in_texcoord.x) / float(1));
    // If the item ID is zero or below, always render.
    // But if it's higher, check against toggles.

    inventoryMask += (itemID <= 0);
    inventoryMask += (itemID == 1) * _InventoryItem01Animated;
    inventoryMask += (itemID == 2) * _InventoryItem02Animated;
    inventoryMask += (itemID == 3) * _InventoryItem03Animated;
    inventoryMask += (itemID == 4) * _InventoryItem04Animated;
    inventoryMask += (itemID == 5) * _InventoryItem05Animated;
    inventoryMask += (itemID == 6) * _InventoryItem06Animated;
    inventoryMask += (itemID == 7) * _InventoryItem07Animated;
    inventoryMask += (itemID == 8) * _InventoryItem08Animated;
    inventoryMask += (itemID == 9) * _InventoryItem09Animated;
    inventoryMask += (itemID == 10) * _InventoryItem10Animated;
    inventoryMask += (itemID == 11) * _InventoryItem11Animated;
    inventoryMask += (itemID == 12) * _InventoryItem12Animated;
    inventoryMask += (itemID == 13) * _InventoryItem13Animated;
    inventoryMask += (itemID == 14) * _InventoryItem14Animated;
    inventoryMask += (itemID == 15) * _InventoryItem15Animated;
    inventoryMask += (itemID == 16) * _InventoryItem16Animated;

    // Higher than 17? Enabled by default
    inventoryMask += (itemID >= 17);

    //Pattern
    float3 PatternTex = tex2D(_DissolvePattern, in_texcoord * float4(1,1,0,0).xy + float4(1,1,0,0).zw);
    half Pattern = max(max(PatternTex.r, PatternTex.g), PatternTex.b);

    //Final Inventory System
    if (float(0))
    {
        const float FinalInventorySystem = round(1-inventoryMask - 0.499 * (1-Pattern * 2));
        clip(0.0 - FinalInventorySystem);
        
        //Inventory Emission
        InventoryEmission = 0;
        #ifdef UNITY_PASS_FORWARDBASE
        Pattern = saturate(Pattern * float(1.25));
        InventoryEmission = round(1-inventoryMask - 0.499 * (1-Pattern * 2));
        InventoryEmission *= float4(128,0,255,1);
        #endif
    }
}

//Inventory System Source: https://gitlab.com/s-ilent/SCSS/-/wikis/Manual/Inventory-System
void InventorySystemSimple(float2 in_texcoord, out float FinalInventorySystem)
{
    // Initialise mask. This will cut things out.
    float inventoryMask = 0.0;
    // Which UV section are we in?
    const uint itemID = floor((in_texcoord.x) / float(1));
    // If the item ID is zero or below, always render.
    // But if it's higher, check against toggles.

    inventoryMask += (itemID <= 0);
    inventoryMask += (itemID == 1) * _InventoryItem01Animated;
    inventoryMask += (itemID == 2) * _InventoryItem02Animated;
    inventoryMask += (itemID == 3) * _InventoryItem03Animated;
    inventoryMask += (itemID == 4) * _InventoryItem04Animated;
    inventoryMask += (itemID == 5) * _InventoryItem05Animated;
    inventoryMask += (itemID == 6) * _InventoryItem06Animated;
    inventoryMask += (itemID == 7) * _InventoryItem07Animated;
    inventoryMask += (itemID == 8) * _InventoryItem08Animated;
    inventoryMask += (itemID == 9) * _InventoryItem09Animated;
    inventoryMask += (itemID == 10) * _InventoryItem10Animated;
    inventoryMask += (itemID == 11) * _InventoryItem11Animated;
    inventoryMask += (itemID == 12) * _InventoryItem12Animated;
    inventoryMask += (itemID == 13) * _InventoryItem13Animated;
    inventoryMask += (itemID == 14) * _InventoryItem14Animated;
    inventoryMask += (itemID == 15) * _InventoryItem15Animated;
    inventoryMask += (itemID == 16) * _InventoryItem16Animated;

    // Higher than 17? Enabled by default
    inventoryMask += (itemID >= 17);
    
    //Final Inventory System
    if (float(0))
    {
        FinalInventorySystem = round(inventoryMask);
    }
}



//DITHER START
inline float DitherNoiseTex(float2 screenPos)
{
    float dither = _DitherTexture.Sample(sampler_DitherTexture, screenPos * _ScreenParams.xy * float4(1,1,1,1).xy).g;
    const float ditherRate = float4(1,1,1,1).x * float4(1,1,1,1).y;
    dither = (1-ditherRate) * dither + ditherRate;
    return dither;
}

float DitherMaskSample(float2 in_texcoord)
{
    float Tex = tex2D(_DitherMask, in_texcoord * float4(1,1,0,0).xy + float4(1,1,0,0).zw).g;
    return Tex;
}

inline float Dither8x8Bayer(int x, int y)
{
    const float dither[ 64 ] = {
        1, 49, 13, 61,  4, 52, 16, 64,
       33, 17, 45, 29, 36, 20, 48, 32,
        9, 57,  5, 53, 12, 60,  8, 56,
       41, 25, 37, 21, 44, 28, 40, 24,
        3, 51, 15, 63,  2, 50, 14, 62,
       35, 19, 47, 31, 34, 18, 46, 30,
       11, 59,  7, 55, 10, 58,  6, 54,
       43, 27, 39, 23, 42, 26, 38, 22};
    int r = y * 8 + x;
    return dither[r] / 64;
}

float2 UnStereo(float2 UV)
{
    #if UNITY_SINGLE_PASS_STEREO
    float4 scaleOffset = unity_StereoScaleOffset[unity_StereoEyeIndex];
    UV.xy = (UV.xy - scaleOffset.zw) / scaleOffset.xy;
    #endif
    return UV;
}

void Dither(half alpha, float2 in_texcoord, float4 screenPosition)
{
    float3 worldSpaceViewDir = WorldSpaceViewDir(float4(0,0,0,1));
    float distanceToObject = distance(worldSpaceViewDir, float3(0,0,0));
    float distDitherStart = float(0) + _ProjectionParams.y;
    float distDither =  distanceToObject + -distDitherStart;
    distDither /= float(0) - distDitherStart;
    
    float alphaDitherStart = saturate(float(0));
    float alphaDither =  alpha + -alphaDitherStart;
    if (float(0) != 0) //Safe Devide
        alphaDither /= saturate(float(0)) - alphaDitherStart;
    else
        alphaDither = 1-alpha;

    float ditherMethod = distDither;
    if(float(0) == 1)
    {
        ditherMethod = alphaDither;
    }
    
    float4 screenPos = screenPosition;
    float4 screenPosNorm = screenPos / screenPos.w;
    screenPosNorm.z = UNITY_NEAR_CLIP_VALUE >= 0 ? screenPosNorm.z : screenPosNorm.z * 0.5 + 0.5;
    float2 clipScreen = screenPosNorm.xy * _ScreenParams.xy;
    float2 unStereoScreenPos = UnStereo(screenPosNorm.xy);
    float2 ditherScreenPos = unStereoScreenPos * float(1);
    
    float ditherPatternBayer = Dither8x8Bayer(fmod(clipScreen.x, 8), fmod(clipScreen.y, 8));
    float ditherPatternTex = DitherNoiseTex(ditherScreenPos);
    float ditherPattern = ditherPatternBayer;
    if(float(0) == 1)
    {
        ditherPattern = ditherPatternTex;
    }
    
    float applyDitherPattern = ditherMethod - ditherPattern;
    
    float ditherMask = DitherMaskSample(in_texcoord);
    float ditherMasked = lerp(1, applyDitherPattern, ditherMask);
    
    float dither = 0;
    if(float(0) + float(0) > 0)
    {
        dither = ditherMasked;
    }
    clip(dither);
}
//DITHER END

half TexChannelSwitch(Texture2D tex, const SamplerState samplertex, const half2 uv, const int texChannelSwitchProp)
{
    half4 TextureSample = tex.Sample(samplertex, uv).rgba;
    half TextureOutput = half(TextureSample[(uint)texChannelSwitchProp % 4]);
    if (texChannelSwitchProp > 3)
        TextureOutput = 1-TextureOutput;
    return TextureOutput;
}

half2 TexChannelSwitchFloat2(Texture2D tex, const SamplerState samplertex, const half2 uv, const int texChannelSwitchProp)
{
    half4 TextureSample = tex.Sample(samplertex, uv).rgba;
    half2 TextureOutput = half2(TextureSample[(uint)texChannelSwitchProp / 4], TextureSample[(uint)texChannelSwitchProp % 4]);
    if (texChannelSwitchProp > 15)
        TextureOutput = 1-half2(TextureSample[((uint)texChannelSwitchProp - 16) / 4], TextureSample[(uint)texChannelSwitchProp % 4]);
    return TextureOutput;
}

#endif //END
