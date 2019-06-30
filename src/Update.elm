module Update exposing (Msg(..), movePlayer, update, updatePosition)

import Keyboard
import Keyboard.Arrows exposing (Direction(..))
import Model exposing (Model, Player, Position)
import Time


type Msg
    = Tick Time.Posix
    | KeyMsg Keyboard.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            ( { model | player = movePlayer model.player }, Cmd.none )

        KeyMsg keyMsg ->
            let
                newPressedKeys =
                    Keyboard.update keyMsg model.pressedKeys
            in
            ( { model
                | pressedKeys = newPressedKeys
                , player = updatePlayerDirection newPressedKeys model.player
              }
            , Cmd.none
            )


updatePlayerDirection : List Keyboard.Key -> Player -> Player
updatePlayerDirection pressedKeys player =
    case getDirection pressedKeys of
        Just direction ->
            { player | direction = direction }

        Nothing ->
            player


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


movePlayer : Player -> Player
movePlayer player =
    { player | position = updatePosition player.position player.direction }


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
