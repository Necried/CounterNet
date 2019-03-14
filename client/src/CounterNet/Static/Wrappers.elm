module CounterNet.Static.Wrappers exposing(..)
import CounterNet.Static.ExtraTypes exposing(..)
import CounterNet.Static.Types exposing(..)

import Dict exposing (Dict)
x = 0
unwrapGoToCounterPlace : GoToCounterPlace -> OutgoingTransition
unwrapGoToCounterPlace GoToCounterPlace  = TGoToCounterPlace 


unwrapGoToMainMenu : GoToMainMenu -> OutgoingTransition
unwrapGoToMainMenu GoToMainMenu  = TGoToMainMenu 


unwrapIncrementCounter : IncrementCounter -> OutgoingTransition
unwrapIncrementCounter IncrementCounter  = TIncrementCounter 


unwrapDecrementCounter : DecrementCounter -> OutgoingTransition
unwrapDecrementCounter DecrementCounter  = TDecrementCounter 




