import QtQuick 6.9
import QtQuick.Controls 6.9
import QtQuick.Window 6.9

Window {
    width: 800
    height: 720
    visible: true
    title: "Python QML Example"

    Button {
        id: myBtn
        text: "Click me!"
        // anchors.centerIn: parent
        onClicked: {
            txtLbl.text = "Hello"
        }
    }

    Text {
        id: txtLbl
        text: "PySide6 & QML"
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.right: parent.right
        horizontalAlignment: Text.AlignHCenter
    }

    Rectangle {
        width: 100
        height: 100
        x: 20
        y: 20
        color: "yellow"
        border.color: "black"
        border.width: 3
        clip: true

        Rectangle {
            width: 200
            height: 300
            x: 10
            y: 10
            color: "blue"
            opacity: 1
            radius: 100
            antialiasing: true
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "#000000"}
                GradientStop { position: 1.0; color: "#ffffff"}
            }
            border.color: "red"
            border.width: 3
        }
    }
}