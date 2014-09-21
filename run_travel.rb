require './lib/flight.rb'
require './lib/find_flight.rb'
require './lib/travel_finder.rb'
require './lib/csv_converter.rb'

flight_finder = FindFlight.new
travel_finder = TravelFinder.new(flight_finder)
csv_converter = CsvConverter.new

travel_finder.find_flights!('./data/Simple-input.csv')
