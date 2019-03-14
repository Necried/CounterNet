module CounterNet.Static.Subs exposing(..)
import CounterNet.Static.Types exposing(..)
import CounterNet.View.MainMenu as MainMenu
import CounterNet.View.CounterPlace as CounterPlace

import CounterNet.Static.Wrappers.MainMenu
import CounterNet.Static.Wrappers.CounterPlace


subs : NetState -> Sub Transition
subs model =
    case model of
        SMainMenu m -> Sub.map CounterNet.Static.Wrappers.MainMenu.unwrap <| MainMenu.subs m
        SCounterPlace m -> Sub.map CounterNet.Static.Wrappers.CounterPlace.unwrap <| CounterPlace.subs m

