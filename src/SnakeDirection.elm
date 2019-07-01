module SnakeDirection exposing (updateLastDirection, updateSnakeDirection)

import Keyboard
import Keyboard.Arrows exposing (Direction(..))
import Model exposing (Model, Snake)


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
    if List.member direction [ North, East, South, West ] then
        Just direction

    else
        Nothing


updateSnakeDirection : Direction -> Snake -> Snake
updateSnakeDirection direction snake =
    case ( snake.direction, direction ) of
        ( West, East ) ->
            snake

        ( East, West ) ->
            snake

        ( North, South ) ->
            snake

        ( South, North ) ->
            snake

        ( _, _ ) ->
            { snake | direction = direction }
