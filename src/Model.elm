module Model exposing (Model, Position, Size, Snake, initialModel)

import Keyboard
import Keyboard.Arrows exposing (Direction(..))


type alias Model =
    { count : Float
    , pressedKeys : List Keyboard.Key
    , snake : Snake
    }


type alias Snake =
    { body : List Position
    , direction : Direction
    }


type alias Size =
    { width : Int
    , height : Int
    }


type alias Position =
    { x : Int
    , y : Int
    }


initialSnake =
    { body = [ { x = 1, y = 0 }, { x = 0, y = 0 } ], direction = NoDirection }


initialModel : Model
initialModel =
    { count = 0, pressedKeys = [], snake = initialSnake }
