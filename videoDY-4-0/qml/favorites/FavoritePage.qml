/********************************************
 * 本模块实现了点赞收藏，可以播放收藏的视频，也可以取消收藏将视频从我的喜欢中移除
 * 时间：2019-06-24
 * 开发人员：
 *********************************************
 *********************************************/
import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.5
import QtMultimedia 5.9
import jsonData 1.0
import "../mainiten"

ListPage{
    id:favoritepage
    anchors.fill: parent
    property alias myfavorite: myfavorite
    property int thisindex: 0
    property int thisindex1: 0
    property var main : []

    function changeIsLike()
    {
        for(var i = 0; i < jsonmodel.count; i++){
            main[i] = jsonmodel.get(i)
        }
        json_data.jsonData = main
    }

//    JsonDataMain{
//        id: json_data
//    }
    JsonListModel{
        id: jsonmodel
        source: json_data.jsonData
        keyField: "id"
    }
    GridView{
        id:myfavorite
        anchors.fill:parent
        width: favoritepage.width
        height: favoritepage.height
        cellWidth: favoritepage.width/3
        cellHeight: cellWidth*1.2
        delegate: contactDelegate
        focus: true
    }
        Component{
            id:contactDelegate
            Item{
                width: myfavorite.cellWidth
                height: myfavorite.cellHeight
//                Column{
//                    anchors.fill:parent
                    Image {
                        //anchors.fill:parent
                        id: favoritepicture
                        width: myfavorite.width/3
                        height: width*1.2
                        source: favoritePictureSource
                        //property alias videosource: favoriteSource
                        MouseArea{
                            anchors.fill:parent
                            onClicked: {
//                                favoriteVideo.mediaPlayer.source=videoPath
//                                favoriteVideo.mediaPlayer.play()
//                                favoriteVideo.visible=true
                                mediaPlayer.source=videoPath
                                thisindex=index
                                thisindex1 = modelindex
                                //console.log(jsonmodel.get(index).heart_num)
                                mediaPlayer.play()
                                videoplay.visible=true
                                //favoritepage.visible=false
                            }
                        }
                    }


                    Image {
                        id:littleheart
                        source: "../../assets/images/zan.png"
                        width: 20
                        height: 20
                        anchors.left: favoritepicture.left
                        anchors.leftMargin: 10
                        anchors.bottom: favoritepicture.bottom
                        anchors.bottomMargin: 10
                    }
                    Text {
                        text:favoriteNum
                        color: "white"
                        anchors.left: littleheart.right
                        anchors.leftMargin: 5
                        anchors.bottom: littleheart.bottom
                    }
            }
        }
        property alias mediaplayer: mediaPlayer

        Page{
            id:videoplay
            anchors.fill: parent
            visible: false
            Video{
                anchors.fill: parent
                id:mediaPlayer
            }
            AppButton{
                text: qsTr("Cancel collection")
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.top: parent.top
                anchors.topMargin: 10
                z:1
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        favoritesmodel.remove(thisindex)
//                        mediaPlayer.visible=false
                        var heartnum
                        heartnum=jsonmodel.get(thisindex1).heart_num
                        heartnum--
                        jsonmodel.setProperty(thisindex1,"heart_num",heartnum)
                        jsonmodel.setProperty(thisindex1,"isLike",false)
                        changeIsLike()
                        console.log(jsonmodel.get(thisindex).isLike)
                    }
                }
            }
            MouseArea{
                anchors.fill:parent
                onDoubleClicked: {
                    mediaPlayer.stop()
                    videoplay.visible=false
                }
            }
        }

}
