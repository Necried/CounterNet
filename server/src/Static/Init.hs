module Static.Init where
import Static.Types
import qualified Data.TMap as TM
import Data.Maybe (fromJust)
import CounterNet.Static.Init


init = CounterNet.Static.Init.init
teardown = CounterNet.Static.Init.teardown . fromJust . TM.lookup
-- reference to the initial Net
initNet :: NetModel
initNet = CounterNet
