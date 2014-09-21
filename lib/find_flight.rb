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

	def check_direct_duration(direct_flights)
		return [] if direct_flights.empty?
		length = 0
		direct_flights.each do |flight|
		  same = direct_flights.select{ |other_flight| flight.find_same_duration(other_flight) }
		  same.delete(flight)
		 	length += same.count
		end
		length
	end

	def shortest_or_cheapest_direct(direct_flights, direct_duration) 
		if direct_flights.empty?
			return []
    elsif direct_duration >= 0
      cheapest = direct_flights.min {|flight, other_flight| flight.price <=> other_flight.price }
		elsif direct_duration <=0
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

	def cheapest_first_leg(first_leg)
		first_leg.min{|flight, other_flight| flight.price <=> other_flight.price }
	end

	def cheapest_second_leg(second_leg)
    return [] if second_leg.empty?
    second_leg.min{|flight, other_flight| flight.price <=> other_flight.price }
	end

	def cheapest_third_leg(third_leg)
		third_leg.min{|flight, other_flight| flight.price <=> other_flight.price }
	end

	def find_indirect_duration(first_leg, second_leg, third_leg)			
		if second_leg == []
			total_time = first_leg.get_duration + third_leg.get_duration
		elsif second_leg == third_leg
			total_time_with_second_leg = first_leg.get_duration + second_leg.get_duration
		elsif third_leg.get_departure == "B" && third_leg.get_arrival == "Z"
			total_time = first_leg.get_duration + third_leg.get_duration
		else
			total_time_with_second_leg = first_leg.get_duration + second_leg.get_duration + third_leg.get_duration
		end
	end

	def find_total_price(first_leg, second_leg, third_leg)
		if second_leg == []
		  total_price = first_leg.get_price + third_leg.get_price
		 elsif second_leg == third_leg
		 	total_price = first_leg.get_price + second_leg.get_price
		 elsif third_leg.get_departure == "B" && third_leg.get_arrival == "Z"
		 	total_price = first_leg.get_price + third_leg.get_price
		 else
		 	total_price = first_leg.get_price + second_leg.get_price + third_leg.get_price
		end
	end

	def combine_indirect_flights(first_leg, second_leg, total_price)  
		"#{first_leg.get_departure} " +  "#{second_leg.get_arrival} " + "#{total_price}"
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