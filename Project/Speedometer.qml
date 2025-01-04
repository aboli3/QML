//import QtQuick 2.15

//Item {

//}


import QtQuick 2.15


Item {
    id: root
    property real currentSpeed: 0
    property real maxSpeed: 200

    Rectangle {
        id: background
        anchors.fill: parent
        radius: width / 2
        color: "#2a2a2a"
        border.color: "#3a3a3a"
        border.width: 2

        // Speed marks
        Repeater {
            model: 11 // 0 to 200, step 20
            Rectangle {
                width: 2
                height: 15
                color: "#ffffff"
                x: background.width/2 - width/2
                y: background.height/2 - height - 100
                transform: Rotation {
                    origin.x: 1
                    origin.y: 115
                    angle: index * 20 - 120
                }
            }
        }

        // Speed value text
        Text {
            anchors.centerIn: parent
            text: Math.round(currentSpeed)
            color: "white"
            font.pixelSize: 48
            font.bold: true
        }

        // Speed unit
        Text {
            anchors.top: parent.verticalCenter
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            text: "km/h"
            color: "white"
            font.pixelSize: 24
        }

        // Needle
        Rectangle {
            id: needle
            width: 4
            height: 100
            color: "red"
            x: background.width/2 - width/2
            y: background.height/2 - height + 8
            antialiasing: true
            transform: Rotation {
                origin.x: 2
                origin.y: height - 8
                angle: -120 + (currentSpeed/maxSpeed * 240)
                Behavior on angle {
                    SpringAnimation {
                        spring: 2
                        damping: 0.2
                        modulus: 360
                    }
                }
            }
        }

        // Center point
        Rectangle {
            width: 20
            height: 20
            radius: 10
            color: "red"
            anchors.centerIn: parent
        }
    }
}
