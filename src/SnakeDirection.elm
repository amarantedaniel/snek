module SnakeDirection exposing (updateSnakeDirection)

import Keyboard exposing (..)
import Model exposing (Direction(..), Model, Snake)


invalidTransitions =
    [ ( Left, Right ), ( Right, Left ), ( Up, Down ), ( Down, Up ) ]


updateSnakeDirection : Maybe Key -> Snake -> Snake
updateSnakeDirection key snake =
    key
        |> arrowToDirection
        |> Maybe.map (validateNewDirection snake)
        |> Maybe.withDefault snake


arrowToDirection : Maybe Key -> Maybe Direction
arrowToDirection key =
    case key of
        Just ArrowRight ->
            Just Right

        Just ArrowLeft ->
            Just Left

        Just ArrowUp ->
            Just Up

        Just ArrowDown ->
            Just Down

        _ ->
            Nothing


validateNewDirection : Snake -> Direction -> Snake
validateNewDirection snake direction =
    if List.member ( snake.direction, direction ) invalidTransitions then
        snake

    else
        { snake | direction = direction }
