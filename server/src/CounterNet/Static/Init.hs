module CounterNet.Static.Init where
import CounterNet.Static.Types (Player)
import CounterNet.Init as Init
import CounterNet.Update as Update
import CounterNet.Static.Wrappers
import CounterNet.Static.Plugins (initPlugins,teardownPlugins)
import Static.ServerTypes
import qualified Data.IntMap as IM'
import qualified Data.TMap as TM

init :: IO (NetState Player)
init = do
    ip <- initPlugins
    return $ NetState
        {
          playerStates = IM'.empty
        , placeStates = TM.insert initMainMenu $ TM.insert initCounterPlace $ TM.empty
        , pluginStates = ip
        }
teardown :: NetState Player -> IO ()
teardown ns = do
    teardownPlugins (pluginStates ns)
