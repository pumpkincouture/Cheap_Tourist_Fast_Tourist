require 'csv'
require_relative 'find_flight'
require_relative 'flight'

class TravelFinder

	def initialize(flight_finder)
    @flight_finder = flight_finder
	end

  def find_flights!(file)
    flight_list = get_flights(file)
    converted_list = @flight_finder.convert_price_to_integer(flight_list)

    display_steve(steve_pick(converted_list))
    display_jen(jen_pick(converted_list))
  end

  def display_steve(steves_pick)
    if steves_pick.is_a? String
      puts steves_pick
    else
      puts "#{steves_pick.get_departure} " + "#{steves_pick.get_arrival} " + "#{total_price}" 
    end
  end  

  def display_jen(jens_pick)
    if jens_pick.is_a? String
      puts jens_pick
    else
      puts "#{jens_pick.get_departure} " + "#{jens_pick.get_arrival} " + "#{jens_pick.get_price}" 
    end
  end

  def steve_pick(list)
    @flight_finder.pick_for_steve(direct_flight_pick(list), cheapest_indirect_price(list), cheapest_indirect_itinerary(list))
  end

  def jen_pick(list)
    @flight_finder.pick_for_jen(direct_flight_pick(list), get_fastest_indirect(list), fastest_indirect_itinerary(list))
  end

  def direct_flight_pick(list)
    converted_list = @flight_finder.find_all_durations(list)
    direct_flights = @flight_finder.find_direct_flights(converted_list)
    direct_flight_choice = @flight_finder.shortest_or_cheapest_direct(direct_flights, @flight_finder.check_direct_duration(direct_flights))
  end

  def get_fastest_indirect(list)
    first_leg_fastest = @flight_finder.fastest_first_leg(@flight_finder.find_first_leg(list))
    second_leg_fastest = @flight_finder.fastest_second_leg(@flight_finder.find_second_leg(list))
    third_leg_fastest = @flight_finder.fastest_third_leg(@flight_finder.find_third_leg(list))
    indirect_duration = @flight_finder.find_indirect_duration(first_leg_fastest, second_leg_fastest, third_leg_fastest)
  end

  def fastest_indirect_itinerary(list)
    first_leg_fastest = @flight_finder.fastest_first_leg(@flight_finder.find_first_leg(list))
    second_leg_fastest = @flight_finder.fastest_second_leg(@flight_finder.find_second_leg(list))
    third_leg_fastest = @flight_finder.fastest_third_leg(@flight_finder.find_third_leg(list))
    total_price = @flight_finder.find_total_price(first_leg_fastest, second_leg_fastest, third_leg_fastest)
    indirect_itinerary = @flight_finder.combine_indirect_flights(first_leg_fastest, third_leg_fastest, total_price)
  end

  def cheapest_indirect_price(list)
    cheap_first_leg = @flight_finder.cheapest_first_leg(@flight_finder.find_first_leg(list))
    cheap_second_leg = @flight_finder.cheapest_second_leg(@flight_finder.find_second_leg(list))
    cheap_third_leg = @flight_finder.cheapest_third_leg(@flight_finder.find_third_leg(list))    
    cheapest_price = @flight_finder.find_total_price(cheap_first_leg, cheap_second_leg, cheap_third_leg)
  end

  def cheapest_indirect_itinerary(list)
    cheap_first_leg = @flight_finder.cheapest_first_leg(@flight_finder.find_first_leg(list))
    cheap_second_leg = @flight_finder.cheapest_second_leg(@flight_finder.find_second_leg(list))
    cheap_third_leg = @flight_finder.cheapest_third_leg(@flight_finder.find_third_leg(list))    
    cheapest_price = @flight_finder.find_total_price(cheap_first_leg, cheap_second_leg, cheap_third_leg)
    cheap_itinerary = @flight_finder.combine_indirect_flights(cheap_first_leg, cheap_third_leg, cheapest_price)
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