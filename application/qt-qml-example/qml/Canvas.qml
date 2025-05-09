import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Canvas")


    Canvas {
        id: myCanvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d")

            ctx.beginPath()
            ctx.rect(50,50,100,100)
            ctx.stroke()

            ctx.beginPath()
            ctx.arc(200,100,50, 0, Math.PI)
            ctx.stroke()

            ctx.beginPath()
            ctx.moveTo(250, 100)
            ctx.lineTo(420, 100)
            ctx.stroke()

            ctx.fillStyle = "red"
            ctx.font = "italic 30px Arial"
            ctx.fillText("Hello Canvas", 250, 90)

            ctx.beginPath()
            ctx.ellipse(420, 50, 200, 100)
            ctx.stroke()

            ctx.fillStyle = "red"
            ctx.fillRect(50,200,100,100)

            ctx.beginPath()
            ctx.moveTo(150, 200)
            ctx.quadraticCurveTo(250, 150, 250,250)
            ctx.stroke()

            ctx.beginPath()
            ctx.moveTo(450,245)
            ctx.lineTo(500, 245)
            ctx.lineTo(500, 225)
            ctx.lineTo(525, 250)
            ctx.lineTo(500, 275)
            ctx.lineTo(500, 255)
            ctx.lineTo(450, 255)
            ctx.closePath()
            ctx.fillStyle = "yellow"
            ctx.fill()
            ctx.strokeStyle = "black"
            ctx.lineWidth = 2
            ctx.stroke()
        }
    }
}
