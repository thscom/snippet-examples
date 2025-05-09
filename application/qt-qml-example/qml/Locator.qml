import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("List View")

    Rectangle {
        id: rect1
        width: parent.width / 2
        height: parent.height / 2
        border.width: 1

        Column {
            anchors.fill: parent
            spacing: 10
            Repeater {
                model: 4
                delegate: Rectangle {
                    width: 50
                    height: 50
                    border.width: 1
                    color: "yellow"
                    opacity: 0.5
                }
            }
        }
        Text {
            text: qsTr("Column")
            anchors.centerIn: parent
            font.pointSize: 30
        }
    }

    Rectangle {
        id: rect2
        width: parent.width / 2
        height: parent.height / 2
        border.width: 1
        anchors.left: rect1.right

        Flow {
            anchors.fill: parent
            spacing: 10
            Repeater {
                model: 4
                delegate: Rectangle {
                    width: 50
                    height: 50
                    border.width: 1
                    color: "green"
                    opacity: 0.5
                }
            }
        }
        Text {
            text: qsTr("Flow")
            anchors.centerIn: parent
            font.pointSize: 30
        }
    }

    Rectangle {
        id: rect3
        width: parent.width / 2
        height: parent.height / 2
        border.width: 1
        anchors.top: rect1.bottom

        Grid {
            anchors.fill: parent
            spacing: 10
            columns: 3
            rows: 2
            Repeater {
                model: 5
                delegate: Rectangle {
                    width: 50
                    height: 50
                    border.width: 1
                    color: "blue"
                    opacity: 0.5
                }
            }
        }
        Text {
            text: qsTr("Grid")
            anchors.centerIn: parent
            font.pointSize: 30
        }
    }

    Rectangle {
        id: rect4
        width: parent.width / 2
        height: parent.height / 2
        border.width: 1
        anchors.top: rect2.bottom
        anchors.left: rect3.right

        Row {
            anchors.fill: parent
            spacing: 10
            Repeater {
                model: 5
                delegate: Rectangle {
                    width: 50
                    height: 50
                    border.width: 1
                    color: "blue"
                    opacity: 0.5
                }
            }
        }
        Text {
            text: qsTr("Row")
            anchors.centerIn: parent
            font.pointSize: 30
        }
    }
}
