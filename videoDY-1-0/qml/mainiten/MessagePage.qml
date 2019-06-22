import Felgo 3.0
import QtQuick 2.0
import"../messages"
ListPage {

    title: "消息"
    emptyText.text: qsTr("No  available.")
    Messages{}
}
