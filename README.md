prettyDate
==========

Takes a Unix time and converts it to a variety of Y:M:D h:m formats

(only the DateTime.elm file is required; Epoch.elm just contains the testing code)

There is a function inside DateTime.elm which sets the time zone

```elm
timeZone : Int
timeZone = 2 -- or whatever your timezone is, as measured in hours from UTC
```

Usage
=====

**1. Get the UTC time as a Signal**

```elm
nowtime = sampleOn Mouse.clicks (every second)
```

**2. Convert it to various formats**

```elm
currentDateAndTime <~ nowtime          -> "Thursday, 27/11/2014  15:13"
currentTime                            -> "Thursday, 27/11/2014"
currentDate                            -> "15:13"
dayNameMonthYear                       -> ("Thursday",27,11,2014)
dayMonthYear                           -> (27,11,2014)
dayOfWeek                              -> "Thursday"
dayHour                                -> 15
yearNumber                             -> 2014
```

ToDo
====

1. Numerous functions could be added, such as:

a. Calculating future dates

```elm
addDays n
addWeeks n
addMonths n
```

b. Comparing dates

```elm
daysBetween date1 date2
minutesBetween time1 time2
```

c. Answering questions

```elm
whatDayOfWeekIs date
```

d. Add some constants

```elm
nextNewYearsDay
thisChristmas
```

Plus, would it be better if the time zone were not baked in, but could be passed in from outside?
