import QtQuick 2.4
import Felgo 3.0

ListPage {
    title: person

    property string person

    property var newMsgs: []

    property int numRepeats: 1//设置刷新的次数

    readonly property int numLoadedItems: blindTextMsgs.length
    property var blindTextMsgs: [//设置一些历史记录
        { text: "Ha ha ha ha ha ha, you see how interesting it is.", me: true },
        { text: "Ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha.", me: false },
        { text: "This is really an interesting video. I hope you can recommend it to me in the future.", me: false},
        { text: "Okay, yeah.", me: true}
    ]

    model: JsonListModel {
        source: {
            var model = newMsgs
            for(var i = 0; i < numRepeats; i++) {
                model = blindTextMsgs.concat(model)
            }
            return model
        }
    }

    Component.onCompleted: listView.positionViewAtEnd()//设置视图一开始就在底部

    listView.backgroundColor: "white"
    listView.anchors.bottomMargin: inputBox.height//设置视图的下边在输入文字的上边
    listView.header: VisibilityRefreshHandler {//用于在项变为可见时处理数据重新加载操作
        onRefresh: loadTimer.start()//可以添加为AppListView的页眉或页脚。只要该项在AppListView中可见，就会发出刷新信号。
    }

    //fake loading with timer
    Timer {
        id: loadTimer
        interval: 2000
        onTriggered: {
            var pos = listView.getScrollPosition()//返回一个包含有关列表当前滚动位置的内部信息的对象。
            numRepeats++//用于显示刷新的次数
            //   console.log(numRepeats)
            listView.restoreScrollPosition(pos, numLoadedItems)//用于恢复上次列表中的信息
        }
    }

    delegate: Item {
        id: bubble

        width: parent.width
        height: bg.height + dp(20)

        property bool me: model.me

        Rectangle {
            id: bg
            color: me ? Theme.tintColor : "#e9e9e9"
            radius: dp(10)

            x: me ? (bubble.width - width - dp(10)) : dp(10)
            y: dp(10)
            width: innerText.width + dp(20)
            height: innerText.implicitHeight + dp(20)

            Text {
                id: innerText
                x: dp(10)
                y: dp(10)
                width: Math.min(innerText.implicitWidth, bubble.parent.width * 0.75)
                wrapMode: Text.WordWrap//设置在单词边界上进行换行
                text: model.text
                font.pixelSize: sp(16)
                color: me ? "white" : "black"
            }
        }
    }


    // horizontal separator line between input text and
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
        placeholderText: "Type a message ..."
        backgroundColor: "white"
        verticalAlignment: Text.AlignVCenter//设置文本高度对齐方式

        onAccepted: {
            newMsgs = newMsgs.concat({me: true, text: inputBox.text})
            inputBox.text = ""//用于将新数据传送后清空输入框
            listView.positionViewAtEnd()//将图形视图设置为末尾
        }
    }
}

