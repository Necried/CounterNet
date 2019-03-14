module CounterNet.Static.Wrappers.MainMenu exposing(..)
import CounterNet.Static.Types.MainMenu exposing(..)
import CounterNet.Static.ExtraTypes exposing(..)
import CounterNet.Static.Types exposing(..)

import Dict exposing (Dict)

unwrap : Msg -> Transition
unwrap msg =
    case msg of
        CounterNet.Static.Types.MainMenu.GoToCounterPlace  -> External TGoToCounterPlace 

