{-# LANGUAGE OverloadedStrings #-}
module CounterNet.Static.Decode where
import CounterNet.Static.Types

import Utils.Utils
import Static.Result (Result(..))
import qualified Data.Text as T
import qualified Static.Result as Result
decodeTransition  ::  (Result T.Text a, [T.Text]) -> (Result T.Text Transition, [T.Text])
decodeTransition (_,transitionTxts) = 
    case transitionTxts of
        ("TGoToCounterPlace" : rest) ->
            (Err "",rest) |> 
                    (\(r3,l4) -> (Ok <| TGoToCounterPlace ,l4))
        ("TGoToMainMenu" : rest) ->
            (Err "",rest) |> 
                    (\(r3,l4) -> (Ok <| TGoToMainMenu ,l4))
        ("TIncrementCounter" : rest) ->
            (Err "",rest) |> 
                    (\(r3,l4) -> (Ok <| TIncrementCounter ,l4))
        ("TDecrementCounter" : rest) ->
            (Err "",rest) |> 
                    (\(r3,l4) -> (Ok <| TDecrementCounter ,l4))

        _ -> (Err <| tConcat ["Incorrect input, could not decode value of type Transition from string \"", tConcat transitionTxts, "\""],[])

-- extra type decoders

