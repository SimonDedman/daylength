## Daylength code
## Simon Dedman 24/4/2018
## Fetches timezone for single or vector of lat/long combinations
## Then uses timezone, latlongs & date to calculate day length
## Timetine fetch uses package lutz, sunrise & sunset times uses package suncalc

daylength <- function(
  date = NULL, # Date. Single or multiple Date. YYYY-MM-DD
  lat = NULL, # numeric. Single latitude
  lon = NULL) { # numeric. Single longitude

  if (!require(lutz)) install.packages("lutz")
  require(lutz) # for lutz tz_lookup_coords
  if (!require(suncalc)) install.packages("suncalc")
  library(suncalc)

# get timezones from latlongs
tzs <- tz_lookup_coords(lat, lon)

sundata <- data.frame(date = as.Date(date),
                      lat = lat,
                      lon = lon)

# get sunrise & sunset times for those latlons & dates
sunriseset <- getSunlightTimes(data = sundata,
                               keep = c("sunrise", "sunset"),
                               tz = tzs)

#calc day length: sunset minus sunrise
daylength <- sunriseset$sunset - sunriseset$sunrise #class=difftime
daylength <- as.numeric(daylength) #change to numeric format
return(daylength)
}
