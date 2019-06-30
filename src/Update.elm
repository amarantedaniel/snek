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
    { snake
        | head = updateHead snake
        , body = updateBody snake
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


updateBody : Snake -> List Position
updateBody { head, body } =
    head :: removeLast body


removeLast : List a -> List a
removeLast list =
    List.take (List.length list - 1) list
