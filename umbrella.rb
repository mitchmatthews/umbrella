require "http"


line_width = 40

puts "=" * line_width
puts "Will you need an umbrella today?".center(line_width)
puts "=" * line_width
puts
puts "Where are you?"
#user_location = gets.chomp.gsub(" ","%20")
user_location = "Chicago"
puts "Checking the weather at #{user_location}...."


# Get the lat/lng of location from Google Maps API
gmaps_key = ENV.fetch("GMAPS_KEY")
gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{gmaps_key}"


# p "Getting coordinates from:"
# p gmaps_url
raw_gmaps_data = HTTP.get(gmaps_url)
parsed_gmaps_data = JSON.parse(raw_gmaps_data)
results_array = parsed_gmaps_data.fetch("results")
first_result_hash = results_array.at(0)
geometry_hash = first_result_hash.fetch("geometry")
location_hash = geometry_hash.fetch("location")
latitude = location_hash.fetch("lat")
longitude = location_hash.fetch("lng")
puts "Your coordinates are #{latitude}, #{longitude}."


# Hidden variables
pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

# Assemble the full URL string by adding the first part, the API token, and the last part together
pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/41.8887,-87.6355"

# Place a GET request to the URL
raw_response = HTTP.get(pirate_weather_url)

require "json"
parsed_response = JSON.parse(raw_response)
currently_hash = parsed_response.fetch("currently")
current_temp = currently_hash.fetch("temperature")
puts "The current temperature is " + current_temp.to_s + "."
