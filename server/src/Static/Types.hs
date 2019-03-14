module Static.Types where
import CounterNet.Static.Types


-- a type identifying all of the nets in the server
data NetModel  =
      CounterNet
    deriving(Show,Ord,Eq)
-- a union type of all the nets and their transitions
data NetTransition  =
      CounterNetTrans CounterNet.Static.Types.Transition
    deriving(Show,Ord,Eq)
-- a union type of all the nets and their transitions
data NetOutgoingMessage  =
      CounterNetOMsg CounterNet.Static.Types.ClientMessage
    deriving(Show,Ord,Eq)
