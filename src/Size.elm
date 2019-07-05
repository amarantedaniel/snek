module Size exposing (cellSize, gridSize)


type alias Size =
    { width : Int
    , height : Int
    }


gridSize : Size
gridSize =
    { width = 20, height = 10 }


cellSize : Int
cellSize =
    20
