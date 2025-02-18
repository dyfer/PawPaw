#!/bin/bash

# ---------------------------------------------------------------------------------------------------------------------
# base

PKG_CONFIG_VERSION=0.28

# ---------------------------------------------------------------------------------------------------------------------
# common

FLAC_VERSION=1.3.3
FLUIDSYNTH_VERSION=1.1.11
FFTW_VERSION=3.3.8
GLIB_VERSION=2.22.5
GLIB_MVERSION=2.22
LIBLO_VERSION=0.30
LIBOGG_VERSION=1.3.4
LIBSAMPLERATE_VERSION=0.1.9
LIBSNDFILE_VERSION=1.0.28
LIBVORBIS_VERSION=1.3.7

# ---------------------------------------------------------------------------------------------------------------------
# plugins

CARLA_VERSION=d664abbe958972b49f1d995cd0b90e5b599f884f
KXSTUDIO_LV2_EXTENSIONS_VERSION=fae65fbc173cd2c4367e85917a6ef97280532d88
LILV_VERSION=0.24.12
LV2_VERSION=6cefc7df1a6158c79d23029df183c09b10b88cad
LV2LINT_VERSION=0.8.0
MOD_SDK_VERSION=2fe7c7728faa551b2838baa49c0d1953c64f2151
MXML_VERSION=3.1
PCRE_VERSION=8.44
SERD_VERSION=0.30.8
SORD_VERSION=0.16.8
SRATOM_VERSION=0.6.8
ZLIB_VERSION=1.2.11

LV2LINT_SUPPORTED=1

if [ "${MACOS_OLD}" -eq 1 ] || [ "${CROSS_COMPILING}" -eq 1 ]; then
    LV2LINT_SUPPORTED=0
fi
if [ "${MACOS}" -eq 1 ] && [ "$(uname -r)" = "12.6.0" ]; then
    LV2LINT_SUPPORTED=0
fi

# ---------------------------------------------------------------------------------------------------------------------
# qt stuff

if [ "${MACOS_UNIVERSAL}" -eq 1 ]; then
    QT5_VERSION=5.12.10
    QT5_MVERSION=5.12
else
    QT5_VERSION=5.9.8
    QT5_MVERSION=5.9
fi

# ---------------------------------------------------------------------------------------------------------------------
# carla

FILE_VERSION=5.34
LIBFFI_VERSION=3.3

if [ "${MACOS_UNIVERSAL}" -eq 1 ]; then
    CXFREEZE_VERSION=6.4.2
    PYTHON_VERSION=3.9.1
    PYLIBLO_VERSION=0.10.0
    PYQT5_VERSION=5.13.1
    SIP_VERSION=4.19.19
    # extra, needed for pyliblo
    CYTHON_VERSION=0.29.21
    # extra, needed for cxfreeze
    IMPORTLIB_METADATA_VERSION=3.1.1
    SETUPTOOLS_SCM_VERSION=5.0.0
    TOML_VERSION=0.10.2
    ZIPP_VERSION=3.4.0
elif [ "${WIN32}" -eq 1 ]; then
    CXFREEZE_VERSION=6.1
    PYTHON_VERSION=3.8.7
    PYLIBLO_VERSION=0.9.2
    PYQT5_VERSION=5.13.1
    SIP_VERSION=4.19.19
else
    CXFREEZE_VERSION=6.1
    PYTHON_VERSION=3.7.4
    PYLIBLO_VERSION=0.9.2
    PYQT5_VERSION=5.9.2
    SIP_VERSION=4.19.13
fi

# ---------------------------------------------------------------------------------------------------------------------
# jack

AFTEN_VERSION=0.0.8
DB_VERSION=5.3.28
OPUS_VERSION=1.3.1
PORTAUDIO_VERSION=19.6.0
RTAUDIO_VERSION=e03448bd15c1c34e842459939d755f5f89e880ed
TRE_VERSION=6092368aabdd0dbb0fbceb2766a37b98e0ff6911

# ---------------------------------------------------------------------------------------------------------------------
