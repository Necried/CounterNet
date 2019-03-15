module CounterNet.Static.Update where
import CounterNet.Static.Types
import CounterNet.Static.Wrappers
import CounterNet.Static.FromSuperPlace (FromSuperPlace(..))
import CounterNet.Update as Update
import qualified Static.Cmd as Cmd
import qualified Data.TMap as TM
import Static.ServerTypes
import qualified Data.IntMap.Strict as IM'
import Data.Maybe (fromJust, isJust, mapMaybe)
import Utils.Utils
import Static.Cmd (Cmd)
import Plugins.Users (processLogout, Users)
import Static.Task (evalTask)

-- player processing functions
processGoToCounterPlacePlayer :: ((ClientID, MainMenuPlayer) -> GoToCounterPlacefromMainMenu) -> (ClientID, Player) -> ((ClientID, Player), (ClientID, Maybe ClientMessage))
processGoToCounterPlacePlayer fromMainMenu (cId,player) = case player of
    PMainMenuPlayer  -> let (np, mCm) = (unwrapGoToCounterPlacefromMainMenu $ fromMainMenu (cId,MainMenuPlayer )) in ((cId, np), (cId, mCm))


processGoToMainMenuPlayer :: ((ClientID, CounterPlacePlayer) -> GoToMainMenufromCounterPlace) -> (ClientID, Player) -> ((ClientID, Player), (ClientID, Maybe ClientMessage))
processGoToMainMenuPlayer fromCounterPlace (cId,player) = case player of
    PCounterPlacePlayer  -> let (np, mCm) = (unwrapGoToMainMenufromCounterPlace $ fromCounterPlace (cId,CounterPlacePlayer )) in ((cId, np), (cId, mCm))


processIncrementCounterPlayer :: ((ClientID, CounterPlacePlayer) -> IncrementCounterfromCounterPlace) -> (ClientID, Player) -> ((ClientID, Player), (ClientID, Maybe ClientMessage))
processIncrementCounterPlayer fromCounterPlace (cId,player) = case player of
    PCounterPlacePlayer  -> let (np, mCm) = (unwrapIncrementCounterfromCounterPlace $ fromCounterPlace (cId,CounterPlacePlayer )) in ((cId, np), (cId, mCm))


processDecrementCounterPlayer :: ((ClientID, CounterPlacePlayer) -> DecrementCounterfromCounterPlace) -> (ClientID, Player) -> ((ClientID, Player), (ClientID, Maybe ClientMessage))
processDecrementCounterPlayer fromCounterPlace (cId,player) = case player of
    PCounterPlacePlayer  -> let (np, mCm) = (unwrapDecrementCounterfromCounterPlace $ fromCounterPlace (cId,CounterPlacePlayer )) in ((cId, np), (cId, mCm))



-- player splitting functions
splitGoToCounterPlacePlayers :: [(ClientID,Player)] -> ([(ClientID,MainMenuPlayer)])
splitGoToCounterPlacePlayers players = foldl (\t@(fromMainMenulst) pl -> case pl of
    (cId,p@(PMainMenuPlayer )) -> ((cId,MainMenuPlayer ):fromMainMenulst)

    _ -> t) ([]) players

splitGoToMainMenuPlayers :: [(ClientID,Player)] -> ([(ClientID,CounterPlacePlayer)])
splitGoToMainMenuPlayers players = foldl (\t@(fromCounterPlacelst) pl -> case pl of
    (cId,p@(PCounterPlacePlayer )) -> ((cId,CounterPlacePlayer ):fromCounterPlacelst)

    _ -> t) ([]) players

splitIncrementCounterPlayers :: [(ClientID,Player)] -> ([(ClientID,CounterPlacePlayer)])
splitIncrementCounterPlayers players = foldl (\t@(fromCounterPlacelst) pl -> case pl of
    (cId,p@(PCounterPlacePlayer )) -> ((cId,CounterPlacePlayer ):fromCounterPlacelst)

    _ -> t) ([]) players

splitDecrementCounterPlayers :: [(ClientID,Player)] -> ([(ClientID,CounterPlacePlayer)])
splitDecrementCounterPlayers players = foldl (\t@(fromCounterPlacelst) pl -> case pl of
    (cId,p@(PCounterPlacePlayer )) -> ((cId,CounterPlacePlayer ):fromCounterPlacelst)

    _ -> t) ([]) players


-- process player connect
clientConnect :: FromSuperPlace -> ClientID -> NetState Player -> NetState Player
clientConnect fsp clientID state =
    let
        (mainMenu,mainMenuPlayer) = Update.clientConnect fsp clientID (safeFromJust "client connect Net" $ TM.lookup $ placeStates state)
    in
        state { placeStates = TM.insert mainMenu $ placeStates state, playerStates = IM'.insert clientID (unwrapMainMenuPlayer mainMenuPlayer) (playerStates state) }

-- process player disconnects
disconnect :: FromSuperPlace -> ClientID -> NetState Player -> IO (NetState Player)
disconnect fsp clientID state =
    let
        player = safeFromJust "disconnect" $ IM'.lookup clientID $ players
        places = placeStates state
        players = playerStates state
        newPlaces = case player of
            PMainMenuPlayer  -> (flip TM.insert) places $ clientDisconnectFromMainMenu fsp clientID (safeFromJust "clientDisconnectFrom" $ TM.lookup places) (MainMenuPlayer )
            PCounterPlacePlayer  -> (flip TM.insert) places $ clientDisconnectFromCounterPlace fsp clientID (safeFromJust "clientDisconnectFrom" $ TM.lookup places) (CounterPlacePlayer )

        newPlayers = IM'.delete clientID players
        task = processLogout clientID
    in do
        case (TM.lookup $ pluginStates state :: Maybe Plugins.Users.Users) of
            Just _ -> do
                evalTask (pluginStates state) task -- back door into the users plugin...
                return ()
            Nothing -> return ()
        return $ state { playerStates = newPlayers, placeStates = newPlaces }

update :: TopLevelData -> Maybe ClientID -> Transition -> NetState Player -> (NetState Player,[(ClientID,ClientMessage)],Maybe (Cmd.Cmd Transition))
update tld mClientID trans state =
    let
        places = placeStates state
        players = playerStates state
        (newPlaces, newPlayers, clientMessages, cmd) = 
            case trans of
                TGoToCounterPlace ->
                    let
                        (mainMenuPlayerLst) = splitGoToCounterPlacePlayers (IM'.toList players)
                        (mainMenu,counterPlace,fromMainMenu) = updateGoToCounterPlace tld (fromJust mClientID) (GoToCounterPlace ) ((safeFromJust "place lookup") $ TM.lookup places) ((safeFromJust "place lookup") $ TM.lookup places) (map snd mainMenuPlayerLst)
                        newPlaces = TM.insert mainMenu $ TM.insert counterPlace places
                        (newPlayers, clientMessages) = unzip $ map (processGoToCounterPlacePlayer fromMainMenu) (mapSnd unwrapMainMenuPlayer mainMenuPlayerLst)
                    in
                        (newPlaces, newPlayers, clientMessages, Nothing)

                TGoToMainMenu ->
                    let
                        (counterPlacePlayerLst) = splitGoToMainMenuPlayers (IM'.toList players)
                        (counterPlace,mainMenu,fromCounterPlace) = updateGoToMainMenu tld (fromJust mClientID) (GoToMainMenu ) ((safeFromJust "place lookup") $ TM.lookup places) ((safeFromJust "place lookup") $ TM.lookup places) (map snd counterPlacePlayerLst)
                        newPlaces = TM.insert counterPlace $ TM.insert mainMenu places
                        (newPlayers, clientMessages) = unzip $ map (processGoToMainMenuPlayer fromCounterPlace) (mapSnd unwrapCounterPlacePlayer counterPlacePlayerLst)
                    in
                        (newPlaces, newPlayers, clientMessages, Nothing)

                TIncrementCounter ->
                    let
                        (counterPlacePlayerLst) = splitIncrementCounterPlayers (IM'.toList players)
                        (counterPlace,fromCounterPlace) = updateIncrementCounter tld (fromJust mClientID) (IncrementCounter ) ((safeFromJust "place lookup") $ TM.lookup places) (map snd counterPlacePlayerLst)
                        newPlaces = TM.insert counterPlace places
                        (newPlayers, clientMessages) = unzip $ map (processIncrementCounterPlayer fromCounterPlace) (mapSnd unwrapCounterPlacePlayer counterPlacePlayerLst)
                    in
                        (newPlaces, newPlayers, clientMessages, Nothing)

                TDecrementCounter ->
                    let
                        (counterPlacePlayerLst) = splitDecrementCounterPlayers (IM'.toList players)
                        (counterPlace,fromCounterPlace) = updateDecrementCounter tld (fromJust mClientID) (DecrementCounter ) ((safeFromJust "place lookup") $ TM.lookup places) (map snd counterPlacePlayerLst)
                        newPlaces = TM.insert counterPlace places
                        (newPlayers, clientMessages) = unzip $ map (processDecrementCounterPlayer fromCounterPlace) (mapSnd unwrapCounterPlacePlayer counterPlacePlayerLst)
                    in
                        (newPlaces, newPlayers, clientMessages, Nothing)


    in
        (state
           {
                placeStates = newPlaces
           ,    playerStates = insertList newPlayers $ players
           }
        , mapMaybe (\(a,b) -> if isJust b then Just (a,fromJust b) else Nothing) clientMessages
        , cmd)
