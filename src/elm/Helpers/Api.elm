module Helpers.Api exposing (..)


baseUrl : String -> String
baseUrl uri =
    "http://api.population.io/1.0/" ++ uri
