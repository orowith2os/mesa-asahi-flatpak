#!/usr/bin/env bash

# The version of the FreeDesktop runtime to use. This should be the same as in org.freedesktop.Platform.GL.{NAME}.{yaml, json}.
FDOVER=22.08

echo "This flatpak assumes all sources are relative to itself; for example, the Mesa source directory should be in src/mesa relative to the Flatpak manifest.
The resulting binaries will be contained in build-dir/files.
For local testing, you can also build this manually with the --install flag."

echo "Ensuring Flathub is enabled."

flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Installing required dependencies inside of Flatpak."

flatpak install --assumeyes --user flathub org.freedesktop.Sdk//${FDOVER} org.freedesktop.Platform//${FDOVER} org.freedesktop.Sdk.Extension.llvm15//${FDOVER} org.flatpak.Builder//stable

echo "Building the Flatpak."

flatpak run org.flatpak.Builder --user --force-clean build-dir org.freedesktop.Platform.GL.host.yml

echo "Done building. Move the resulting files in build-dir/files to /var/lib/flatpak/extension/org.freedesktop.Platform.GL.host/x86_64/${FDOVER}."
