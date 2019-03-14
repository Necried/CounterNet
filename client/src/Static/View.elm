module Static.View exposing(..)
import CounterNet.Static.View as CounterNet

import Static.Types exposing(..)
import Html exposing(Html)
view : NetModel -> Html NetTransition
view model =
    case model of
        CounterNet m -> Html.map CounterNetTrans <| CounterNet.view m

title : NetModel -> String
title model =
    case model of
        CounterNet m -> CounterNet.title m

