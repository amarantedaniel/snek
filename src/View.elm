module View exposing (view)

import Html exposing (..)
import Model exposing (Model, Position, Size, Snake)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Update exposing (Msg(..))


gridSize =
    Size 40 20


cellSize =
    Size 20 20


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ Html.text "snek" ]
        , svg
            [ width "50%"
            , height "auto"
            , viewBox ("0 0 " ++ String.fromInt (gridSize.width * cellSize.width) ++ " " ++ String.fromInt (gridSize.height * cellSize.height))
            ]
            (renderBackground
                ++ renderSnake model.snake
                ++ renderFood model.food
            )
        ]


renderBackground : List (Html Msg)
renderBackground =
    [ rect
        [ width (String.fromInt (gridSize.width * cellSize.height))
        , height (String.fromInt (gridSize.height * cellSize.height))
        , Svg.Attributes.style "fill:#8cbf00"
        ]
        []
    ]


renderSnake : Snake -> List (Html Msg)
renderSnake snake =
    renderSnakePart snake.head :: List.map renderSnakePart snake.body


renderSnakePart : Position -> Html Msg
renderSnakePart position =
    rect
        [ width (String.fromInt cellSize.width)
        , height (String.fromInt cellSize.height)
        , x (String.fromInt (position.x * cellSize.width))
        , y (String.fromInt (position.y * cellSize.height))
        , Svg.Attributes.style "fill:black;stroke:gray"
        ]
        []


renderFood : Position -> List (Html Msg)
renderFood food =
    [ circle
        [ cx (String.fromInt ((food.x * cellSize.width) + (cellSize.width // 2)))
        , cy (String.fromInt ((food.y * cellSize.height) + (cellSize.height // 2)))
        , r (String.fromInt (cellSize.height // 3))
        , fill "black"
        , stroke "gray"
        ]
        []
    ]
