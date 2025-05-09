import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Path View")

    PathView {
        id: pw
        anchors.fill: parent
        model: ListModel {
            ListElement { content:"Item 1"; color: "red" }
            ListElement { content:"Item 2"; color: "green" }
            ListElement { content:"Item 3"; color: "blue" }
            ListElement { content:"Item 4"; color: "red" }
            ListElement { content:"Item 5"; color: "green" }
            ListElement { content:"Item 6"; color: "blue" }
        }
        delegate: Rectangle {
            width: pw.width * 0.5
            height: pw.height * 0.5
            color: model.color
            opacity: PathView.itemOpacity
            z: PathView.itemZ
            Text {
                text: model.content
                anchors.centerIn: parent
                font.pointSize: 30
            }
        }
        path: Path {
            startX: pw.width / 2
            startY: pw.height / 3 * 2
            PathAttribute {
                name: "itemOpacity"
                value: 1.0
            }
            PathAttribute {
                name: "itemZ"
                value: 10
            }
            PathCubic {
                x: pw.width / 2
                y: pw.height / 3
                control1X: pw.width
                control1Y: y
                control2X:  pw.width
                control2Y: pw.height / 3 * 2
            }
            PathAttribute {
                name: "itemOpacity"
                value: 0
            }
            PathAttribute {
                name: "itemZ"
                value: 0
            }
            PathCubic {
                x: pw.width / 2
                y: pw.height / 3 * 2
                control1X: 0
                control1Y: y
                control2X:  0
                control2Y: pw.height / 3
            }
            PathAttribute {
                name: "itemOpacity"
                value: 1
            }
            PathAttribute {
                name: "itemZ"
                value: 10
            }
        }
    }

}
