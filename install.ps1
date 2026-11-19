# OBS Companion installer for Windows (current user, no administrator rights).
#
#   irm https://github.com/support-leagueorbit/OBS-Companion/releases/latest/download/install.ps1 | iex
#
# Options (run it as a script block to pass them):
#   & ([scriptblock]::Create((irm https://github.com/support-leagueorbit/OBS-Companion/releases/latest/download/install.ps1))) -Version 0.6.0-preview -Login
#
# What it does:
#   1. Downloads the Setup program and SHA256SUMS from this repo's GitHub Releases (nowhere else).
#   2. Checks the Setup program's SHA-256 against SHA256SUMS. Stops if they differ.
#   3. Runs "Setup install -quiet", which installs to %LOCALAPPDATA%\Programs\OBS Companion.
#   4. Deletes the downloaded files.
param(
    [string]$Version = '',   # e.g. 0.6.0-preview; empty = latest release
    [switch]$Login,          # also start OBS Companion when you sign in to Windows
    [switch]$NoStart         # don't open OBS Companion after installing
)

$ErrorActionPreference = 'Stop'
$ObscRepo = 'https://github.com/support-leagueorbit/OBS-Companion/releases'

function Get-ObscArch {
    $a = $null
    try { $a = [System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture.ToString() } catch { }
    if (-not $a) {
        $a = $env:PROCESSOR_ARCHITEW6432
        if (-not $a) { $a = $env:PROCESSOR_ARCHITECTURE }
    }
    switch -Regex ($a) {
        '^(X64|AMD64)$' { return 'amd64' }
        '^ARM64$' { return 'arm64' }
        default { throw "OBS Companion needs 64-bit Windows (this PC reports '$a')." }
    }
}

function Get-ObscBase([string]$Version) {
    if ($Version) {
        if ($Version -notmatch '^\d+\.\d+\.\d+(-[0-9A-Za-z.]+)?$') { throw "Version '$Version' doesn't look like 1.2.3 or 1.2.3-preview." }
        return "$ObscRepo/download/v$Version"
    }
    return "$ObscRepo/latest/download"
}

# Download one file. Only ever called with an address under $ObscRepo.
function Get-ObscFile([string]$Url, [string]$OutFile) {
    if (-not $Url.StartsWith("$ObscRepo/")) { throw "Refusing to download from $Url" }
    $old = $ProgressPreference
    $ProgressPreference = 'SilentlyContinue'
    try { Invoke-WebRequest -UseBasicParsing -Uri $Url -OutFile $OutFile }
    finally { $ProgressPreference = $old }
}

# The expected SHA-256 for $Name from a SHA256SUMS file, or an error.
function Get-ObscExpectedHash([string]$SumsFile, [string]$Name) {
    foreach ($line in Get-Content -LiteralPath $SumsFile) {
        if ($line -match '^([0-9a-fA-F]{64})\s+\*?(\S+)\s*$' -and $Matches[2] -eq $Name) {
            return $Matches[1].ToLowerInvariant()
        }
    }
    throw "SHA256SUMS has no entry for $Name. Not installing."
}

function Test-ObscHash([string]$File, [string]$Expected) {
    $actual = (Get-FileHash -LiteralPath $File -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($actual -ne $Expected) {
        throw "Checksum mismatch for $(Split-Path -Leaf $File): the download is damaged or not the published file. Not installing."
    }
}

function Invoke-ObscSetup([string]$Setup, [bool]$Login) {
    $setupArgs = @('install', '-quiet')
    if ($Login) { $setupArgs += '-login' }
    $out = & $Setup @setupArgs 2>&1
    if ($LASTEXITCODE -ne 0) { throw "Setup failed: $out" }
    $line = "$out" -split "`n" | Where-Object { $_ -like 'installed:*' } | Select-Object -First 1
    if ($line) { return $line.Substring(10).Trim() }
    return $null
}

function Install-ObsCompanion {
    param([string]$Version = '', [switch]$Login, [switch]$NoStart)
    if ([Net.ServicePointManager]::SecurityProtocol -ne 0) {
        [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
    }
    $arch = Get-ObscArch
    $base = Get-ObscBase $Version
    $name = "OBS-Companion-Setup-windows-$arch.exe"
    $tmp = Join-Path ([IO.Path]::GetTempPath()) ("obsc-install-" + [Guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $tmp | Out-Null
    try {
        Write-Host "Downloading OBS Companion ($arch) from GitHub Releases..."
        $sums = Join-Path $tmp 'SHA256SUMS'
        $setup = Join-Path $tmp $name
        Get-ObscFile "$base/SHA256SUMS" $sums
        $expected = Get-ObscExpectedHash $sums $name
        Get-ObscFile "$base/$name" $setup
        Test-ObscHash $setup $expected
        Write-Host "Checksum OK. Installing for this Windows account..."
        $exe = Invoke-ObscSetup $setup $Login.IsPresent
        Write-Host "OBS Companion is installed. Find it in the Start menu as 'OBS Companion'."
        if ($exe -and -not $NoStart) { Start-Process -FilePath $exe }
        return $exe
    }
    finally {
        Remove-Item -LiteralPath $tmp -Recurse -Force -ErrorAction SilentlyContinue
    }
}

if ($env:OBSC_INSTALL_TEST -ne '1') {
    Install-ObsCompanion -Version $Version -Login:$Login -NoStart:$NoStart | Out-Null
}
