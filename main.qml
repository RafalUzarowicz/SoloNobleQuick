import QtQuick 2.12
import QtQuick.Window 2.12

//Item {
//    anchors.fill: parent
//    visible: true

//    Game {
//        id: game
//    }
//}


Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello Quick")



    Game {
        id: game
    }
}
