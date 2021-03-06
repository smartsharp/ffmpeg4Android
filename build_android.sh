#!/bin/bash
# https://www.jianshu.com/p/0a7f3175c1b9?utm_source=desktop&utm_medium=timeline
PREFIX=android-build

NDK_HOME=/opt/android-ndk-r14b
NDK_HOST_PLATFORM=linux-x86_64

COMMON_OPTIONS="\
    --prefix=android/ \
    --target-os=android \
    --disable-static \
    --enable-shared \
    --enable-small \
    --disable-programs \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-doc \
    --disable-symver \
    --disable-asm \
    "
#    --disable-ffmpeg \
#

function build_android {
    ./configure \
    --libdir=${PREFIX}/libs/armeabi-v7a \
    --incdir=${PREFIX}/includes/armeabi-v7a \
    --pkgconfigdir=${PREFIX}/pkgconfig/armeabi-v7a \
    --arch=arm \
    --cpu=armv7-a \
    --cross-prefix="${NDK_HOME}/toolchains/arm-linux-androideabi-4.9/prebuilt/${NDK_HOST_PLATFORM}/bin/arm-linux-androideabi-" \
    --sysroot="${NDK_HOME}/platforms/android-19/arch-arm/" \
    --extra-cflags="-march=armv7-a -mfloat-abi=softfp -mfpu=neon" \
    --extra-ldexeflags=-pie \
    ${COMMON_OPTIONS}
    echo -n "Confirm to compile arm7 lib? (y or n)"
    read flag
    if [ "$flag" = "y" -o "$flag" = "Y" ] ; then
        echo
    else
        exit
    fi
    make clean
    make -j8 && make install

    ./configure \
    --libdir=${PREFIX}/libs/arm64-v8a \
    --incdir=${PREFIX}/includes/arm64-v8a \
    --pkgconfigdir=${PREFIX}/pkgconfig/arm64-v8a \
    --arch=aarch64 \
    --cpu=armv8-a \
    --cross-prefix="${NDK_HOME}/toolchains/aarch64-linux-android-4.9/prebuilt/${NDK_HOST_PLATFORM}/bin/aarch64-linux-android-" \
    --sysroot="${NDK_HOME}/platforms/android-21/arch-arm64/" \
    --extra-ldexeflags=-pie \
    ${COMMON_OPTIONS} 
    echo -n "Confirm to compile arm64 lib (y or n)"
    read flag
    if [ "$flag" = "y" -o "$flag" = "Y" ] ; then
        echo
    else
        exit
    fi
    make clean
    make -j8 && make install

    ./configure \
    --libdir=${PREFIX}/libs/x86 \
    --incdir=${PREFIX}/includes/x86 \
    --pkgconfigdir=${PREFIX}/pkgconfig/x86 \
    --arch=x86 \
    --cpu=i686 \
    --cross-prefix="${NDK_HOME}/toolchains/x86-4.9/prebuilt/${NDK_HOST_PLATFORM}/bin/i686-linux-android-" \
    --sysroot="${NDK_HOME}/platforms/android-19/arch-x86/" \
    --extra-ldexeflags=-pie \
    ${COMMON_OPTIONS} 
    echo -n "Confirm to compile x86 lib (y or n)"
    read flag
    if [ "$flag" = "y" -o "$flag" = "Y" ] ; then
        echo
    else
        exit
    fi
    make clean
    make -j8 && make install

    ./configure \
    --libdir=${PREFIX}/libs/x86_64 \
    --incdir=${PREFIX}/includes/x86_64 \
    --pkgconfigdir=${PREFIX}/pkgconfig/x86_64 \
    --arch=x86_64 \
    --cpu=x86_64 \
    --cross-prefix="${NDK_HOME}/toolchains/x86_64-4.9/prebuilt/${NDK_HOST_PLATFORM}/bin/x86_64-linux-android-" \
    --sysroot="${NDK_HOME}/platforms/android-21/arch-x86_64/" \
    --extra-ldexeflags=-pie \
    ${COMMON_OPTIONS}
    echo -n "Confirm to compile x86_64 lib (y or n)"
    read flag
    if [ "$flag" = "y" -o "$flag" = "Y" ] ; then
        echo
    else
        exit
    fi
    make clean
    make -j8 && make install

};

build_android

