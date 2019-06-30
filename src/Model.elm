module Model exposing (Model, Player, Position, Size, initialModel)

import Keyboard
import Keyboard.Arrows exposing (Direction(..))


type alias Model =
    { count : Float
    , pressedKeys : List Keyboard.Key
    , player : Player
    }


type alias Player =
    { position : Position, direction : Direction }


type alias Size =
    { width : Int
    , height : Int
    }


type alias Position =
    { x : Int
    , y : Int
    }


initialPlayer =
    { position = { x = 0, y = 0 }, direction = NoDirection }


initialModel : Model
initialModel =
    { count = 0, pressedKeys = [], player = initialPlayer }
