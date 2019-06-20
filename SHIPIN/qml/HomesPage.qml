import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.9
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

ListPage {
    title: "推荐"   
    MediaPlayer{
        id:mediaplayer
        autoPlay: true
        loops: MediaPlayer.Infinite
        source: "./audio/01.mp4"
        autoLoad: true
    }
    VideoOutput {
        anchors.fill: parent
        source: mediaplayer
    }

    Rectangle{      //进度条
        id: progressBar
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        //width: parent.width
        height: 1
        width: mediaplayer.duration>0?parent.width*mediaplayer.position/mediaplayer.duration:0
        //opacity:
        color: "white"
    }

    Image{
        id:heart
        source: "./Image/heart.png"
        width:50
        height: 50
        visible: true
        anchors.right: parent.right
        anchors.top:parent.top
        anchors.topMargin: 350
        anchors.rightMargin: 15
    }

    Image{
        id:redheart
        source: "./Image/redheart.png"
        width:50
        height: 50
        visible: false
        anchors.right: parent.right
        anchors.top:parent.top
        anchors.topMargin: 350
        anchors.rightMargin: 15
    }

    Image{
        id:pinglun
        source: "./Image/pinglun (3).png"
        width: 50
        height: 50
        visible: true
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 350+heart.height+40
        anchors.rightMargin: 15
    }

    Image {
        id: zhuanfa
        source: "./Image/zhuanfa.png"
        width: 50
        height: 50
        visible: true
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 350+heart.height+pinglun.height+40*2
        anchors.rightMargin: 15
    }

    Image{
        id:pause    //zanting
        source: "./Image/stop3.png"
        visible: false
        anchors.centerIn: parent
        width: 80
        height: 80
    }


    Timer{
        id: clickTimer //超过300ms(典型延时时间)还没有触发第二次点击证明是单击
        property int clickNum: 0
        //            property  bool praise :false
        interval: 500;
        onTriggered: {
            clickNum=0
            clickTimer.stop()
        }
    }

    Image {
        id: redheart1
        width: 50;
        height: 50
        x:mouse.mouseX
        y:mouse.mouseY
        source: "./Image/redheart.png"
        opacity: 1.0
        visible: false

    }
    //        Image {
    //            id: redheart2
    //            width: 50;
    //            height: 50
    //            x:mouse.mouseX
    //            y:mouse.mouseY+10
    //            source: "./Image/redheart1.png"
    //            opacity: 1.0
    //        }

    PropertyAnimation {
        id: animateOpacity;
        target: redheart1
        properties: "opacity";
        to: 0.0;
        duration: 2000
    }
    //        PropertyAnimation{
    //            id:animationwidth
    //            target: redheart1
    //            properties:"width"
    //            to:200
    //            duration: 2000
    //        }
    //        PropertyAnimation{
    //            id:animationheigh
    //            target: redheart1
    //            properties:"height"
    //            to:200
    //            duration: 2000
    //        }

    NumberAnimation {
        id: animateRotation
        target: redheart1
        loops: Animation.Infinite
        properties: "rotation"
        from: 0
        to: 360
        duration: 3000
        easing {type: Easing.OutBack}
    }
    //    }
    MouseArea{
        id:mouse
        anchors.fill:parent
        property int status: 1
        onClicked: {
            clickTimer.clickNum++
            if(clickTimer.clickNum==1) {
                clickTimer.start();
                if(status==1)
                {
                    mediaplayer.pause()
                    pause.visible=true

                    //heart.visible=true
                    //image:"./Image/pause.png"
                    //iconImage:"./Image/pause.png"
                    status=0;
                }
                else{
                    mediaplayer.play()
                    pause.visible=false
                    status=1;
                }
            }
            if(clickTimer.clickNum>1) {
                clickTimer.clickNum=0
                clickTimer.stop()
                mediaplayer.play()
                pause.visible=false
                redheart1.visible=true
                redheart.visible=true
                animateOpacity.start()
                animateRotation.start()

            }
        }

    }
}
