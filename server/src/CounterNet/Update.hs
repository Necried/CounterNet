module CounterNet.Update where
import CounterNet.Static.Types
import CounterNet.Static.FromSuperPlace
import CounterNet.Static.Helpers.MainMenu as MainMenu
import CounterNet.Static.Helpers.CounterPlace as CounterPlace

-- import CounterNet.Static.Helpers.MainMenuPlayer as MainMenuPlayer
-- import CounterNet.Static.Helpers.CounterPlacePlayer as CounterPlacePlayer

import Static.List
import Utils.Utils
import Static.ServerTypes
import Static.Cmd (Cmd(..))
import qualified Static.Cmd as Cmd

-- function called when new client connects (do not delete)
clientConnect :: FromSuperPlace -> ClientID -> MainMenu -> (MainMenu, MainMenuPlayer)
clientConnect fsp clientID mainMenu =
    (mainMenu,MainMenuPlayer)

-- functions called when a client disconnects (do not delete)
clientDisconnectFromCounterPlace :: FromSuperPlace -> ClientID -> CounterPlace -> CounterPlacePlayer -> CounterPlace
clientDisconnectFromCounterPlace fsp clientID counterPlace counterPlacePlayer =
    counterPlace

clientDisconnectFromMainMenu :: FromSuperPlace -> ClientID -> MainMenu -> MainMenuPlayer -> MainMenu
clientDisconnectFromMainMenu fsp clientID mainMenu mainMenuPlayer =
    mainMenu

-- functions for each transition
updateGoToCounterPlace :: FromSuperPlace -> 
    ClientID ->
    GoToCounterPlace ->
    MainMenu -> 
    CounterPlace -> 
    List MainMenuPlayer -> 
    ( MainMenu,
      CounterPlace,
      (ClientID, MainMenuPlayer) -> GoToCounterPlacefromMainMenu
    )
updateGoToCounterPlace fsp clientId GoToCounterPlace mainMenu counterPlace lstMainMenu =
    let
        fromMainMenu :: (ClientID, MainMenuPlayer) -> GoToCounterPlacefromMainMenu
        fromMainMenu (pId, pmainMenu) = 
            if clientId == pId
                then GoToCounterPlace_MainMenutoCounterPlace CounterPlacePlayer (WentToCounterPlace (getServerCounterData counterPlace))
                else GoToCounterPlace_Stay_MainMenu MainMenuPlayer


    in
        (mainMenu, counterPlace, fromMainMenu)

updateGoToMainMenu :: FromSuperPlace -> 
    ClientID ->
    GoToMainMenu ->
    CounterPlace -> 
    MainMenu -> 
    List CounterPlacePlayer -> 
    ( CounterPlace,
      MainMenu,
      (ClientID, CounterPlacePlayer) -> GoToMainMenufromCounterPlace
    )
updateGoToMainMenu fsp clientId GoToMainMenu counterPlace mainMenu lstCounterPlace =
    let
        fromCounterPlace :: (ClientID, CounterPlacePlayer) -> GoToMainMenufromCounterPlace
        fromCounterPlace (pId, pcounterPlace) =
            if clientId == pId
                then GoToMainMenu_CounterPlacetoMainMenu MainMenuPlayer WentToMainMenu
                else GoToMainMenu_Stay_CounterPlace CounterPlacePlayer


    in
        (counterPlace, mainMenu, fromCounterPlace)

updateIncrementCounter :: FromSuperPlace -> 
    ClientID ->
    IncrementCounter ->
    CounterPlace -> 
    List CounterPlacePlayer -> 
    ( CounterPlace,
      (ClientID, CounterPlacePlayer) -> IncrementCounterfromCounterPlace
    )
updateIncrementCounter fsp clientId IncrementCounter counterPlace lstCounterPlace =
    let
        newServerCounterData@(CounterPlace counter) = alterServerCounterData (+1) counterPlace

        fromCounterPlace :: (ClientID, CounterPlacePlayer) -> IncrementCounterfromCounterPlace
        fromCounterPlace (pId, pcounterPlace) = 
            IncrementCounter_CounterPlacetoCounterPlace CounterPlacePlayer (CounterIncremented counter)


    in
        (newServerCounterData, fromCounterPlace)

updateDecrementCounter :: FromSuperPlace -> 
    ClientID ->
    DecrementCounter ->
    CounterPlace -> 
    List CounterPlacePlayer -> 
    ( CounterPlace,
      (ClientID, CounterPlacePlayer) -> DecrementCounterfromCounterPlace
    )
updateDecrementCounter fsp clientId DecrementCounter counterPlace lstCounterPlace =
    let
        newServerCounterData@(CounterPlace counter) = alterServerCounterData (flip (-) 1) counterPlace

        fromCounterPlace :: (ClientID, CounterPlacePlayer) -> DecrementCounterfromCounterPlace
        fromCounterPlace (pId, pcounterPlace) = 
            DecrementCounter_CounterPlacetoCounterPlace CounterPlacePlayer (CounterDecremented counter)

    in
        (newServerCounterData, fromCounterPlace)


