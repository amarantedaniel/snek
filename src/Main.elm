module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Browser.Events exposing (onAnimationFrameDelta)
import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time



---- CONSTANTS ----


tickFrequency =
    100


gridSize =
    Size 40 20


cellSize =
    Size 20 20


type alias Size =
    { width : Int
    , height : Int
    }


type alias Position =
    { x : Int
    , y : Int
    }



---- MODEL ----


type alias Model =
    { count : Float }


init : ( Model, Cmd Msg )
init =
    ( { count = 0 }, Cmd.none )



---- UPDATE ----


type Msg
    = Tick Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            ( { model | count = model.count + 1 }, Cmd.none )



---- VIEW ----


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
        , renderCircle "red" { x = 0, y = 0 }
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



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every tickFrequency Tick



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        }
