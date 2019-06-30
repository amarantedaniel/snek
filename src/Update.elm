module Update exposing (Msg(..), moveSnake, update, updatePosition)

import Keyboard
import Keyboard.Arrows exposing (Direction(..))
import Model exposing (Model, Position, Snake)
import Time


type Msg
    = Tick Time.Posix
    | KeyMsg Keyboard.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            ( { model | snake = moveSnake model.snake }, Cmd.none )

        KeyMsg keyMsg ->
            let
                newPressedKeys =
                    Keyboard.update keyMsg model.pressedKeys
            in
            ( { model
                | pressedKeys = newPressedKeys
                , snake = updateSnakeDirection newPressedKeys model.snake
              }
            , Cmd.none
            )


updateSnakeDirection : List Keyboard.Key -> Snake -> Snake
updateSnakeDirection pressedKeys snake =
    case getDirection pressedKeys of
        Just direction ->
            { snake | direction = direction }

        Nothing ->
            snake


getDirection : List Keyboard.Key -> Maybe Direction
getDirection pressedKeys =
    let
        direction =
            Keyboard.Arrows.arrowsDirection pressedKeys
    in
    if List.member direction [ North, East, South, West ] then
        Just direction

    else
        Nothing


moveSnake : Snake -> Snake
moveSnake snake =
    { snake | position = updatePosition snake.position snake.direction }


updatePosition : Position -> Direction -> Position
updatePosition position direction =
    case direction of
        North ->
            { position | y = position.y - 1 }

        East ->
            { position | x = position.x + 1 }

        South ->
            { position | y = position.y + 1 }

        West ->
            { position | x = position.x - 1 }

        _ ->
            position
