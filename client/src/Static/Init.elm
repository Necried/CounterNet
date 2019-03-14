module Static.Init exposing (..)
import Static.Types exposing(..)
import CounterNet.Static.Init

init : (NetModel, Cmd NetTransition)
init = (CounterNet CounterNet.Static.Init.init, Cmd.none)
