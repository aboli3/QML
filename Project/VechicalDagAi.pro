
#BUILDING VECHICAL DASHBOARD

QT += core quick multimedia

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
CONFIG += c++17

# OpenCV configuration
INCLUDEPATH +=C:/Users/Aboli/source/opencv/build/include
win32 {
    # Adjust these paths to match your installation
    #OPENCV_PATH = C:/Users/Aboli/source/opencv/build
    OPENCV_PATH = C:/Users/Aboli/source/build
    OPENCV_VERSION = 460  # Change this to match your version!

    INCLUDEPATH += C:/Users/Aboli/source/opencv/build/include

    LIBS += C:\Users\Aboli\source\build\bin\libopencv_core460.dll
    LIBS += C:\Users\Aboli\source\build\bin\libopencv_highgui460.dll
    LIBS += C:\Users\Aboli\source\build\bin\libopencv_imgcodecs460.dll
    LIBS += C:\Users\Aboli\source\build\bin\libopencv_imgproc460.dll
    LIBS += C:\Users\Aboli\source\build\bin\libopencv_calib3d460.dll
    LIBS += C:\Users\Aboli\source\build\bin\libopencv_video460.dll
    LIBS += C:\Users\Aboli\source\build\bin\libopencv_videoio460.dll


    # Debug and Release configurations
    CONFIG(debug, debug|release) {
        LIBS += -L$$OPENCV_PATH/x64/vc15/bin
    }
    CONFIG(release, debug|release) {
        LIBS += -L$$OPENCV_PATH/x64/vc15/bin
    }
}


# Dlib configuration
#DLIB_PATH = C:/Users/Aboli/dlib-19.24/dlib-19.24  # Adjust path to your dlib directory

#INCLUDEPATH += $$DLIB_PATH
#LIBS += -L$$DLIB_PATH/build1/dlib/Release \
#        -ldlib19.24.0_release_64bit_msvc1937

#LIBS += C:/Users/Aboli/dlib-19.24/dlib-19.24/build1/dlib/Release/dlib19.24.0_release_64bit_msvc1937.lib

#INCLUDEPATH +=C:/Users/Aboli/dlib-19.24/dlib-19.24/source/dlib/external/pybind11/include
#LIBS += C:/Users/Aboli/dlib-19.24/dlib-19.24/build1
#LIBS += -ldlib


DLIB_PATH = C:/Users/Aboli/dlib-19.24/dlib-19.24

INCLUDEPATH += $$DLIB_PATH
INCLUDEPATH += $$DLIB_PATH/dlib

# Point to the correct lib file
#LIBS += -L$$DLIB_PATH/build/dlib/Release \
#        -ldlib19.24.0_release_64bit_msvc1937
LIBS += $$DLIB_PATH/build1/dlib/Release/dlib19.24.0_release_64bit_msvc1937.lib
#LIBS += C:/Users/Aboli/dlib-19.24/dlib-19.24/build1/dlib/Release/dlib19.24.0_release_64bit_msvc1937.lib

SOURCES += \
        dashboardcontroller.cpp \
        drivermonitor.cpp \
        main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

#QMAKE_CXXFLAGS += /bigobj
DEFINES += DLIB_JPEG_SUPPORT

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    dashboardcontroller.h \
    drivermonitor.h
