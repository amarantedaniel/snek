module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (src)
import Model exposing (Mode(..), Model, Position, Snake)
import Size exposing (cellSize, gridSize)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Update exposing (Msg(..))


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ Html.text "snek" ]
        , p [] [ Html.text "Use the arrows to move the snek" ]
        , svg
            [ class "grid"
            , viewBox ("0 0 " ++ String.fromInt (gridSize.width * cellSize) ++ " " ++ String.fromInt (gridSize.height * cellSize))
            ]
            (renderBackground
                ++ renderSnake model.snake
                ++ renderFood model.food
                ++ renderGameOver model.gameOver
            )
        , p []
            [ if model.gameOver then
                Html.text "Press space to play again"

              else
                Html.text ""
            ]
        , if model.mode == MasterHacker then
            img [ class "master-hacker", src "https://i.imgur.com/iVHfwLc.gif" ] []

          else
            Html.text ""
        ]


renderBackground : List (Html Msg)
renderBackground =
    [ rect
        [ width (String.fromInt (gridSize.width * cellSize))
        , height (String.fromInt (gridSize.height * cellSize))
        , fill "#8cbf00"
        ]
        []
    ]


renderSnake : Snake -> List (Html Msg)
renderSnake snake =
    renderSnakePart snake.head :: List.map renderSnakePart snake.body


renderSnakePart : Position -> Html Msg
renderSnakePart position =
    rect
        [ width (String.fromInt cellSize)
        , height (String.fromInt cellSize)
        , x (String.fromInt (position.x * cellSize))
        , y (String.fromInt (position.y * cellSize))
        , fill "black"
        , stroke "gray"
        ]
        []


renderFood : Position -> List (Html Msg)
renderFood food =
    [ circle
        [ cx (String.fromInt ((food.x * cellSize) + (cellSize // 2)))
        , cy (String.fromInt ((food.y * cellSize) + (cellSize // 2)))
        , r (String.fromInt (cellSize // 3))
        , fill "black"
        , stroke "gray"
        ]
        []
    ]


renderGameOver : Bool -> List (Html Msg)
renderGameOver gameOver =
    [ Svg.text_
        [ x (String.fromInt ((gridSize.width * cellSize) // 2))
        , y (String.fromInt ((gridSize.height * cellSize) // 2))
        , textAnchor "middle"
        , fill "red"
        , fontWeight "bold"
        , fontSize "50"
        ]
        [ Svg.text "GAME OVER" ]
    ]
        |> List.filter (\_ -> gameOver)
