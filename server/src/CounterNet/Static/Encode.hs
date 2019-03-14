{-# LANGUAGE OverloadedStrings #-}
module CounterNet.Static.Encode where
import CounterNet.Static.Types

import Utils.Utils
import qualified Data.Text as T
import Static.Types
import Data.Map.Strict as Dict
import qualified Static.Result as Result
encodeClientMessage :: ClientMessage -> T.Text
encodeClientMessage clientmessage = 
    case clientmessage of
        MWentToCounterPlace clientCounterData -> 
            let
                clientCounterDataTxt = encodeInt (-1000000) (1000000) clientCounterData
            in
                tConcat ["MWentToCounterPlace\0", clientCounterDataTxt]
        MWentToMainMenu -> 
                tConcat ["MWentToMainMenu"]
        MCounterIncremented clientCounterData -> 
            let
                clientCounterDataTxt = encodeInt (-1000000) (1000000) clientCounterData
            in
                tConcat ["MCounterIncremented\0", clientCounterDataTxt]
        MCounterDecremented clientCounterData -> 
            let
                clientCounterDataTxt = encodeInt (-1000000) (1000000) clientCounterData
            in
                tConcat ["MCounterDecremented\0", clientCounterDataTxt]


-- extra type encoders

