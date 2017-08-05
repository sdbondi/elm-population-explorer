module Types.Model exposing (Model)

import RemoteData exposing (RemoteData(..), WebData)
import Types.Country exposing (Countries, Country)


type alias Model =
    { countries : WebData Countries, selectedCountry : Maybe Country }
