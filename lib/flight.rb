class Flight
  include Comparable

  attr_accessor :origin, :destination, :departure, :arrival, :price

  def initialize(list)
  	@origin = list[0]
  	@destination = list[1]
  	@departure = list[2]
  	@arrival = list[3]
  	@price = list[4]
  end

  def no_lay_over
    @origin == "A" && @destination == "Z"
  end

  def lay_over
    @origin != "A" || @destination != "Z"
  end
  
  def find_fast_flight
    @arrival - @departure <= 16.00
  end

  def find_other_cheap(other_flight)
    @price == other_flight.price 
  end

  def check_origin(other_flight)
    @origin || other_flight.origin == "A"
  end

  def check_destination(other_flight)
    @destination || other_flight.destination == "Z"
  end

  def compare_fast(other_flight)

  
  end
end