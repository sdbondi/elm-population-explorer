module Types.Msg exposing (..)

import RemoteData exposing (WebData)
import Types.Country exposing (Countries, Country)


type Msg
    = FetchCountries
    | CountriesResponse (WebData Countries)
    | SelectCountry Country
