//import QtQuick 2.15
//import QtQuick.Window 2.15
//import QtQuick.Controls 2.15
//import QtMultimedia

////Window {
////    width: 640
////    height: 480
////    visible: true
////    title: qsTr("Hello World")
////}


//// main.qml
////import QtQuick
////import QtQuick.Window
////import QtQuick.Controls

//Window {
//    width: 800
//    height: 480
//    visible: true
//    title: "AI-Enhanced Vehicle Dashboard"
//    color: "#1a1a1a"

//    Row {
//        anchors.centerIn: parent
//        spacing: 20

//        Speedometer {
//            id: speedometer
//            width: 300
//            height: 300
//            currentSpeed: dashboardController.speed
//        }

//        // AI Insights Panel
//        Rectangle {
//            width: 300
//            height: 300
//            color: "#2a2a2a"
//            radius: 10

//            Column {
//                anchors.fill: parent
//                anchors.margins: 20
//                spacing: 15

//                Text {
//                    text: "AI Driving Analysis"
//                    color: "white"
//                    font.pixelSize: 24
//                    font.bold: true
//                }

//                // Risk Level Indicator
//                Rectangle {
//                    width: parent.width
//                    height: 30
//                    color: "#3a3a3a"

//                    Row {
//                        spacing: 2
//                        Repeater {
//                            model: 5
//                            Rectangle {
//                                width: 50
//                                height: 30
//                                color: index < dashboardController.riskLevel ?
//                                    Qt.rgba(1, 0.3, 0.3, 1) : Qt.rgba(0.3, 1, 0.3, 1)
//                            }
//                        }
//                    }
//                }

//                Text {
//                    text: "Driving Advice:"
//                    color: "white"
//                    font.pixelSize: 18
//                }

//                Text {
//                    text: dashboardController.drivingAdvice
//                    color: "#00ff00"
//                    font.pixelSize: 20
//                    wrapMode: Text.WordWrap
//                    width: parent.width
//                }
//            }
//        }
//    }
//}


import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtMultimedia 5.15

Window {
    width: 800
    height: 480
    visible: true
    title: "AI-Enhanced Vehicle Dashboard"
    color: "#1a1a1a"

    Row {
        anchors.centerIn: parent
        spacing: 20

        Speedometer {
            id: speedometer
            width: 300
            height: 300
            currentSpeed: dashboardController.speed
        }

        // AI Insights Panel
        Rectangle {
            width: 300
            height: 300
            color: "#2a2a2a"
            radius: 10

            Column {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15

                Text {
                    text: "AI Driving Analysis"
                    color: "white"
                    font.pixelSize: 24
                    font.bold: true
                }

                // Risk Level Indicator
                Rectangle {
                    width: parent.width
                    height: 30
                    color: "#3a3a3a"

                    Row {
                        spacing: 2
                        Repeater {
                            model: 5
                            Rectangle {
                                width: 50
                                height: 30
                                color: index < dashboardController.riskLevel ?
                                    Qt.rgba(1, 0.3, 0.3, 1) : Qt.rgba(0.3, 1, 0.3, 1)
                            }
                        }
                    }
                }

                Text {
                    text: "Driving Advice:"
                    color: "white"
                    font.pixelSize: 18
                }

                Text {
                    text: dashboardController.drivingAdvice
                    color: "#00ff00"
                    font.pixelSize: 20
                    wrapMode: Text.WordWrap
                    width: parent.width
                }

                // Add Driver Monitoring Panel here
                Rectangle {
                    id: driverMonitoringPanel
                    width: parent.width
                    height: 160
                    color: "#2a2a2a"
                    radius: 10

                    Camera {
                        id: camera

                        VideoOutput {
                            id: videoOutput
                            anchors.fill: parent
                            source: camera
                        }
                    }

                    Rectangle {
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: 40
                        color: dashboardController.driverMonitor.isDriverAlert ?
                               "green" : "red"
                        opacity: 0.7

                        Text {
                            anchors.centerIn: parent
                            text: dashboardController.driverMonitor.alertnessStatus
                            color: "white"
                            font.pixelSize: 14
                            font.bold: true
                        }
                    }
                }
            }
        }
    }
}
