require 'csv'
require_relative 'find_flight'
require_relative 'flight'

class TravelFinder

	def initialize(flight_finder)
    @flight_finder = flight_finder
	end

  def find_flights!(file)
    get_list = get_flights(file)
    direct_flight = direct_flight_pick(get_list)

    @flight_finder.pick_for_steve(direct_flight, indirect_price(get_list), indirect_itinerary(get_list))
    @flight_finder.pick_for_jen(direct_flight, indirect_flight_duration(get_list), indirect_itinerary(get_list))
  end

  def direct_flight_pick(list)
    converted_list = @flight_finder.find_all_durations(@flight_finder.convert_price_to_integer(@flight_finder.convert_time_to_integer(list)))
    direct_flights = @flight_finder.find_direct_flights(converted_list)
    compare_direct = @flight_finder.shortest_or_cheapest_direct(direct_flights, @flight_finder.check_direct_duration(direct_flights))
  end

  def indirect_flight_duration(list)
    first_leg_fastest = @flight_finder.fastest_first_leg(@flight_finder.find_first_leg(list))
    second_leg_fastest = @flight_finder.fastest_second_leg(@flight_finder.find_second_leg(list))
    third_leg_fastest = @flight_finder.fastest_third_leg(@flight_finder.find_third_leg(list))
    indirect_duration = @flight_finder.find_indirect_duration(first_leg_fastest, second_leg_fastest, third_leg_fastest)
  end

  def indirect_itinerary(list)
    first_leg_fastest = @flight_finder.fastest_first_leg(@flight_finder.find_first_leg(list))
    second_leg_fastest = @flight_finder.fastest_second_leg(@flight_finder.find_second_leg(list))
    third_leg_fastest = @flight_finder.fastest_third_leg(@flight_finder.find_third_leg(list))
    total_price = @flight_finder.find_total_price(first_leg_fastest, second_leg_fastest, third_leg_fastest)
    indirect_itinerary = @flight_finder.combine_indirect_flights(first_leg_fastest, third_leg_fastest, total_price)
  end

  def indirect_price(list)
    first_leg_fastest = @flight_finder.fastest_first_leg(@flight_finder.find_first_leg(list))
    second_leg_fastest = @flight_finder.fastest_second_leg(@flight_finder.find_second_leg(list))
    third_leg_fastest = @flight_finder.fastest_third_leg(@flight_finder.find_third_leg(list))
    indirect_price = @flight_finder.find_total_price(first_leg_fastest, second_leg_fastest, third_leg_fastest)
  end

  def get_flights(file)
  	flights_array = []
  	csv_data = CSV.foreach(file) do |row|
        if row[1] != nil
             flight = Flight.new(row)
  	         flights_array << flight
        elsif row.empty?
          flights_array << row 
        end
  	end
    flights_array
	end

  def get_block(original_file)
      flights_block = []
     original_file.each do |flight| 
        flights_block << flight
        break if flight == []
      end
    flights_block
  end
end