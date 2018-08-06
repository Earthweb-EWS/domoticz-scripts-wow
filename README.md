# domoticz-script-wow
Domoticz LUA Script Upload Data to Met Office WOW


Simple script to upload data to Met Office WOW. Also suitable to use with KNMI WOW (Dutch). </br>

Because of API limit's of Met Office WOW, the script will upload every several minutes instead of every minute. </br>


To easy setup: Download and edit script_time_wu.lua </br>
Replace STATION_ID, STATION_PASSWORD and one of the sensors by name (After commentline Sensor Settings). </br>
Upload file to Domoticz scripts directory. </br>
