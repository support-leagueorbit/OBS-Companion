# Changelog

All notable changes to OBS Companion. Versions marked "preview" work but are still young.

## 0.8.1-preview

**Hotkeys**
- **Hotkeys** in Settings: use the control page's shortcuts while OBS or a game has the focus (Windows; off until you switch them on). **Ctrl+Alt+Shift** plus the page's key switches scenes, presses custom buttons, scores, saves a replay or changes mode, and each key can be changed or turned off. No hotkey starts or stops the stream.
- **Stream Deck** and macro pads: point a Stream Deck **Hotkey** button at an OBS Companion hotkey (F13–F24 work on their own). See the user guide.

**Score overlays you already use**
- Paste the control link of a score overlay you already use (the Blue Ridge BCA stream overlay to start with) and OBS Companion keeps its score in step. Switching it on asks first. If the score is changed on the overlay's own page, OBS Companion asks which score is right instead of overwriting it. The link is kept in the computer's keychain and never shown again.

**Accessibility**
- Screen readers describe the live program picture: which scene is on air and the score. The Studio Mode preview names its scene.

## 0.8.0-preview

**Filters and plugins**
- Copy a source's filters and paste them on other sources and scenes, or export them to a file and import them. Any filter your OBS has works, including plugin filters such as Audio Monitor. Before anything changes you see filters whose plugin isn't installed, names already in use, where an Audio Monitor sends sound, and any files the filters use. Each filter's result is shown, and the paste can be undone.
- **OBS plugins** card on the OBS tab: which plugins your OBS has (recognised from the filters, sources and outputs they add) and what OBS Companion can do with each. It knows Audio Monitor, Aitum Multistream and DistroAV (NDI), and lists other plugins' filter kinds.
- **Audio Monitor** in the audio mixer: a switch per source says which device it also plays on (for example "Also on Headset"), and **Add Audio Monitor…** copies a working one from another source.
- **DistroAV (NDI)** in the plugins card: add an NDI camera, send a scene or source over NDI, and start or stop the NDI main or preview output (after you confirm).
- **Aitum Multistream** with Go live: tick which of Aitum's outputs (for example Facebook) start with your main stream. Go live names every output it starts and you confirm once; each output's result is shown, and End stream stops them too. Stream keys stay in Aitum, never in OBS Companion.

**Accessibility**
- In the overlay editor, moving an item with the arrow keys stops at the centre and safe-area lines, as dragging does; press again to go past.

**Stream settings**
- While you stream, **Connection** on the OBS tab says whether your connection keeps up, from OBS's own counters (nothing extra is sent). If it doesn't, it suggests a lower bitrate; nothing changes until you set it.
- A graphics adapter whose name merely contains "arc" (some virtual display adapters) is no longer taken for an Intel Arc card when picking the encoder.

## 0.7.0-preview

**Accessibility**
- Text and buttons meet the WCAG AA contrast level in both the dark and the light theme (white text on blue buttons was too faint in the dark theme).
- Works in Windows high-contrast mode: switches, the pressed Off/Assist/On button and the selected tab now show clearly.
- Screen readers hear changes nobody at this computer made: the scene on air, the score and a match win, the mode, the stream going live or ending, and OBS connecting or dropping.
- The page starts in your computer's light or dark setting until you pick a theme.
- The user guide lists every keyboard shortcut (**?** on the page shows them too).
- Dialogs keep the keyboard inside them and put it back where you were when they close. The overlay editor works from the keyboard.
- The control page works at 200 % and 400 % browser zoom, and the phone app at Android's largest font and display size: every control can be reached and no text is cut off.
- The phone app tells TalkBack about the scene on air, the score, the mode and the stream, and which toggles are on.

**Phones**
- The phone connection's certificate is never replaced silently. If it's damaged while phones are paired, phones are turned off and the Phones page, the activity list and the log say what happened and what to do (see the user guide).

**Install and uninstall**
- The one-line install commands (`irm … | iex`, `curl … | sh`) are gone, also from 0.6.0-preview: they ran a script from the internet before anything could check it, and the scripts had a fault that stopped them working. Download the Setup program or the archive, check it against `SHA256SUMS` (the README shows the command), then run it.
- If an update can't copy the new version (a full disk, a virus scanner holding the file), the version you had is put back instead of leaving no program.
- Uninstalling a second copy (say, a test copy) no longer removes the other copy's start-at-sign-in entry, Apps & features entry or Start menu shortcut.
- The tray's **Start when I sign in** appears only in the installed copy, and its tick shows whether it starts that copy.

**Reliability**
- The phone connection's key and certificate are saved so that a crash or power cut leaves the old file, never a half-written one.
- The media library replaces a stored file that was cut off or damaged instead of reusing it when you send the same file again, and sending a file that's already stored no longer fails when the library is full.

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
