module GameMode exposing (updateGameMode)

import Keyboard exposing (..)
import Model exposing (Mode(..))


hackerKeys : List (Maybe Key)
hackerKeys =
    [ "j", "k", "l", "h" ]
        |> List.map Character
        |> List.map Just


updateGameMode : Maybe Key -> Mode
updateGameMode key =
    if List.member key hackerKeys then
        MasterHacker

    else
        Normal
