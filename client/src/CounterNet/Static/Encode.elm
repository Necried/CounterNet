module CounterNet.Static.Encode exposing(..)
import CounterNet.Static.Types exposing(..)
import CounterNet.Static.ExtraTypes exposing(..)

import Utils.Utils exposing(..)
import Static.Types
encodeTransition : Transition -> Maybe String
encodeTransition trans =
    case trans of

        External ext -> Just <| encodeOutgoingTransition ext
encodeOutgoingTransition : OutgoingTransition -> String
encodeOutgoingTransition outgoingtransition = 
    case outgoingtransition of
        TGoToCounterPlace -> 
                tConcat ["TGoToCounterPlace"]
        TGoToMainMenu -> 
                tConcat ["TGoToMainMenu"]
        TIncrementCounter -> 
                tConcat ["TIncrementCounter"]
        TDecrementCounter -> 
                tConcat ["TDecrementCounter"]


--extra types encoders

