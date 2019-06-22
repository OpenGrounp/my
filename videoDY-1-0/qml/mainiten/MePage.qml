import Felgo 3.0
import QtQuick 2.0
import "../favorites"
ListPage {

    title: "我的喜欢"
    emptyText.text: qsTr("No  available.")
    FavoritePage{}
}
