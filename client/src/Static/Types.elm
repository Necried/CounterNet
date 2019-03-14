module Static.Types exposing(..)
import CounterNet.Static.Types


type alias TopLevelData = ()
-- a type identifying all of the nets in the server
type NetModel  =
      CounterNet CounterNet.Static.Types.NetState
-- a union type of all the nets and their incoming transitions
type NetIncomingMessage  =
      CounterNetInMsg CounterNet.Static.Types.IncomingMessage
-- a union type of all the nets and their outgoing transitions
type NetTransition  =
      CounterNetTrans CounterNet.Static.Types.Transition
