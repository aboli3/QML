
import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Example with List Model"

    ListView {
        width: parent.width
        height: parent.height

        model: personListModel

        delegate: Item {
            width: parent.width
            height: 40

            Text {
                text: "Name: " + name + ", Age: " + age
            }
        }
    }
}
