class FlightBuilder

	attr_reader :origin, :destination
	attr_accessor :flight_duration

	def initialize(array)
		@origin = array[0].origin
		@destination = array[-1].destination
	end

	def calculate_total_duration
		total_duration = 0
		total_duration += @duration
	end

	def calculate_total_price
		array.total_price = 0
		array.each {|flight| array.total_price += flight.price}
	end
end