CONFIG(debug, debug|release): CONFIG -= release
else: CONFIG -= debug

QT -= core gui
CONFIG += c++11 staticlib

TEMPLATE = lib
TARGET = labsound

DEFINES -= UNICODE
DEFINES += OPUS_BUILD USE_ALLOCA D_VARIADIC_MAX=10 WTF_USE_WEBAUDIO_KISSFFT=1
DEFINES += HAVE_NO_OFLOG  HAVE_LIBDL HAVE_ALLOCA HAVE_UNISTD_H WEBAUDIO_KISSFFT
DEFINES += STATICALLY_LINKED_WITH_WTF __LITTLE_ENDIAN__ NDEBUG
DEFINES += HAVE_ALLOCA HAVE_UNISTD_H USEAPI_DUMMY BUILDING_WTF=1


# Platform-dependent

win32 {
	
	contains(QMAKE_TARGET.arch, x86_64) { # x64
		DESTDIR = $$PWD/../build/bin-win64
		LIBS += -L$$PWD/../build/bin-win64
	} else { # x32
		DESTDIR = $$PWD/../build/bin-win32
		LIBS += -L$$PWD/../build/bin-win32
	}
	
	DEFINES += __WINDOWS_WASAPI__ NOMINMAX __OS_WINDOWS__
	DEFINES += _CRT_SECURE_NO_WARNINGS _SCL_SECURE_NO_WARNINGS
	
	SOURCES += $$files($$PWD/../src/backends/windows/*.cpp)
	SOURCES += $$PWD/../third_party/rtaudio/src/RtAudio.cpp
	SOURCES += $$PWD/../third_party/STK/src/STKInlineCompile.cpp
	
	QMAKE_LFLAGS += /NODEFAULTLIB:MSVCRT /OPT:REF
	QMAKE_CFLAGS_RELEASE = -O2 -MT
	QMAKE_CXXFLAGS_RELEASE = -O2 -MT
	QMAKE_CXXFLAGS_WARN_ON -= -w34100
	
} else:macx {
	
	DEFINES += __MACOSX_CORE__ OSX
	
	DESTDIR = $$PWD/../build/bin-mac64
	LIBS += -L$$PWD/../build/bin-mac64
	
	SOURCES += $$files($$PWD/../src/backends/darwin/*.cpp)
	
} else {
	
	DEFINES += __LINUX_ALSA__ LABSOUND_ASOUND=1
	DESTDIR = $$PWD/../build/bin-linux64
	LIBS += -L$$PWD/../build/bin-linux64
	
	SOURCES += $$files($$PWD/../src/backends/linux/*.cpp)
	SOURCES += $$PWD/../third_party/rtaudio/src/RtAudio.cpp
	
}


# LabSound

INCLUDEPATH += \
	$$PWD/../include \
	$$PWD/../src \
	$$PWD/../src/internal \
	$$PWD/../include/LabSound/extended \
	$$PWD/../include/LabSound/core \
	$$PWD/../third_party \
	$$PWD/../third_party/STK


SOURCES += \
	$$files($$PWD/../src/core/*.cpp) \
	$$files($$PWD/../src/extended/*.cpp) \
	$$files($$PWD/../src/internal/src/*.cpp) \
	$$files($$PWD/../third_party/kissfft/src/*.cpp) \
	$$files($$PWD/../third_party/ooura/src/*.cpp)

SOURCES -= $$PWD/../src/extended/PowerMonitorNode.cpp


# libopus

INCLUDEPATH += \
	$$PWD/../third_party/libnyquist/third_party/libogg/include \
	$$PWD/../third_party/libnyquist/third_party/opus/celt \
	$$PWD/../third_party/libnyquist/third_party/opus/libopus/include \
	$$PWD/../third_party/libnyquist/third_party/opus/opusfile/include \
	$$PWD/../third_party/libnyquist/third_party/opus/opusfile/src/include \
	$$PWD/../third_party/libnyquist/third_party/opus/silk \
	$$PWD/../third_party/libnyquist/third_party/opus/silk/float

SOURCES += \
	$$files($$PWD/../third_party/libnyquist/third_party/opus/celt/*.c) \
	$$files($$PWD/../third_party/libnyquist/third_party/opus/libopus/src/*.c) \
	$$files($$PWD/../third_party/libnyquist/third_party/opus/opusfile/src/*.c) \
	$$files($$PWD/../third_party/libnyquist/third_party/opus/silk/*.c) \
	$$files($$PWD/../third_party/libnyquist/third_party/opus/silk/float/*.c)

SOURCES -= \
	$$files($$PWD/../third_party/libnyquist/third_party/opus/libopus/src/*_demo.c) \
	$$PWD/../third_party/libnyquist/third_party/opus/libopus/src/opus_compare.c \
	$$PWD/../third_party/libnyquist/third_party/opus/celt/opus_custom_demo.c


# libnyquist

INCLUDEPATH += \
	$$PWD/../third_party/libnyquist/include \
	$$PWD/../third_party/libnyquist/include/libnyquist \
	$$PWD/../third_party/libnyquist/third_party \
	$$PWD/../third_party/libnyquist/third_party/FLAC/src/include \
	$$PWD/../third_party/libnyquist/third_party/libogg/include \
	$$PWD/../third_party/libnyquist/third_party/libvorbis/include \
	$$PWD/../third_party/libnyquist/third_party/libvorbis/src \
	$$PWD/../third_party/libnyquist/third_party/musepack/include \
	$$PWD/../third_party/libnyquist/third_party/opus/celt \
	$$PWD/../third_party/libnyquist/third_party/opus/libopus/include \
	$$PWD/../third_party/libnyquist/third_party/opus/opusfile/include \
	$$PWD/../third_party/libnyquist/third_party/opus/opusfile/src/include \
	$$PWD/../third_party/libnyquist/third_party/opus/silk \
	$$PWD/../third_party/libnyquist/third_party/opus/silk/float \
	$$PWD/../third_party/libnyquist/third_party/wavpack/include \
	$$PWD/../third_party/libnyquist/src

SOURCES += \
	$$files($$PWD/../third_party/libnyquist/src/*.cpp) \
	$$files($$PWD/../third_party/libnyquist/src/*.c) \
	$$files($$PWD/../third_party/libnyquist/third_party/wavpack/src/*.c)
