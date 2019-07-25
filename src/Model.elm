module Model exposing (Direction(..), Mode(..), Model, Position, Snake, initialModel)

import Keyboard exposing (Key)


type alias Model =
    { count : Float
    , snake : Snake
    , food : Position
    , gameOver : Bool
    , key : Maybe Key
    , mode : Mode
    }


type Direction
    = Up
    | Down
    | Left
    | Right


type alias Snake =
    { head : Position
    , body : List Position
    , direction : Direction
    }


type alias Position =
    { x : Int
    , y : Int
    }


type Mode
    = Normal
    | MasterHacker


initialSnake : Snake
initialSnake =
    { head = { x = 3, y = 0 }
    , body =
        [ { x = 2, y = 0 }
        , { x = 1, y = 0 }
        , { x = 1, y = 0 }
        ]
    , direction = Right
    }


initialModel : Model
initialModel =
    { count = 0
    , snake = initialSnake
    , food = { x = 0, y = 0 }
    , gameOver = False
    , key = Nothing
    , mode = Normal
    }
