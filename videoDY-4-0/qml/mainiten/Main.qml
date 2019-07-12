/********************************************
 * 本模块实现了整个程序的整体的属性的设置，以及提供了程序打开的入口
 * 时间：2019-06-24
 * 开发人员：
 *********************************************
 *********************************************/

import Felgo 3.0
import QtQuick 2.0

App {
  id: app


  onInitTheme: {
    // Set styles
    Theme.ploratfm = "android" //程序的使用工具
    Theme.colors.tintColor = "#57adee"
    Theme.colors.backgroundColor = "#eee"

    Theme.navigationBar.backgroundColor = Theme.tintColor
    Theme.navigationBar.titleColor = "white"
    Theme.navigationBar.itemColor = "white"
    Theme.colors.statusBarStyle = Theme.colors.statusBarStyleWhite
  }

  MainPage {}
}
