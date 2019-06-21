import QtQuick 2.4
import QtQuick.Controls 1.2
import Felgo 3.0

ListPage {
    id: mainPage

    property alias navigation: navigation

    useSafeArea: false // fill full screen

    Navigation {

        id: navigation
        drawer.drawerPosition: drawer.drawerPositionLeft

        NavigationItem {
            title:"首页"
            icon:IconType.home
            NavigationStack {
                Page{
                    navigationBarHidden:true//用于隐藏头部
                    HomesPage {}
                }
            }
        }

        NavigationItem {
            title: "关注"
            icon:IconType.bars
            NavigationStack {
                AttentionPage {}
            }
        }
        NavigationItem{
            title:"拍摄"
            icon: IconType.angleup
        }


        NavigationItem {

            title: "消息"
            icon:IconType.envelope

            NavigationStack {
                id:messagestackid
                MessagePage {}
            }
        }

        NavigationItem {
            title:"我"
            icon:IconType.user
            NavigationStack {
                MePage{}

            }

        }

    }
}
