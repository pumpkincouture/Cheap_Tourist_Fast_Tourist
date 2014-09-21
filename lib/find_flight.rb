require_relative 'flight_builder'

class FindFlight

	def convert_price_to_integer(flight_list)
		new_list = flight_list.clone
		new_list.each do |flight|
		  flight.price = flight.convert_price 
		end
	end

	def find_all_durations(converted_list)
		converted_list.each do |flight|
			flight.duration = flight.find_duration
		end
	end

	def find_direct_flights(converted_list)
	  converted_list.select{|flight| flight.no_lay_over}
	end

	def find_first_leg(converted_list)
	 converted_list.select{|flight| flight.lay_over_one }
	end

	def find_second_leg(converted_list)
		converted_list.select{|flight| flight.lay_over_two }
	end

	def find_third_leg(converted_list)
		converted_list.select{|flight| flight.lay_over_three }
	end

	def gather_legs(first_leg, second_leg, third_leg)
		flights = []
		second_leg_number = -1 
		third_leg_number = -1

		first_leg.each {|leg| flights << [leg, second_leg[second_leg_number += 1], third_leg[third_leg_number += 1]].flatten}
		flights
	end

	def delete_nil(flights_array)
		flights_array.each do |array|
			if array.include? nil 
			  array.delete(nil)
			else
			  flights_array
		  end
		end
	end

	def create_itinerary(flights_array)
		itineraries = []
		flights_array.each do |array|
			itineraries << FlightBuilder.new(array)
		end
		itineraries

	end

	def pick_for_jen(direct_flight_pick, indirect_flight_duration, indirect_flight)
		if direct_flight_pick == []
			indirect_flight
		elsif direct_flight_pick.get_duration <= indirect_flight_duration
			direct_flight_pick
		else
			indirect_flight
		end
	end

	def pick_for_steve(direct_flight_pick, indirect_flight_price, indirect_flight)
		if direct_flight_pick == []
			indirect_flight
		elsif direct_flight_pick.get_price <= indirect_flight_price
			direct_flight_pick
		else
			indirect_flight
		end
	end
end