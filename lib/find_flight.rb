class FindFlight

	def convert_time_to_integer(flight_list)
		converted_list = flight_list.clone
		converted_list.each do |flight|
			flight.departure = flight.convert_departure
			flight.arrival = flight.convert_arrival
		end
	end

	def convert_price_to_integer(convert_time)
		convert_time.each do |flight|
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

	def check_direct_duration(direct_flights)
		length = 0
		direct_flights.each do |flight|
		  same = direct_flights.select{ |other_flight| flight.find_same_duration(other_flight) }
		  same.delete(flight)
		 	length += same.count
		end
		length
	end

	def shortest_or_cheapest_direct(direct_flights, direct_duration) 
    if direct_duration >= 0
      cheapest = direct_flights.min {|flight, other_flight| flight.price <=> other_flight.price }
		else
    	shortest = direct_flights.min {|flight, other_flight| flight.duration <=> other_flight.duration }
		end
	end

	def fastest_first_leg(first_leg)
		first_leg.min{|flight, other_flight| flight.duration <=> other_flight.duration }
	end

	def fastest_second_leg(second_leg)
		return [] if second_leg.empty?
		second_leg.min{|flight, other_flight| flight.duration <=> other_flight.duration } 
	end

	def fastest_third_leg(third_leg)
		third_leg.min{|flight, other_flight| flight.duration <=> other_flight.duration }
	end

	def cheapest_and_fastest_first_leg(fastest_first_leg, first_leg)
		first_leg.min{|flight, other_flight| flight.price <=> other_flight.price } && fastest_first_leg
	end

	def cheapest_and_fastest_second_leg(fastest_second_leg, second_leg)
    return [] if second_leg.empty?
    second_leg.min{|flight, other_flight| flight.price <=> other_flight.price } && fastest_second_leg
	end

	def cheapest_and_fastest_third_leg(fastest_third_leg, third_leg)
		third_leg.min{|flight, other_flight| flight.price <=> other_flight.price } && fastest_third_leg
	end

	def find_indirect_duration(fastest_first_leg, fastest_second_leg, fastest_third_leg)			
		if fastest_second_leg.empty?
			total_time = fastest_first_leg.get_duration + fastest_third_leg.get_duration
		else
			total_time_with_second_leg = fastest_first_leg.get_duration + fastest_second_leg.get_duration + fastest_third_leg.get_duration
		end
	end

	def find_total_price(fastest_first_leg, fastest_second_leg, fastest_third_leg)
		if fastest_second_leg.empty?
		  total_price = fastest_first_leg.get_price + fastest_third_leg.get_price
		 else
		 	total_price = fastest_first_leg.get_price + fastest_second_leg.get_price + fastest_third_leg.get_price
		end
	end

	def combine_indirect_flights(first_leg, second_leg, total_price)  
		"#{first_leg.get_departure} " +  "#{second_leg.get_arrival} " + "#{total_price}"
	end

	def pick_for_jen(direct_flight_pick, indirect_flight_duration, indirect_flight)
		if direct_flight_pick.get_duration <= indirect_flight_duration
			direct_flight_pick
		else
			indirect_flight
		end
	end

	def pick_for_steve(direct_flight_pick, indirect_flight_price, indirect_flight)
		if direct_flight_pick.get_price <= indirect_flight_price
			direct_flight_pick
		else
			indirect_flight
		end
	end
end