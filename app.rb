require "sinatra"
require "sinatra/reloader"
require "net/http"
require "json"

get("/") do
  url = URI("https://api.exchangerate.host/symbols")
  raw_data = Net::HTTP.get(url)
  parsed_data = JSON.parse(raw_data)
  @hash = parsed_data.fetch("symbols")
  erb(:app)
end

get("/:from") do
  @symbol1 = params.fetch("from")
  url = URI("https://api.exchangerate.host/symbols")
  raw_data = Net::HTTP.get(url)
  parsed_data = JSON.parse(raw_data)
  @hash = parsed_data.fetch("symbols")
  erb(:from)
end

get("/:from/:to") do
  @symbol1 = params.fetch("from")
  @symbol2 = params.fetch("to")
  url = URI("https://api.exchangerate.host/convert?from=#{@symbol1}&to=#{@symbol2}")
  raw_data = Net::HTTP.get(url)
  parsed_data = JSON.parse(raw_data)
  @hash = parsed_data.fetch("info")
  @value = @hash.fetch("rate")
  erb(:to)
end
