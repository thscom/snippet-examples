import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Button")


    Button {
        anchors.centerIn: parent
        width: 100
        height: 50
        background: Rectangle {
            color: "red"
            MouseArea {
                anchors.fill: parent
                onPressed: {
                    parent.color = "black"
                }
                onReleased: {
                    parent.color = "red"
                }
            }
            Behavior on color {
                ColorAnimation {
                    duration: 300
                }
            }
        }
        contentItem: Rectangle {
            color: "green"
            opacity: 0.5
            MouseArea {
                anchors.fill: parent
                onPressed: {
                    parent.color = "yellow"
                }
                onReleased: {
                    parent.color = "green"
                }
            }
            Behavior on color {
                ColorAnimation {
                    duration: 300
                }
            }
        }
        leftPadding: 0
        rightPadding: 0
        leftInset: 30
        rightInset: 30
        topPadding: 15
        topInset: 0
        bottomPadding: 15
        bottomInset: 0
    }
}
