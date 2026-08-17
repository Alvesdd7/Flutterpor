#!/usr/bin/env bash
set -euo pipefail

FLUTTER_DIR=".vercel_flutter"

if [ ! -x "$FLUTTER_DIR/bin/flutter" ]; then
  echo "Baixando Flutter stable para o build da Vercel..."
  rm -rf "$FLUTTER_DIR"
  git clone --depth 1 --branch stable https://github.com/flutter/flutter.git "$FLUTTER_DIR"
fi

export PATH="$PWD/$FLUTTER_DIR/bin:$PATH"

flutter --version
flutter config --enable-web
flutter pub get
flutter build web --release
