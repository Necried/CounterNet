module CounterNet.Static.Update exposing(..)
import CounterNet.Static.Types exposing(..)
import CounterNet.Static.Wrappers exposing(..)
import CounterNet.Static.FromSuperPlace exposing (FromSuperPlace)
import CounterNet.Update exposing(..)
import Static.Types exposing(..)
import Dict

update : FromSuperPlace -> IncomingMessage -> NetState -> (NetState,Maybe (Cmd Transition))
update fsp trans state =
    case (trans,state) of
        ((MWentToCounterPlace clientCounterData) , SMainMenu st) -> (SCounterPlace <| updateMainMenuWentToCounterPlaceCounterPlace fsp (WentToCounterPlace clientCounterData)  st, Nothing)

        (MWentToMainMenu , SCounterPlace st) -> (SMainMenu <| updateCounterPlaceWentToMainMenuMainMenu fsp WentToMainMenu  st, Nothing)

        ((MCounterIncremented clientCounterData) , SCounterPlace st) -> (SCounterPlace <| updateCounterPlaceCounterIncrementedCounterPlace fsp (CounterIncremented clientCounterData)  st, Nothing)

        ((MCounterDecremented clientCounterData) , SCounterPlace st) -> (SCounterPlace <| updateCounterPlaceCounterDecrementedCounterPlace fsp (CounterDecremented clientCounterData)  st, Nothing)


        _ -> (state, Nothing)
outgoingToIncoming : Transition -> Maybe IncomingMessage
outgoingToIncoming trans =
    case trans of

        _ -> Nothing
