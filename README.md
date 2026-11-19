# OBS Companion

**A stream director for table games (pool, darts, cornhole and similar) that sits next to OBS Studio.**

OBS Companion watches your table cameras and directs OBS for you:
- cuts to another camera or a holding scene when someone blocks the table, and back when it's clear;
- keeps names and scores on screen, and shows a winner scene and saves a replay when a match is won;
- builds ready-made scenes with your logo, sponsor and picture in the same place everywhere, and a framed picture-in-picture for a second camera that you can drag anywhere and swap with one click;
- finds your OBS Studio, reads your current setup, and recommends the best stream settings for your computer (encoder, bitrate, resolution, frame rate), each with a reason;
- works with your OBS plugins: copy and import filter setups between sources and computers, and use Audio Monitor, Aitum Multistream (for example Facebook alongside YouTube) and DistroAV (NDI) from the control page;
- lets an AI assistant help through MCP, while a person always stays in charge.

Made by **LeagueOrbit**. Current version: **0.8.3-preview** ([what's new](CHANGELOG.md)).

> Preview release: it works, but it's still young. macOS and Linux builds are provided but have had less testing than Windows.

## What you need

- **OBS Studio 28 or newer** on the same computer (it has the WebSocket server built in).
- **Windows 10 or 11** (64-bit). The control page opens in its own window (Microsoft Edge WebView2, built into Windows 11 and most Windows 10 PCs), or in your browser if WebView2 is missing.
- **macOS 12 Monterey or newer** (Apple silicon or Intel), or **Linux** (64-bit PC or ARM 64-bit) with a web browser.
- Your table cameras added to OBS as sources, one scene per camera.
- No administrator rights: it installs for your user account only.

## Download and install

1. **Download** the file for your computer, and `SHA256SUMS`, from the [latest release](https://github.com/support-leagueorbit/OBS-Companion/releases/latest):

   | Computer | File |
   |---|---|
   | Windows 10/11 (64-bit) | [OBS-Companion-Setup-windows-amd64.exe](https://github.com/support-leagueorbit/OBS-Companion/releases/latest/download/OBS-Companion-Setup-windows-amd64.exe) |
   | macOS, Apple silicon (M1 and later) | [obs-companion-darwin-arm64.tar.gz](https://github.com/support-leagueorbit/OBS-Companion/releases/latest/download/obs-companion-darwin-arm64.tar.gz) |
   | macOS, Intel | [obs-companion-darwin-amd64.tar.gz](https://github.com/support-leagueorbit/OBS-Companion/releases/latest/download/obs-companion-darwin-amd64.tar.gz) |
   | Linux, 64-bit PC | [obs-companion-linux-amd64.tar.gz](https://github.com/support-leagueorbit/OBS-Companion/releases/latest/download/obs-companion-linux-amd64.tar.gz) |
   | Linux, ARM 64-bit | [obs-companion-linux-arm64.tar.gz](https://github.com/support-leagueorbit/OBS-Companion/releases/latest/download/obs-companion-linux-arm64.tar.gz) |
   | Checksums | [SHA256SUMS](https://github.com/support-leagueorbit/OBS-Companion/releases/latest/download/SHA256SUMS) |

2. **Check it** in the folder you downloaded to. The number must match the file's line in `SHA256SUMS`; if it doesn't, delete the file and download it again.
   - Windows (Command Prompt or PowerShell): `certutil -hashfile OBS-Companion-Setup-windows-amd64.exe SHA256`
   - macOS: `shasum -a 256 obs-companion-darwin-arm64.tar.gz` (or `-darwin-amd64`)
   - Linux: `sha256sum --ignore-missing -c SHA256SUMS` (prints `OK` for the file you downloaded)

3. **Run it.**
   - Windows: double-click the Setup program. It installs for your user account only.
   - macOS and Linux: unpack the archive (`tar -xzf <file>`) and run `obs-companion` in the `obs-companion` folder.

There is no one-line install command on purpose: piping a script from the internet into a shell runs it before anything can be checked.

### "Windows protected your PC" / "unknown publisher"

OBS Companion isn't signed with a paid code-signing certificate, so the first time you run the Setup program Windows SmartScreen may show a blue box saying *Windows protected your PC* (publisher: unknown). Click **More info**, then **Run anyway**. Only do this for a file you downloaded from this repository's [Releases page](https://github.com/support-leagueorbit/OBS-Companion/releases) and checked as above. On macOS, a file downloaded in a browser may need **right-click › Open** the first time.
## First run

1. **Turn on OBS's WebSocket server:** in OBS, **Tools › WebSocket Server Settings › Enable WebSocket server** (keep authentication on), then **Apply**. OBS Companion reads the password from OBS on the same computer and keeps it in memory only.
2. **Start OBS Companion.** The control page opens, already signed in. On Windows and Linux a small table icon in the system tray reopens it.
3. **Find your OBS** (**OBS** tab › **Which OBS**): the installed copy, a Steam copy and portable copies are found automatically. If yours isn't listed, press **Browse…** (Windows) or paste its path.
4. **Import your setup** (**OBS** tab › **Your current OBS setup**): it reads your scenes, profile and this computer's hardware. Your stream key is never read. **Use this setup as the starting point** picks your holding and winner scenes and opens camera setup.
5. **Best stream settings** (**OBS** tab): type your upload speed and check the recommendation. **Apply as a new OBS profile** puts it in a separate profile; your own profile is never changed, and **Switch back to my profile** undoes it.
6. **Cameras** tab: for each table camera, grab a frame with the table clear and click the table's corners.
7. Optional: **OBS** tab › **Ready-made scenes**: pick camera 1 and camera 2 and press **Set up scenes**.

The full guide: [docs/USER_GUIDE.md](docs/USER_GUIDE.md). Questions: [FAQ](FAQ.md).

## Update

Download, check and run the new Setup program (or unpack the new archive over the old folder). Your settings, cameras and media are kept. From 0.8.2 on, the new version closes the old one when it starts, so you don't need to quit first.

**Updating from 0.8.1 or earlier:** quit the old copy first (tray icon › **Quit**). It can't be closed for you, and the new version says so if it's still running.

To see which version is running: **Settings**, at the bottom of the **Updates** card.

## Uninstall

- **Windows:** **Settings › Apps › Installed apps › OBS Companion › Uninstall**. It asks whether to delete your settings too; choose **No** to keep them for a later reinstall.
- **macOS and Linux:** quit OBS Companion and delete the folder you unpacked (or `~/.local/bin/obs-companion` if an older version's install script put it there). Your settings are in `~/Library/Application Support/obs-companion` (macOS) or `~/.config/obs-companion` (Linux); delete that folder too if you don't want to keep them.

OBS itself is never changed by uninstalling. A profile the companion added (**OBS Companion recommended**) stays in OBS until you remove it there.

## Free features

Everything in this preview is free to use, including commercially. Some features may become part of an optional paid plan in a later version; the core setup tools, one scene with the LeagueOrbit logo, and music stay free.

What's included:
- automatic camera switching when the table is blocked, with Off / Assist / On modes;
- score on screen, winner scene and replay on a win;
- ready-made scenes with logo, sponsor and picture slots, and the camera picture-in-picture pair with **Swap cameras**;
- OBS detection, setup import and best stream settings;
- custom buttons and graphics packs;
- AI assistants through MCP;
- music through the free [OBS Companion AI Music](https://github.com/support-leagueorbit/OBS-Companion-AI-Music) app.

## You stay in charge

- **Off** only watches, **Assist** suggests switches, **On** switches by itself.
- Change anything in OBS yourself and the companion steps back until you've been idle for a while (60 s by default) or press **Resume automation now**.
- People beat AI, and AI beats the automatic rules. An AI can turn automation off but never on, and can't change settings.
- OBS Companion never starts or stops your stream, and never reads your stream key.

## Music: OBS Companion AI Music (optional)

[OBS Companion AI Music](https://github.com/support-leagueorbit/OBS-Companion-AI-Music) is a free companion app that composes original background music on your own computer, so you can play it on stream without copyright claims. Pick a style with one click, add or remove instruments, and save your own styles. See its README for the styles and instruments it includes. OBS Companion can start it, add it to OBS as a source, and play or stop music from a button. It's a separate download; OBS Companion works fine without it.

## LeagueOrbit (optional)

If your league uses LeagueOrbit, OBS Companion can follow a LeagueOrbit table and take the live score and match wins from it. It works on its own without LeagueOrbit.

## AI assistants (MCP)

Any MCP client can use OBS Companion while it's running: command `obs-companion` with args `["mcp"]`, or `http://127.0.0.1:8765/mcp` with the header `Authorization: Bearer <AI key>` (the key is the file `obs-companion/ai-token` in your user settings folder). An AI key is always treated as an AI: it can't start streaming, turn automation on, take control from a person, or change settings.

## Privacy

OBS Companion runs on your computer. Camera pictures are analysed there and aren't sent to LeagueOrbit or anyone else; only a phone you've paired on your own network can see the program preview. The control page listens on your computer only, unless you allow paired phones. It doesn't collect or send usage data, and has no advertising or tracking. It only contacts LeagueOrbit (`app.leagueorbit.com`) if you turn on "Follow a LeagueOrbit table", and checks for new versions only if you set an update address. Your OBS WebSocket password and stream key are never saved, shown or sent anywhere.

## Licence

Free to use, including for commercial streams. You may not sell, resell or modify it. See [LICENSE](LICENSE). Third-party components and their licences: [THIRD_PARTY_NOTICES.txt](THIRD_PARTY_NOTICES.txt). OBS Studio is a separate program by the OBS Project and isn't included.

## Support

Email **support@leagueorbit.com**, or open an [issue](https://github.com/support-leagueorbit/OBS-Companion/issues). Please don't post stream keys, passwords or AI keys anywhere.
