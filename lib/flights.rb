class Flights

  attr_reader :origin, :destination, :departure, :arrival, :price

  def initialize(list)
  	@origin = list[0]
  	@destination = list[1]
  	@departure = list[2]
  	@arrival = list[3]
  	@price = list[4]
  end

  

end



