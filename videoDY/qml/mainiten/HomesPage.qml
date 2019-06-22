import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.9
import testApp 1.0
import "../comment"
import "../favorites"
ListPage{
    //id:root
    property int isPlay: 0
    property int heartfavorites:1023
    function changeIsLike()
    {
        json_data.jsonData = arguments[0]
    }
CommentPage{
    id:comment1
}

        title: "首页"
        id:page

        JsonData{
            id: json_data
        }

        JsonListModel{
            id: jsonmodel
            source: json_data.jsonData
            keyField: "id"
        }

        FavoriteModel{
            id:favoritesmodel
        }

        AppListView{
            id: listview
            model: jsonmodel
            snapMode: AppListView.SnapOneItem
            highlightRangeMode: AppListView.StrictlyEnforceRange
            onCurrentIndexChanged:{
                isPlay = currentIndex
                currentItem.video_dy.play()
                console.log(currentIndex)
            }
            delegate: Rectangle{
                id:rec
                width: page.width
                height: page.height
                property alias video_dy: videoPlayer_dy

                Image{          //白色小心心
                    id:heart
                    source: "../images/icon_home_like_before.png"
                    width:60
                    height:60
                    visible: true
                    z:1
                    anchors.right: parent.right
                    anchors.top:parent.top
                    anchors.topMargin: 450
                    anchors.rightMargin: 15
                    MouseArea{
                        anchors.fill: heart
                        onClicked: {
                            heart.visible=false
                            redheart.visible=true
                            page.heartfavorites++
                            var data={
                                "videoPath":jsonmodel.get(index).video_source,
                                "favoritePictureSource":jsonmodel.get(index).image_source
                            }
                            console.log("videoPath:"+jsonmodel.get(index).video_source)
                            console.log("videoPath:"+jsonmodel.get(index).image_source)
                            favoritesmodel.append(data)
                        }
                    }
                }
                Image{          //红色小心心
                    id:redheart
                    source: "../images/icon_home_like_after.png"
                    width:60
                    height: 60
                    visible: false
                    z:1
                    anchors.right: parent.right
                    anchors.top:parent.top
                    anchors.topMargin: 450
                    anchors.rightMargin: 15
                    MouseArea{
                        anchors.fill: redheart
                        onClicked: {
                            redheart.visible=false
                            heart.visible=true
                            page.heartfavorites--
                            favoritesmodel.remove(index)                        //                            var data={"favoriteSource": }
                        }
                    }
                }
                Image{
                    id:pinglunImage      //评论
                    source: "../images/pinglun (3).png"
                    width: 50
                    height: 50
                    visible: true
                    z:1
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 450+heart.height+40
                    anchors.rightMargin: 15
                    MouseArea{
                        anchors.fill: pinglunImage
                        onClicked: {
                            console.log("true")
                            comment1.visible=true
                            comment1.z=100
                            comment1.opacity=0.7
                        }

                    }
                }

                Image {
                    id: zhuanfa        //转发
                    source: "../images/zhuanfa.png"
                    width: 50
                    height: 50
                    visible: true
                    z:1
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 450+heart.height+pinglunImage.height+40*2
                    anchors.rightMargin: 15
                }

                Image{
                    id:pauseImage   //暂停
                    source: "../images/stop2.png"
                    visible: false
                    anchors.centerIn: parent
                    width: 50
                    height: 50
                    z:1
                }
                Text{       //点赞人数
                    id:hearttext
                    text: page.heartfavorites
                    anchors.top: heart.bottom
                    anchors.left: heart.left
                    anchors.leftMargin: (heart.width-hearttext.text.length)/3
                    color: "white"
                    z:1
                }
                Video{
                    id:videoPlayer_dy
                    anchors.fill: parent
                    source: jsonmodel.get(index).video_source
                    loops: MediaPlayer.Infinite
                    autoPlay: false
                    MouseArea{
                        hoverEnabled: true
                        anchors.fill: parent
                        onClicked: {
                            //console.log(model[index].video_source)
                            if(videoPlayer_dy.playbackState == 1)
                            {
                                videoPlayer_dy.pause()
                                pauseImage.visible=true
                            }

                            else{
                                pauseImage.visible=false
                                videoPlayer_dy.play()
                            }
                        }
                        onCanceled: {
                            videoPlayer_dy.seek(videoPlayer_dy.position-50000)
                            videoPlayer_dy.pause()
                        }
                    }
                }
            }
        }
    }

