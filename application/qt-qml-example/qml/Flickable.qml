import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Flickable")

    Rectangle {
        width: 300
        height: 300
        color: "red"
        clip: true
        anchors.centerIn: parent

        Flickable {
            id: fk
            anchors.fill: parent

            Image {
                id: ct
                source: "qrc:/res/bg.jpg"
            }

            contentWidth: ct.width
            contentHeight: ct.height
            rebound: Transition {
                NumberAnimation {
                    properties: "x,y"
                    duration: 500
                    easing.type: Easing.OutBounce
                }
            }

            ScrollBar.vertical: ScrollBar {
                background: Rectangle {
                    color: "#ffffff"
                }
                interactive: true
            }
            ScrollBar.horizontal: ScrollBar {
                background: Rectangle {
                    color: "#ffffff"
                }
                interactive: true
            }

            MouseArea {
                anchors.fill: parent
                onWheel: {
                    var delta = wheel.angleDelta.y / 120
                    if (delta > 0) {
                        ct.scale *= 1.1
                    } else {
                        ct.scale /= 1.1
                    }

                }
            }
        }
    }

}
