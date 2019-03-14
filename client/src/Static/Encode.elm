module Static.Encode exposing(..)
import CounterNet.Static.Encode as CounterNet

import Static.Types exposing(NetTransition(..))

encodeTransition : NetTransition -> Maybe String
encodeTransition netTrans =
    case netTrans of
        CounterNetTrans msg -> CounterNet.encodeTransition msg

