require 'csv'

class TravelFinder

	attr_reader :flight_list

	def initialize(flight_finder)
    @flight_finder = flight_finder
	end

  def find_flights!(file)
    get_info = get_flights(file)
    refine_data = delete_whitespace(get_info)
    @flight_finder.find_cheap_flight(refine_data)
  end

  def get_flights(file)
  	flights_array = []
  	csv_data = CSV.foreach(file) do |row|
  	  flight = Flight.new(row)
  	  flights_array << flight unless row.empty?
  	end
    flights_array
	end

  def delete_whitespace(list)
    list.each do |row|
      list.delete(row) if row.destination && row.departure== nil
    end
  end
end