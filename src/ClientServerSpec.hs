{-# LANGUAGE OverloadedStrings #-}

module ClientServerSpec where

import Types
import TypeHelpers

--directory to output the generated files
outputDirectory = "."
--where the generator is
generatorRoot = "../petri-app-land"

clientCounterData = dt (IntRangeT (-1000000) 1000000) "clientCounterData" "client side counter data"
serverCounterData = dt (IntRangeT (-1000000) 1000000) "serverCounterData" "server side counter data"


{-|
   summary: the `Net` type is where we specify the details of our app.
   details: the `Net` type has `places`, which are similar to specifying different webpages
            in our app, and `transitions` which are the links between our pages. This is 
            just an example, as we don't only work with webpages and links! For example,
            a "place" can be a database, and a "transition" can be update of our database!
-}
counterNet :: Net
counterNet =
    let
        mainMenu =
            Place "MainMenu" 
                    []  -- summary: Server state
                        -- details: Information kept by the server at this place/room
                    []  -- summary: Player state
                        -- details: Information of each individual client at this place/room,
                        --           such as their personal information, etc.
                    []  -- summary: Client state
                        -- details: Information stored by the client on their browser, and
                        --           is not tracked by the server

                    -- summary: Initial commands 
                    -- details: When the server starts, perform commands that can be executed right away
                    Nothing
                    

        counterPlace =
            Place "CounterPlace"
                    [serverCounterData] --server state
                    []                  --player state
                    [clientCounterData]                          --client state
                    Nothing
                    

        goToCounterPlace =                 
            Transition -- The constructor to specify a "Transition" in our app

                -- summary: Specify the origin of our transition
                -- details: The constructor that specifies which party initiates the transition.
                --          In this case, the client will send the server a message!
                OriginClientOnly 

                -- summary: The name of the message that initiates the transition
                -- details: The message sent to the server that indicates the transition wanted. This
                --          is just a Haskell constructor, where we can use constructor fields to carry
                --          additional information.
                --  Loosely translated, we get this in Haskell, for the declaration below:
                --  data GoToCounterPlace = GoToCounterPlace
                (msg "GoToCounterPlace" [])

                -- summary: A list of places and messages that are the beginning & endpoints of the transition
                -- details: Specify transitions from place to place, and the return data of taking that
                --          transition. The format is (FromPlace, Maybe (ToPlace, msg)).
                --          We need a Maybe because it is not guarenteed for clients to always take
                --          the transition!
                [("MainMenu", Just ("CounterPlace", msg "WentToCounterPlace" [clientCounterData], Nothing))
                ,("MainMenu", Nothing) --some people will stay
                ]

                -- summary: A server command to be issued when the transition is fired.
                -- details: We can tell the server to perform some tasks when someone initiates a 
                --          transition, which can be helpful in some situations. For example,
                --          when a user logins, we can instruct the server to log the actions of
                --          the user!
                Nothing

        goToMainMenu =                 
            Transition
                OriginClientOnly
                (msg "GoToMainMenu" [])
                [("CounterPlace", Just ("MainMenu", msg "WentToMainMenu" [], Nothing))
                ,("CounterPlace", Nothing) --some people will stay
                ]
                Nothing

        incrementCounter =
            Transition
                OriginClientOnly
                (msg "IncrementCounter" [])
                [("CounterPlace", Just ("CounterPlace", msg "CounterIncremented" [clientCounterData], Nothing))
                ]
                Nothing

        decrementCounter =
            Transition
                OriginClientOnly
                (msg "DecrementCounter" [])
                [("CounterPlace", Just ("CounterPlace", msg "CounterDecremented" [clientCounterData], Nothing))
                ]
                Nothing                
    in
        -- summary: The top-level view of the net
        -- details: The framework will use this as the entrypoint to generate the code for our app.
        --          The constructor `Net` is used to specify this point.
        Net
            -- summary: The name of our net
            "CounterNet"
            -- summary: The starting place that clients enter when they use the app
            "MainMenu"
            -- summary: The places in our app
            [mainMenu, counterPlace]
            -- summary: The transitions in our app
            [goToCounterPlace,goToMainMenu,incrementCounter,decrementCounter]
            -- summary: A list of plugins to be used in our app
            []


clientServerApp :: ClientServerApp
clientServerApp =
    ( "CounterNet"            --starting net for a client
    , [counterNet]             --all the nets in this client/server app
    , []              --extra client types used in states or messages
    )
