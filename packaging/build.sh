#!/bin/sh
# Build plasma-camera in Docker and install it into ~/.local.
#   ./build.sh          build and install
#   ./build.sh --image  rebuild the image
set -eu
HERE=$(cd "$(dirname "$0")" && pwd)
ROOT=$(dirname "$HERE")
IMG=plasma-camera-build
if [ "${1:-}" = "--image" ] || ! docker image inspect $IMG >/dev/null 2>&1; then
    docker build -t $IMG "$HERE"
fi
docker run --rm -u "$(id -u):$(id -g)" -e LANG=C.UTF-8 -v "$ROOT:/src" -w /src $IMG sh -ec '
    cmake -Wno-dev -S . -B packaging/build -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF >/dev/null
    cmake --build packaging/build -j"$(nproc)"'
BIN=$HOME/.local/bin/plasma-camera
install -Dm755 "$HERE/build/bin/plasma-camera" "$BIN.new" && mv -f "$BIN.new" "$BIN"
DESK=$HOME/.local/share/applications/org.kde.plasma.camera.desktop
sed "s|^Exec=plasma-camera|Exec=$BIN|" /usr/share/applications/org.kde.plasma.camera.desktop > "$DESK"
kbuildsycoca6 >/dev/null 2>&1 || true
echo "Installed: $BIN"
