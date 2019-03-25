module CounterNet.Static.Types exposing(..)
import CounterNet.Static.ExtraTypes exposing(..)


-- the types of all places in the net
type Dummy = Dummy
-- place states
type MainMenu  =
      MainMenu


type CounterPlace  =
      CounterPlace Int {-clientCounterData-}



-- union place type
type NetState  =
      SMainMenu MainMenu
    | SCounterPlace CounterPlace
-- internal transition types

-- outgoing transition types
type OutgoingTransition  =
      TGoToCounterPlace
    | TGoToMainMenu
    | TIncrementCounter
    | TDecrementCounter
type WentToCounterPlace  =
      WentToCounterPlace Int
type WentToMainMenu  =
      WentToMainMenu
type CounterIncremented  =
      CounterIncremented Int
type CounterDecremented  =
      CounterDecremented Int
type GoToCounterPlace  =
      GoToCounterPlace
type GoToMainMenu  =
      GoToMainMenu
type IncrementCounter  =
      IncrementCounter
type DecrementCounter  =
      DecrementCounter

-- outgoing server message types
type IncomingMessage  =
      MWentToCounterPlace Int {-clientCounterData-}
    | MWentToMainMenu
    | MCounterIncremented Int {-clientCounterData-}
    | MCounterDecremented Int {-clientCounterData-}

type Transition =
    External OutgoingTransition
