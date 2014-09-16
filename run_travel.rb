require './lib/flight.rb'
require './lib/find_flight.rb'
require './lib/travel_finder.rb'

flight_finder = FindFlight.new
travel_finder = TravelFinder.new(flight_finder)
travel_finder.find_flights!('./lib/sample-input.csv')
