module CounterNet.View.MainMenu exposing(..)
import CounterNet.Static.Types.MainMenu exposing(Msg(..))
import CounterNet.Static.Types exposing(MainMenu(..))
import CounterNet.Static.Helpers.MainMenu exposing(..)
import CounterNet.Static.ExtraTypes exposing(..)

import Html exposing(..)
import Html.Events exposing (..)

view : MainMenu -> Html Msg
view mainMenu =
    div []
    [   h1 [] [ text "A Simple Multiplayer Counting App"]
    ,   button [ onClick GoToCounterPlace ] [ text "Let's Start!"]
    ]

title : MainMenu -> String
title mainMenu = "Simple Counter App"

subs : MainMenu -> Sub Msg
subs _ = Sub.none