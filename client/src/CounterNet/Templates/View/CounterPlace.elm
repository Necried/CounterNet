module CounterNet.View.CounterPlace exposing(..)
import CounterNet.Static.Types.CounterPlace exposing(Msg(..))
import CounterNet.Static.Types exposing(CounterPlace(..))
import CounterNet.Static.Helpers.CounterPlace exposing(..)
import CounterNet.Static.ExtraTypes exposing(..)

import Html exposing(Html)
import Debug exposing(todo)

subs : CounterPlace -> Sub Msg
subs counterPlace =
    Sub.none

view : CounterPlace -> Html Msg
view counterPlace =
    todo "Please fill out the view function for the CounterNet net for the CounterPlace place."

title : CounterPlace -> String
title counterPlace =
    todo "Please fill out the title function for the CounterNet net for the CounterPlace place."
