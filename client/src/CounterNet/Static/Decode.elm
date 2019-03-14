module CounterNet.Static.Decode exposing(..)
import CounterNet.Static.Types exposing(..)
import CounterNet.Static.ExtraTypes exposing(..)

import Utils.Utils exposing(..)
decodeIncomingMessage  :  (Result String a, List String) -> (Result String IncomingMessage, List String)
decodeIncomingMessage (_,incomingmessageTxts) = 
    case incomingmessageTxts of
        ("MWentToCounterPlace" :: rest) ->
            (Err "",rest) |> 
                \(r3,l4) ->
                        (case l4 of
                            (clientCounterDataTxt :: ll4) -> (decodeInt (-1000000) (1000000) clientCounterDataTxt |> Result.andThen Ok,ll4)
                            [] -> (Err "Ran out of string to process while parsing IncomingMessage",[]))
                 |>
                        (\(r4,l5) -> (rMap MWentToCounterPlace r4,l5))
        ("MWentToMainMenu" :: rest) ->
            (Err "",rest) |> 
                    (\(r3,l4) -> (Ok <| MWentToMainMenu ,l4))
        ("MCounterIncremented" :: rest) ->
            (Err "",rest) |> 
                \(r3,l4) ->
                        (case l4 of
                            (clientCounterDataTxt :: ll4) -> (decodeInt (-1000000) (1000000) clientCounterDataTxt |> Result.andThen Ok,ll4)
                            [] -> (Err "Ran out of string to process while parsing IncomingMessage",[]))
                 |>
                        (\(r4,l5) -> (rMap MCounterIncremented r4,l5))
        ("MCounterDecremented" :: rest) ->
            (Err "",rest) |> 
                \(r3,l4) ->
                        (case l4 of
                            (clientCounterDataTxt :: ll4) -> (decodeInt (-1000000) (1000000) clientCounterDataTxt |> Result.andThen Ok,ll4)
                            [] -> (Err "Ran out of string to process while parsing IncomingMessage",[]))
                 |>
                        (\(r4,l5) -> (rMap MCounterDecremented r4,l5))

        _ -> (Err <| tConcat ["Incorrect input, could not decode value of type IncomingMessage from string \"", tConcat incomingmessageTxts, "\""],[])

--extra types decoders

