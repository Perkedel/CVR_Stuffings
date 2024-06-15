# CVR Animator Templates
A set of templates for basic animator tasks in cvr.

## Dependencies
This package is most useful with and expects you to use [SimpleAAS](https://github.com/NotAKidOnSteam/SimpleAAS)

## Usage

1. Select a template to use.
2. Add a NAK Simple ASS component and fill in the override and avatar.
3. Add the template controler to the controllers list and any other controlers you need.
4. Press `Compile Controllers`
5. Add the animations you need to the override controller(see below).

## Available Templates
### Expressive
Expressive templates are for adding basic gesture based expressions to your avatars.

There are two.
- `ExpressiveBlend`
	+ Adds left and right hand expressions in a single layer using direct blendtrees.
	+ Simplest and most performant.
	+ No control over transitions.
- `ExpressiveTraditional`
	+ Adds left and right hand expressions each in a seperate layer using transitions from `Any State`.
	+ Open hand and Fist gestures handled as a blendtree for blending between shapes(manual eye close, tounge stick out, etc...)
	+ Less effecient than ExpressiveBlend but offers more control.

Animations to replace in the override controllers are `Expr{Hand}{Gesture}`(So the animation on a right handed finger gun is `ExprRightGun`) Neither adds any aditional advanced settings.

### Scaling
Scaling templates are for adding scaling to an avatar to make it grow bigger or smaller.

There are four.
- `ScalingBlendTree`
	+ Most effecient and simple. Uses a single layer and blend tree.
	+ Adds the following AdvancedSettings
		* `AvatarScale`: Preferably a Slider but an Input Single is also usable.
	+ The override contoller allows you to replace the following animations
		* `ScaleMax`: The largest scale of the gameobject(usually the avatar)
		* `ScaleMin`: The smallest scale of the gameobject(usually the avatar)
		* `ScaleStandard`: The standard, default, or average scale of the gameobject(usually the avatar)
	+ `AvatarScale` is from 0 to 1 where 0 is smallest, 1 is largest, and 0.5 is standard.
- `ScalingBlendTreeTouchToggle`
	+ Like `ScalingBlendTree` but adds support for a toggle for touch triggers on the avatar(for scaling by touching your wrist for example.)
	+ Adds the following AdvancedSettings
		* `AvatarScale`: Preferably a Slider but an Input Single is also usable.
		* `TouchToggle`: Use a game object toggle for this.
	+ The override contoller allows you to replace the following animations
		* `ScaleMax`: The largest scale of the gameobject(usually the avatar)
		* `ScaleMin`: The smallest scale of the gameobject(usually the avatar)
		* `ScaleStandard`: The standard, default, or average scale of the gameobject(usually the avatar)
		* `TouchTogglesOn`: Animation enabling the touch toggles. This template assumes they are disabled on upload.
	+ `AvatarScale` is from 0 to 1 where 0 is smallest, 1 is largest, and 0.5 is standard.
- `ScalingMotionTime`
	+ Scales the avatar using a single animation and motion time.
	+ Adds the following AdvancedSettings
		* `AvatarScale`: Preferably a Slider but an Input Single is also usable.
	+ The override contoller allows you to replace the following animations
		* `ScaleCombined` An animation with at least two keyframes with the smallest and largest scales. A third in the middle is suggested for an "Average" scale.
	+ `AvatarScale` determines the avatar's scale by acting as `ScaleCombined`'s Motion time.
		* The "time" in the animation is determined by the remainder of the setting divided by 1
		* So a value of .5, 1.5, and 2.5 are all read as .5 or half way through the animation.
		* As well 1 is read as 0.
		* 0 is the first key frame, almost 1 is the last keyframe, and other values are between.
		* This means increasing/decreasing the scale with touch triggers can make the scale "loop".
		* Google the modulo operator idk.
- `ScalingMotionTimeTouchToggle`
	+ Like `ScalingMotionTime` but adds support for a toggle for touch triggers on the avatar(for scaling by touching your wrist for example.)
	+ Adds the following AdvancedSettings
		* `AvatarScale`: Preferably a Slider but an Input Single is also usable.
		* `TouchToggle`: Use a game object toggle for this.
	+ The override contoller allows you to replace the following animations
		* `ScaleCombined` An animation with at least two keyframes with the smallest and largest scales. A third in the middle is suggested for an "Average" scale.
		* `TouchTogglesOn`: Animation enabling the touch toggles.
		* `TouchTogglesOff`: Animation disabling the touch toggles. 
	+ `AvatarScale` determines the avatar's scale by acting as `ScaleCombined`'s Motion time.
		* The "time" in the animation is determined by the remainder of the setting divided by 1
		* So a value of .5, 1.5, and 2.5 are all read as .5 or half way through the animation.
		* As well 1 is read as 0.
		* 0 is the first key frame, almost 1 is the last keyframe, and other values are between.
		* This means increasing/decreasing the scale with touch triggers can make the scale "loop".
		* Google the modulo operator idk.

> https://github.com/jll123567/VR-Content