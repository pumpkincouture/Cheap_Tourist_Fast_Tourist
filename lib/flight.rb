require 'time'

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

  def convert_price
    @price.tr(',','').to_i 
  end

  def find_duration
    minute = 60
    hour = 60.0
    (Time.parse(@arrival) - Time.parse(@departure)) / minute / hour
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
end