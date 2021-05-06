import QtQuick 2.12
import QtQuick.Window 2.12

Rectangle{
    antialiasing: true

    property int indexX: 0
    property int indexY: 0

    property int tileIndex: indexX + boardSize*indexY

    property var occupied: false
    property var selected: board.selectedTileX === indexX && board.selectedTileY === indexY
    property var highlighted: occupied ? false : (indexX > 1 && grid.itemAt(indexX-2 + boardSize*indexY).hoveredOn && grid.itemAt(indexX-1 + boardSize*indexY).occupied) ||
                              (indexX < boardSize-2 && grid.itemAt(indexX+2 + boardSize*indexY).hoveredOn && grid.itemAt(indexX+1 + boardSize*indexY).occupied) ||
                              (indexY > 1 && grid.itemAt(indexX + boardSize*(indexY-2)).hoveredOn && grid.itemAt(indexX + boardSize*(indexY-1)).occupied) ||
                              (indexY < boardSize-2 && grid.itemAt(indexX + boardSize*(indexY+2)).hoveredOn && grid.itemAt(indexX + boardSize*(indexY+1)).occupied)
    property var marked: occupied ? false : (indexX > 1 && grid.itemAt(indexX-2 + boardSize*indexY).selected && grid.itemAt(indexX-1 + boardSize*indexY).occupied) ||
                         (indexX < boardSize-2 && grid.itemAt(indexX+2 + boardSize*indexY).selected && grid.itemAt(indexX+1 + boardSize*indexY).occupied) ||
                         (indexY > 1 && grid.itemAt(indexX + boardSize*(indexY-2)).selected && grid.itemAt(indexX + boardSize*(indexY-1)).occupied) ||
                         (indexY < boardSize-2 && grid.itemAt(indexX + boardSize*(indexY+2)).selected && grid.itemAt(indexX + boardSize*(indexY+1)).occupied)

    property var hoveredOn: mouseArea.containsMouse

    color: "transparent"
    height: width
    width: 50

    x: 0
    y: 0

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onReleased: {
            for(i = 0; i<grid.count; ++i){
                grid.itemAt(i).update()
            }
        }

        onClicked: {
            if(occupied){
                board.selectedTileX = indexX
                board.selectedTileY = indexY
                board.selectedTileIndex = tileIndex
            }else{
                var middleIndex = Math.floor(indexX+board.selectedTileX)/2 + boardSize*(Math.floor(indexY+board.selectedTileY)/2)
                if(marked && grid.itemAt(middleIndex).occupied){
                    occupied = true
                    grid.itemAt(board.selectedTileIndex).occupied = false
                    grid.itemAt(middleIndex).occupied = false
                }
            }
        }
    }

    Rectangle{
        anchors.centerIn: parent
        antialiasing: parent.antialiasing

        color: !occupied && highlighted ? "blue" : "transparent"
        height: width
        width: parent.width
        radius: 0.3 * width
    }

    Rectangle{
        anchors.centerIn: parent
        antialiasing: parent.antialiasing

        color: !occupied && marked ? "red" : "transparent"
        height: width
        width: parent.width
        radius: 0.3 * width
    }

    Rectangle{
        anchors.centerIn: parent
        antialiasing: parent.antialiasing

        radius: parent.width*0.1
        width: radius*2
        height: width
        color: "black"
    }

    Rectangle{
        anchors.centerIn: parent
        antialiasing: parent.antialiasing

        radius: parent.width*0.45
        width: radius*2
        height: width
        color: occupied && selected ? "black" : "transparent"
    }

    Rectangle{
        anchors.centerIn: parent
        antialiasing: parent.antialiasing

        radius: parent.width*0.4
        width: radius*2
        height: width
        color: occupied ? "green" : "transparent"
    }

    Text {
        id: lol
        text: qsTr("("+indexX+", "+indexY+")" + tileIndex)
    }
}
