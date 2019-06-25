import Felgo 3.0
import QtQuick 2.9

Page {

    AppImage {
        id: image
        anchors.fill: parent
        // important to automatically rotate the image taken from the camera
        autoTransform: true
        fillMode: Image.PreserveAspectFit
    }

    AppButton {
        anchors.centerIn: parent
        text: "Display CameraPicker"
        onClicked: {
            nativeUtils.displayCameraPicker("test")
        }
    }

    Connections {
        target: nativeUtils
        onCameraPickerFinished: {
            if(accepted) image.source = path
        }
    }
}
//import QtQuick 2.12
//import QtMultimedia 5.9

//Item {
//     anchors.fill: parent

//     Camera {
//         id: camera

//         imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash



//         exposure {
//             exposureCompensation: -1.0
//             exposureMode: Camera.ExposurePortrait
//         }

//         flash.mode: Camera.FlashRedEyeReduction

//         imageCapture {
//             onImageCaptured: {
//                 photoPreview.source = preview  // Show the preview in an Image
//             }
//         }
//     }

//     VideoOutput {
//         source: camera
//         anchors.fill: parent
//         focus : visible // to receive focus and capture key events when visible
//     }

//     Image {
//         id: photoPreview
//     }
// }

//import QtQuick 2.12
//import QtMultimedia 5.9


//Item{
//    Camera{//摄像头
//        id: camera
//        captureMode: Camera.CaptureVideo
//        imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash
//        exposure {
//            exposureCompensation: -1.0
//            exposureMode: Camera.ExposurePortrait
//        }

//        flash.mode: Camera.FlashRedEyeReduction

//        videoRecorder {
//            onRecorderStateChanged: {
//                console.log("onRecorderStateChanged: " + videoRecorder.recorderState);
//                if (videoRecorder.recorderState === CameraRecorder.StoppedState) {
//                    console.log("actualLocation: " + videoRecorder.actualLocation);
//                    myvideo.source =  videoRecorder.actualLocation;
//                }
//            }
//        }
//        // videoRecorder.audioEncodingMode: videoRecorder.ConstantBitrateEncoding
//        videoRecorder.audioBitRate: 128000
//        videoRecorder.mediaContainer: "mp4"
//        videoRecorder.outputLocation: "../../assets/video"

//        Component.onCompleted: {
//            camera.viewfinder.resolution.width = 640
//            camera.viewfinder.resolution.height = 480
//            resolution = camera.viewfinder.resolution
//            console.log("resolution: " + resolution.width + " " + resolution.height)
//            console.log("deviceId: " + camera.deviceId)
//        }

//    }
//}
//Item {
//    property bool isCameraAvailable:QtMultimedia.availableCameras.length>0//判断当前相机是否可用
//    property bool isStart:false;//是否开始录像
//    property bool isRecord:false;//是否开始记录
//    property bool isLoop:true;//是否循环预览视频
//    property string videoName:"/mnt/sdcard/Download/vd"//视频录完后保存的名字
//    Rectangle{
//        anchors.fill:parent
//        visible:true//录像的输出
//        VideoOutput{
//            anchors.fill:parent
//            visible:!isRecord
//            source:_mCamera;
//        }
//        Camera
//        {
//            id:_mCamera
//            captureMode:Camera.CaptureVideo//设置录像模式
//            flash.mode:Camera.FlashRedEyeReduction
//            position:Camera.BackFace//设置采用后置摄像头录像
//            focus.focusMode:Camera.FocusAuto //自动获取焦点
//            focus.focusPointMode:Camera.FocusPointCenter
//            //videoRecorder.audioEncodingMode:CameraRecorder.ConstantBitrateEncoding;
//            videoRecorder.audioBitRate:128000 //设置视频比特率为128000
//            videoRecorder.mediaContainer:"mp4"//视频录取格式为MP4
//            videoRecorder.outputLocation:videoName // 视频保存地址
//            exposure{
//                exposureCompensation:-1.0
//                exposureMode:Camera.ExposurePortrait
//            }
//            videoRecorder
//            {
//                onRecorderStateChanged:{//录像状态变化的监听
//                    console.log("onRecorderStateChanged:"+videoRecorder.recorderState);
//                }
//                onDurationChanged:{//获取录像的时长（毫秒）
//                    tmParse(parseInt(duration/1000));
//                }
//            }
//        }
//        MediaPlayer
//        {
//            id:_mPlayer
//            onStopped:{//需求是循环播放录像

//                console.log("playvideostop:")
//                if(isLoop){
//                    _mPlayer.play();
//                }
//            }
//        }//视频播放的输出，录像时隐藏视频播放的输出
//        VideoOutput{
//            id:_mPlayerOutput
//            anchors.fill:parent
//            visible:isRecord
//        }//右边功能控制栏
//        Column{
//            anchors.right:parent.right
//            spacing:16
//            visible:isCameraAvailable
//            anchors.verticalCenter:parent.verticalCenter
//            anchors.rightMargin:18

//            Rectangle{
//                width:72;height:72;radius:width/2
//                color:"gray"
//                visible:isRecord
//                Text{
//                    text:"丢弃"
//                    anchors.fill:parent
//                    horizontalAlignment:Text.AlignHCenter;
//                    verticalAlignment:Text.AlignVCenter
//                    font.pixelSize:height*0.3
//                    color:"white"
//                }
//                MouseArea{
//                    anchors.fill:parent
//                    onClicked:{
//                        isRecord=false;
//                        isLoop=false;
//                        _mPlayer.stop();
//                    }
//                }
//            }
//            Rectangle{
//                width:72;height:72;radius:width/2
//                color:"gray"
//                visible:!isRecord
//                Text
//                {
//                    id:_control
//                    text:"开始";
//                    anchors.fill:parent
//                    horizontalAlignment:Text.AlignHCenter;
//                    verticalAlignment:Text.AlignVCenter
//                    font.pixelSize:height*0.3;color:"white"
//                }
//                MouseArea{
//                    anchors.fill:parent
//                    onClicked:{
//                        if(!isStart){
//                            console.log("getvideoname:"+videoName)
//                            isStart=true;
//                            _control.text="结束"
//                            isRecord=false
//                            _mPlayerOutput.source=_mPlayer
//                            _mCamera.videoRecorder.record()
//                            countDown.start();
//                            console.log("clickisrecordvideo...")
//                        }else{
//                            isStart=false;
//                            _control.text="开始"
//                            isRecord=true
//                            _mCamera.videoRecorder.stop()
//                            _mPlayer.source="file://"+videoName+".mp4"
//                            _mPlayer.play()
//                        }
//                    }
//                }
//            }
//            Rectangle{
//                width:72;height:72;radius:width/2
//                color:"gray";
//                visible:isRecord
//                Text{
//                    text:"使用"
//                    anchors.fill:parent
//                    horizontalAlignment:Text.AlignHCenter;
//                    verticalAlignment:Text.AlignVCenter
//                    font.pixelSize:height*0.3;color:"white"
//                }MouseArea{
//                    anchors.fill:parent
//                    onClicked:{         //单击使用时根据自己的需求做相应的处理
//                    }
//                }
//            }
//        }
//        //当前录像的时间
//        Rectangle{
//            width:160;height:160;radius:80;visible:isStart
//            anchors.horizontalCenter:parent.horizontalCenter
//            color:"#30ffffff"
//            Text{
//                id:videoTime
//                anchors.centerIn:parent
//            }
//        }
//        Text
//        {
//            anchors.centerIn:parent;text:"设备不可用"
//            color:"whitesmoke";font.pixelSize:24
//            visible:!isCameraAvailable
//        }
//    }
//    //把毫秒转换成分秒个格式进行显示
//    function tmParse(duration){
//        console.log("getcurrentduration:"+duration)
//        var min=parseInt(duration/60)
//        var sec=duration%60
//        if(sec<10){
//            sec="0"+sec
//        }
//        if(min<10){
//            min="0"+min
//        }
//        console.log("getmin:"+min+":"+sec)
//        videoTime.text="00:"+min+":"+sec;
//    }
//    Timer{
//        id:countDown
//        interval:10000;
//        running:true;
//        repeat:true;
//        onTriggered:
//        {
//            _mCamera.videoRecorder.stop();
//        }
//    }

//}
//当前录像的时间
//Rectangle{
//    width:160;height:160;radius:80;visible:isStart
//    anchors.horizontalCenter:parent.horizontalCenter
//    color:"#30ffffff"
//    Text{
//        id:videoTime
//        anchors.centerIn:parent
//    }
//}
//Text
//{
//    anchors.centerIn:parent;text:"设备不可用"
//    color:"whitesmoke";font.pixelSize:24
//    visible:!isCameraAvailable
//}
//}
////把毫秒转换成分秒个格式进行显示
//function tmParse(duration){
//    console.log("getcurrentduration:"+duration)
//    var min=parseInt(duration/60)
//    var sec=duration%60
//    if(sec<10){
//        sec="0"+sec
//    }
//    if(min<10){
//        min="0"+min
//    }
//    console.log("getmin:"+min+":"+sec)
//    videoTime.text="00:"+min+":"+sec;
//}
//Timer{
//    id:countDown
//    interval:10000;
//    running:true;
//    repeat:true;
//    onTriggered:
//    {
//        _mCamera.videoRecorder.stop();
//    }
//}



