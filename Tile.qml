import QtQuick 2.12
import QtQuick.Window 2.12

Rectangle{
    property int indexX: 0
    property int indexY: 0
    property int tileIndex: indexX + boardSize*indexY

    property var occupied: false
    property var selected: tileIndex == board.selectedTileIndex
    property var highlighted: occupied ? false : (indexX > 1 && grid.itemAt(indexX-2 + boardSize*indexY).hoveredOn && grid.itemAt(indexX-2 + boardSize*indexY).occupied && grid.itemAt(indexX-1 + boardSize*indexY).occupied) ||
                              (indexX < boardSize-2 && grid.itemAt(indexX+2 + boardSize*indexY).hoveredOn && grid.itemAt(indexX+2 + boardSize*indexY).occupied && grid.itemAt(indexX+1 + boardSize*indexY).occupied) ||
                              (indexY > 1 && grid.itemAt(indexX + boardSize*(indexY-2)).hoveredOn && grid.itemAt(indexX + boardSize*(indexY-2)).occupied && grid.itemAt(indexX + boardSize*(indexY-1)).occupied) ||
                              (indexY < boardSize-2 && grid.itemAt(indexX + boardSize*(indexY+2)).hoveredOn && grid.itemAt(indexX + boardSize*(indexY+2)).occupied && grid.itemAt(indexX + boardSize*(indexY+1)).occupied)
    property var marked: occupied ? false : (indexX > 1 && grid.itemAt(indexX-2 + boardSize*indexY).selected && grid.itemAt(indexX-1 + boardSize*indexY).occupied) ||
                         (indexX < boardSize-2 && grid.itemAt(indexX+2 + boardSize*indexY).selected && grid.itemAt(indexX+1 + boardSize*indexY).occupied) ||
                         (indexY > 1 && grid.itemAt(indexX + boardSize*(indexY-2)).selected && grid.itemAt(indexX + boardSize*(indexY-1)).occupied) ||
                         (indexY < boardSize-2 && grid.itemAt(indexX + boardSize*(indexY+2)).selected && grid.itemAt(indexX + boardSize*(indexY+1)).occupied)

    property var hoveredOn: mouseArea.containsMouse

    property var closeNeighbours: [indexX-1 + boardSize*indexY, indexX+1 + boardSize*indexY, indexX + boardSize*(indexY-1), indexX + boardSize*(indexY+1)]

    property var farNeighbours: [indexX-2 + boardSize*indexY, indexX+2 + boardSize*indexY, indexX + boardSize*(indexY-2), indexX + boardSize*(indexY+2)]

    antialiasing: true
    color: "transparent"
    height: width
    width: 50

    x: 0
    y: 0

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            if(occupied){
                board.selectedTileIndex = tileIndex
            }else{
                var middleIndex = Math.floor(indexX+board.selectedTileIndex%boardSize)/2 + boardSize*(Math.floor(indexY+board.selectedTileIndex/boardSize)/2)
                if(marked && grid.itemAt(middleIndex).occupied){
                    occupied = true
                    grid.itemAt(board.selectedTileIndex).occupied = false
                    grid.itemAt(middleIndex).occupied = false
                    board.selectedTileIndex = tileIndex
                    status.pawnsNum = status.pawnsNum - 1
                }
            }
        }
    }

    Rectangle{
        id: highlight

        property var highlightColor: "blue"
        property var fromColor: !occupied && highlighted ? highlightColor : "transparent"
        property var toColor: !(!occupied && highlighted) ? highlightColor : "transparent"

        anchors.centerIn: parent
        antialiasing: parent.antialiasing
        color: !occupied && highlighted ? highlightColor : "transparent"
        height: width
        width: parent.width
        radius: 0.3 * width

        Behavior on color{
            ColorAnimation {
                from: fromColor
                to: toColor
                duration: 100
            }
        }
    }

    Rectangle{
        id: mark

        property var markColor: "red"
        property var fromColor: !occupied && marked ? markColor : "transparent"
        property var toColor: !(!occupied && marked) ? markColor : "transparent"

        anchors.centerIn: parent
        antialiasing: parent.antialiasing
        color: !occupied && marked ? markColor : "transparent"
        height: width
        width: parent.width
        radius: 0.3 * width

        Behavior on color{
            ColorAnimation {
                from: fromColor
                to: toColor
                duration: 100
            }
        }
    }

    Rectangle{
        id: spot

        anchors.centerIn: parent
        antialiasing: parent.antialiasing
        radius: parent.width*0.1
        width: radius*2
        height: width
        color: "black"

        Behavior on color{
            ColorAnimation {
                from: "transparent"
                to: "black"
                duration: 100
            }
        }
    }

    Rectangle{
        id: selection

        property var selectionColor: "black"
        property var fromColor: occupied && selected ? selectionColor : "transparent"
        property var toColor: !(occupied && selected) ? selectionColor : "transparent"

        anchors.centerIn: parent
        antialiasing: parent.antialiasing
        radius: parent.width*0.45
        width: radius*2
        height: width
        color: occupied && selected ? selectionColor : "transparent"

        Behavior on color{
            ColorAnimation {
                from: fromColor
                to: toColor
                duration: 100
            }
        }
    }

    Rectangle{
        id: pawn

        property var fromColor: occupied ? "green" : "transparent"
        property var toColor: !occupied ? "green" : "transparent"

        anchors.centerIn: parent
        antialiasing: parent.antialiasing
        radius: parent.width*0.4
        width: radius*2
        height: width
        color: occupied ? "green" : "transparent"

        Behavior on color{
            ColorAnimation {
                from: fromColor
                to: toColor
                duration: 300
            }
        }
    }
}
