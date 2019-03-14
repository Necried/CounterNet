module CounterNet.Static.View exposing(..)
import Html exposing(Html)
import Static.Types exposing (NetModel)
import CounterNet.Static.Types exposing(..)
import CounterNet.View.MainMenu
import CounterNet.View.CounterPlace

import CounterNet.Static.Wrappers.MainMenu
import CounterNet.Static.Wrappers.CounterPlace


view : NetState -> Html Transition
view ns =
    case ns of
        SMainMenu m -> Html.map CounterNet.Static.Wrappers.MainMenu.unwrap <| CounterNet.View.MainMenu.view m
        SCounterPlace m -> Html.map CounterNet.Static.Wrappers.CounterPlace.unwrap <| CounterNet.View.CounterPlace.view m

title : NetState -> String
title ns =
    case ns of
        SMainMenu m -> CounterNet.View.MainMenu.title m
        SCounterPlace m -> CounterNet.View.CounterPlace.title m

