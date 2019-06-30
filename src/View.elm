module View exposing (renderCircle, view)

import Html exposing (Html)
import Model exposing (Model, Position, Size)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Update exposing (Msg(..))


gridSize =
    Size 40 20


cellSize =
    Size 20 20


view : Model -> Html Msg
view model =
    svg
        [ width "100%"
        , height "auto"
        , viewBox ("0 0 " ++ String.fromInt (gridSize.width * cellSize.width) ++ " " ++ String.fromInt (gridSize.height * cellSize.height))
        ]
        [ rect
            [ width (String.fromInt (gridSize.width * cellSize.height))
            , height (String.fromInt (gridSize.height * cellSize.height))
            ]
            []
        , renderCircle "red" model.snake.position
        ]


renderCircle : String -> Position -> Html Msg
renderCircle color pos =
    circle
        [ cx (String.fromInt ((pos.x * cellSize.width) + (cellSize.width // 2)))
        , cy (String.fromInt ((pos.y * cellSize.height) + (cellSize.height // 2)))
        , r (String.fromInt (cellSize.height // 2))
        , fill color
        ]
        []
