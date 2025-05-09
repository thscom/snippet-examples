import QtQuick
import QtQuick.Window
import QtQuick.Controls
import Qt.labs.settings

Window {
    id: window
    width: 640
    height: 480
    visible: true
    color: "#ff0000"
    title: qsTr("Attribute")

    Settings {
        fileName: "./settings.ini"
        property alias color: window.color
        property alias window_width: window.width
        property alias window_height: window.height
    }

    Rectangle {
        width: 100
        height: 100
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - height / 2
        color: "yellow"
        focus: true
        // Keys.onLeftPressed: x -= 100
        // Keys.onRightPressed: x += 100
        // Keys.onUpPressed: y -= 100
        // Keys.onDownPressed: y += 100
        Keys.onPressed: {
            switch (event.key) {
            case Qt.Key_Left: {
                x -= 100
                break
            }
            case Qt.Key_Right: {
                x += 100
                break
            }
            case Qt.Key_Up: {
                y -= 100
                break
            }
            case Qt.Key_Down: {
                y += 100
                break
            }
            }
        }
        MouseArea {
            anchors.fill: parent
            onEntered: {
                window.color = window.color == '#ff0000'
                        ? "#00ff00" : "#ff0000"
            }
        }
    }

}
