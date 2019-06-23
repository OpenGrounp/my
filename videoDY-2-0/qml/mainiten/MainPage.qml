import QtQuick 2.4
import QtQuick.Controls 1.2
import Felgo 3.0

Page {
    id: mainPage

    property alias navigation: navigation

    useSafeArea: false // fill full screen

    Navigation {
        //navigationMode: navigationModeDrawer
        id: navigation
        drawer.drawerPosition: drawer.drawerPositionLeft

        NavigationItem {
            id: homeitem
            title:"首页"
            icon:IconType.home

            NavigationStack {
                Page{
                    id: firstpage
                    navigationBarHidden:true//用于隐藏头部
                    HomesPage {id:usepage}

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
            title: "关注"
            id: guanzhu
            icon:IconType.bars

            NavigationStack {
                AttentionPage {}
            }
        }
        NavigationItem{
            id:paishe
            title:"拍摄"
            icon: IconType.angleup
        }


        NavigationItem {
            id:message
            title: "消息"
            icon:IconType.envelope

            NavigationStack {
                id:messagestackid
                MessagePage {}
            }
        }

        NavigationItem {
            id:me
            title:"我"
            icon:IconType.user
            NavigationStack {
                MePage{}

            }

        }

    }
}
