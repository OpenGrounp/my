import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.5
import QtMultimedia 5.9

Rectangle{
    id:favoritepage
    anchors.fill: parent
    FavoriteModel{
        id:favoritesmodel
    }

//    ListModel{
//        id:model
//        ListElement{
//            favoriteSource:"./video/01.mp4"
//            favoritePictureSource:"../images/picture/01.png"
//        }
//        ListElement{
//            favoriteSource:"./video/02.mp4"
//            favoritePictureSource:"../images/picture/02.png"
//        }
//        ListElement{
//            favoriteSource:"./video/03.mp4"
//            favoritePictureSource:"../images/picture/03.png"
//        }
//    }
////    Loader{
////        id:pageLoader
////    }

//    //NavigationStack{
////    Image {
////        id: image
////        x: 548
////        y: 396
////        fillMode: Image.PreserveAspectFit
////        source: "Image/pause/three_pointer.png"
////    }

    GridView{
        id:myfavorite
        anchors.fill:parent
        //model: model
        model: favoritesmodel
        width: favoritepage.width
        height: favoritepage.height
        cellWidth: favoritepage.width/3
        cellHeight: 80
        delegate: contactDelegate
        focus: true
    }
        Component{
            id:contactDelegate
            Item{
                width: myfavorite.cellWidth
                height: myfavorite.cellHeight
                Column{
                    anchors.fill:parent
                    Image {
                        //anchors.fill:parent
                        id: favoritepicture
                        width: myfavorite.width/3
                        height: width*1.2
                        source: favoritePictureSource
//                        MouseArea{
//                            anchors.fill:favoritepage
//                            onClicked: {
//                                console.log("  "+favoritepicture.source)
//                            }
//                        }

//                        anchors.horizontalCenter: parent.horizontalCenter
//                        MouseArea{
//                            anchors.fill:parent
//                            onClicked: {
//                              videoPlayer_dy.play()
//                              videoPlayer_dy.visible=true
//                              //myfavorite.visible=false
//                             //pageLoader.source="VideoPage.qml"
//                                //pageLoader.source="VideoPage.qml"
////                                page.navigationStack.push(Qt.resolvedUrl("FavoritesVideo.qml"))
//                            }
//                        }
                    }


                    Image {
                        id:littleheart
                        source: "../images/zan.png"
                        width: 20
                        height: 20
                        anchors.left: favoritepicture.left
                        anchors.leftMargin: 10
                        anchors.bottom: favoritepicture.bottom
                        anchors.bottomMargin: 10
                    }
                    Text {
                        text:"2"
                        color: "white"
                        anchors.left: littleheart.right
                        anchors.leftMargin: 5
                        anchors.bottom: littleheart.bottom
                    }
                }
            }
        }
//        Video{
//            id:videoPlayer_dy
//            width: parent.width
//            height: parent.height
//            source: favoriteSource
//            loops: MediaPlayer.Infinite
//            visible: false
//            //z:1
//            //autoPlay: false
//        }
}
