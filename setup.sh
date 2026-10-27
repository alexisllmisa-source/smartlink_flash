#!/bin/bash
set -e

echo "=== 1. Instalando herramientas de sistema ==="
sudo apt-get update && sudo apt-get install -y build-essential wget unzip make

NDK_DIR="$HOME/android-ndk-r25b"

if [ ! -d "$NDK_DIR" ]; then
    echo "=== 2. Descargando Android NDK r25b ==="
    wget -q --show-progress https://dl.google.com/android/repository/android-ndk-r25b-linux.zip -O /tmp/ndk.zip
    echo "=== 3. Descomprimiendo NDK ==="
    unzip -q /tmp/ndk.zip -d $HOME
    rm /tmp/ndk.zip
fi

echo "=== 4. Compilando el proyecto para SL6806 ==="
NDK=$HOME/android-ndk-r25b
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm
CLANG=$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/armv7a-linux-androideabi21-clang

make all CHIP=6806 TOOLCHAIN="$TOOLCHAIN" CC="$CLANG"
echo "=== ¡Proceso completado con éxito! ==="
