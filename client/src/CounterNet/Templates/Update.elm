module CounterNet.Update exposing(..)
import CounterNet.Static.Types exposing(..)
import CounterNet.Static.FromSuperPlace exposing(..)
import CounterNet.Static.ExtraTypes exposing(..)
import CounterNet.Static.Helpers.MainMenu as MainMenu
import CounterNet.Static.Helpers.CounterPlace as CounterPlace
import Utils.Utils
import Debug exposing(todo)

updateMainMenuWentToCounterPlaceCounterPlace : FromSuperPlace -> WentToCounterPlace -> MainMenu -> CounterPlace
updateMainMenuWentToCounterPlaceCounterPlace fsp (WentToCounterPlace clientCounterData)  mainMenu =
    todo "Please implement update function updateMainMenuWentToCounterPlaceCounterPlace for the CounterNet net."


updateCounterPlaceWentToMainMenuMainMenu : FromSuperPlace -> WentToMainMenu -> CounterPlace -> MainMenu
updateCounterPlaceWentToMainMenuMainMenu fsp WentToMainMenu  counterPlace =
    todo "Please implement update function updateCounterPlaceWentToMainMenuMainMenu for the CounterNet net."


updateCounterPlaceCounterIncrementedCounterPlace : FromSuperPlace -> CounterIncremented -> CounterPlace -> CounterPlace
updateCounterPlaceCounterIncrementedCounterPlace fsp (CounterIncremented clientCounterData)  counterPlace =
    todo "Please implement update function updateCounterPlaceCounterIncrementedCounterPlace for the CounterNet net."


updateCounterPlaceCounterDecrementedCounterPlace : FromSuperPlace -> CounterDecremented -> CounterPlace -> CounterPlace
updateCounterPlaceCounterDecrementedCounterPlace fsp (CounterDecremented clientCounterData)  counterPlace =
    todo "Please implement update function updateCounterPlaceCounterDecrementedCounterPlace for the CounterNet net."



