module Update exposing (Msg(..), update)

import Keyboard exposing (..)
import Keyboard.Arrows exposing (arrowKey)
import Model exposing (Direction(..), Model, Position, Snake)
import Random
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
            if model.gameOver then
                ( model, Cmd.none )

            else
                runLoop model

        KeyDown key ->
            ( { model | key = arrowKey key }, Cmd.none )

        NewFood food ->
            ( { model | food = food }, Cmd.none )


runLoop : Model -> ( Model, Cmd Msg )
runLoop model =
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
    let
        randomWidth =
            Random.int 0 (gridSize.width - 1)

        randomHeight =
            Random.int 0 (gridSize.height - 1)
    in
    if snakeAteFood then
        Random.generate NewFood <|
            Random.map2 Position randomWidth randomHeight

    else
        Cmd.none


checkIfHitSelf : Snake -> Bool
checkIfHitSelf snake =
    List.member snake.head snake.body
