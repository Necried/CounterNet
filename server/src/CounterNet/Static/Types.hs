{-# LANGUAGE DeriveDataTypeable #-}
module CounterNet.Static.Types where
import Data.Typeable (Typeable)
import Data.Data (Data)
import Data.SafeCopy (SafeCopy)


-- place states and place player states
data MainMenu  =
      MainMenu
    deriving(Ord,Eq,Show,Typeable)

data MainMenuPlayer  =
      MainMenuPlayer
    deriving(Ord,Eq,Show,Typeable)


data CounterPlace  =
      CounterPlace Int {-serverCounterData-}
    deriving(Ord,Eq,Show,Typeable)

data CounterPlacePlayer  =
      CounterPlacePlayer
    deriving(Ord,Eq,Show,Typeable)



-- outgoing client message types
data WentToCounterPlace  =
      WentToCounterPlace Int {-clientCounterData-}
    deriving(Ord,Eq,Show)
data WentToMainMenu  =
      WentToMainMenu
    deriving(Ord,Eq,Show)
data CounterIncremented  =
      CounterIncremented Int {-clientCounterData-}
    deriving(Ord,Eq,Show)
data CounterDecremented  =
      CounterDecremented Int {-clientCounterData-}
    deriving(Ord,Eq,Show)
data ClientMessage  =
      MWentToCounterPlace Int {-clientCounterData-}
    | MWentToMainMenu
    | MCounterIncremented Int {-clientCounterData-}
    | MCounterDecremented Int {-clientCounterData-}
    deriving(Ord,Eq,Show)

-- individual transition types
data GoToCounterPlacefromMainMenu  =
      GoToCounterPlace_MainMenutoCounterPlace CounterPlacePlayer WentToCounterPlace
    | GoToCounterPlace_Stay_MainMenu MainMenuPlayer
    deriving(Ord,Eq,Show)

data GoToMainMenufromCounterPlace  =
      GoToMainMenu_CounterPlacetoMainMenu MainMenuPlayer WentToMainMenu
    | GoToMainMenu_Stay_CounterPlace CounterPlacePlayer
    deriving(Ord,Eq,Show)

data IncrementCounterfromCounterPlace  =
      IncrementCounter_CounterPlacetoCounterPlace CounterPlacePlayer CounterIncremented
    deriving(Ord,Eq,Show)

data DecrementCounterfromCounterPlace  =
      DecrementCounter_CounterPlacetoCounterPlace CounterPlacePlayer CounterDecremented
    deriving(Ord,Eq,Show)


-- main transition types
data Transition  =
      TGoToCounterPlace
    | TGoToMainMenu
    | TIncrementCounter
    | TDecrementCounter
    deriving(Ord,Eq,Show)
data GoToCounterPlace  =
      GoToCounterPlace
    deriving(Ord,Eq,Show)
data GoToMainMenu  =
      GoToMainMenu
    deriving(Ord,Eq,Show)
data IncrementCounter  =
      IncrementCounter
    deriving(Ord,Eq,Show)
data DecrementCounter  =
      DecrementCounter
    deriving(Ord,Eq,Show)

-- player state union type
data Player  =
      PMainMenuPlayer
    | PCounterPlacePlayer
    deriving(Ord,Eq,Show)
-- extra server types


