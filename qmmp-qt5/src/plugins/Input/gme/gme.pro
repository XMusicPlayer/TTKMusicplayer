include(../../plugins.pri)

HEADERS += decodergmefactory.h \
    decoder_gme.h \
    gmehelper.h


SOURCES += decoder_gme.cpp \
    decodergmefactory.cpp \
    gmehelper.cpp


TARGET = $$PLUGINS_PREFIX/Input/gme
QMAKE_CLEAN = $$PLUGINS_PREFIX/Input/libgme.so

INCLUDEPATH += ../../../ \
                    $$EXTRA_PREFIX/libgme/include

CONFIG += warn_on \
    plugin
TEMPLATE = lib



unix{
    isEmpty(LIB_DIR):LIB_DIR = /lib/$$TTKMusicPlayer
    target.path = $$LIB_DIR/qmmp/Input
    INSTALLS += target
    QMAKE_LIBDIR += ../../../../lib/$$TTKMusicPlayer
    LIBS += -L$$EXTRA_PREFIX/libgme/lib -lgme -lqmmp
}

win32 {
    HEADERS += ../../../../src/qmmp/metadatamodel.h \
               ../../../../src/qmmp/decoderfactory.h
    msvc:{
        HEADERS += ../../../../src/qmmp/qmmpsettings.h \
                   ../../../../src/qmmp/statehandler.h \
                   ../../../../src/qmmp/abstractengine.h
    }
    QMAKE_LIBDIR += ../../../../bin/$$TTKMusicPlayer
    gcc{
        LIBS += -L$$EXTRA_PREFIX/libgme/lib -lgme.dll -lqmmp1
    }
    msvc{
        LIBS += -L$$EXTRA_PREFIX/libgme/lib -lgme -lqmmp1
    }
#    LIBS += -lqmmp0 -lgme.dll
}