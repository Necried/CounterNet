module CounterNet.Static.Wrappers where
import Static.Dict
import Data.Map.Strict as Dict
import CounterNet.Static.Types

unwrapWentToCounterPlace :: WentToCounterPlace -> ClientMessage
unwrapWentToCounterPlace (WentToCounterPlace clientCounterData)  = (MWentToCounterPlace clientCounterData) 


unwrapWentToMainMenu :: WentToMainMenu -> ClientMessage
unwrapWentToMainMenu WentToMainMenu  = MWentToMainMenu 


unwrapCounterIncremented :: CounterIncremented -> ClientMessage
unwrapCounterIncremented (CounterIncremented clientCounterData)  = (MCounterIncremented clientCounterData) 


unwrapCounterDecremented :: CounterDecremented -> ClientMessage
unwrapCounterDecremented (CounterDecremented clientCounterData)  = (MCounterDecremented clientCounterData) 



unwrapMainMenuPlayer :: MainMenuPlayer -> Player
unwrapMainMenuPlayer MainMenuPlayer  = PMainMenuPlayer 


unwrapCounterPlacePlayer :: CounterPlacePlayer -> Player
unwrapCounterPlacePlayer CounterPlacePlayer  = PCounterPlacePlayer 



unwrapGoToCounterPlacefromMainMenu :: GoToCounterPlacefromMainMenu -> (Player, Maybe ClientMessage)
unwrapGoToCounterPlacefromMainMenu trans =
    case trans of
        (GoToCounterPlace_MainMenutoCounterPlace player msg)  -> (unwrapCounterPlacePlayer player, Just $ unwrapWentToCounterPlace msg)
        (GoToCounterPlace_Stay_MainMenu player)  -> (unwrapMainMenuPlayer player, Nothing)




unwrapGoToMainMenufromCounterPlace :: GoToMainMenufromCounterPlace -> (Player, Maybe ClientMessage)
unwrapGoToMainMenufromCounterPlace trans =
    case trans of
        (GoToMainMenu_CounterPlacetoMainMenu player msg)  -> (unwrapMainMenuPlayer player, Just $ unwrapWentToMainMenu msg)
        (GoToMainMenu_Stay_CounterPlace player)  -> (unwrapCounterPlacePlayer player, Nothing)




unwrapIncrementCounterfromCounterPlace :: IncrementCounterfromCounterPlace -> (Player, Maybe ClientMessage)
unwrapIncrementCounterfromCounterPlace trans =
    case trans of
        (IncrementCounter_CounterPlacetoCounterPlace player msg)  -> (unwrapCounterPlacePlayer player, Just $ unwrapCounterIncremented msg)




unwrapDecrementCounterfromCounterPlace :: DecrementCounterfromCounterPlace -> (Player, Maybe ClientMessage)
unwrapDecrementCounterfromCounterPlace trans =
    case trans of
        (DecrementCounter_CounterPlacetoCounterPlace player msg)  -> (unwrapCounterPlacePlayer player, Just $ unwrapCounterDecremented msg)





unwrapGoToCounterPlace :: GoToCounterPlace -> Transition
unwrapGoToCounterPlace GoToCounterPlace  = TGoToCounterPlace 


unwrapGoToMainMenu :: GoToMainMenu -> Transition
unwrapGoToMainMenu GoToMainMenu  = TGoToMainMenu 


unwrapIncrementCounter :: IncrementCounter -> Transition
unwrapIncrementCounter IncrementCounter  = TIncrementCounter 


unwrapDecrementCounter :: DecrementCounter -> Transition
unwrapDecrementCounter DecrementCounter  = TDecrementCounter 



