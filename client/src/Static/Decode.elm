module Static.Decode exposing(..)
import Static.Types exposing(..)
import Utils.Utils exposing(..)
import CounterNet.Static.Decode


decodeIncomingMessage : String -> NetModel -> Result String NetIncomingMessage
decodeIncomingMessage txt clientNet =
    case clientNet of
        CounterNet _ -> rMap CounterNetInMsg <| Tuple.first <| CounterNet.Static.Decode.decodeIncomingMessage (Err "",String.split "\u{0000}" txt)
