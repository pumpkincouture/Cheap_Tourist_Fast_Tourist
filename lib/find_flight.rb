require_relative 'flight'
class FindFlight
	# include Comparable

	def sort_by_cheap(list)
		sorted_list = list.sort_by(&:price)
	end

	# def multiple_cheap_flights(list)
	#   same_flight = list.group_by{|flight| flight.price }.values.select{|price| price.count > 1 }
	# 	p same_flight
	# end

	def find_direct_flights(sorted_list)
	 direct_flights = sorted_list.select{|flight| flight.no_lay_over}
	end

	def find_indirect_flights(sorted_list)
		indirect_flights = sorted_list.select{|flight| flight.lay_over}
	end

	# def pick_cheaper_flight(direct_flights, )

	# def pick_shorter_flight()
	# end
	# def find_cheap_flight(list)

	# 		p list[0].compare_cheap(list[2])
	# 	# end		
	# end

	# # def find_fast_flight(list)
	# end
end