module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Browser.Events exposing (onAnimationFrameDelta)
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)



---- MODEL ----


type alias Model =
    { count : Float }


init : ( Model, Cmd Msg )
init =
    ( { count = 0 }, Cmd.none )



---- UPDATE ----


type Msg
    = Frame Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Frame _ ->
            ( { model | count = model.count + 1 }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    text ("Count: " ++ String.fromFloat model.count)



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions _ =
    onAnimationFrameDelta Frame



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        }
