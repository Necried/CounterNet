module Static.Init where
import Static.Types
import CounterNet.Static.Init


init = CounterNet.Static.Init.init
-- reference to the initial Net
initNet :: NetModel
initNet = CounterNet
