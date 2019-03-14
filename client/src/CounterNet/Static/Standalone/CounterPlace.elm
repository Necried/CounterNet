module CounterNet.Static.Standalone.CounterPlace exposing(..)
import Html exposing(..)
import Browser exposing(..)
import CounterNet.View.CounterPlace as View
import CounterNet.Static.Types exposing (..)
import CounterNet.Static.ExtraTypes exposing (..)
import CounterNet.Static.Types.CounterPlace exposing (Msg)
import Dict exposing (Dict)
import Json.Decode as D

main : Program () CounterPlace Msg
main = Browser.document { init = \_ -> (model, Cmd.none), view = \m -> { body = [View.view m], title = View.title m }, update = \_ m -> (m,Cmd.none), subscriptions = \_ -> Sub.none }

--Change the model here to preview your state
model : CounterPlace
model = CounterPlace (-1000000)
