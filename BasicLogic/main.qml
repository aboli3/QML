import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Rectangle{
        id : firstRec
        width: 100
        height: 100
        color: "red"
        border.color: "black"
        border.width: 5
        radius: 50
        MouseArea{
            anchors.fill: parent
            onClicked: {
                secondRec.color = "orange"
                windowObject.display("orange")
            }
        }
    }
    Rectangle{
        id: secondRec
        width: 100
        height: 100
        color: "blue"
        border.color: "black"
        anchors.left: firstRec.right
        border.width: 5
        radius: 50
        MouseArea{
            anchors.fill: parent
            onClicked: {
                thirdRec.color = "yellow"
            }
        }
    }
    Rectangle{
        id: thirdRec
        width: 100
        height: 100
        color: "green"
        border.color: "black"
        anchors.left: secondRec.right
        border.width: 5
        radius: 50
        MouseArea{
            anchors.fill: parent
            onClicked: {
                firstRec.color = "pink"
            }
        }
    }
    Text{
        id: lable
        width: 100
        height: 200
        x: 300
        y: 300
        anchors.top: thirdRec.bottom
        color: "black"
        text: "morning"
    }
    Connections{
        onEntityChanged:{
            console.log("********************"+windowObject.entity)
        }
    }
}
