require "http"
require "json"
require "dotenv/load"

puts "Where are you currently located?"

location = gets.chomp

puts "Please hold while we check the weather at " + location + "!"

pirate_weather_key = ENV.fetch("PIRATE_WEATHER_KEY")

pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_key + "/41.8887,-87.6355"

raw_response = HTTP.get(pirate_weather_url)

require "json"

parsed_response = JSON.parse(raw_response)

currently_hash = parsed_response.fetch("currently")

current_temp = currently_hash.fetch()
