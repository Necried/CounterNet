{-# LANGUAGE OverloadedStrings #-}

module ClientServerSpec where

import Types
import TypeHelpers

--directory to output the generated files
outputDirectory = "."
--where the generator is
generatorRoot = "../elm-haskell-state-diagram"


clientCounterData = edt (ElmIntRange (-1000000) 1000000) "clientCounterData" "client side counter data"
serverCounterData = edt (ElmIntRange (-1000000) 1000000) "serverCounterData" "server side counter data"

{-
counterType :: ElmCustom
counterType = ec -- helper to make custom types
                "Counter" -- name of type (Elm syntax rules)
                [("Counter",
                            [edt (ElmIntRange (-1000000) 1000000) "counterData" "stores counter data"
                            ]
                 )
                ]

counterAction :: ElmCustom
counterAction = ec
                "CounterAction"
                [("Increment", [])
                ,("Decrement", [])
                ]
-}

counterNet :: Net
counterNet =
    let
        mainMenu =
            HybridPlace "MainMenu" 
                    [] --server state
                    []                  --player state
                    []                          --client state
                    Nothing
                    (Nothing, Nothing)
                    

        counterPlace =
            HybridPlace "CounterPlace"
                    [serverCounterData] --server state
                    []                  --player state
                    [clientCounterData]                          --client state
                    Nothing
                    (Nothing, Nothing)
                    

        goToCounterPlace =                 
            NetTransition
                OriginClientOnly
                (constructor "GoToCounterPlace" [])
                [("MainMenu", Just ("CounterPlace", constructor "WentToCounterPlace" [clientCounterData]))
                ,("MainMenu", Nothing) --some people will stay
                ]
                Nothing

        goToMainMenu =                 
            NetTransition
                OriginClientOnly
                (constructor "GoToMainMenu" [])
                [("CounterPlace", Just ("MainMenu", constructor "WentToMainMenu" []))
                ,("CounterPlace", Nothing) --some people will stay
                ]
                Nothing

        incrementCounter =
            NetTransition
                OriginClientOnly
                (constructor "IncrementCounter" [])
                [("CounterPlace", Just ("CounterPlace", constructor "CounterIncremented" [clientCounterData]))
                ]
                Nothing

        decrementCounter =
            NetTransition
                OriginClientOnly
                (constructor "DecrementCounter" [])
                [("CounterPlace", Just ("CounterPlace", constructor "CounterDecremented" [clientCounterData]))
                ]
                Nothing                
    in
        HybridNet
            "CounterNet"
            "MainMenu"
            [mainMenu, counterPlace]
            [goToCounterPlace,goToMainMenu,incrementCounter,decrementCounter]
            []


clientServerApp :: ClientServerApp
clientServerApp =
    ( "CounterNet"            --starting net for a client
    , [counterNet]             --all the nets in this client/server app
    , []              --extra client types used in states or messages
    )
