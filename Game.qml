import QtQuick 2.12
import QtQuick.Window 2.12

Item{
    id: game
    width: parent.width
    height: parent.height

    property var board: undefined

    Component{
        id: boardComponent
        Board {
        }
    }



    Rectangle{
        id: button
        width: parent.width*0.1
        height: 30
        color: "gray"
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        border {
            color: "black"
            width: 5
        }

        Text{
            id: buttonText
            anchors.centerIn: parent
            text: "New game"
        }

        MouseArea{
            id: buttonMouseArea
            anchors.centerIn: parent
            width: parent.width
            height: parent.height

            onPressed: {
                status.pawnsNum = 32
                if(game.board != undefined){
                    game.board.opacity = 0.0
                }
                game.board = boardComponent.createObject(game, {opacity: 0.0})
                game.board.opacity = 1.0
            }
        }
    }

    Rectangle{
        id: status
        width: parent.width*0.1
        height: 30
        color: "white"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        border {
            color: "black"
            width: 5
        }

        property int pawnsNum: 32

        Text{
            id: statusText
            anchors.centerIn: parent
            text: ""+parent.pawnsNum
        }
    }


}
