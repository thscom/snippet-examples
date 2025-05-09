import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Busy Indicator")

    BusyIndicator {
        id: bi
        // anchors.fill: parent
        // anchors.centerIn: parent
        width: 100
        height: 100
        MouseArea {
            anchors.fill: parent
            onClicked: {
                bi.running = !bi.running
            }
        }

        background: Rectangle {
            id: bgRect
            color: "transparent"
        }

        contentItem: Item {
            Rectangle {
                anchors.centerIn: parent
                width: parent.width < parent.height
                    ? parent.width / 4 * 3 : parent.height / 4 * 3
                height: width
                color: bgRect.color
                radius: height / 2
                border.width: height / 12
            }

            Canvas {
                id: cv
                anchors.centerIn: parent
                width: parent.width < parent.height
                    ? parent.width / 4 * 3 : parent.height / 4 * 3
                height: width
                property real angle: 0
                function rotate() {
                    var ctx = getContext("2d")
                    ctx.clearRect(0,0,cv.width,cv.height)
                    ctx.beginPath()
                    ctx.arc(width/2,height/2,height/2-height/12/2, cv.angle, cv.angle + Math.PI * 2 / 12, false)
                    ctx.lineWidth = height/12
                    ctx.strokeStyle="red"
                    ctx.stroke()
                    requestAnimationFrame(rotate)
                }

                onPaint: {
                    rotate()
                }

                Timer {
                    repeat: true
                    interval: 25
                    onTriggered: {
                        cv.angle += Math.PI * 2 / 24
                    }
                    running: bi.running
                }
            }
        }
    }

    BusyIndicator {
        id: bi2
        anchors.centerIn: parent
        width: 100
        height: 100
        MouseArea {
            anchors.fill: parent
            onClicked: {
                bi2.running = !bi2.running
            }
        }
    }
}
