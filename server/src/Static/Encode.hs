module Static.Encode where
import CounterNet.Static.Encode as CounterNet

import Static.ServerTypes
import Data.Text as T
import Static.Types

encodeOutgoingMessage :: NetOutgoingMessage -> T.Text
encodeOutgoingMessage netTrans =
    case netTrans of
        CounterNetOMsg msg -> CounterNet.encodeClientMessage msg

