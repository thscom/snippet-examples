import QtQuick
import QtQuick.Window
import QtQuick.Controls


Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Text")

    Rectangle {
        id: rect
        anchors.centerIn: parent
        height: txt.height
        width: txt.width
        color: "yellow"

        Text {
            id: txt
            text: qsTr("Text")
            anchors.centerIn: parent
            color: "red"
            font {
                family: "Arial"
                pointSize: 50
                bold: true
                italic: true
                underline: true
            }
            style: Text.Outline
            styleColor: "black"
        }

        states: [
            State {
                name: "y"
                PropertyChanges {
                    target: rect
                    color: "yellow"
                }
            },
            State {
                name: "g"
                PropertyChanges {
                    target: rect
                    color: "green"
                }
            }
        ]

        Timer {
            interval: colorAnimation.duration
            repeat: true
            running: true
            onTriggered: {
                if (rect.state == "y"){
                    rect.state = "g"
                } else {
                    rect.state = "y"
                }
            }
        }

        transitions: [
            Transition {
                from: "*"
                to: "*"

                ColorAnimation {
                    id: colorAnimation
                    duration: 300
                }
            }
        ]

    }

}
