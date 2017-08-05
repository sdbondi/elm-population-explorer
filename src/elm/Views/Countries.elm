module Views.Countries exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import RemoteData exposing (RemoteData(..), WebData)
import Types.Country exposing (Country, Countries)
import Types.Msg exposing (Msg(..))
import Components.Grid exposing (gw, gcol)


joinClass =
    String.join " "


renderCountry : Maybe Country -> Country -> Html Msg
renderCountry selected country =
    let
        selectedClass =
            case selected of
                Just c ->
                    if c == country then
                        "is-selected"
                    else
                        ""

                Nothing ->
                    ""
    in
        gcol ( 1, 6 )
            [ div [ class (joinClass [ "country", selectedClass ]), onClick (SelectCountry country) ] [ text country ]
            ]


renderCountries : WebData Countries -> Maybe Country -> Html Msg
renderCountries resp selected =
    div [ class "countries" ] <|
        case resp of
            Success countries ->
                [ gw (List.map (renderCountry selected) countries) ]

            Failure _ ->
                [ text "An error!" ]

            NotAsked ->
                [ text "Please wait..." ]

            Loading ->
                [ div [ class "loader" ] [ text "Loading..." ] ]
