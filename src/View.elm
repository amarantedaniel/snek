module View exposing (renderCircle, view)

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
        , div []
            [ Html.text ("(" ++ String.fromInt model.food.x ++ ", " ++ String.fromInt model.food.x ++ ")") ]
        ]


renderBackground : List (Html Msg)
renderBackground =
    [ rect
        [ width (String.fromInt (gridSize.width * cellSize.height))
        , height (String.fromInt (gridSize.height * cellSize.height))
        ]
        []
    ]


renderSnake : Snake -> List (Html Msg)
renderSnake snake =
    renderCircle "red" snake.head :: List.map (renderCircle "red") snake.body


renderFood : Position -> List (Html Msg)
renderFood food =
    [ renderCircle "blue" food ]


renderCircle : String -> Position -> Html Msg
renderCircle color pos =
    circle
        [ cx (String.fromInt ((pos.x * cellSize.width) + (cellSize.width // 2)))
        , cy (String.fromInt ((pos.y * cellSize.height) + (cellSize.height // 2)))
        , r (String.fromInt (cellSize.height // 2))
        , fill color
        ]
        []
