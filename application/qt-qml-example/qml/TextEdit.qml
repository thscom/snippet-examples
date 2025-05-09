import QtQuick
import QtQuick.Window
import QtQuick.Controls


Window {
    width: 640
    height: 320
    visible: true
    title: qsTr("TextEdit")

    Rectangle {
        anchors.centerIn: parent
        width: te.width
        height: te.height
        color: "yellow"

        TextEdit {
            id: te
            anchors.centerIn: parent
            text: "Text Edit"
            color: "red"
            font {
                pointSize: 30
                bold: true
            }
            selectByMouse: true
            selectionColor: "blue"

            cursorDelegate: Canvas {
                width: 4
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.setLineDash([2,2,2])
                    ctx.lineWidth = 4
                    ctx.strokeStyle = "#444fff"
                    ctx.lineCap = "round"
                    ctx.beginPath()
                    ctx.moveTo(0,0)
                    ctx.lineTo(0, height)
                    ctx.stroke()
                }
            }
        }

    }
}
