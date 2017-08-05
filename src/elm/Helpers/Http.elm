module Helpers.Http exposing (..)

import Http exposing (request, emptyBody, expectJson, Request)
import Json.Decode as Decode


type alias Header =
    ( String, String )


type alias Headers =
    List Header


baseUrl : String -> String
baseUrl uri =
    "http://api.population.io/1.0/" ++ uri


convertHeader : Header -> Http.Header
convertHeader header =
    let
        ( name, value ) =
            header
    in
        Http.header name value


getWithHeaders : String -> Headers -> Decode.Decoder a -> Request a
getWithHeaders url headers decoder =
    request
        { method = "GET"
        , headers = List.map convertHeader headers
        , url = url
        , expect = expectJson decoder
        , body = emptyBody
        , timeout = Nothing
        , withCredentials = False
        }
