# OBS Companion: frequently asked questions

**Does it cost anything?**
No. OBS Companion is free to use, including on commercial streams. There are no paid features. See [LICENSE](LICENSE).

**Which OBS version do I need?**
OBS Studio 28 or newer, with its WebSocket server turned on (**Tools › WebSocket Server Settings**). OBS Companion runs on the same computer as OBS.

**Does it start or stop my stream?**
Never. It switches scenes, updates text sources and saves replays. Going live and ending the stream are always up to you in OBS.

**Does it read my stream key or passwords?**
It never reads your stream key: it only notes whether one is set. It reads the OBS WebSocket password from OBS's settings on the same computer, keeps it in memory only, and never shows, saves or sends it.

**Will the recommended stream settings change my OBS profile?**
No. **Apply as a new OBS profile** creates a separate profile called "OBS Companion recommended" and switches OBS to it after you confirm. Your own profile stays exactly as it is, and **Switch back to my profile** returns to it. Nothing is applied while you're streaming or recording. The new profile doesn't contain your stream key, so after switching, paste it (or connect your account) once in OBS › **Settings › Stream**.

**How does it know my upload speed?**
You type it in (from any speed test). The recommended bitrate leaves headroom so the stream stays smooth.

**Windows says "Windows protected your PC" or "unknown publisher". Is that safe?**
OBS Companion isn't signed with a paid certificate, so Windows doesn't recognise the publisher yet. If you downloaded the file from this repository's Releases page, click **More info**, then **Run anyway**. You can check the file's SHA-256 against `SHA256SUMS` from the same release first (see the README).

**macOS says it can't check the app for malicious software.**
The macOS builds aren't notarised (that needs a paid Apple account). If you downloaded the archive in a browser, right-click the program and choose **Open** the first time.

**Where are my settings kept? How do I uninstall?**
Settings, media and keys are kept in `%APPDATA%\obs-companion` (Windows), `~/Library/Application Support/obs-companion` (macOS) or `~/.config/obs-companion` (Linux).
- Windows: uninstall from **Settings › Apps** (or run `obs-companion uninstall`). You choose whether to keep your settings.
- macOS and Linux: delete `~/.local/bin/obs-companion` (and the settings folder above, if you want).

**Can an AI assistant take over my stream?**
No. An AI can switch scenes and press buttons you've allowed, but it can't start streaming, turn automation on, take control from a person, or change settings. Anything a person does wins.

**Do I need LeagueOrbit?**
No. OBS Companion works on its own. If your league uses LeagueOrbit, it can follow a LeagueOrbit table for live scores.

**Does it need the internet?**
No, except for features you turn on: following a LeagueOrbit table, and checking for new versions if you set an update address. It doesn't send usage data.

**Where's the music?**
Background music comes from the free, optional [OBS Companion AI Music](https://github.com/support-leagueorbit/OBS-Companion-AI-Music) app. OBS Companion works without it.

**Is there a phone app?**
An Android app for controlling OBS Companion from your phone is in testing and isn't published yet.

**Where can I report a problem?**
Open an [issue](https://github.com/support-leagueorbit/OBS-Companion/issues) with what you did, what you expected and what happened. Please don't include stream keys, passwords or AI keys.
