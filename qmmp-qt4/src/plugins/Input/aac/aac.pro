include(../../plugins.pri)

HEADERS += decoderaacfactory.h \
    decoder_aac.h \
    aacfile.h \
    aacmetadatamodel.h

SOURCES += decoder_aac.cpp \
    decoderaacfactory.cpp \
    aacfile.cpp \
    aacmetadatamodel.cpp

TARGET = $$PLUGINS_PREFIX/Input/aac
QMAKE_CLEAN = $$PLUGINS_PREFIX/Input/libaac.so

INCLUDEPATH += ../../../ \
                     $$EXTRA_PREFIX/libfaad2/include \
                     $$EXTRA_PREFIX/libtaglib/include
CONFIG += warn_on \
    plugin \
    link_pkgconfig
TEMPLATE = lib

win32:{
  QMAKE_LIBDIR += ../../../../bin/$$TTKMusicPlayer
  gcc{
      LIBS += -L$$EXTRA_PREFIX/libfaad2/lib -lfaad \
              -L$$EXTRA_PREFIX/libtaglib/lib -ltag.dll \
              -lqmmp0
  }
}
unix:{
    QMAKE_LIBDIR += ../../../../lib/$$TTKMusicPlayer
    LIBS += -L$$EXTRA_PREFIX/libfaad2/lib -lfaad \
          -L$$EXTRA_PREFIX/libtaglib/lib -ltag \
          -lqmmp
}

isEmpty(LIB_DIR):LIB_DIR = /lib/$$TTKMusicPlayer
target.path = $$LIB_DIR/qmmp/Input
INSTALLS += target