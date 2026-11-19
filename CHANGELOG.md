# Changelog

All notable changes to OBS Companion. Versions marked "preview" work but are still young.

## 0.6.0-preview

First public preview.

**Directing**
- Watches your table cameras and cuts to another camera, or to a holding scene, when the table is blocked; comes back when it's clear. Modes: Off (watch only), Assist (suggests) and On (switches by itself).
- Steps back whenever you change something in OBS yourself, and resumes after you've been idle or when you press **Resume automation now**.
- Live scene tiles show what each scene looks like right now.

**Scores and replays**
- Writes names, scores and the race into your OBS text sources, or use the built-in score bar as a Browser source.
- Shows the winner scene and saves a replay when a match is won.
- Optional: follow a LeagueOrbit table for live scores.

**Your OBS setup and stream settings (new)**
- **Which OBS:** finds OBS Studio whether it's installed, from Steam, or portable. **Browse…** if it can't; the chosen program is checked and never run.
- **Your current OBS setup:** your profile, this computer's processor, graphics card and memory, the encoders OBS has, and what each scene is for. Your stream key shows only as "set" or "not set".
- **Best stream settings for this computer:** encoder, bitrate, resolution, frame rate, keyframes, audio and recording, each with a one-line reason, for YouTube, Twitch, Facebook, Kick or a custom server.
- **Apply as a new OBS profile** puts them in a separate profile and switches after you confirm. Your own profile is never changed; **Switch back to my profile** undoes it. Nothing is applied while you're live or recording.

**Ready-made scenes (new)**
- One click builds Main camera, Camera 1 (PIP 2), Camera 2 (PIP 1) and Be right back. Your logo, sponsor and picture sit in the same place and size in every one of them.
- A framed picture-in-picture for the second camera: drag it anywhere, snap it to a corner, resize it, and pick the border colour, width, corners and shadow. **Swap cameras** switches main and PIP.
- Your own scenes are never changed. **Repair scenes** puts back anything missing.

**Buttons, media and music**
- One-tap buttons for scenes, sources, sounds, pictures and sponsor banners.
- Works with the optional [OBS Companion AI Music](https://github.com/support-leagueorbit/OBS-Companion-AI-Music) app: start it, add it to OBS, and play or stop music from a button.

**AI assistants**
- MCP over stdio or HTTP. An AI can help direct but can't start streaming, turn automation on, take control from a person or change settings. It can read the stream-settings recommendation but not apply it.

**Install**
- Windows Setup program (per user, no administrator rights), macOS and Linux archives, and one-command installers that check SHA-256 before installing.

**Known limits**
- Windows builds aren't code-signed and macOS builds aren't notarised (see the README).
- macOS and Linux builds have had less testing than Windows. macOS has no tray icon yet.
- Upload speed for the stream-settings advice is typed in by you.
