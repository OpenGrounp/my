/********************************************
 * 本模块实现了首页的具体功能，包括滑动翻页，视频切换，点赞，评论等
 * 时间：2019-06-24
 * 开发人员：
 *********************************************
 *********************************************/

import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.9
import jsonData 1.0
import "../comment"
//import "../favorites"

ListPage{
    title: qsTr("Home")
    id:page
    visible: true
    property alias jsonmodel: jsonmodel
//    property alias json_data: json_data
    property int heartfavorites:0

    CommentPage{
        id:comment_page
    }

    property var main : []
    property var like : []

    function lookjson()
    {
        favoritesmodel.clear()
        var k = 0;
        for(k = 0; k < jsonmodel.count; k++){
            if(jsonmodel.get(k).isLike === true){
                var data={
                    modelindex : k,
                    videoPath:jsonmodel.get(k).video_source,
                    favoritePictureSource:jsonmodel.get(k).image_source,
                    favoriteNum:jsonmodel.get(k).heart_num
                }
                favoritesmodel.append(data)
            }
        }
    }

    //当喜欢的状态改变值调用此函数
    function changeIsLike()
    {
        var j = 0;
        for(var i = 0; i < jsonmodel.count; i++){
            main[i] = jsonmodel.get(i)
            if(main[i].isLike === true){
                like[j] = jsonmodel.get(i)
                j++
            }
        }
        json_data.jsonData = main
        jsondata_like.jsonDataLike = like
    }

    //关于like-data-json的使用
//    JsonDataLike{
//        id:jsondata_like
//    }

//    //关于默认data-json的使用
//    JsonDataMain{
//        id: json_data
//    }

    JsonListModel{
        id: jsonmodel
        source: json_data.jsonData
        keyField: "id"
    }

    property var stopPlay: listview.currentItem.video_dy

    //实现视频的播放以及点赞，评论分享的整体布局
    AppListView{
        id: listview
        visible: true
        model: jsonmodel
        snapMode: AppListView.SnapOneItem
        highlightRangeMode: AppListView.StrictlyEnforceRange
        onCurrentIndexChanged:{
            currentItem.video_dy.play()
            if(jsonmodel.get(currentIndex).isLike === true){
                currentItem.heart.visible = false
                currentItem.redheart.visible = true
            }
            if(jsonmodel.get(currentIndex).isLike === false){
                currentItem.heart.visible = true
                currentItem.redheart.visible = false
            }
            console.log(jsonmodel.get(currentIndex).isLike)
            lookjson()

            console.log(currentIndex)
        }
        delegate: Rectangle{
            id:rec
            //            anchors.fill: page
            width: page.width
            height: page.height
            property alias video_dy: videoPlayer_dy
            property alias heart: heart
            property alias redheart: redheart

            Rectangle{  //进度条
                id: progressBar
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                //width: parent.width
                height: 1
                width: videoPlayer_dy.duration > 0?parent.width*videoPlayer_dy.position/videoPlayer_dy.duration : 0     //position保存当前播放的位置
                //opacity:
                color: "white"
                z:2

            }

            Image{          //点赞前的白色小心心
                id:heart
                source: "../../assets/images/icon_home_like_before.png"
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
                        jsonmodel.setProperty(index,"isLike",true)
                        if(jsonmodel.get(index).isLike===true)
                        {
                            heart.visible=false
                            redheart.visible=true
                            //page.heartfavorites++

                            heartfavorites=Number(jsonmodel.get(index).heart_num)
                            heartfavorites++
                            jsonmodel.setProperty(index,"heart_num",heartfavorites)
                            changeIsLike()
                            hearttext.text=heartfavorites
                            console.log(jsonmodel.get(index).heart_num)
                            var data={
                                videoPath:jsonmodel.get(index).video_source,
                                favoritePictureSource:jsonmodel.get(index).image_source,
                                favoriteNum:jsonmodel.get(index).heart_num
                            }
                            console.log("videoPath:"+jsonmodel.get(index).video_source)
                            console.log("imagePath:"+jsonmodel.get(index).image_source)
                            //favoritesmodel.append(data)
                            lookjson()
                        }
                    }
                }
            }
            Image{          //点赞之后的红色小心心
                id:redheart
                source: "../../assets/images/icon_home_like_after.png"
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
                        jsonmodel.setProperty(index,"isLike",false)
                        if(jsonmodel.get(index).isLike===false)
                        {
                            redheart.visible=false
                            heart.visible=true
                            //favoritesmodel.remove(index)
                            console.log(jsonmodel.get(index).heart_num)
                            heartfavorites=jsonmodel.get(index).heart_num
                            heartfavorites--
                            jsonmodel.setProperty(index,"heart_num",heartfavorites)
                            changeIsLike()
                            hearttext.text=heartfavorites
                            lookjson()
                        }
                    }
                }
            }
            Image{
                id:pinglunImage      //评论
                source: "../../assets/images/pinglun (3).png"
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
                        //     CommentPage{}
                        comment_page.visible=true
                        comment_page.z=1;
                        comment_page.opacity=0.7
                    }
                }
            }

            Image {
                id: zhuanfa        //转发
                source: "../../assets/images/zhuanfa.png"
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
                id:pauseImage   //点击暂停时出现
                source: "../../assets/images/stop2.png"
                visible: false
                anchors.centerIn: parent
                width: 50
                height: 50
                z:1
            }
            Text{       //点赞人数
                id:hearttext
                text: jsonmodel.get(index).heart_num
                anchors.top: heart.bottom
                anchors.left: heart.left
                anchors.leftMargin: (heart.width-hearttext.text.length)/3
                color: "white"
                z:1
            }
            Video{      //视频播放，视频滑动
                id:videoPlayer_dy
                anchors.fill: parent
                source: jsonmodel.get(index).video_source
                loops: MediaPlayer.Infinite
                autoPlay: false
                MouseArea{
                    hoverEnabled: true
                    anchors.fill: parent
                    onClicked: {
                        if(videoPlayer_dy.playbackState == 1){
                            videoPlayer_dy.pause()
                            pauseImage.visible = true
                        }else{
                            videoPlayer_dy.play()
                            pauseImage.visible = false
                        }
                    }
                    onCanceled:{
                        videoPlayer_dy.pause()
                        videoPlayer_dy.seek(videoPlayer_dy.position-50000)
                    }
                }
            }
        }
    }
}

