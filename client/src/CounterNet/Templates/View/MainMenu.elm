module CounterNet.View.MainMenu exposing(..)
import CounterNet.Static.Types.MainMenu exposing(Msg(..))
import CounterNet.Static.Types exposing(MainMenu(..))
import CounterNet.Static.Helpers.MainMenu exposing(..)
import CounterNet.Static.ExtraTypes exposing(..)

import Html exposing(Html)
import Debug exposing(todo)

subs : MainMenu -> Sub Msg
subs mainMenu =
    Sub.none

view : MainMenu -> Html Msg
view mainMenu =
    todo "Please fill out the view function for the CounterNet net for the MainMenu place."

title : MainMenu -> String
title mainMenu =
    todo "Please fill out the title function for the CounterNet net for the MainMenu place."
