module Update exposing (Msg(..), update)

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
            ( runLoop model, Cmd.none )

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


runLoop : Model -> Model
runLoop model =
    let
        newHead =
            updateHead model.snake

        snakeAteFood =
            newHead == model.food

        newSnake =
            moveSnake newHead snakeAteFood model.snake
    in
    { model | snake = newSnake }


moveSnake : Position -> Bool -> Snake -> Snake
moveSnake newHead snakeAteFood snake =
    { snake
        | head = newHead
        , body = updateBody snakeAteFood snake
    }


updateHead : Snake -> Position
updateHead { head, direction } =
    case direction of
        North ->
            { head | y = head.y - 1 }

        East ->
            { head | x = head.x + 1 }

        South ->
            { head | y = head.y + 1 }

        West ->
            { head | x = head.x - 1 }

        _ ->
            head


updateBody : Bool -> Snake -> List Position
updateBody snakeAteFood { head, body } =
    case snakeAteFood of
        True ->
            head :: body

        False ->
            head :: removeLast body


removeLast : List a -> List a
removeLast list =
    List.take (List.length list - 1) list
