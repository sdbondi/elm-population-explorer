module Update exposing (update)

import Types.Model exposing (Model)
import Helpers.Countries exposing (fetchCountries)
import Types.Msg exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchCountries ->
            ( model, fetchCountries )

        CountriesResponse response ->
            ( { model | countries = response }, Cmd.none )

        SelectCountry country ->
            ( { model | selectedCountry = Just country }, Cmd.none )
