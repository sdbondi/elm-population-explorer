module Main exposing (..)

import Html
import RemoteData exposing (RemoteData(..))
import Types.Model exposing (Model)
import Types.Msg exposing (Msg)
import Types.Model exposing (Model)
import Views.Index
import Update exposing (..)
import Helpers.Countries exposing (fetchCountries)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = Views.Index.view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


init : ( Model, Cmd Msg )
init =
    ( Model NotAsked Nothing, fetchCountries )
