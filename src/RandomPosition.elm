module RandomPosition exposing (randomPosition)

import Model exposing (Position)
import Random
import Size exposing (gridSize)


randomPosition : (Position -> msg) -> Cmd msg
randomPosition msg =
    Random.map2 Position randomWidth randomHeight
        |> Random.generate msg


randomWidth : Random.Generator Int
randomWidth =
    Random.int 0 (gridSize.width - 1)


randomHeight : Random.Generator Int
randomHeight =
    Random.int 0 (gridSize.height - 1)
