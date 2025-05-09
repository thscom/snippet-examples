import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("List View")

    Rectangle {
        height: lv.height
        width: lv.width
        color: "blue"
        clip: true

        ListModel {
            id: model
            ListElement {
                name: "Group 1"
                url: "qrc:/qml/ChildListView.qml"
                subListElement: [
                    ListElement { content: "Item 11" },
                    ListElement { content: "Item 12" },
                    ListElement { content: "Item 13" }
                ]
            }
            ListElement {
                name: "Group 2"
                url: "qrc:/qml/ChildListView.qml"
                subListElement: [
                    ListElement { content: "Item 21" },
                    ListElement { content: "Item 22" },
                    ListElement { content: "Item 23" },
                    ListElement { content: "Item 24" },
                    ListElement { content: "Item 25" }
                ]
            }
            ListElement {
                name: "Group 3"
                url: "qrc:/qml/ChildListView.qml"
                subListElement: [
                    ListElement { content: "Item 31" },
                    ListElement { content: "Item 32" },
                    ListElement { content: "Item 33" },
                    ListElement { content: "Item 34" },
                    ListElement { content: "Item 35" }
                ]
            }
        }

        ListView {
            id: lv
            width: 260
            height: root.height
            model: model
            delegate: ChildListView {
                title: name
                childModel: subListElement
            }

            ScrollBar.vertical: ScrollBar {
                background: Rectangle {
                    color: "#ffffff"
                }
                interactive: true
            }
        }
    }


}
