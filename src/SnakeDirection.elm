module SnakeDirection exposing (updateLastDirection, updateSnakeDirection)

import Keyboard
import Keyboard.Arrows exposing (Direction(..))
import Model exposing (Model, Snake)


validDirections : List Direction
validDirections =
    [ North, East, South, West ]


invalidTransitions : List ( Direction, Direction )
invalidTransitions =
    [ ( West, East ), ( East, West ), ( North, South ), ( South, North ) ]


updateLastDirection : List Keyboard.Key -> Model -> Direction
updateLastDirection pressedKeys model =
    let
        direction =
            getDirection pressedKeys
    in
    case direction of
        Just validDirection ->
            validDirection

        Nothing ->
            model.lastDirection


getDirection : List Keyboard.Key -> Maybe Direction
getDirection pressedKeys =
    let
        direction =
            Keyboard.Arrows.arrowsDirection pressedKeys
    in
    if List.member direction validDirections then
        Just direction

    else
        Nothing


updateSnakeDirection : Direction -> Snake -> Snake
updateSnakeDirection direction snake =
    if List.member ( snake.direction, direction ) invalidTransitions then
        snake

    else
        { snake | direction = direction }
