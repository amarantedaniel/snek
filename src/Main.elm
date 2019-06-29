module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Browser.Events exposing (onAnimationFrameDelta)
import Debug
import Html exposing (Html)
import Keyboard
import Keyboard.Arrows exposing (Direction(..))
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


type alias Player =
    { position : Position }



---- MODEL ----


type alias Model =
    { count : Float
    , pressedKeys : List Keyboard.Key
    , player : Player
    }


init : ( Model, Cmd Msg )
init =
    ( { count = 0, pressedKeys = [], player = { position = { x = 0, y = 0 } } }, Cmd.none )



---- UPDATE ----


type Msg
    = Tick Time.Posix
    | KeyMsg Keyboard.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            ( { model | player = movePlayer model }, Cmd.none )

        KeyMsg keyMsg ->
            ( { model | pressedKeys = Keyboard.update keyMsg model.pressedKeys }, Cmd.none )


movePlayer : Model -> Player
movePlayer model =
    let
        direction =
            Keyboard.Arrows.arrowsDirection model.pressedKeys

        player =
            model.player
    in
    case direction of
        North ->
            { player | position = { x = player.position.x, y = player.position.y - 1 } }

        NorthEast ->
            { player | position = { x = player.position.x + 1, y = player.position.y - 1 } }

        East ->
            { player | position = { x = player.position.x + 1, y = player.position.y } }

        SouthEast ->
            { player | position = { x = player.position.x + 1, y = player.position.y + 1 } }

        South ->
            { player | position = { x = player.position.x, y = player.position.y + 1 } }

        SouthWest ->
            { player | position = { x = player.position.x - 1, y = player.position.y + 1 } }

        West ->
            { player | position = { x = player.position.x - 1, y = player.position.y } }

        NorthWest ->
            { player | position = { x = player.position.x - 1, y = player.position.y - 1 } }

        NoDirection ->
            player



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
        , renderCircle "red" model.player.position
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
    Sub.batch <| [ Sub.map KeyMsg Keyboard.subscriptions, Time.every tickFrequency Tick ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        }
