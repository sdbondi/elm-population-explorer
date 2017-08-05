module Views.Index exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Views.Countries exposing (renderCountries)
import Types.Msg exposing (Msg)
import Types.Model exposing (Model)


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
