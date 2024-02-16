require "sinatra"
require "sinatra/reloader"
require 'net/http'
require 'json'

# Home route
get("/") do
  uri = URI("https://api.exchangerate.host/symbols")
  response = Net::HTTP.get(uri)
  @symbols = JSON.parse(response)["symbols"]

  erb :home
end

# Single currency route
get("/:currency") do |currency|
  uri = URI("https://api.exchangerate.host/symbols")
  response = Net::HTTP.get(uri)
  @currency = currency
  @symbols = JSON.parse(response)["symbols"]

  erb :currency
end

# Pair of currencies route
get("/:currency1/:currency2") do |currency1, currency2|
  uri = URI("https://api.exchangerate.host/convert?from=#{currency1}&to=#{currency2}")
  response = Net::HTTP.get(uri)
  @currency1 = currency1
  @currency2 = currency2
  @conversion_rate = JSON.parse(response)["info"]["rate"]

  erb :conversion
end
