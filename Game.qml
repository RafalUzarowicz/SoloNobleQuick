import QtQuick 2.12
import QtQuick.Window 2.12

Item{
    id: game

    anchors.fill: parent

    property var board: undefined

    Component{
        id: boardComponent
        Board {
        }
    }

    Rectangle{
        id: button

        width: parent.width*0.1 > buttonText.width+20 ? parent.width*0.1 : buttonText.width+20
        height: 30
        radius: 0.2*height

        color: "gray"

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottomMargin: 10

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
                    game.board.destroy()
                }
                game.board = boardComponent.createObject(game, {opacity: 0.0})
                game.board.opacity = 1.0
            }
        }
    }

    Rectangle{
        id: status

        property int pawnsNum: 32

        width: parent.width*0.1 > statusText.width+20 ? parent.width*0.1 : statusText.width+20
        height: 30
        radius: 0.2*height

        color: "white"

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.bottomMargin: 10

        border {
            color: "black"
            width: 5
        }

        Text{
            id: statusText
            anchors.centerIn: parent
            text: ""+parent.pawnsNum
        }
    }
}
