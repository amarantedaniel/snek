module Model exposing (Model, Player, Position, Size, initialModel)

import Keyboard


type alias Model =
    { count : Float
    , pressedKeys : List Keyboard.Key
    , player : Player
    }


type alias Player =
    { position : Position }


type alias Size =
    { width : Int
    , height : Int
    }


type alias Position =
    { x : Int
    , y : Int
    }


initialModel : Model
initialModel =
    { count = 0, pressedKeys = [], player = { position = { x = 0, y = 0 } } }
