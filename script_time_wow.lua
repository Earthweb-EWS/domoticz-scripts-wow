-- Met Office WeatherObservationsWebsite (WOW) AWS upload script
-- (C)2018 Earthweb EWS, based on (C)2013 GizMoCuz script for Weatherunderground and IanDury

date = os.date("*t")
if (date.min % 15 == 7) then
-- start script every 15 minutes with an offset of 7 minutes

Outside_Temp_Hum = ''
Barometer = ''
RainMeter = ''
WindMeter = ''

-- WOW Settings
baseurl = "http://wow.metoffice.gov.uk/automaticreading?"
SiteID = "STATION_ID"
AWSPin = "STATION_PASSWORD"

local function CelciusToFarenheit(C)
   return (C * (9/5)) + 32
end

local function hPatoInches(hpa)
   return hpa * 0.0295301
end

local function mmtoInches(mm)
   return mm * 0.039370
end

utc_dtime = os.date("!%m-%d-%y %H:%M:%S",os.time())

month = string.sub(utc_dtime, 1, 2)
day = string.sub(utc_dtime, 4, 5)
year = "20" .. string.sub(utc_dtime, 7, 8)
hour = string.sub(utc_dtime, 10, 11)
minutes = string.sub(utc_dtime, 13, 14)
seconds = string.sub(utc_dtime, 16, 17)

timestring = year .. "-" .. month .. "-" .. day .. "+" .. hour .. "%3A" .. minutes .. "%3A" .. seconds

SoftwareType="Domoticz"

WU_URL= baseurl .. "siteid=" .. SiteID .. "&siteAuthenticationKey=" .. AWSPin .. "&dateutc=" .. timestring

if Outside_Temp_Hum ~= '' then
   WU_URL = WU_URL .. "&tempf=" .. string.format("%3.1f", CelciusToFarenheit(otherdevices_temperature[Outside_Temp_Hum]))
   WU_URL = WU_URL .. "&humidity=" .. otherdevices_humidity[Outside_Temp_Hum]
   WU_URL = WU_URL .. "&dewptf=" .. string.format("%3.1f", CelciusToFarenheit(otherdevices_dewpoint[Outside_Temp_Hum]))
end

if Barometer ~= '' then
   WU_URL = WU_URL .. "&baromin=" .. string.format("%2.2f", hPatoInches(otherdevices_barometer[Barometer]))
end

if RainMeter ~= '' then
   WU_URL = WU_URL .. "&dailyrainin=" .. string.format("%2.2f", mmtoInches(otherdevices_rain[RainMeter]))
   WU_URL = WU_URL .. "&rainin=" .. string.format("%2.2f", mmtoInches(otherdevices_rain_lasthour[RainMeter]))
end

if WindMeter ~= '' then
   WU_URL = WU_URL .. "&winddir=" .. string.format("%.0f", otherdevices_winddir[WindMeter])
   WU_URL = WU_URL .. "&windspeedmph=" .. string.format("%.0f", (otherdevices_windspeed[WindMeter]/0.1)*0.223693629205)
   WU_URL = WU_URL .. "&windgustmph=" .. string.format("%.0f", (otherdevices_windgust[WindMeter]/0.1)*0.223693629205)
end

WU_URL = WU_URL .. "&softwaretype=" .. SoftwareType

print ('Uploading data to Met Office WeatherObservationsWebsite')
--print (WU_URL)

print ('SiteID=' .. SiteID)
--print ('Sensor=' .. Sensor)

commandArray = {}

-- remove the comment in the line below to actually upload it
commandArray['OpenURL']=WU_URL

print ('Uploading data to Met Office WeatherObservationsWebsite completed')

return commandArray

-- end of script

else
  commandArray = {}
  return commandArray
end