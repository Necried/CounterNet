module CounterNet.Static.Standalone.MainMenu exposing(..)
import Html exposing(..)
import Browser exposing(..)
import CounterNet.View.MainMenu as View
import CounterNet.Static.Types exposing (..)
import CounterNet.Static.ExtraTypes exposing (..)
import CounterNet.Static.Types.MainMenu exposing (Msg)
import Dict exposing (Dict)
import Json.Decode as D

main : Program () MainMenu Msg
main = Browser.document { init = \_ -> (model, Cmd.none), view = \m -> { body = [View.view m], title = View.title m }, update = \_ m -> (m,Cmd.none), subscriptions = \_ -> Sub.none }

--Change the model here to preview your state
model : MainMenu
model = MainMenu 
