module Model exposing (Model, Position, Size, Snake, initialModel)

import Keyboard
import Keyboard.Arrows exposing (Direction(..))


type alias Model =
    { count : Float
    , pressedKeys : List Keyboard.Key
    , snake : Snake
    , food : Position
    , gameOver : Bool
    }


type alias Snake =
    { head : Position
    , body : List Position
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
    { head = { x = 3, y = 0 }
    , body =
        [ { x = 2, y = 0 }
        , { x = 1, y = 0 }
        , { x = 1, y = 0 }
        ]
    , direction = East
    }


initialModel : Model
initialModel =
    { count = 0
    , pressedKeys = []
    , snake = initialSnake
    , food = { x = 10, y = 10 }
    , gameOver = False
    }
