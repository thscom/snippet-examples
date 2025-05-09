import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    width: 640
    height: 320
    visible: true
    title: qsTr("TextInput")


    Rectangle {
        anchors.centerIn: parent
        width: ti.width
        height: ti.height
        color: "yellow"
        border {
            color: "black"
        }

        Text {
            id: tl
            visible: false
            text: ti.text
            font.pointSize: ti.font.pointSize
        }

        TextInput {
            id: ti
            anchors.centerIn: parent
            width: text.length < 1
                   ? 100 : echoMode == TextInput.Password
                     ? tl.width * 2 : tl.width
            font {
                pointSize: 30
                bold: true
            }
            // echoMode: TextInput.Password

            validator: RegularExpressionValidator {
                regularExpression: /^\d+$/
            }

            cursorVisible: true
            cursorDelegate: Rectangle {
                id: rect
                width: 4
                color: "red"

                states: [
                    State {
                        name: "red"
                        PropertyChanges {
                            target: rect
                            color: "red"
                        }
                    },
                    State {
                        name: "transparent"
                        PropertyChanges {
                            target: rect
                            color: "transparent"
                        }
                    }
                ]

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

                Timer {
                    interval: colorAnimation.duration
                    repeat: true
                    running: true
                    onTriggered: {
                        rect.state = rect.state === "red"
                                ? "transparent" : "red"
                    }
                }
            }
        }
    }

}
