import Felgo 3.0
import QtQuick 2.0

App {
  id: app


  onInitTheme: {
    // Set styles
    Theme.colors.tintColor = "#57adee"
    Theme.colors.backgroundColor = "#eee"

    Theme.navigationBar.backgroundColor = Theme.tintColor
    Theme.navigationBar.titleColor = "white"
    Theme.navigationBar.itemColor = "white"
    Theme.colors.statusBarStyle = Theme.colors.statusBarStyleWhite
  }

  MainPage {}
}
