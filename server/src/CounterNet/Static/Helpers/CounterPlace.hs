module CounterNet.Static.Helpers.CounterPlace where


import CounterNet.Static.Types
import CounterNet.Static.Types

import Static.List
getServerCounterData :: CounterPlace -> Int
getServerCounterData (CounterPlace serverCounterData)  = serverCounterData



updateServerCounterData :: Int -> CounterPlace -> CounterPlace
updateServerCounterData newserverCounterData (CounterPlace serverCounterData)  = (CounterPlace newserverCounterData) 


alterServerCounterData :: (Int -> Int) -> CounterPlace -> CounterPlace
alterServerCounterData f (CounterPlace serverCounterData)  = 
    let
        newserverCounterData = f serverCounterData
    in
        (CounterPlace newserverCounterData) 



