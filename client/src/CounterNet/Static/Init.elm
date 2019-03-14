module CounterNet.Static.Init exposing(..)
import CounterNet.Init as Init
import CounterNet.Static.Types exposing (NetState(..))
import CounterNet.Update as Update
import CounterNet.Static.Wrappers
import CounterNet.Static.ExtraTypes exposing(..)

init : NetState
init = SMainMenu Init.init
