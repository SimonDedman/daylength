## Daylength code
## Simon Dedman 24/4/2018 updated 19/6/2019
## Fetches timezone for single or vector of lat/long combinations
## Then uses timezone, latlongs & date to calculate day length in hours & decimal minutes
## Timetine fetch uses package lutz, sunrise & sunset times uses package suncalc
## Pasting output as new columns preserves parent class i.e. POSIXct; pasting as
## Single cells inherits class of target object/column/vector. Ensure this is
## the correct format with:
# df_i$dawn <- rep(NA, nrow(df_i))
# df_i$dawn <- as.POSIXct(df_i$dawn, tz = "America/New_York") #change to your tz
# attr(df_i$dawn, "tzone") <- "EST" #change to your tz

daylength <- function(
  date = NULL, # Date. Single or multiple Date. YYYY-MM-DD
  lat = NULL, # numeric. Single or vector
  lon = NULL, # numeric. Single or vector
  tzs = NULL) { # character. Single or vector. Extract with attr(time, "tzone")

  if (!require(lutz)) install.packages("lutz")
  require(lutz) # for lutz tz_lookup_coords
  if (!require(suncalc)) install.packages("suncalc")
  library(suncalc)

  # get timezones from latlongs if not supplied
  if (is.null(tzs)) {tzs <- tz_lookup_coords(lat, lon)}

  sundata <- data.frame(date = as.Date(date),
                        lat = lat,
                        lon = lon)

  # get sunrise & sunset times for those latlons & dates
  sunriseset <- getSunlightTimes(data = sundata,
                                 keep = c("sunrise", "sunset", "dawn", "dusk"),
                                 tz = tzs)
  # calc day length: sunset minus sunrise
  daylength <- sunriseset$sunset - sunriseset$sunrise #class=difftime
  daylength <- as.numeric(daylength) #change to numeric format
  dl <- cbind(sunriseset, daylength) #join together
  return(dl) # POSIXct, daylength is numeric
}
