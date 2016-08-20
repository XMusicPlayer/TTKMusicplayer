include(../../plugins.pri)

HEADERS += srconverter.h \
 effectsrconverterfactory.h \
 settingsdialog.h

SOURCES += srconverter.cpp \
 effectsrconverterfactory.cpp \
 settingsdialog.cpp

TARGET=$$PLUGINS_PREFIX/Effect/srconverter
QMAKE_CLEAN =$$PLUGINS_PREFIX/Effect/libsrconverter.so
INCLUDEPATH += ../../../
CONFIG += warn_on \
plugin \
link_pkgconfig

TEMPLATE = lib
QMAKE_LIBDIR += ../../../../lib/$$TTKMusicPlayer
INCLUDEPATH += $$EXTRA_PREFIX/libsamplerate/include
LIBS += -L$$EXTRA_PREFIX/libsamplerate/lib -lsamplerate -lqmmp

isEmpty(LIB_DIR):LIB_DIR = /lib/$$TTKMusicPlayer
target.path = $$LIB_DIR/qmmp/Effect
INSTALLS += target

FORMS += settingsdialog.ui
