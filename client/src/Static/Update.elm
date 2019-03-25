module Static.Update exposing(..)
import CounterNet.Static.Update as CounterNet

import Static.Types exposing(..)
import Maybe

update : TopLevelData -> NetIncomingMessage -> NetModel -> (NetModel, Cmd NetTransition)
update tld netInMsg state =
    case (netInMsg,state) of
            (CounterNetInMsg msg, CounterNet m) ->
                let
                    (newCounterNetState, mcmd) = CounterNet.update tld msg m
                    newClientState = CounterNet newCounterNetState
                in (newClientState, Cmd.map CounterNetTrans mcmd)



outgoingToIncoming : NetTransition -> Maybe NetIncomingMessage
outgoingToIncoming trans =
    case trans of
        CounterNetTrans tr -> Maybe.map CounterNetInMsg <| CounterNet.outgoingToIncoming tr


