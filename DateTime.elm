module DateTime where


shiftZone : Int -> Int
shiftZone h = 3600 * h

secsPerDay : Int
secsPerDay = 86400


timeZone : Int
timeZone = 7


daysInMonths : [Int]
daysInMonths = [31,28,31,30,31,30,31,31,30,31,30,31]


daysInMonthsLeap : [Int]
daysInMonthsLeap = [31,29,31,30,31,30,31,31,30,31,30,31]


daysInWeek : [String]
daysInWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]


timeBetween : (Int,Int) -> Float
timeBetween (h,m) = toFloat (60 * (h-18) + m)

dayNumber : Float -> Int
dayNumber time = (round time) // (1000 * secsPerDay)

dayHour : Float -> Int
dayHour time = (dayTime time) // 3600

dayMinute : Float -> Int
dayMinute time = ((dayTime time) - 3600 * (dayHour time)) // 60


isLeapYear : Int -> Bool
isLeapYear y = 
            if  | y % 4 == 0 && y % 400 /= 0 -> True
                | otherwise -> False


daysInYear : Int -> Int
daysInYear y = if (isLeapYear y) then 366 else 365


yearNumber : Float -> Int
yearNumber time = 
              let (yn,d) = getYearAndDay (dayNumber time) 1970
              in yn

dayOfWeek : Float -> String
dayOfWeek time = 
             let daynum = dayNumber time
                 alteredDayNum = 3 + daynum
                 diw = alteredDayNum % 7
             in daysInWeek |> drop diw |> head

currentTime :  Float -> String
currentTime time = 
               let (h,myn) = hourMinute time
               in displayTime(h,myn)

currentDate :  Float -> String
currentDate time = 
                let  (dw,dy,m,yn) = dayNameMonthYear time
                in displayDate (dw,dy,m,yn) 

                
currentDateAndTime : Float -> String
currentDateAndTime time = 
                      let (dw,dy,m,yn) = dayNameMonthYear time
                          (h,myn) = hourMinute time
                          tyme = displayTime(h,myn)
                          dayt = displayDate (dw,dy,m,yn) 
                      in dayt ++ "  " ++ tyme

dayNameMonthYear : Float -> (String,Int,Int,Int)
dayNameMonthYear time =
                   let (dy,m,yn) = dayMonthYear time
                       dw = dayOfWeek time
                   in (dw,dy,m,yn)


dayMonthYear : Float -> (Int,Int,Int) -- ,Bool)
dayMonthYear time =
                let (yn,d) = getYearAndDay (dayNumber time) 1970
                    moons = if (isLeapYear yn) then daysInMonthsLeap else daysInMonths
                    (dy,m) = monthAndDay d moons
                    -- lyr = isLeapYear yn
                in (dy,m,yn) -- ,lyr)


monthAndDay : Int -> [Int]-> (Int,Int)
monthAndDay d mns =
               if | d > (head mns) -> monthAndDay (d - (head mns)) (tail mns)
                  | otherwise -> (d,13 - (length mns))


dayOfYear : Float -> Int
dayOfYear time = 
             let (yn,d) = getYearAndDay (dayNumber time) 1970
              in d


getYearAndDay : Int -> Int -> (Int,Int)
getYearAndDay d y =
                 if | d > daysInYear y -> getYearAndDay (d - daysInYear y) (y+1)
                    | otherwise -> (y,d)


displayTime (h,m) = show h ++ ":" ++ show m
displayDate (dw,dy,m,yn) = dw ++ ", " ++ show dy ++ "/" ++ show m ++ "/" ++ show yn


dayTime time = (round (time/1000.0)) % secsPerDay


hourMinute : Float -> (Int,Int)
hourMinute time = (timeZone + (dayHour time), dayMinute time)


hourMinuteSecond : Float -> (Int,Int,Int)
hourMinuteSecond time =
                    let hrs = dayHour time
                        mns = dayMinute time
                        scs = dayTime time - 60 * mns - 3600 * hrs
                    in (timeZone + hrs,mns,scs)