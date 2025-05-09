import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Grid View")

    ListModel {
        id: model
        ListElement { color: "red"; url: "qrc:/qml/GridViewItem.qml" }
        ListElement { color: "yellow"; url: "qrc:/qml/GridViewItem.qml" }
        ListElement { color: "green"; url: "qrc:/qml/GridViewItem.qml" }
        ListElement { color: "red"; url: "qrc:/qml/GridViewItem.qml" }
        ListElement { color: "yellow"; url: "qrc:/qml/GridViewItem.qml" }
        ListElement { color: "green"; url: "qrc:/qml/GridViewItem.qml" }
        ListElement { color: "red"; url: "qrc:/qml/GridViewItem.qml" }
        ListElement { color: "yellow"; url: "qrc:/qml/GridViewItem.qml" }
        ListElement { color: "green"; url: "qrc:/qml/GridViewItem.qml" }
    }

    Component {
        id: delegate
        Item {
            width: gv.cellWidth - 20
            height: gv.cellHeight - 20
            Component.onCompleted: createQml(this, model.url, model.color)
        }
    }

    function createQml(parent, url, color) {
        var myComp = Qt.createComponent(url)
        if (myComp.status === Component.Ready) {
            myComp.createObject(parent, {
                                    color: color
                                })
        }
    }

    GridView {
        id: gv
        anchors.fill: parent
        model: model
        delegate: delegate
        cellWidth: height / 2
        cellHeight: height / 2
        flow: GridView.FlowTopToBottom
    }

}
