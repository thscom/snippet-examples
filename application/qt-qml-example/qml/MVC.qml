import QtQuick
import QtQuick.Window
import QtQuick.Controls


Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("MVC")

    ListView {
        id: myListView
        width: 150
        height: parent.height
        model: ListModel {
            ListElement { content: "Item 1" }
            ListElement { content: "Item 2" }
            ListElement { content: "Item 3" }
            ListElement { content: "Item 4" }
        }
        delegate: Rectangle {
            width: 150
            height: 50
            color: index % 2 === 0 ? "#30ffaf" : "#f6ff08"
            Text {
                anchors.centerIn: parent
                text: content
                font {
                    pointSize: 20
                    bold: true
                }
            }
        }
    }

    Column {
        id: myColumn
        width: 150
        height: parent.height
        anchors.left: myListView.right
        anchors.leftMargin: 10
        Repeater {
            model: ["Column 1", "Column 2", "Column 3", "Column 4"]
            delegate: Rectangle {
                width: 150
                height: 50
                color: index % 2 === 0 ?  "#f6ff08": "#30ffaf"
                Text {
                    anchors.centerIn: parent
                    text: modelData
                    font {
                        pointSize: 20
                        bold: true
                    }
                }
            }
        }
    }

    GridView {
        id: myGridView
        width: 300
        height: parent.height
        anchors.left: myColumn.right
        anchors.leftMargin: 10
        cellWidth: 150
        cellHeight: 50
        model: ListModel {
            ListElement { content: "Grid 1" }
            ListElement { content: "Grid 2" }
            ListElement { content: "Grid 3" }
            ListElement { content: "Grid 4" }
        }
        delegate: Rectangle {
            width: 150
            height: 50
            color: index % 2 === 0 ? "#30ffaf" : "#f6ff08"
            Text {
                anchors.centerIn: parent
                text: content
                font {
                    pointSize: 20
                    bold: true
                }
            }
        }
    }
}
