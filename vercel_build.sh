#!/usr/bin/env bash
set -euo pipefail

echo "Preparando estrutura Flutter Web..."

mkdir -p lib
mkdir -p web/icons
mkdir -p assets/images

cp main.dart lib/main.dart

cp index.html web/index.html
cp manifest.json web/manifest.json
cp favicon.png web/favicon.png

cp Icon-192.png web/icons/Icon-192.png
cp Icon-512.png web/icons/Icon-512.png
cp Icon-maskable-192.png web/icons/Icon-maskable-192.png
cp Icon-maskable-512.png web/icons/Icon-maskable-512.png

cp alvesos-mobile.jpg assets/images/alvesos-mobile.jpg
cp jarvis-nexus.png assets/images/jarvis-nexus.png

FLUTTER_DIR=".vercel_flutter"

if [ ! -x "$FLUTTER_DIR/bin/flutter" ]; then
  echo "Baixando Flutter..."
  rm -rf "$FLUTTER_DIR"
  git clone --depth 1 --branch stable https://github.com/flutter/flutter.git "$FLUTTER_DIR"
fi

export PATH="$PWD/$FLUTTER_DIR/bin:$PATH"

flutter --version
flutter config --enable-web
flutter pub get
flutter build web --release
