require 'csv'
require_relative 'find_flight'
require_relative 'flight'

class TravelFinder

	attr_reader :flight_list

	def initialize(flight_finder)
    @flight_finder = flight_finder
	end

  def find_flights!(file)
    get_info = get_flights(file)
    refine_data = delete_whitespace(get_info)
    # sort_list = @flight_finder.sort_by_cheap(refine_data)
    converted_list = @flight_finder.convert_time_to_integer(refine_data)
    @flight_finder.find_direct_flights(converted_list)
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