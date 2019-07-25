module Update exposing (Msg(..), update)

import GameMode exposing (updateGameMode)
import Keyboard exposing (..)
import Keyboard.Arrows exposing (arrowKey)
import Model exposing (Direction(..), Mode, Model, Position, Snake, initialModel)
import RandomPosition exposing (randomPosition)
import Size exposing (gridSize)
import SnakeDirection exposing (updateSnakeDirection)
import Time


type Msg
    = Tick Time.Posix
    | KeyDown RawKey
    | NewFood Position


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            runLoop model

        KeyDown key ->
            ( { model
                | key = anyKeyOriginal key
                , mode = updateGameMode (anyKeyOriginal key)
              }
            , Cmd.none
            )

        NewFood food ->
            ( { model | food = food }, Cmd.none )


runLoop : Model -> ( Model, Cmd Msg )
runLoop model =
    if model.gameOver then
        runGameOverLoop model

    else
        runNormalGameLoop model


runGameOverLoop : Model -> ( Model, Cmd Msg )
runGameOverLoop model =
    if shouldRestart model.key then
        ( initialModel, randomPosition NewFood )

    else
        ( model, Cmd.none )


runNormalGameLoop : Model -> ( Model, Cmd Msg )
runNormalGameLoop model =
    let
        snake =
            updateSnakeDirection model.key model.snake

        newHead =
            updateHead snake

        snakeAteFood =
            newHead == model.food

        newSnake =
            moveSnake newHead snakeAteFood snake
    in
    ( { model
        | snake = newSnake
        , gameOver = checkIfHitSelf newSnake
      }
    , repositionFood snakeAteFood
    )


moveSnake : Position -> Bool -> Snake -> Snake
moveSnake newHead snakeAteFood snake =
    { snake
        | head = newHead
        , body = updateBody snakeAteFood snake
    }


updateHead : Snake -> Position
updateHead { head, direction } =
    case direction of
        Up ->
            { head | y = modBy gridSize.height (head.y - 1) }

        Right ->
            { head | x = modBy gridSize.width (head.x + 1) }

        Down ->
            { head | y = modBy gridSize.height (head.y + 1) }

        Left ->
            { head | x = modBy gridSize.width (head.x - 1) }


updateBody : Bool -> Snake -> List Position
updateBody snakeAteFood { head, body } =
    if snakeAteFood then
        head :: body

    else
        head :: removeLast body


removeLast : List a -> List a
removeLast list =
    List.take (List.length list - 1) list


repositionFood : Bool -> Cmd Msg
repositionFood snakeAteFood =
    if snakeAteFood then
        randomPosition NewFood

    else
        Cmd.none


checkIfHitSelf : Snake -> Bool
checkIfHitSelf snake =
    List.member snake.head snake.body


shouldRestart : Maybe Key -> Bool
shouldRestart key =
    key == Just Spacebar
