﻿#ifndef HEKKY_PBR_UBER_KEYWORD_DEFS
#define HEKKY_PBR_UBER_KEYWORD_DEFS

#define MIN_PERCEPTUAL_ROUGHNESS 0.045
#define MIN_ROUGHNESS 0.002025

#define FORWARD_BASE defined(UNITY_PASS_FORWARDBASE)
#define FORWARD_ADD defined(UNITY_PASS_FORWARDADD)
#define SHADOW_CASTER defined(UNITY_PASS_SHADOWCASTER)

#if DIRECTIONAL
#define LIGHT_DIRECTIONAL 1
#else
#define LIGHT_DIRECTIONAL 0
#endif // DIRECTIONAL

#if (POINT || SPOT)
#define LIGHT_DYNAMIC 1
#else
#define LIGHT_DYNAMIC 0
#endif // (POINT || SPOT)

#if (SHADOWS_SCREEN || SHADOWS_SHADOWMASK || LIGHTMAP_SHADOW)
#define SHADOWS_ENABLED 1
#else
#define SHADOWS_ENABLED 0
#endif // (SHADOWS_SCREEN || SHADOWS_SHADOWMASK || LIGHTMAP_SHADOW)

#if defined(SHADOWS_SCREEN) && defined(UNITY_PASS_FORWARDBASE)
#define MSAA_SHADOW_FIX 1
#else
#define MSAA_SHADOW_FIX 0
#endif

#if (_NORMALMAP || DIRLIGHTMAP_COMBINED)
    #define _TANGENT_TO_WORLD 1
#endif // (_NORMALMAP || DIRLIGHTMAP_COMBINED)

#define BLEND_MODE_TRANSPARENT (defined(_ALPHAPREMULTIPLY_ON))
#define BLEND_MODE_FADE (defined(_ALPHABLEND_ON))
#define BLEND_MODE_MASKED (defined(_ALPHATEST_ON))

#define EMISSION_ENABLED (defined(_EMISSION))

#define SAMPLE_LIGHTMAP (defined(LIGHTMAP_ON))
#define SAMPLE_DYNAMICLIGHTMAP (defined(DYNAMICLIGHTMAP_ON))
#define HAS_LIGHTMAP (defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON))
#define BAKERY_AVAILABLE (defined(_BAKERY_RNM) || defined(_BAKERY_SH) || defined(_BAKERY_MONOSH))
// Spherical harmonics non-linear samples spherical harmonic lightmaps in gamma space. In Bakery's default shaders this
// is togglable via a toggle but since we are dealing with VRChat, I'm going to assume that you're using gamma space
// spherical harmonic lightmaps if you're using gamma space rendering (why would you even though)
#define BAKERY_SHNONLINEAR (defined(UNITY_COLORSPACE_GAMMA))

#define BAKERY_ENABLED (BAKERY_AVAILABLE && defined(LIGHTMAP_ON))
#define LTCGI_ENABLED (defined(_LTCGI))

// More readable shorthands for toggle checks, which will get optimized by the shader optimizer later
#define LIGHTING_MODE_REALISTIC (_LightingMode == 0)
#define LIGHTING_MODE_TOON (_LightingMode == 1)
#define LIGHTING_MODE_UNLIT (_LightingMode == 2)

#define LIGHTING_SHADOWS_ENABLED (_LightingShadows == 1)
#define LIGHTING_NORMAL_REPROJECTION (_EnableNormalReproj == 1)

#define BAKED_SPECULAR_ENABLED (_LightmapSpecular == 1)

#define OUTLINE_ENABLED (_DoOutline == 1)

#define SUBSURFACE_SCATTERING (defined(_SUBSURFACE_SCATTERING))

#define PARALLAX_OCCLUSION_MAPPING (defined(_PARALLAXMAP))
#define POM_CLIPPING (defined(_POM_CLIPPING))

#define SSR (defined(_SSR_ENABLED))

/*

// Unity Standard Shader Keywords
// These Should Be Always Included

_ALPHABLEND_ON
_ALPHAMODULATE_ON
_ALPHAPREMULTIPLY_ON
_ALPHATEST_ON
_COLORADDSUBDIFF_ON
_COLORCOLOR_ON
_COLOROVERLAY_ON
_DETAIL_MULX2
_EMISSION
_FADING_ON
_GLOSSYREFLECTIONS_OFF
_GLOSSYREFLECTIONS_OFF
_MAPPING_6_FRAMES_LAYOUT
_METALLICGLOSSMAP
_NORMALMAP
_PARALLAXMAP
_REQUIRE_UV2
_SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
_SPECGLOSSMAP
_SPECULARHIGHLIGHTS_OFF
_SPECULARHIGHLIGHTS_OFF
_SUNDISK_HIGH_QUALITY
_SUNDISK_NONE
_SUNDISK_SIMPLE
_TERRAIN_NORMAL_MAP
BILLBOARD_FACE_CAMERA_POS
EFFECT_BUMP
EFFECT_HUE_VARIATION
ETC1_EXTERNAL_ALPHA
GEOM_TYPE_BRANCH
GEOM_TYPE_BRANCH_DETAIL
GEOM_TYPE_FROND
GEOM_TYPE_LEAF
GEOM_TYPE_MESH
LOD_FADE_CROSSFADE
PIXELSNAP_ON
GEOM_TYPE_FROND
STEREO_INSTANCING_ON
STEREO_MULTIVIEW_ON
UNITY_HDR_ON
UNITY_SINGLE_PASS_STEREO
UNITY_UI_ALPHACLIP
UNITY_UI_CLIP_RECT

// Post Processing Stack V1 and V2

FOG_OFF
FOG_LINEAR
FOG_EXP
FOG_EXP2
ANTI_FLICKER
UNITY_COLORSPACE_GAMMA
SOURCE_GBUFFER
AUTO_KEY_VALUE
GRAIN
DITHERING
TONEMAPPING_NEUTRAL
TONEMAPPING_FILMIC
CHROMATIC_ABERRATION
DEPTH_OF_FIELD
DEPTH_OF_FIELD_COC_VIEW
BLOOM
BLOOM_LENS_DIRT
COLOR_GRADING
COLOR_GRADING_LOG_VIEW
USER_LUT
VIGNETTE_CLASSIC
VIGNETTE_MASKED
FXAA
FXAA_LOW
FXAA_KEEP_ALPHA
STEREO_INSTANCING_ENABLED
STEREO_DOUBLEWIDE_TARGET
TONEMAPPING_ACES
TONEMAPPING_CUSTOM
APPLY_FORWARD_FOG
DISTORT
CHROMATIC_ABERRATION_LOW
BLOOM_LOW
VIGNETTE
FINALPASS
COLOR_GRADING_HDR_3D
COLOR_GRADING_HDR
AUTO_EXPOSURE

*/

#endif // HEKKY_PBR_UBER_KEYWORD_DEFS