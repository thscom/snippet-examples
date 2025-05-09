import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("List View")

    Rectangle {
        id: rect
        width: 100
        height: 100
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
                name: "yellow"
                PropertyChanges {
                    target: rect
                    color: "yellow"
                }
            }
        ]
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (rect.state === "red") {
                    rect.state = "yellow"
                } else {
                    rect.state = "red"
                }
            }
        }
        Behavior on color {
            ColorAnimation {
                duration: 300
            }
        }
    }

    Rectangle {
        id: rect1
        width: 100
        height: 100
        color: "red"
    }

    SequentialAnimation{
        running: true
        ParallelAnimation {

            ColorAnimation {
                target: rect1
                property: "color"
                from: "red"
                to: "blue"
                duration: 500

            }

            NumberAnimation {
                target: rect1
                property: "x"
                from: 0
                to: 150
                duration: 500
                easing.type: Easing.InOutQuad
            }
        }


        PropertyAction {
            target: rect1
            property: "y"
            value:100
        }

        PauseAnimation {
            duration: 200
        }

        ScriptAction {
            script: myScript()
        }

        PropertyAnimation {
            target: rect1
            property: "width"
            from: 100
            to: 150
            duration: 500
        }
    }

    Text {
        id: txt
        anchors.top: rect.bottom
        font.pointSize: 30
        text: "Text Animate"
    }

    function myScript() {
        txt.anchors.left = rect1.left
        txt.anchors.top = rect1.bottom
        txt.text = "Execute Script Action"
    }

}
