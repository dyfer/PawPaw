#!/bin/bash

# ---------------------------------------------------------------------------------------------------------------------
# pawpaw setup

PAWPAW_DIR="$(realpath ~/PawPawBuilds)"
PAWPAW_BUILDDIR="${PAWPAW_DIR}/builds"
PAWPAW_DOWNLOADDIR="${PAWPAW_DIR}/downloads"
PAWPAW_PREFIX="${PAWPAW_DIR}/target"
PAWPAW_TMPDIR="/tmp"

# ---------------------------------------------------------------------------------------------------------------------
# OS setup

if [ "${MACOS}" -eq 1 ]; then
    CMAKE_SYSTEM_NAME="Darwin"
elif [ "${WIN32}" -eq 1 ]; then
    CMAKE_SYSTEM_NAME="Windows"
fi

# ---------------------------------------------------------------------------------------------------------------------
# build environment

## build flags

BUILD_FLAGS="-O2 -pipe -I${PAWPAW_PREFIX}/include"
BUILD_FLAGS="${BUILD_FLAGS} -mtune=generic -msse -msse2 -mfpmath=sse"
# -ffast-math
BUILD_FLAGS="${BUILD_FLAGS} -fPIC -DPIC -DNDEBUG"
BUILD_FLAGS="${BUILD_FLAGS} -fdata-sections -ffunction-sections -fno-common -fvisibility=hidden"
if [ "${MACOS}" -eq 1 ]; then
    if [ "${MACOS_OLD}" -eq 1 ]; then
        BUILD_FLAGS="${BUILD_FLAGS} -mmacosx-version-min=10.5"
    else
        BUILD_FLAGS="${BUILD_FLAGS} -mmacosx-version-min=10.8 -stdlib=libc++ -Wno-deprecated-declarations"
    fi
elif [ "${WIN32}" -eq 1 ]; then
    BUILD_FLAGS="${BUILD_FLAGS} -DPTW32_STATIC_LIB -mstackrealign"
fi
# -DFLUIDSYNTH_NOT_A_DLL
TARGET_CFLAGS="${BUILD_FLAGS}"
TARGET_CXXFLAGS="${BUILD_FLAGS} -fvisibility-inlines-hidden"

## link flags

LINK_FLAGS="-fdata-sections -ffunction-sections -L${PAWPAW_PREFIX}/lib"
if [ "${MACOS}" -eq 1 ]; then
    LINK_FLAGS="${LINK_FLAGS} -Wl,-dead_strip -Wl,-dead_strip_dylibs"
    if [ "${MACOS_OLD}" -ne 1 ]; then
        LINK_FLAGS="${LINK_FLAGS} -stdlib=libc++"
    fi
else
    LINK_FLAGS="${LINK_FLAGS} -Wl,-O1 -Wl,--as-needed -Wl,--gc-sections -Wl,--no-undefined -Wl,--strip-all"
    if [ "${WIN32}" -eq 1 ]; then
        LINK_FLAGS="${LINK_FLAGS} -static"
    fi
fi
TARGET_LDFLAGS="${LINK_FLAGS}"

## toolchain

if [ "${MACOS}" -eq 1 ]; then
    TOOLCHAIN_PREFIX="i686-apple-darwin10"
    TOOLCHAIN_PREFIX_="${TOOLCHAIN_PREFIX}-"
elif [ "${WIN64}" -eq 1 ]; then
    TOOLCHAIN_PREFIX="x86_64-w64-mingw32"
    TOOLCHAIN_PREFIX_="${TOOLCHAIN_PREFIX}-"
elif [ "${WIN32}" -eq 1 ]; then
    TOOLCHAIN_PREFIX="i686-w64-mingw32"
    TOOLCHAIN_PREFIX_="${TOOLCHAIN_PREFIX}-"
fi
TARGET_AR="${TOOLCHAIN_PREFIX_}ar"
TARGET_CC="${TOOLCHAIN_PREFIX_}gcc"
TARGET_CXX="${TOOLCHAIN_PREFIX_}g++"
TARGET_LD="${TOOLCHAIN_PREFIX_}ld"
TARGET_STRIP="${TOOLCHAIN_PREFIX_}strip"
TARGET_PATH="${PAWPAW_PREFIX}/bin:/usr/${TOOLCHAIN_PREFIX}/bin:${PATH}"
TARGET_PKG_CONFIG_PATH="${PAWPAW_PREFIX}/lib/pkgconfig"

# ---------------------------------------------------------------------------------------------------------------------
# other

# "-j 2"
MAKE_ARGS=""

if [ "${CROSS_COMPILING}" -eq 1 ]; then
    MAKE_ARGS="${MAKE_ARGS} CROSS_COMPILING=true"
fi

if [ "${MACOS}" -eq 1 ]; then
    MAKE_ARGS="${MAKE_ARGS} MACOS=true"
    if [ "${MACOS_OLD}" -eq 1 ]; then
        MAKE_ARGS="${MAKE_ARGS} MACOS_OLD=true"
    fi
elif [ "${WIN32}" -eq 1 ]; then
    MAKE_ARGS="${MAKE_ARGS} WIN32=true WINDOWS=true"
fi

# ---------------------------------------------------------------------------------------------------------------------
