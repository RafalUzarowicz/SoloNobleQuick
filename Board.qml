import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.15

Item{
    id: board

    property var boardSize: 7
    property int selectedTileIndex: 0

    anchors.fill: parent

    property var boardMinLenght: Math.min(width, height)

    property var grid: grid

    Behavior on opacity{
        NumberAnimation{
            duration: 300
        }
    }

    Repeater{
        id: grid

        model: boardSize * boardSize
        Tile{
            indexX: modelData % boardSize
            indexY: Math.floor(modelData / boardSize)

            width: board.boardMinLenght / boardSize
            height: board.boardMinLenght / boardSize

            x: board.x + indexX*width + (board.width-board.boardMinLenght)/2
            y: board.y + indexY*height + (board.height-board.boardMinLenght)/2

            enabled:
                (indexY>1 && indexY<boardSize-2) ||
                (indexX>1 && indexX<boardSize-2)
            opacity: enabled
            occupied: modelData == Math.floor(boardSize * boardSize / 2) ? false : true
        }

    }
}
