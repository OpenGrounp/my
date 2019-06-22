import QtQuick 2.4
import Felgo 3.0
ListPage {
    id:comment_page
    MouseArea{
        anchors.fill:parent
        onDoubleClicked: {
            comment1.visible=false
        }
    }

    CommentModel{//初始化一个model
        id:model1
    }
    emptyText.text: qsTr("No messages")

    delegate:
        SimpleRow {
        image.radius: image.height
        image.fillMode: Image.PreserveAspectCrop
        autoSizeImage: true
        imageMaxSize: dp(48)
        text: name
        detailText: contentMessage
        imageSource: Qt.resolvedUrl(iconpath)
        Timer{
            interval: 50//设置触发器之间的间隔
            running: true
            onTriggered: time.text=Qt.formatDateTime(new Date(),"yyyy-MM-dd\nhh:mm")
        }
        Text {
            id: time;
            color: "black";
            font.pointSize: 10;
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.topMargin: parent.height/3
            //anchors.centerIn: parent;
        }

    }
    // Model should be loaded
    model: model1
    Rectangle {//用于对下面输入消息的文本框线条的显示用于分割
        height: px(1)
        anchors.bottom: inputBox.top
        anchors.left: parent.left
        anchors.right: parent.right
        color: "#cccccc"
    }

    AppTextField {
        id: inputBox
        height: dp(48)
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: dp(8)
        anchors.rightMargin: dp(8)
        font.pixelSize: sp(16)
        placeholderText: "Enter message ..."
        backgroundColor: "white"
        verticalAlignment: Text.AlignVCenter//设置文本高度对齐方式

        onAccepted: {
            var data={
                name:"Tom McEloy",
                contentMessage: inputBox.text,

                iconpath:"../images/user1.png"}
            //console.log(inputBox.text)
            if(inputBox.text=="")
            {}else{
                model1.append(data)}
            inputBox.text = ""//用于将新数据传送后清空输入框
            listView.positionViewAtEnd()//将图形视图设置为末尾
        }
    }
}

