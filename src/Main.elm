module Main exposing (main)

import Browser
import Keyboard
import Model exposing (Model, initialModel)
import RandomPosition exposing (randomPosition)
import Time
import Update exposing (Msg(..), update)
import View exposing (view)


tickFrequency =
    100


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( initialModel, randomPosition NewFood )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch <| [ Keyboard.downs KeyDown, Time.every tickFrequency Tick ]
