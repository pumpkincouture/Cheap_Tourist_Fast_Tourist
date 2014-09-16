class Flight

  attr_reader :origin, :destination
  attr_accessor :duration, :departure, :price, :arrival

  def initialize(list)
  	@origin = list[0]
  	@destination = list[1]
  	@departure = list[2]
  	@arrival = list[3]
  	@price = list[4]
  end

  def convert_departure
    @departure.delete(":").to_i
  end

  def convert_arrival
    @arrival.delete(":").to_i
  end

  def convert_price
    # new_price = @price.delete(".").to_i
    @price.tr(',','').to_i 
  end

  def find_duration
    @arrival - @departure
  end

  def no_lay_over
    @origin == "A" && @destination == "Z"
  end

  def lay_over_one
    @origin == "A" && @destination != "Z"
  end

  def lay_over_two
    @origin != "A" && @destination != "Z"
  end

  def lay_over_three
    @origin != "A" && @destination == "Z"
  end

  def get_departure
    @departure
  end

  def get_arrival
    @arrival
  end

  def get_price
    @price
  end

  def get_duration
    @duration 
  end

  def find_same_duration(other_flight)
    @duration == other_flight.duration
  end

  # def find_duration_difference(first_leg)
  #   @arrival - first_leg.departure
  # end
  
  # def find_fast_flight
  #   @arrival - @departure <= 16.00
  # end

  # def find_other_cheap(other_flight)
  #   @price == other_flight.price 
  # end

  # def check_origin(other_flight)
  #   @origin || other_flight.origin == "A"
  # end

  # def check_destination(other_flight)
  #   @destination || other_flight.destination == "Z"
  # end

  # def compare_fast(other_flight)

  
  # end
end