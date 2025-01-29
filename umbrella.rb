require "http"
require "json"
require "dotenv/load"

puts "Where are you currently located?"

location = gets.chomp

puts "Please hold while we check the weather at " + location + "!"

gmaps_key = ENV.fetch("GMAPS_KEY")

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{gmaps_key}"

raw_gmaps_response = HTTP.get(gmaps_url)

parsed_gmaps_response = JSON.parse(raw_gmaps_response)

results_array = parsed_gmaps_response.fetch("results")
address_components_hash = results_array.at(0)
location_hash = address_components_hash.fetch("geometry")
final_hash = location_hash.fetch("location")
latitude = final_hash.fetch("lat")
longitude = final_hash.fetch("lng")

puts "Your coordinates are #{latitude}, #{longitude}."

pirate_weather_key = ENV.fetch("PIRATE_WEATHER_KEY")

pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_weather_key}/#{latitude},#{longitude}"

raw_response = HTTP.get(pirate_weather_url)

parsed_response = JSON.parse(raw_response)

currently_hash = parsed_response.fetch("currently")

current_temp = currently_hash.fetch("temperature")

puts "The current temperature is " + current_temp.to_s + "."

hourly_hash = parsed_response.fetch("hourly")

hourly_summary = hourly_hash.fetch("summary")

puts "The next hour is " + hourly_summary.to_s + "."
