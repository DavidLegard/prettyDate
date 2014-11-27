module Grogger where

import Mouse
import DateTime as D





nowtime = sampleOn Mouse.clicks (every second)

currentTimeSignal = D.currentDateAndTime <~ nowtime



main : Signal Element
main = lift asText currentTimeSignal

-- (D.dayHour <~ 

