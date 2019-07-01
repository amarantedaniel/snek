module SnakeDirection exposing (updateSnakeDirection)

import Keyboard
import Keyboard.Arrows exposing (Direction(..))
import Model exposing (Snake)


updateSnakeDirection : List Keyboard.Key -> Snake -> Snake
updateSnakeDirection pressedKeys snake =
    let
        direction =
            pressedKeys
                |> getDirection
                |> validateDirectionExists
                |> validateDirectionIsValid snake
    in
    case direction of
        Just validDirection ->
            { snake | direction = validDirection }

        Nothing ->
            snake


getDirection : List Keyboard.Key -> Direction
getDirection pressedKeys =
    Keyboard.Arrows.arrowsDirection pressedKeys


validateDirectionExists : Direction -> Maybe Direction
validateDirectionExists direction =
    if List.member direction [ North, East, South, West ] then
        Just direction

    else
        Nothing


validateDirectionIsValid : Snake -> Maybe Direction -> Maybe Direction
validateDirectionIsValid snake direction =
    case ( snake.direction, direction ) of
        ( West, Just East ) ->
            Nothing

        ( East, Just West ) ->
            Nothing

        ( North, Just South ) ->
            Nothing

        ( South, Just North ) ->
            Nothing

        ( _, _ ) ->
            direction
