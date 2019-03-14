module Static.Update exposing(..)
import CounterNet.Static.Update as CounterNet

import Static.Types exposing(..)
import Maybe

update : TopLevelData -> NetIncomingMessage -> NetModel -> (NetModel, Maybe (Cmd NetTransition))
update tld netInMsg state =
    case (netInMsg,state) of
            (CounterNetInMsg msg, CounterNet m) ->
                let
                    (newCounterNetState, mcmd) = CounterNet.update tld msg m
                    newClientState = CounterNet newCounterNetState
                in (newClientState, Maybe.map (Cmd.map CounterNetTrans) mcmd)



outgoingToIncoming : NetTransition -> Maybe NetIncomingMessage
outgoingToIncoming trans =
    case trans of
        CounterNetTrans tr -> Maybe.map CounterNetInMsg <| CounterNet.outgoingToIncoming tr


