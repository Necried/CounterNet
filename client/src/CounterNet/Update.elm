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
    CounterPlace clientCounterData

updateCounterPlaceWentToMainMenuMainMenu : FromSuperPlace -> WentToMainMenu -> CounterPlace -> MainMenu
updateCounterPlaceWentToMainMenuMainMenu fsp WentToMainMenu  counterPlace =
    MainMenu

updateCounterPlaceCounterIncrementedCounterPlace : FromSuperPlace -> CounterIncremented -> CounterPlace -> CounterPlace
updateCounterPlaceCounterIncrementedCounterPlace fsp (CounterIncremented clientCounterData)  counterPlace =
    CounterPlace clientCounterData

updateCounterPlaceCounterDecrementedCounterPlace : FromSuperPlace -> CounterDecremented -> CounterPlace -> CounterPlace
updateCounterPlaceCounterDecrementedCounterPlace fsp (CounterDecremented clientCounterData)  counterPlace =
    CounterPlace clientCounterData

