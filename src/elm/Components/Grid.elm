module Components.Grid exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias GridWrapSettings =
    { baseClass : String
    }


type alias HtmlList a =
    List (Html a)


gridWrap : GridWrapSettings -> HtmlList a -> Html a
gridWrap settings children =
    div [ class settings.baseClass ] children


gw =
    gridWrap { baseClass = "gw" }


gwNoGuts =
    gridWrap { baseClass = "gw--no-guts" }


type alias GridColSettings =
    { width : Int
    , of_ : Int
    }


gridCol : GridColSettings -> HtmlList a -> Html a
gridCol settings children =
    let
        className =
            "g g-" ++ toString settings.width ++ "-of-" ++ toString settings.of_
    in
        div [ class className ] children


gcol : ( Int, Int ) -> HtmlList a -> Html a
gcol widths children =
    let
        ( w, of_ ) =
            widths
    in
        gridCol { width = w, of_ = of_ } children
