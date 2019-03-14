module CounterNet.Static.Helpers.CounterPlace exposing (..)
import Dict exposing (Dict)

import CounterNet.Static.ExtraTypes exposing(..)
import CounterNet.Static.Types exposing(..)
import CounterNet.Static.Types


getClientCounterData : CounterPlace -> Int
getClientCounterData (CounterPlace clientCounterData)  = clientCounterData



updateClientCounterData : Int -> CounterPlace -> CounterPlace
updateClientCounterData newclientCounterData (CounterPlace clientCounterData)  = (CounterPlace newclientCounterData) 


alterClientCounterData : (Int -> Int) -> CounterPlace -> CounterPlace
alterClientCounterData f (CounterPlace clientCounterData)  = 
    let
        newclientCounterData = f clientCounterData
    in
        (CounterPlace newclientCounterData) 



