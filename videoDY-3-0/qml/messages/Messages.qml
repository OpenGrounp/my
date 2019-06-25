import Felgo 3.0
import QtQuick 2.0

ListPage {
  title: qsTr("Message")

  emptyText.text: qsTr("No  messages")

  delegate: SimpleRow {
    image.radius: image.height
    image.fillMode: Image.PreserveAspectCrop
    autoSizeImage: true
    style.showDisclosure: false
    imageMaxSize: dp(48)

    onSelected: {
      messagestackid.popAllExceptFirstAndPush(detailPageComponent, {
                                     person: item.text,
                                     newMsgs: [{me: true, text: item.detailText}]
                                   })
    }
  }

  Component { id: detailPageComponent;  Content { } }

  model: [
    { text: "Mary", detailText: "Hahahahahaha.....", image: Qt.resolvedUrl("../../assets/images/portrait1.jpg") }
  ]
}
