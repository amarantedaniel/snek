module Size exposing (cellSize, gridSize)


type alias Size =
    { width : Int
    , height : Int
    }


gridSize : Size
gridSize =
    { width = 40, height = 20 }


cellSize : Int
cellSize =
    20
