module Views.Countries exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import RemoteData exposing (RemoteData(..), WebData)
import Types.Country exposing (Country, Countries)
import Types.Msg exposing (Msg(..))


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
