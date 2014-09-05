require './lib/flights.rb'
require './lib/travel_finder.rb'

travel_finder = TravelFinder.new
travel_finder.get_flights('./lib/sample-input.csv')