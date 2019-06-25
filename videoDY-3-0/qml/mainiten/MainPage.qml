/********************************************
 * 本模块实现了QML页面的整体框架的实现，主要包括了首页、关注页、拍摄页、消息页、关于我的喜欢的页面
 * 时间：2019-06-24
 * 开发人员：
 *********************************************
 *********************************************/

import QtQuick 2.4
import QtQuick.Controls 1.2
import Felgo 3.0
import "../favorites"
import "../camera"

Page {
    id: mainPage

    property alias navigation: navigation

    useSafeArea: false

    ListModel{
        id:favoritesmodel
    }
    FavoritePage{

    }
    //关于默认data-json的使用
    Navigation {
        navigationMode: navigationModeDefault
        id: navigation
        drawer.drawerPosition: drawer.drawerPositionLeft

        NavigationItem {
            id: homeitem
            title: qsTr("Home")
            icon:IconType.home

            NavigationStack {
                Page{
                    id: firstpage
                    navigationBarHidden:true//用于隐藏头部
                    HomesPage {
                        id:usepage
                        anchors.fill: mainPage
                        tabBarHidden: true
                    }

                    Connections{
                        target: guanzhu
                        onSelected:{
                            usepage.stopPlay.pause()
                        }
                    }
                    Connections{
                        target: me
                        onSelected:{
                            usepage.stopPlay.pause()
                        }
                    }
                    Connections{
                        target: paishe
                        onSelected:{
                            usepage.stopPlay.pause()
                        }
                    }
                    Connections{
                        target: message
                        onSelected:{
                            usepage.stopPlay.pause()
                        }
                    }
                    Connections{
                        target: homeitem
                        onSelected:{
                            usepage.stopPlay.seek(usepage.stopPlay.position-50000)
                            usepage.stopPlay.play()
                        }
                    }
                }
            }
        }

        NavigationItem {
            title: qsTr("Attention")
            id: guanzhu
            icon:IconType.bars

            NavigationStack {
                AttentionPage {}
            }
        }
        NavigationItem{
            id:paishe
            title:qsTr("Shooting")
            icon: IconType.angleup
            NavigationStack{
                CameraPage{}
            }
        }


        NavigationItem {
            id:message
            title: qsTr("Message")
            icon:IconType.envelope

            NavigationStack {
                id:messagestackid
                MessagePage {}
            }
        }

        NavigationItem {
            id:me
            title:qsTr("Me")
            icon:IconType.user
            NavigationStack {
                Page{
                    title: qsTr("My Favorite")
                    //navigationBarHidden:true//用于隐藏头部
                    FavoritePage{
                        anchors.fill: parent
                        myfavorite.model:favoritesmodel
                    }

                }

            }

        }

    }
}

