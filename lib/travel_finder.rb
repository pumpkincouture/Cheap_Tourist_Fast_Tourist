require 'csv'

class TravelFinder

	attr_reader :flight_list

	def initialize
		@flight_list = flight_list
	end

  def get_flights(file)
  	flights_array = []
  	csv_data = CSV.foreach(file) do |row|
  	  @flights = Flights.new(row)
  	  flights_array << @flights
  	end
    flights_array
	end

end