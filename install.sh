#!/bin/sh
# OBS Companion installer for macOS and Linux (current user, no sudo).
#
#   curl -fsSL https://github.com/support-leagueorbit/OBS-Companion/releases/latest/download/install.sh | sh
#
# Options:  ... | sh -s -- --version 0.6.0-preview --dir "$HOME/bin"
#
# What it does:
#   1. Downloads the archive for this computer and SHA256SUMS from this repo's
#      GitHub Releases (nowhere else).
#   2. Checks the archive's SHA-256 against SHA256SUMS. Stops if they differ.
#   3. Installs the obs-companion program to ~/.local/bin (or --dir).
#   4. Deletes the downloaded files.
# Everything runs inside main(), so a cut-off download can't run half a script.
set -eu

OBSC_RELEASES="https://github.com/support-leagueorbit/OBS-Companion/releases"

say() { printf '%s\n' "$*"; }
die() { printf 'install: %s\n' "$*" >&2; exit 1; }

detect_os() {
	case "$(uname -s)" in
	Linux) echo linux ;;
	Darwin) echo darwin ;;
	*) die "this script is for macOS and Linux; on Windows use install.ps1" ;;
	esac
}

detect_arch() {
	m=$(uname -m)
	# A Terminal running under Rosetta reports x86_64 on Apple silicon.
	if [ "$m" = x86_64 ] && [ "$(sysctl -n sysctl.proc_translated 2>/dev/null || echo 0)" = 1 ]; then
		m=arm64
	fi
	case "$m" in
	x86_64 | amd64) echo amd64 ;;
	aarch64 | arm64) echo arm64 ;;
	*) die "no build for this processor ($m)" ;;
	esac
}

# fetch URL FILE: download one file. Only ever called with an address under
# OBSC_RELEASES; https only, also after redirects.
fetch() {
	case "$1" in "$OBSC_RELEASES"/*) ;; *) die "refusing to download from $1" ;; esac
	if command -v curl >/dev/null 2>&1; then
		curl -fsSL --proto '=https' --proto-redir '=https' --tlsv1.2 -o "$2" "$1"
	elif command -v wget >/dev/null 2>&1; then
		wget -q --https-only -O "$2" "$1"
	else
		die "needs curl or wget"
	fi
}

sha256_of() {
	if command -v sha256sum >/dev/null 2>&1; then
		sha256sum "$1" | cut -d' ' -f1
	elif command -v shasum >/dev/null 2>&1; then
		shasum -a 256 "$1" | cut -d' ' -f1
	else
		die "needs sha256sum or shasum to check the download"
	fi
}

# expected_sha SUMS NAME: the listed hash, or nothing.
expected_sha() {
	awk -v n="$2" '{ f = $2; sub(/^\*/, "", f); if (f == n && $1 ~ /^[0-9a-fA-F]+$/ && length($1) == 64) { print tolower($1); exit } }' "$1"
}

main() {
	version="" dir="${HOME}/.local/bin"
	while [ $# -gt 0 ]; do
		case "$1" in
		--version) [ $# -ge 2 ] || die "--version needs a value"; version="$2"; shift 2 ;;
		--dir) [ $# -ge 2 ] || die "--dir needs a value"; dir="$2"; shift 2 ;;
		-h | --help) say "usage: install.sh [--version 1.2.3] [--dir DIR]"; return 0 ;;
		*) die "unknown option $1" ;;
		esac
	done
	if [ -n "$version" ]; then
		printf '%s' "$version" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.]+)?$' || die "version '$version' doesn't look like 1.2.3"
		base="$OBSC_RELEASES/download/v$version"
	else
		base="$OBSC_RELEASES/latest/download"
	fi
	os=$(detect_os)
	arch=$(detect_arch)
	name="obs-companion-$os-$arch.tar.gz"

	tmp=$(mktemp -d 2>/dev/null || mktemp -d -t obsc-install)
	trap 'rm -rf "$tmp"' EXIT INT TERM
	say "Downloading OBS Companion ($os $arch) from GitHub Releases..."
	fetch "$base/SHA256SUMS" "$tmp/SHA256SUMS"
	want=$(expected_sha "$tmp/SHA256SUMS" "$name")
	[ -n "$want" ] || die "SHA256SUMS has no entry for $name. Not installing."
	fetch "$base/$name" "$tmp/$name"
	got=$(sha256_of "$tmp/$name")
	[ "$got" = "$want" ] || die "checksum mismatch for $name: the download is damaged or not the published file. Not installing."
	say "Checksum OK."

	mkdir "$tmp/x"
	tar -xzf "$tmp/$name" -C "$tmp/x"
	bin="$tmp/x/obs-companion/obs-companion"
	[ -f "$bin" ] && [ ! -L "$bin" ] || die "the archive doesn't contain the program"
	mkdir -p "$dir"
	# Copy to a temporary name first, then rename: a running copy keeps working.
	cp "$bin" "$dir/.obs-companion.new"
	chmod 0755 "$dir/.obs-companion.new"
	mv -f "$dir/.obs-companion.new" "$dir/obs-companion"
	docs="${XDG_DATA_HOME:-$HOME/.local/share}/obs-companion"
	mkdir -p "$docs"
	for f in LICENSE.txt THIRD_PARTY_NOTICES.txt; do
		if [ -f "$tmp/x/obs-companion/$f" ]; then cp "$tmp/x/obs-companion/$f" "$docs/$f"; fi
	done
	say "Installed: $dir/obs-companion"
	case ":${PATH}:" in
	*":$dir:"*) say "Start it with: obs-companion" ;;
	*) say "Start it with: \"$dir/obs-companion\"  (or add $dir to your PATH)" ;;
	esac
}

[ "${OBSC_INSTALL_TEST:-}" = 1 ] || main "$@"
