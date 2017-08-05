module Helpers.Countries exposing (..)

import RemoteData exposing (RemoteData(..))
import Types.Msg exposing (Msg(..))
import Types.Country exposing (Countries)
import Json.Decode as Decode
import Helpers.Http exposing (..)
import Helpers.Api as Api


fetchCountries : Cmd Msg
fetchCountries =
    let
        url =
            Api.baseUrl "countries"
    in
        getWithHeaders url [ ( "Accept", "application/json" ) ] decodeCountries
            |> RemoteData.sendRequest
            |> Cmd.map CountriesResponse


decodeCountries : Decode.Decoder Countries
decodeCountries =
    Decode.at [ "countries" ] <|
        Decode.list Decode.string
