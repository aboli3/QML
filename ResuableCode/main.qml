import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Resusability Example")

    Rect{
        id : redRect
        rectColor: "red"
    }
    Rect{
        id : blueRect
        rectColor: "blue"
        anchors.top: redRect.bottom
    }
    Rect{
        id : greenRect
        rectColor: "green"
        anchors.top: blueRect.bottom
    }
}
