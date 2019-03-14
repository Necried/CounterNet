module Static.Subs exposing(..)
import Static.Types exposing(..)
import CounterNet.Static.Subs as CounterNet

subscriptions : NetModel -> Sub NetTransition
subscriptions model =
    case model of
        CounterNet m -> Sub.map CounterNetTrans <| CounterNet.subs m

