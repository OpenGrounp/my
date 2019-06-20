import Felgo 3.0
import QtQuick 2.0

ListPage {
  title: qsTr("消息")

  emptyText.text: qsTr("No  messages")

  delegate: SimpleRow {
    image.radius: image.height
    image.fillMode: Image.PreserveAspectCrop
    autoSizeImage: true
    style.showDisclosure: false
    imageMaxSize: dp(48)
    detailTextItem.maximumLineCount: 1
    detailTextItem.elide: Text.ElideRight

    onSelected: {
      messagestackid.popAllExceptFirstAndPush(detailPageComponent, {
                                     person: item.text,
                                     newMsgs: [{me: true, text: item.detailText}]
                                   })
    }
  }

  Component { id: detailPageComponent;  Conversationpage { } }

  model: [
    { text: "Tom McEloy", detailText: "Hahahahahaha.....", image: Qt.resolvedUrl("../assets/portrait1.jpg") }
  ]
}
