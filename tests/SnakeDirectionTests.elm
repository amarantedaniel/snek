module SnakeDirectionTests exposing (all)

import Expect
import Keyboard exposing (..)
import Model exposing (Direction(..), initialModel)
import SnakeDirection exposing (updateSnakeDirection)
import Test exposing (..)


all : Test
all =
    describe "SnakeDirection"
        [ describe "updateSnakeDirection"
            [ describe "when given a valid key"
                [ describe "when key represents a valid direction"
                    [ test "it should change the snake's direction" <|
                        \_ ->
                            let
                                snake =
                                    initialModel.snake

                                newSnake =
                                    updateSnakeDirection (Just ArrowUp) snake

                                expectedSnake =
                                    { snake | direction = Up }
                            in
                            Expect.equal newSnake expectedSnake
                    ]
                , describe "when key represents a direction opposite of current direction"
                    [ test "it should not change the snake's direction" <|
                        \_ ->
                            let
                                snake =
                                    initialModel.snake

                                newSnake =
                                    updateSnakeDirection (Just ArrowLeft) snake
                            in
                            Expect.equal newSnake snake
                    ]
                ]
            , describe "when givan an invalid key"
                [ test "it should not change the snake's direction" <|
                    \_ ->
                        let
                            snake =
                                initialModel.snake

                            newSnake =
                                updateSnakeDirection (Just (Character "b")) snake
                        in
                        Expect.equal newSnake snake
                ]
            ]
        ]
