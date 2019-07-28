module UpdateTests exposing (all)

import Expect
import Keyboard exposing (..)
import Model exposing (Direction(..), initialModel)
import RandomPosition exposing (randomPosition)
import SnakeDirection exposing (updateSnakeDirection)
import Test exposing (..)
import Time
import Update exposing (Msg(..), update)


all : Test
all =
    describe "Update"
        [ describe "on Tick"
            [ describe "when game is over and space is pressed"
                [ test "the game should restart" <|
                    \_ ->
                        { initialModel | gameOver = True, key = Just Spacebar }
                            |> update (Tick time)
                            |> Tuple.first
                            |> Expect.equal initialModel
                ]
            ]
        ]


time : Time.Posix
time =
    Time.millisToPosix 0
