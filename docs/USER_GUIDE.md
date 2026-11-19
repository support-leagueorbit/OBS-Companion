# OBS Companion: user guide

OBS Companion sits next to OBS on your streaming computer and helps direct the stream of a table game: pool, darts, cornhole and similar. It:
- cuts away when someone blocks the table camera, and comes back when the view is clear;
- keeps the score on screen;
- saves a replay when a match is won;
- lets an AI assistant help.

You stay in charge: anything you do in OBS or on the control page takes priority.

---

## 1. Setup (5 minutes)

### Turn on OBS's WebSocket server
1. In OBS (version 28 or newer), open **Tools > WebSocket Server Settings**.
2. Tick **Enable WebSocket server**.
3. Keep **Enable Authentication** on. OBS makes a password for you.
4. Click **Apply**.

**Show Connect Info** in the same dialog shows the server's address, password and a QR code. You don't need them: OBS Companion runs on the same computer and reads the address and password from OBS's own settings. It keeps the password in memory only and never shows, saves or sends it anywhere.

### Start OBS Companion
- **Windows / Linux:** double-click `obs-companion`. A small table icon appears in the system tray, and the control page opens in your browser, already signed in.
- **macOS:** double-click `obs-companion`. The control page opens. There is no tray icon yet; keep the page open and use `obs-companion open` to reopen it.

If the page says **Not signed in**, open it again from the tray icon (**Open control page**) or run `obs-companion open`. For your safety the page only opens through the companion itself (see section 6).

Check what it found: the **Live** tab shows "Connected to OBS", your OBS version and your scenes. To get recommendations for your current setup, run `obs-companion analyze`. It tells you, for example, if there's no fallback scene or only one camera.

### Your OBS setup and the best stream settings (OBS tab)
Open the **OBS** tab and scroll below the scene and audio panels. Three cards help you start from what you already have.

**Which OBS.** The companion looks for OBS Studio on this computer: the installed copy, a Steam copy, and portable copies (a portable OBS keeps its settings inside its own folder, and the companion reads them from there). Each one found is listed with its version; the one marked **in use** is the one whose settings are read. If you have more than one, press **Use this one** next to the one you stream with.
- OBS not found, or you want a different one? Press **Browse…** and pick `obs64.exe` (in OBS's `bin\64bit` folder). The companion checks the file really is OBS Studio before using it, and remembers your choice. It never runs the file you pick.
- Only have a copied OBS settings folder (no OBS installed)? Press **Choose a settings folder…** and pick the folder (usually called `obs-studio`).
- **Find automatically** forgets your choice.
- OBS 27 or older is marked **too old**: update OBS to 28 or newer, which has the WebSocket server built in.
- On macOS and Linux there is no Browse button yet: type or paste the path (for example `/Applications/OBS.app`) and press **Use this path**.
- After choosing a different OBS, restart the companion so it connects with that OBS's WebSocket password.

**Your current OBS setup** shows:
- your current profile: where you stream to, encoder, bitrate, resolution and frame rate, audio, recording, replay buffer and hotkeys;
- this computer as OBS last reported it: processor, graphics card and driver, memory and display;
- the encoders your OBS really has;
- each scene's role (table camera or holding scene).

Your stream key is never read or shown; you only see whether one is set. **Use this setup as the starting point** takes your holding (fallback) and winner scenes from the scene names. It then opens camera setup with the table scenes already picked.

**Best stream settings for this computer** recommends settings and gives the reason for each one:
- **Encoder:** your graphics card's encoder (NVIDIA NVENC, AMD AMF, Intel Quick Sync or Apple VideoToolbox) if OBS has it, with AV1 or HEVC where your platform accepts them (YouTube does; Twitch, Facebook and Kick take H.264). Otherwise x264 on the processor.
- **Bitrate:** constant bitrate within your platform's limit, leaving a quarter of your upload spare. Choose where you stream in **Streaming to**, type your **Upload speed (Mbps)** (measure it at the venue with any speed test), and press **Update**. Until you do, it assumes a typical 6,000 kbps.
- **Picture:** 1080p at 60 fps when the encoder and bitrate allow it. Balls and darts move fast, so it picks 720p60 before 1080p30. If your cameras only send 30 fps, it stays at 30.
- **The rest:**
  - keyframes every 2 s, the encoder's quality preset and B-frames;
  - NV12 and Rec. 709 colour;
  - 48 kHz audio at 160 kbps;
  - dynamic bitrate and network optimizations;
  - Hybrid MP4 recordings that reuse the stream's encoding.
- **OBS process priority** is an OBS-wide setting, marked **set it in OBS**: set it yourself in OBS.

**Apply as a new OBS profile** puts the settings into a new OBS profile called **OBS Companion recommended** and switches OBS to it, after you confirm with **Apply and switch**. Your own profile is never changed.
- Afterwards you see **What changed** (every setting, before and after) and a check that OBS loaded the settings.
- **Switch back to my profile** returns to your own profile at any time.
- Pressing the button again (**Update the OBS profile and use it**) updates the recommended profile. Its earlier files are kept in a `companion-backup` folder inside that profile.
- The new profile has your stream service and server, but **not your stream key or account sign-in**. After switching, paste your key (or connect your account) once in **OBS › Settings › Stream**.
- Applying and switching back wait while OBS is streaming, recording or running the replay buffer.
- Only a person can apply or switch back. An AI assistant can read the recommendation (MCP tool `get_stream_recommendation`) but can't apply it.

### Ready-made scenes (OBS tab)
**Ready-made scenes**, at the top of the OBS tab's setup area, builds a set of scenes with the same layout everywhere:

| Scene | What it shows |
|---|---|
| **Main camera** | Camera 1, full screen. |
| **Camera 1 (PIP 2)** | Camera 1 full screen, with camera 2 in a framed picture-in-picture (PIP). |
| **Camera 2 (PIP 1)** | Camera 2 full screen, with camera 1 in the PIP. |
| **Be right back** | A holding scene. |

Every one of them shows your **logo** (top left), **sponsor** (top right) and **picture** (bottom right) in exactly the same place and size, because they come from one shared slot set: change the logo once and it changes everywhere.

1. Pick **Camera 1 (main)** and **Camera 2** from your OBS video sources, then press **Set up scenes**.
2. Under **Logo, sponsor and picture**, pick each from your media library (upload them in the Media tab first). An empty slot shows nothing.
3. Under **Picture-in-picture**:
   - Drag the PIP where you want it, or click it and use the arrow keys (Shift for bigger steps).
   - Or use **Bottom left**, **Bottom right**, **Top left** or **Top right**.
   - **Size** makes it bigger or smaller.
   - **Border colour**, **Width**, **Corners** and **Shadow** style the frame; press **Apply border**.
   - The PIP is in the same place in both camera scenes, and the border always moves with the camera. If you move the PIP in OBS itself, the companion copies it to the other camera scene the next time you open this card.
4. **Swap cameras** switches between **Camera 1 (PIP 2)** and **Camera 2 (PIP 1)**, so the main camera and the PIP change places. It follows the usual rules for switching, so an AI may press it too.
5. Each ready-made scene can hold one **LeagueOrbit overlay** on top: **Add LeagueOrbit overlay…** picks one, **Change** replaces it, **Remove** takes it away. This appears once LeagueOrbit sign-in is available (see LeagueOrbit below).

Good to know:
- Your own scenes are never changed. If you already have a scene called "Main camera" (or any of the names above), the companion makes "Main camera (Companion)" instead.
- **Repair scenes** puts back anything missing or moved in the ready-made scenes, and keeps your choices.
- If you haven't chosen a holding scene yet, **Be right back** becomes it (shown when every camera is blocked; change it in Settings › Scenes).
- To have the companion cut away when someone blocks the table, press **Teach it where the table is**: camera setup opens with both camera scenes already picked.
- An AI assistant can swap cameras with the MCP tool `swap_cameras` (same rules as switching scenes).
- OBS's scene list also shows three helper scenes starting with "Companion:" (the shared logo slots and the two PIP frames). Leave them in place; they're what keeps everything identical.
- Setting up and changing the scenes is for a person only. An AI assistant can switch to them but can't change them.

---

## 2. Cameras: teach it where the table is

Do this once per camera angle, with the table clear of people.

1. Open the **Cameras** tab.
2. **Scene:** pick the OBS scene that shows this camera, for example "Table 1 overhead".
3. **Camera source:** pick the camera input in that scene.
4. Click **Grab frame**. A still from the camera appears.
5. Click the **corners of the playing surface**, inside the rails. Use four clicks for a normal table, or up to 12 points for odd shapes. **Clear corners** starts again.
6. Click **Save camera**. The felt colour is learned automatically from the area you outlined.

Repeat for every angle. The **first camera in the list is the preferred view**: the companion returns to it whenever it's clear. Use ↑ to reorder and **Remove** to delete.

**What it watches**
- About once a second it takes a small snapshot of each camera and measures how much of the table's felt it can see.
- A camera counts as **blocked** after about 3 seconds with much of the table hidden, for example by a person standing in front of it. It counts as **clear** again after about 4 seconds of a clear view. Balls, cues and hands don't count.
- A black or frozen-colour feed (camera unplugged) counts as blocked.
- Lighting changes are tolerated. If you change the cloth or move the camera, calibrate again.

**What it does (mode On)**
- If the scene on air shows a blocked camera, it cuts to the **clearest other camera**.
- If every camera is blocked, it cuts to your **fallback scene**.
- When the camera it left is clear again, it **cuts back**.
- It only switches between the scenes you set up as cameras and the fallback scene. If you've chosen some other scene yourself, it leaves it alone.

**Rack hints (pool):** the preferred camera also notices when the table has been **cleared** (last ball down) and when a **new rack** is set. These appear as hints on the Live tab and to AI assistants: "the table looks cleared: was a game won?". They **never change the score by themselves**. You, or an AI you've allowed to score, decide who won.

---

## 3. Settings

### What automation and AI may control
These switches decide what the companion may do on its own and what an AI may do. **You can always do everything from the control page yourself.**

| Setting | Default | Allows |
|---|---|---|
| Switch scenes | on | camera cuts, fallback, winner scene |
| Write scores into OBS text | on | updating your score text sources |
| Show/hide sources | on | e.g. a sponsor banner, by AI request |
| Replay buffer | on | saving replays (automatically on a match win) |
| Start/stop recording | **off** | AI or automation recording |
| Audio mute/volume | **off** | AI muting, e.g. bar music |

**Streaming is never on this list.** The companion never starts or stops your stream, and no AI can.

### Scenes
- **Fallback:** shown when every camera is blocked, for example a wide shot, a scoreboard or "Be right back".
- **Winner scene:** shown for a few seconds when a match is won (set the time with **Show winner for**), then the companion goes back.
- **Person keeps control for:** how long the companion waits after you last changed something in OBS before it acts again. The default is 60 seconds.
- **Never touch:** scenes the companion and AI will never switch to or away from, for example an interview scene.

### Score text sources
Choose which OBS **text sources** show Name A, Score A, Name B, Score B and the race. The companion writes into them on every score change. To use the built-in score bar instead, add a **Browser source** in OBS with the URL `http://127.0.0.1:8765/overlay/score` at 1920×1080.

### Scoring
On the **Live** tab:
- **New match:** enter the names and the race (games needed to win; 0 for no limit).
- **+1** for a game won by A or B.
- **Undo** reverts the last change.

When a side reaches the race, the match is won: the winner scene shows and a replay is saved (if the replay buffer is running).

### LeagueOrbit (optional)
Tick **Follow a LeagueOrbit table** and paste the table's **overlay link code**. Scores and match wins then come from LeagueOrbit. The code only lets the companion **read** the score: nothing is ever sent back with it. This needs LeagueOrbit's companion feed; until LeagueOrbit offers it, keep using LeagueOrbit's own browser-source overlay as usual.

**LeagueOrbit account (coming in a later version).** Settings › LeagueOrbit will offer **Sign in with LeagueOrbit**. It opens LeagueOrbit's own sign-in page in your browser: your password is only ever typed there, never into the companion. Your sign-in is kept in your computer's own password store (Windows Credential Manager, the macOS keychain, or your Linux desktop's keyring), and your plan keeps working without internet for up to 3 days after it last checked. It checks about once an hour, and after being offline (or after your computer wakes from sleep) it checks again within minutes. If your computer's clock is set back, the plan shows as Free until the clock is right. **Sign out** ends the sign-in on LeagueOrbit too, and removes it from this computer even when you're offline. It also takes the LeagueOrbit overlays that need a sign-in out of your ready-made scenes (the free one stays). Uninstalling removes the sign-in as well; on macOS and Linux, run `obs-companion forget-signin` before deleting the program. Until then the page says sign-in is coming, and everything works without an account.



---

## 4. Modes: Off, Assist, On

- **Off:** watch only. Nothing is changed in OBS except what you click yourself.
- **Assist:** the companion suggests ("switch to Side camera: Overhead is blocked") but doesn't act.
- **On:** the companion switches by itself, within the settings above.

The tray icon has the same three choices.

### Keyboard and display

Everything on the control page works from the keyboard: **Tab** moves between controls (the focused one has a blue ring), and **Enter** or **Space** presses it. **Esc** closes a dialog. When you're not typing in a box, these shortcuts work too:

| Key | What it does |
|---|---|
| **1**–**9** | Switch to scene 1–9 |
| **Shift**+**1**–**9** | Press custom button 1–9 |
| **Space** | Transition (in OBS Studio Mode) |
| **A** / **B** | +1 game for player A / B |
| **Z** | Undo the last score change |
| **R** | Save a replay |
| **M** | Change mode: Off › Assist › On |
| **L** | Show the activity log |
| **?** | Show these shortcuts |

In the overlay editor, **Tab** reaches each item on the canvas: the **arrow keys** move it (**Shift** moves further), **Alt**+arrows resize it, and **Delete** removes it.

The sun/moon button at the top switches between the dark and light theme. Until you choose one, the page follows your computer's light or dark setting. Text in both themes meets the WCAG AA contrast level, and animations are reduced when your computer asks for less motion.

---

## 5. Connecting an AI assistant (MCP)

Any assistant that supports **MCP** (Claude Desktop, Claude Code and many others) can work with the companion **while it's running**.

**Assistants that start a program** (most desktop apps): add an MCP server with
- command: the full path to `obs-companion`
- arguments: `mcp`

**Assistants that connect over HTTP:**
- address: `http://127.0.0.1:8765/mcp`
- header: `Authorization: Bearer <AI key>`

The AI key is in the file `ai-token` in the companion's settings folder:

| System | Folder |
|---|---|
| Windows | `%APPDATA%\obs-companion` |
| macOS | `~/Library/Application Support/obs-companion` |
| Linux | `~/.config/obs-companion` |

**What the assistant can do:**
- read the status, the score and the camera views;
- switch scenes;
- record game wins, set or undo scores, start a new match;
- save replays;
- show or hide sources, mute audio, start or stop recording (only if allowed in Settings);
- analyse your OBS setup.

**What it can't do:**
- start or stop streaming;
- turn automation **on** (it may only turn it off);
- take control back from you;
- touch never-touch scenes;
- change settings or calibrate cameras;
- see your LeagueOrbit code.

To stop an AI recording scores, untick **AI may record scores**.

---

## 6. Safety model

**You always win.**
- Anything changed in OBS that the companion didn't do (a scene click, a source toggled, a text edited) means a person is in control. The companion and any AI pause until you've been idle for the time you set, or until you click **Resume automation now**.
- People beat AI, and AI beats automatic rules.

**Streaming is human-only.** Nothing in the companion can start or stop your stream.

**Your computer only, by default.**
- The control page and API listen on this computer only (127.0.0.1).
- Websites can't control it through your browser: requests from other sites, and pages that try to trick the browser with their own domain name, are refused.

**Keys.** Two random keys live in the companion's settings folder, which only your user account can read:

| Key file | Used by | Notes |
|---|---|---|
| `api-token` | You and your tools | Full control. Keep it private. |
| `ai-token` | AI assistants | Always treated as an AI, whatever it claims. |

**Signing in to the control page.** The tray icon and `obs-companion open` pass a one-time sign-in code in the part of the address after `#`. Browsers never send that part to any server. The page trades the code for a sign-in cookie that other sites can't use. Other people using the same computer can't sign in, because they can't read your key files.

**It checks it's talking to itself.** Before sending a key, the tray and the AI bridge check that the program answering is really your OBS Companion. A program that took over its port gets nothing.

**OBS password.** It is read from OBS's settings on this computer and kept in memory only.

**A note on AI assistants with full computer access.** Some AI tools can run any program or read any file as you (Claude Code, for example). Such a tool could read your `api-token` and act as you. Give those tools the same trust you'd give a person at your keyboard, or run them under a separate account.

### Music (AI Music app)
Royalty-free background music from the AI Music app on the same computer. It's off until you turn it on.

1. Start the AI Music app, then in Companion go to Settings → **Music** and turn on **Use the AI Music app**. The card says *Connected* when Companion finds it.
2. **Per scene:** pick a style and mood for any scene. When that scene goes live, whoever switched to it, the music changes at the next bar. Scenes left on *(leave music as is)* don't change the music.
2b. **Hearing it on stream:** OBS only plays the music if it has a source for it. In the **Music** tab, step **2. Music in OBS**, click **Add music to OBS** (it adds a source called **AI Music** to your scenes). The sound library in step 3 is optional.
3. **Buttons:** add a **Play music** or **Stop music** step to any button. An AI assistant can only change music by pressing a button you've marked "AI may press".
4. **Commentator:** with **Turn the music down while the commentator speaks** on, the music dips (−12 dB by default) and comes back afterwards. If Companion closes mid-line, the music app restores the level by itself within 30 seconds.

**Music tab:** pick a style with one click, add or remove instruments for the music that's playing, mute a part with its switch, and save the result as your own style. Changes mix in over a few seconds at the next bar. **Full editor** opens the music app's own editor inside the tab. It also has a **Sound library** panel (to download the larger sound set) and tune settings. Instruments whose sound library isn't installed yet are greyed out and say so. A paired phone has the same Music panel.

**Music engine:** Companion's installer can include the music engine (it asks, only when the engine file is next to the setup program). Turn on **Start the music engine with Companion** and Companion starts it for you, and stops it when Companion closes. It never stops an engine you started yourself. The large sound library is a separate download; without it the engine uses a built-in synthesized sound.

Safety: Companion only talks to the music app on this computer. It checks the app's identity before sending its key, and never shows or logs the key.

### Phone app (Companion for Android) (coming soon)
> **Coming soon.** The Android app is in testing and isn't published yet. This section describes how it will work.

Control the stream from a phone on the same Wi-Fi as the PC.

**Pair a phone (once):**
1. On the PC: Settings → **Phones** → turn on **Let paired phones control the stream**, then press **Pair a phone**. A QR code and an 8-character code appear for 5 minutes.
2. On the phone: open Companion → **Scan the QR code**. No camera permission is needed. If scanning isn't possible, open **Type it in instead** and enter the PC's address, the fingerprint shown on the PC and the code.
3. The phone appears in the PC's list of paired phones. **Unpair** removes it at once.

**What the phone can do:** everything a person at the PC's control page can do: switch scenes (you take control from the auto director; **Hand back to auto** returns it), score, buttons, audio meters, director mode, recording and replays, camera health, and sending photos to the media library and showing them on the current scene. **Go live / End stream** always asks you to confirm.

**Cameras card:** once the ready-made scenes are set up on the PC (OBS tab), the **Live** tab shows a **Cameras** card: a small picture of the layout, which camera is main and which is picture-in-picture, and a **Swap cameras** button. One tap switches to the other camera scene ("Camera 1 (PIP 2)" ↔ "Camera 2 (PIP 1)"). Like any scene switch, this takes control from the auto director until you press **Hand back to auto**. Moving the picture-in-picture box, the border, the logo slots and the overlays are set on the PC.

**TalkBack and large text:** every control has a spoken name, the on-air scene and the selected Auto director mode are read as selected, and the phone reads out changes made elsewhere (the scene on air, the score and a win, the mode, the stream going live or ending) as well as its own messages. Text and buttons meet the WCAG AA contrast level.

**What it can't do:** see secrets (it shows only whether the LeagueOrbit code is set), change settings or security, pair other phones, install or delete graphics packs, or check for updates. Those stay on the PC.

**Security:** the phone talks to the PC over encrypted TLS on port 8767, and only to the exact PC it paired with (it checks the certificate fingerprint from the QR). The phone keeps its key in Android's encrypted storage, and the PC stores only a hash of it. Pairing attempts are limited to 5 a minute per device. If the phone says *"This isn't the companion you paired with"*, the PC's certificate has changed: unpair and pair again, and if you didn't reinstall the companion, check your network.

**Troubleshooting:** the phone must be on the same network as the PC, and Windows may ask you once to allow OBS Companion through the firewall on private networks. **Look for PCs on this network** finds PCs that have phones turned on.

If the Phones section says **"phones are off: the phone certificate … can't be loaded"**, the file the phones trust is damaged. The companion leaves it alone so your paired phones aren't cut off without warning. Restore `tls-cert.pem` and `tls-key.pem` from a backup, or delete both files (the message names the folder), restart the companion and pair the phones again.

---

## 7. Troubleshooting

| Problem | Fix |
|---|---|
| "Not connected to OBS" | Is OBS open? Is the WebSocket server enabled (section 1)? OBS's Safe Mode doesn't start it: restart OBS normally. |
| "Not signed in" | Open the page from the tray icon or with `obs-companion open`. |
| Cameras never show blocked | Recalibrate with the table clear; outline only the playing surface. |
| Cuts away when nothing is in the way | A busy cloth or strong shadows. Recalibrate, or outline a smaller area. |
| The companion doesn't act | Mode must be **On**, **Switch scenes** must be allowed, and the page shouldn't say "A person is in control". |
| AI says "isn't running" | Start OBS Companion first. AI assistants talk to the running app. |
| Where's the log? | `obs-companion.log` in the settings folder (section 5). |
