import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Shapes
import App.Backend 1.0


Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello QML")

    Rectangle {
        id: rect1
        width: 50
        height: 50
        x: 10
        y: 10
        clip: true
        color: "yellow"
        opacity: 1
        border.color: "black"
        border.width: 3

        Rectangle {
            width: 100
            height: 100
            x: 10
            y: 10
            radius: 50
            border.color: "red"
            border.width: 3
            antialiasing: true
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "#00999f" }
                GradientStop { position: 0.5; color: "#8dd8ca" }
                GradientStop { position: 1.0; color: "#2faead" }
            }
        }

        MouseArea {
            anchors.fill: parent
            drag.target: rect1
        }
    }

    Button {
        width: 100
        height: 30
        x: 20
        y: 70
        text: qsTr("backend")
        onClicked: {
            Backend.receive("Button 1 msg")
        }
    }

    Button {
        width: 100
        height: 30
        x: 140
        y: 70
        text: qsTr("backend2")
        onClicked: {
            Backend.receive("Button 2 msg")
        }
    }

    function onTestSignal(param){
        txtArea.text += "\n test signal" + param
    }

    Button {
        width: 100
        height: 30
        x: 260
        y: 70
        clip: false
        text: qsTr("signal")
        signal mySignal(var param)
        onClicked: {
            clip = true
            mySignal.connect(onTestSignal)
            mySignal(" -> ^_^!")
        }
        onClipChanged: {
            txtArea.text += "\n clip attribute changed"
        }
    }

    TextArea {
        id: txtArea
        x: 20
        y:170
        font.pointSize: 20
        placeholderText: qsTr("Msg area")
    }

    Connections {
        target: Backend
        function onMessage(msg) {
            txtArea.text = msg
        }
    }
    Connections {
        target: Backend2
        function onMessage(msg) {
            txtArea.text = msg
        }
    }

    Switch {
        anchors.centerIn: parent
        text: "Timer"
        checked: true
        onCheckedChanged: {
            if (checked) {
                myTimer.start()
                text = "Stop Timer"
            } else {
                myTimer.stop()
                text = "Start Timer"
            }
        }
    }

    Timer {
        id: myTimer
        interval: 500
        repeat: true
        running: true
        onTriggered: {
            txtArea.color =
                    (txtArea.color == "#ff0000")
                ? "#0000ff" : "#ff0000"
        }
    }

    Rectangle {
        id: rect2
        width: 100
        height: 100
        color: "red"
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.bottomMargin: 10

        Text {
            anchors.centerIn: parent
            font.pointSize: 18
            text: qsTr("rect2")
        }

        property int myNum: 1
        states: [
            State {
                name: "state 1"
                when: rect2.myNum == 1
                changes: [
                    PropertyChanges {
                        target: rect2
                        color: "red"

                    }
                ]
            },
            State {
                name: "state 2"
                when: rect2.myNum == 2
                changes: [
                    PropertyChanges {
                        target: rect2
                        color: "blue"

                    }
                ]
            }
        ]
        MouseArea {
            anchors.fill: parent
            onEntered: {
                rect2.myNum = 2
                // rect2.state = "state 2"
            }
            onExited: {
                rect2.myNum = 1
                // rect2.state = "state 1"
            }
        }

        transitions: [
            Transition {
                from: "state 1"
                to: "state 2"

                ColorAnimation {
                    property: "color"
                    duration: 300
                }
            },
            Transition {
                from: "state 2"
                to: "state 1"

                ColorAnimation {
                    property: "color"
                    duration: 500
                }
            }
        ]
    }
}
