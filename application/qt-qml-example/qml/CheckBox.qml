import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("List View")

    CheckBox {
        id: cb
        font.pointSize: 30
        text: "CheckBox"
        tristate: true // unchecked/checked/partially-checked

        onCheckStateChanged: {
            switch (checkState) {
            case Qt.Checked:
                logTxt.text = text + ": Checked"
                break
            case Qt.PartiallyChecked:
                logTxt.text = text + ": Partially Checked"
                break
            default:
                logTxt.text = text + ": UnChecked"
                break
            }
        }

        background: Rectangle {
            color: "blue"
            width: cb.implicitWidth
        }

        contentItem: Text {
            text: cb.text
            color: "yellow"
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            leftPadding: cb.indicator.width
        }

        indicator: Rectangle {
            color: "transparent"
            width: img.width
            height: cb.height

            Image {
                id: img
                anchors.centerIn: parent
                height: cb.height
                source: cb.getCheckState()
                fillMode: Image.PreserveAspectFit
            }
        }

        function getCheckState() {
            switch (cb.checkState) {
            case Qt.Checked:
                return "qrc:/res/Checked.png"
            case Qt.PartiallyChecked:
                return "qrc:/res/PartiallyChecked.png"
            default:
                return "qrc:/res/UnChecked.png"
            }
        }
    }

    Rectangle {
        anchors.top: cb.bottom
        width: logTxt.width
        height: logTxt.height
        color: "yellow"

        Text {
            id: logTxt
            text: qsTr("text")
            font.pointSize: 30
        }
    }
}
