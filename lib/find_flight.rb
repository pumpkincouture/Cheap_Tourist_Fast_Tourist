class FindFlight

	def find_cheap_flight(list)
		list.each do |flight|
		  cheap_flight = list.select { |other_flight| flight.compare_cheap(other_flight) }
		end
		# p cheap_flight
	end

	def find_fast_flight(list)
	end
end