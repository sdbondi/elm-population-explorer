module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import RemoteData exposing (RemoteData(..), WebData)
import Types.Country exposing (Countries, Country)
import Json.Decode as Decode
import Helpers.Http as Http


-- APP


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    { countries : WebData Countries, selectedCountry : Maybe Country }


init : ( Model, Cmd Msg )
init =
    ( Model NotAsked Nothing, getCountries )



-- UPDATE


type Msg
    = FetchCountries
    | CountriesResponse (WebData Countries)
    | SelectCountry Country


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchCountries ->
            ( model, getCountries )

        CountriesResponse response ->
            ( { model | countries = response }, Cmd.none )

        SelectCountry country ->
            ( { model | selectedCountry = Just country }, Cmd.none )



-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div []
            [ h1 [] [ text "Selected Country" ]
            , div []
                [ case model.selectedCountry of
                    Just selectedCountry ->
                        text selectedCountry

                    Nothing ->
                        text "Not selected"
                ]
            ]
        , h2 [] [ text "Countries" ]
        , div [] (renderCountries model.countries)
        ]


renderCountry : Country -> Html Msg
renderCountry country =
    div [ class "country" ] [ a [ href "#", onClick (SelectCountry country) ] [ text country ] ]


renderCountries : WebData Countries -> List (Html Msg)
renderCountries resp =
    case resp of
        Success countries ->
            List.map renderCountry countries

        Failure _ ->
            [ text "An error!" ]

        NotAsked ->
            [ text "" ]

        Loading ->
            [ div [ class "loader" ] [ text "Loading..." ] ]


baseUrl : String -> String
baseUrl uri =
    "http://api.population.io/1.0/" ++ uri



-- Requests


getCountries : Cmd Msg
getCountries =
    let
        url =
            baseUrl "countries"
    in
        Http.getWithHeaders url [ ( "Accept", "application/json" ) ] decodeCountries
            |> RemoteData.sendRequest
            |> Cmd.map CountriesResponse


decodeCountries : Decode.Decoder Countries
decodeCountries =
    Decode.at [ "countries" ] <|
        Decode.list Decode.string
