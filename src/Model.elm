module Model exposing (Model, Position, Snake, initialModel)

import Keyboard
import Keyboard.Arrows exposing (Direction(..))


type alias Model =
    { count : Float
    , pressedKeys : List Keyboard.Key
    , lastDirection : Direction
    , snake : Snake
    , food : Position
    , gameOver : Bool
    }


type alias Snake =
    { head : Position
    , body : List Position
    , direction : Direction
    }


type alias Position =
    { x : Int
    , y : Int
    }


initialSnake : Snake
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
    , lastDirection = East
    }
