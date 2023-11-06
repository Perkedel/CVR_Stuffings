# CVR_Stuffings

 Official Perkedel Technologies collection of ChilloutVR objects projects

## All ChilloutVR projects

This repository contains everything made by us for a VR based social media, ChilloutVR / CVR. It has everything ever created by us & with affilation to us.

Everything here shall be uploaded & available for all gamers to contribute right to amend, modify, and add more stuffs. As well as to fork & build their own project upon. No part as all as possible be closed to an exclusive access. All gamers deserves.

## WARNING!!! MAY CONTAINS NSFW

**All employees are required to be in their mature age (most beings are 18+) in order to volunteer**. I mean, all Perkedel employees in any division basically requires 18+ years old, which is the minimum appropriate age of accepting paid jobs & contracts. If there is something that requires special condition for the target job, we can use the technology to pitch up for the work, OR using their natural abilities. You know, mix it up together? It's common industry practice! Wait where are we? OH, you must be adult. no matter what.

Additionally, proper mentals in specifics pertaining encounter of nudity & sexualized works **are required**. I mean all Perkedel employees in any division are expected to say okay with lewd works, we are company of culture! We don't hire losers. only winners. We don't care if you are handsome or beautiful (not like most of local companies in my areas), We want works. You can do it, willing do it, even by others is disgusting? You're in! Yeah, I know, we're trying everyday.

## Instructions

### Installation Setup

- Install CCK https://developers.abinteractive.net/cck/setup/ . Download the CCK & open up `DiceGlow` project with `Unity 2021.3.23f1` (**the version must be exactly as told by ABI!!**). Once you have downloaded it, simply drag the `.unitypackage` file into the editor. Add all files to it, **and DO NOT MOVE OR EDIT ANY OF THE FILE IN THAT FOLDER!!**
- Install other assets that are not included here. The refered assets are listed in sections below.
- Look around.
- Start developing & Contribute. You only need this project for all objects.

### Uploading

- In the top bar menu, `Alpha Blend Interactive`, `Control Panel`. Log in with your username & ABI Creation Kit access key.
- Open up some Scene containing `GameObject` that has CVR Asset components. The CCK will detect all objects that has this components.
- Click *Upload* of which object you'd like to upload.
- Corectly Fill the tags, title, description, changelog, thumbnail, legal, etc.
- Proceed upload.

## List of Not Included Assets

Below are assets that are not included and must be installed prior of usage and developments. There are name, Sauce URL, reason, and optionally hash of each package file.

- CCK https://developers.abinteractive.net/cck/setup/ . Space saving, common module. 
- [Magica Cloth 1](https://assetstore.unity.com/packages/tools/physics/magica-cloth-160144) & [2 the sequel](https://assetstore.unity.com/packages/tools/physics/magica-cloth-2-242307). Paywalled
- Glenskunk's [Cartoon Heart](https://glenskunk.gumroad.com/l/toonheartforVR?layout=profile) & [rest of them](https://glenskunk.gumroad.com/) ([alt](https://jinxxy.com/GlenSkunk?jc=c52ec67a13d09e3c89aaddcb76f108d62e2d254afe4fa1477865)). Paywalled
- Heartbeat connector . Paywalled
- Car Module . Paywalled
- [Fluff's VRC Avatar Toolbox](https://fluffs.gumroad.com/l/flufftoolbox). Paywalled
- [Fluff's VRC2CVR](https://fluffs.gumroad.com/l/flufftoolbox). Space Saving
- ~~[Narazaka's VRC2CVR-YA](https://github.com/Narazaka/VRC2CVR). Space Saving~~ ~~Included, so small!~~ No longer works
- [DonNomNomVR's AudioLink](https://github.com/DomNomNomVR/cvr-audio-link). Space Saving

<!-- Pls include all free but CCK, to backup! -->
> Some packages (e.g. `.unitypackage` extracted) are included for convenience.  
> **Pls keep the Steam Audio with ones caught by kjoy** at `ThirdParty/kjoy/SteamAudio.unitypackage`. Using version above this will cause entire project hangs to assembling C# scripts **forever**.  
> If you got this, simply close the project, remove 2 plugins in `DiceGlow/Assets/Plugins`: `SteamAudio` & `FMOD`, along with their `.meta` files. Then reload, and install the correct version shipped by kjoy.

## Quick Tutorials

### Assets

<!-- PLS COMPLETE THIS! -->

#### How to World

Make sure in your Unity Scene, there is a GameObject with component `CVRWorld`. by default, this object now is your spawn point you can place around, AS WELL AS Panoramic preview photo cam (for CVR Portal).

You can however, make another empty `GameObject` to be assigned as one of the spawn points. Simply position that `GameObject` to anywhere you'd like the player to spawn at. the `CVRWorld` accepts more than 1 and you can make it pick randomly.

The `CVRWorld` will also spawn component `CVRAssetInfo` automatically. **DO NOT FORGET TO NOTE ITS GUID!**

#### How to Avatar

Make sure in this Avatar you'd like to upload has these commponents:

- **CVRAvatar**
- CVRAssetInfo (Automatic). **DO NOT FORGET TO NOTE ITS GUID!**

#### How to Props

Make sure the GameObject you'd like to upload as an individual prop has these components:

- **CVRSpawnable**.
- CVRInteractable. To allow drag & drop.
- CVRAssetInfo (Automatic). **DO NOT FORGET TO NOTE ITS GUID!**

Any other components like MonoBehaviour based and derivatives should be working & load in the software. Ensure also that it is not harmful.

## UUIDs

### Avatars

- 92f6e5f4-e860-42fd-8154-81d69f605099 Howard the Alien

### Worlds

- 6b1b8855-9196-4e21-a418-f52a862651af SFW DiceGlow Test Area
- ?? NSFW CornSyrup Test Area
- 3fe2b7c3-129a-418e-87ad-c3931657f843 (**NOT PERKEDEL**) UCC Cinema. MilchZocker
- af0f00bc-0702-46ce-9441-bcce0ad6c813 (**NOT PERKEDEL**) UCC Avatars. MilchZocker
- 9d0677a5-b88f-4994-901b-7b91c99e8cd8 (**NOT PERKEDEL**) UCC Bird Island. MilchZocker
- bc8f15fa-8f6b-42b5-8096-8b3058345e98 (**NOT PERKEDEL**) UCC Hub. MilchZocker

### Props

- e93b46ac-a385-43bc-8458-1ba48f1341db Wahaha Dice
- e33ca9f8-0785-416a-b635-73a999bcb756 Wahaha Dice Scale 50
- acfed254-b590-4c9b-96c3-28c8e22f51ec Wahaha Dice Scale 25
- fa51c676-05bb-41c3-aa41-68941f9fb2a7 Wahaha Dice Scale 5
- 2796a410-02e1-4fcc-b7d8-d58f31b354c1 Wahaha Dice GIANT 1000
- e8da5752-5216-4bfe-a3ae-3c87d8ac9ca7 Wahaha Dice micro 1
- ed1fe55e-c63a-4119-9fc2-caa9933cf6aa Ehehe Dice
- c5482fb7-620f-42b0-ab84-afc8210a7a5a Ehehe Dice Scale 50
- 5a5a3265-a1e7-469b-83f3-d83e8800cb02 Ehehe Dice Scale 25
- 04ea5304-11c2-4244-98f1-7676a656da9e Ehehe Dice Scale 5
- b06c91e7-989f-4685-8819-875b666093cf Ehehe Dice GIANT 1000
- ca2e8dfb-3d35-42ad-8f22-bf839f732308 Ehehe Dice micro 1
- 7bb92abf-fc97-4836-b9fb-fff929408907 A Dice
- 3974a044-678b-4d26-8c00-9adaba057ffd A Dice Scale 50
- f500a295-e148-489d-bb6c-bca39fa976ad A Dice Scale 25
- 86462140-5f07-4fc0-a814-2541b5cd085d A Dice Scale 5
- 6f803736-519f-4e3c-b8bd-d0581ab83083 A Dice GIANT 1000
- 7cbb201a-d83b-40cd-975b-05250b7f74ad A Dice micro 1
- cd15f618-b0bf-4a55-a9ee-6fc52fad42b2 E Dice
- 962ea7dc-0c0a-4952-9842-d637570f2cde E Dice Scale 50
- 5e3a8b44-9676-47cc-aa41-91e37fbd301a E Dice Scale 25
- e2890d25-c725-495a-b5e0-98fb7526be8c E Dice Scale 5
- dc2a31c2-d7b8-47e2-ae2c-b69c9d638c52 E Dice GIANT 1000
- c01e0e3d-b793-4259-ba8c-84b1a6038a6c E Dice micro 1
- c7a0bd47-3ece-485f-a994-d3eddbc2b4c1 Anjay Button
- 8f094998-b863-4bc6-b3c9-726eb82f1e24 Fart Reverb Button
- cdc8b5b1-43af-40fd-b7a5-af48dc8d6dde EmptyBall
- 323d2618-403d-4835-9eac-5c8362a511a4 Stupid Cartoon Heart with Sound

### Assorted

These are the GUID from our cache folder of CVR.

- ..

## Additional Info

### GUID

Ensure to detach the GUID if you'd like to make new variant of these prefabs.

For employee: **DO NOT LOSE THE GUID!! MAKE SURE IT IS STILL ATTACHED, & IS SAME MATCH WITH THE PAGE IT UPLOADED TO!**

### Video Player not working

BUG REPORT: https://feedback.abinteractive.net/p/youtube-dl-sometimes-did-not-ship-with-it-video-player-does-not-work-on-some-people

![Log found using Mod: MelonLoader, CVRLogger++. ChilloutVR is unable to find the software needed to download the video, which is `youtube-dl`.](/DiceGlow/Assets/Sprites/Screenshots/cvr_uses_youtube-dl.png)

ChilloutVR uses [`youtube-dl`](https://github.com/ytdl-org/youtube-dl) to download the video, and then either with Network Sync to broadcast the playback, or locally play depending on that GameObject video player component setting right now. The part that plays the video is powered by AVPro. Somehow, the `youtube-dl` either **did not shipped with**, OR had obvious permission trouble (i.e. `Program Files` folders have strict permissions).

To remedy this, simply download `yt-dlp`. Why `yt-dlp` you ask? Because unfortunately current stable version of `youtube-dl` is broken, and in need dire update to be released due to ever breaking YouTube policies. The `yt-dl` is a fork of `youtube-dlc` which is also fork of `youtube-dl` or so in between, and **it happens that this forks works pretty well today**, thanks to auto-updating API methods in every attempt of downloading (the JSON manifest on how to download YouTube video is always fetched per attempt), I think.

Pick just the regular [`yt-dlp.exe`](https://github.com/yt-dlp/yt-dlp#release-files). Once you have downloaded it, place this EXE file into `C:\Program Files (x86)\Steam\steamapps\common\ChilloutVR\ChilloutVR_Data`, **& then rename is to `youtube-dl.exe`**.

Now, try again. If your log says `killing youtube-dl timeout`, try re-pasting the URL again to try load again. It should work now. When it successful, the log should say something about **AVPro playback broadcasting**.

![IT WORKS!!! The video now plays TheFatRat Hunger!!!](/DiceGlow/Assets/Sprites/Screenshots/cvr_youtube_works.png)

- https://github.com/ytdl-org/youtube-dl
- https://www.reddit.com/r/archlinux/comments/119hsoj/stop_using_youtubedl_and_use_ytdlp_instead/
- https://www.reddit.com/r/youtubedl/comments/mh51mc/out_of_curiosity_how_does_youtubedl_work/
- https://ytdl-org.github.io/youtube-dl/
- https://openjur.de/u/2466945.html 🖕🖕🖕🖕🖕🖕🖕🖕🖕🖕🖕🖕🖕🖕🖕🖕🖕🖕🖕🖕🖕 
- ~~https://youtube-dl.org/~~ brogen

### Whitelisted URL for Video Player

Known Whitelisted domains in CVR for Video Player are:

- [VRCDN](https://vrcdn.live)
- [YouTube.com](https://youtube.com)

### Are these done by Realizer division?

Not officially. Although some Realizer members had involved, still it was done by serveral other volunteers at Perkedel Technologies who worked with this in their free time.

Due to different settings and goal with the game engine CVR used, There is no dedicated division handling content creation for this social media. So, Ricitello, **PECK YOU!!**  
Also actually we've been having beef with Unity in general. `Made with Unity`, No permanent buy, etc. etc.

### Weren't you supposed to make your own Godot social media?

Creating social media on its own is huge responsibilities. It is not a simple hassle and burdens to take. While the server (for usual opinions) will be as neutral as possible & dev themselves may not, these days, neutrality is a necessity. Or let's say, **siding a necessity**, in which **it is required to ban people on certain usual opinion sets** in favour of bigger more evil threats that must be obeyed, in order to legally operate, among other things.

Although, VR Sandbox can still be possible, **BUT** without the social media capability. It won't be GodotChat. **Meja** (Open Source Tabletop simulator clone). More like industrial physics simulation framework.

This **Kantor 369 Meja** is one that will officially be built by Realizers. Later.

### Unity?! Don't they will steal your soul?

Fortunately, in desperation, Unity had partially rolled back their new paywallism-partialism agendas. Therefore, only by the new version after 2024, will they succ our soul like Shang Tsung.

Therefore, the version of Unity (`Unity 2021.3.23f1`) used by AlphaBlend Interactive & for these creations of it are **not subject to Neo-Paywall-Partialism / Runtime Fee agenda**. Everyone in this version should be safe, for now. Because if not wrong, these legacy versions shall be supported until spans of 2024. However, we have yet confirmed would Unity impose punishment us gamers who stuck in these legacy version prior to this agenda.

Be knowledgeful also, that ABI already built their software & set goals for long since before. Therefore, to stop and *port* to other engines is not a viable option. This can only be done from scratch with different set of instructions. We shall see further, so stay tuned.

### Why did you include `NAME`?! They are all partialists

We unfortunately have no choice but include these shaders, due to other modules have used such shader, hence depends on it. We hope that these modules uses features available in Free edition only, and say if they did used paid feature, can be replaced back to the free sets ones without breaking.

Perkedel and affiliates condemn highly, the act of partializing feature sets under micro-transactions or any similar system, as well as basically paywalling assets. If you have any questions, let us know, under DM Prefix `CVR_PAID_ASSET_CONCERNS`.

#### Sauces

- https://youtu.be/wyonsFb14zE?si=_59YKO556UHurZJI
- https://youtu.be/qa58KNo8JfA?si=X-_b1dxivObMaZKz
- https://youtu.be/ENoVL68z9PU?si=YyeXAfWCEpDq1Hww
- https://youtu.be/Le79j1ZSfKk?si=k-D8BFEqUwsjx_kl
- https://youtu.be/LlPOn0nAOeo?si=2tAqr7a9InVhvQVL
- https://youtu.be/uJnOBC9wJyQ?si=Ixmi5OvGtDEAf0-L
- https://youtu.be/UW9SiyCPOPI?si=aZHcSHIXE-dMyjBT
- https://youtu.be/KTWHdLZZdGw?si=PL3HIwjyEEVGphLY
- https://x.com/FuckedByUnity?s=09

### Dippy's Unity Packages ~~GONE 404~~ EXISTS

~~We are no longer able to find his Gumroad whatsoever. However worry not, because we have claimed those items before these disappearances. Further creation shall use these items yoinked or the reuploads. Only things we worry are the other files that may have not been claimed, who knows.~~ We found it https://dippythefoxderg.gumroad.com/ . Please refer to these files for more informations.

- https://dippythefoxderg.gumroad.com/l/DippyPushButt Button SFX
- https://dippythefoxderg.gumroad.com/l/DippyDipSauce Dip Sauce
- https://dippythefoxderg.gumroad.com/l/DippyAdStand Advertisement Stand
  
### MilchZocker's Source codes

Following are GitHub repositories allegedly a CVR project:

- https://github.com/MilchZocker/UCC-Cinema
- https://github.com/MilchZocker/UCC-Cinema
- https://github.com/MilchZocker/UCC-Infinite-Driving
- https://github.com/MilchZocker/UCC-Tutorial
- https://github.com/MilchZocker/UCC-Pen **NOTE:** Packed only in `.unitypackage` does not mean closed private. It's just need to be extracted. This may be included for convenience.
- https://github.com/MilchZocker/UCC-Swimming-System-demo
- https://github.com/MilchZocker/ChilloutVR-Dark-UI **ARCHIVED**
- https://github.com/MilchZocker/ChilloutVR-addons **ARCHIVED**
- https://github.com/MilchZocker/CVR-Player-Tracker
- https://github.com/MilchZocker/CVR-Player-Tracker
- https://github.com/MilchZocker/Cache-Auto-Delete
- https://github.com/MilchZocker/CVR-Account-Switcher
- https://github.com/MilchZocker/Beat-Together
- https://github.com/MilchZocker/Mirror
- https://github.com/MilchZocker/CVR-Player-Counter
- https://github.com/MilchZocker/CVR-Global-Position-Tracker
- https://github.com/MilchZocker/little-tokyo **EMPTY**

### Beach ball gone

https://www.dropbox.com/s/kaznw4kewte243g/CVR%20Beach%20Ball.unitypackage?dl=0 gone



## Commissions

Below are available commissions. The status, name, and optional cost to get out of procrastinations

Ready to Inquire? Contact `JOELwindows7`, Discord. **Use below DM prefix!**

### (INACTIVE) Props 0/20, US$5 + `assets_cost`/Service

DM Prefix = `PLS_CVR_PROP`

Port this 3D assets OR Pre-Propped GameObject contraption into CVR

### (INACTIVE) Avatars 0/10, US$10 + `assets_cost`/Service

DM Prefix = `PLS_CVR_AVATAR`

Port this avatar assets OR Pre-Avatared Armature into CVR

### (INACTIVE) World 0/5, US$20 + `assets_cost`/Service

DM Prefix = `PLS_CVR_WORLD`

Port this Prefabbed Scene into CVR

### Rules

- All models will be included in the repo and will be shared.
- Think 10 times before doing this commission
- Sparsdat the Assets: **NOT ACCEPTING YET**, status may change one time.
  - `NO` = Sparsdated assets nor Paywalled assets to be sparsdated will be rejected
  - `YES` = Sparsdated assets and/or Paywalled assets to be sparsdated will be accepted like normal service
  - Protolocer Probability as of 2024 for span 2000-2100 = 99.999% towards `NO`. Note = `Copyright Infringement is obvious mistake`.
  - Goned assets will still be included as per Perkedel's Archive Policy.
- Paywalled Assets: **NOT ACCEPTED**, No exclusive gift allowed, all gamers must be able to freely download. Insisting requires the source assets (especially `.blend` file) **also to be shared** both here & on Admiral Zumi's channel with full notes pointing to your name & the contract informations.
  - If you are upset about this rule, picked other commissioner & they are better than me, **then the next contract will be $0**. Do not lose the voucher.
  - If above regret contract is about the same asset, **then you'll have another $0 voucher**. FINALLY! You finally shared your sexy uwu latex avatar to all gamers, THANK YOU!! Like that.
  - **above voucher won't always apply and approval is random chance.** Do not try to abuse the system. I will see it.
- Free, unpaid commission / request may have have long procrastinations. Engage unrefundable donation in how much to our Ko-fi https://ko-fi.com/joelwindows7 to remove this procrastination, with message of case number. If you accidentally paid under, simply repay the rest, OR wait for little bit / partially boosted service to finish.
  - In random case, if I found the asset topic is being e.g. sought after, your contract may be instantly expedited **free of charge**.
  - And out of some, if this is critically sought after, **it can even bypass INACTIVE status**!! Who knows!
  - So if you are really sure that the 3D Model were sought after to be here in CVR, don't hesitate to consult with us (JOELwindows7, Discord), and we'll gladly review and discuss. 
  - Note again, you shall not expect things would be done fast.

## Sauces Total

- https://youtu.be/tnPS_l-1N94?si=ZHS3yb_UwXq7o8Bd how to prop
- https://youtu.be/a98qCeLAogw?si=y0Rjmnn5fB7sq6za how to convert from vrc to cvr
- https://youtu.be/t1dp00Ot3N8?si=vGoCEuC83_OA7C2S how to video player
- https://youtu.be/xsB__FC5Jf0?si=LKYKiIDIuRKj-wVk how to mod cvr
- https://youtu.be/8qSok3zPhvU?si=6K9KiZb6rcTz6i4k how to magica cloth
- https://youtu.be/7yAzUAkDdDI?si=z7hJQKj1KB0Y7x8n how to boop
- https://youtu.be/q-Q5EUr_6Mo?si=0Vmb741o7hcvtjt6 how to upload avatar conver from vrc
- https://youtu.be/xkRUD1Ox9rU?si=0ja5QvyXVT17Da6- chair prefab
- https://youtu.be/qkmRsS9fB1A?si=zfptjnSc8P55x4id avatar basic
- https://youtu.be/_i2GiYA1Fug?si=ymhNp4meG97M_s4q local test world
- https://youtu.be/OatATrRSO2A?si=Ix0zOX2F8w2Qx0fU how to World
- https://youtu.be/GOslhH_mlwg?si=B18KD2Tp4XA5sCfY how to upload
- https://youtu.be/XMfqNyvXMfo?si=zs0C4IvfSoulH6H1 ANJAAAAAAAY...
- https://www.nirsoft.net/ Nir Sofer's softwares full of utilities
- https://launcher.nirsoft.net/ Nirsoft launcher. Password listed on that website `nirsoft9876$`. It's like that because agressive antivirus would sus it without it.
- https://dippythefoxderg.gumroad.com/ Dippy's objects
- Incoming Howard the Alien
- https://vrcmods.com/item?id=3060
- https://www.youtube.com/watch?v=3E56N7si8XQ This
- https://mega.nz/file/sbB0BSpS#1uHZ-Y_5PN16RM6llg61THgkaSc-bEC8kKtZRUFOT28 was gone. That's the original 3D AL's Howard model.
- https://skfb.ly/6BJGR This remake one is terrible! I'd be honest with you
- https://skfb.ly/6Csn7 So we have to extract the file
- https://web.archive.org/web/20231031134535/https://mega.nz/file/sbB0BSpS#1uHZ-Y_5PN16RM6llg61THgkaSc-bEC8kKtZRUFOT28 Archive hates MEGA
- https://steamcommunity.com/sharedfiles/filedetails/?id=1622701252 and there is no time without contemplating that vast files have been gone, even beyond say, Heimdall's seeings
- https://odysee.com/@X0P1R4T3-33NSVREENMNT-0FFICIAL:f/howard-the-alien-fbx:3 Here ungoned Howard the Alien
- End Howard the Alien
- https://fluffs.gumroad.com/l/sdk3-to-cck convert Avatar VRC to CVR
- https://github.com/Narazaka/VRC2CVR Convert Avatar VRC to CVR YA!
- https://fluffs.gumroad.com/l/VRCDynamicBoneToPhysicsBoneConverter Convert VRC PhysBones to & from
- https://wetcat.gumroad.com/ oh man.. sss. Wrong dude, it's the paywall, what?! next. Wait, get all of $0 ones!
- https://chilloutvr.eu/ Unofficial ChilloutVR community Discord
- https://session.chilloutvr.eu/ Forum directory
- https://session.chilloutvr.eu/ Open Group Room directory
- https://github.com/ZettaiVR/VRC2CVR
- https://github.com/imagitama/vrc3cvr
- https://booth.pm/ja/items/4032295
- https://github.com/Dreadrith/PhysBone-Converter
- https://github.com/Markcreator/VRChat-Tools
- https://github.com/Markcreator/Unity-Tools
- https://youtu.be/hr7GyFM7pX4?si=4vFs6RgKwFHShIiC DairyOrange Fart Extra Reverb
- https://github.com/MilchZocker?tab=repositories Source code of every MilchZocker
- https://mikedabird.itch.io/avigen
- https://docs.google.com/document/d/1diQRcDXPP_qaf0yT6INq4UhrhlawIQ_GLs2yjtUutAE/edit#heading=h.p9e4plmyq5cr
- https://github.com/llealloo/vrc-udon-audio-link
- https://github.com/DomNomNomVR/cvr-audio-link
- https://askubuntu.com/questions/1381100/no-longer-able-to-download-youtube-using-youtube-dl-how-do-i-fix-this-problem
- https://emojipedia.org/guy-fawkes?emoji=guy-fawkes
- https://blog.emojipedia.org/samsung-one-ui-6-0-emoji-changelog/
- https://blog.emojipedia.org/microsoft-windows-11-23h2-emoji-changelog/
- https://sponsor.ajay.app/
- https://dearrow.ajay.app/
- https://wiki.sponsor.ajay.app/w/Guidelines
- https://github.com/yt-dlp/yt-dlp#standalone-py2exe-builds-windows
- https://docs.python.org/3/library/zipimport.html
- https://en.wikipedia.org/wiki/Beerware
- https://github.com/TayouVR/CVR-CCK
- https://www.youtube.com/watch?v=bALvLFDcDvY
- https://arkorenart.gumroad.com/l/spectrum
- https://www.reddit.com/r/ChilloutVR/comments/17nvoe3/virtual_reality_mastodon_instance/?utm_source=share&utm_medium=web2x&context=3
- https://www.reddit.com/r/ChilloutVR/comments/17nmrgo/friday_night_drinking_night/?utm_source=share&utm_medium=web2x&context=3
- https://www.reddit.com/r/ChilloutVR/comments/wctfy4/finally_ported_all_my_public_avatars_over_to_cvr/?utm_source=share&utm_medium=web2x&context=3
- https://twitter.com/Shelfen90/status/1505330028057403392
- https://twitter.com/B33_Bratty/status/1505832109616742400
- https://www.youtube.com/watch?v=SyLuutxY_mM
- https://www.youtube.com/watch?v=SyLuutxY_mM
- https://www.patreon.com/poiyomi/posts
- https://sfbgames.itch.io/chiptone Generate SFX pls!!!!!
- https://discord.gg/sHN9x2n2j8 STARCVR pls
- https://drive.google.com/file/d/1P-Tds7rIppLZAZ2JG-6d7nv9rhS-caHl/view Disconeer Bean Staff
- https://twitter.com/Khodrin3D/status/1474042570238042122
- https://khodrin.com/christmas-scarf/ OOOOOO!!!
- end STARCVR
- https://docs.unity3d.com/ScriptReference/ParticleSystem.Clear.html
- https://kenney.nl/assets/furniture-kit
- https://www.reddit.com/r/gamedev/comments/7nvqwj/heres_120_furniture_models_including_isometric/
- https://www.blender3darchitect.com/furniture-models/120-free-low-poly-furniture-models/
- https://github.com/ValveSoftware/steam-audio Will you pls install Steam Audio pls?!??!?!?!??!
- https://discord.com/invite/K6tsPtsgd7 Kjoy's Discord Server pls. We got it from Steam Audio sample world!
- https://steamdb.info/app/661130/history/?changeid=20993745
- https://youtu.be/srrW9TTKnlg?si=SrPXvKgcNjW_Yfba Tye. How am I supposed to avatar with fresh pure package?!?!?
- https://youtu.be/I5dSZ3FZShM?si=qcAc8SPCfyFSS2m8 quick convert vrc to cvr avatar
- https://freesound.org/people/loudernoises/sounds/332808/ Synthetic 100 BPM heartbeat sound iyey

## sovania

by JOELwindow7  
Perkedel Technologies  
Our Assets = CC4.0-BY-SA  
Our Codes = GNU GPL v3  
