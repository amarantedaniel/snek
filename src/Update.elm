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
            ( { model | player = movePlayer model }, Cmd.none )

        KeyMsg keyMsg ->
            ( { model | pressedKeys = Keyboard.update keyMsg model.pressedKeys }, Cmd.none )


movePlayer : Model -> Player
movePlayer { player, pressedKeys } =
    let
        direction =
            Keyboard.Arrows.arrowsDirection pressedKeys
    in
    { player | position = updatePosition player.position direction }


updatePosition : Position -> Direction -> Position
updatePosition position direction =
    case direction of
        North ->
            { position | y = position.y - 1 }

        NorthEast ->
            { position | x = position.x + 1, y = position.y - 1 }

        East ->
            { position | x = position.x + 1 }

        SouthEast ->
            { position | x = position.x + 1, y = position.y + 1 }

        South ->
            { position | y = position.y + 1 }

        SouthWest ->
            { position | x = position.x - 1, y = position.y + 1 }

        West ->
            { position | x = position.x - 1 }

        NorthWest ->
            { position | x = position.x - 1, y = position.y - 1 }

        NoDirection ->
            position
