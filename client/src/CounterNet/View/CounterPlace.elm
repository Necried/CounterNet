module CounterNet.View.CounterPlace exposing(..)
import CounterNet.Static.Types.CounterPlace exposing(Msg(..))
import CounterNet.Static.Types exposing(CounterPlace(..))
import CounterNet.Static.Helpers.CounterPlace exposing(..)
import CounterNet.Static.ExtraTypes exposing(..)

import Html exposing(..)
import Html.Events exposing (..)

view : CounterPlace -> Html Msg
view (CounterPlace counter) =
  div [] [
    div []
        [ button [ onClick DecrementCounter ] [ text "-" ]
        , div [] [ text (String.fromInt counter) ]
        , button [ onClick IncrementCounter ] [ text "+" ]
        ]
  , div []
        [ button [ onClick GoToMainMenu ] [ text "Exit" ]
        ]
  ]

title : CounterPlace -> String
title counterPlace =
    "COUNTING IS EXCITING"

subs : CounterPlace -> Sub Msg
subs _ = Sub.none