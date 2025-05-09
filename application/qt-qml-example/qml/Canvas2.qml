import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Canvas")


    Canvas {
        anchors.fill: parent

        Image {
            id: myImg
            source: "qrc:/res/bg.jpg"
            visible: false
            smooth: true
        }

        onPaint: {
            var ctx = getContext("2d")
            ctx.translate(120, 140)

            ctx.rotate(Math.PI / 2)
            ctx.beginPath()
            ctx.rect(0,0,100,100)
            ctx.clip()
            ctx.drawImage(myImg, 0, 0, myImg.width*0.2,myImg.height * 0.2)
        }
    }

}
