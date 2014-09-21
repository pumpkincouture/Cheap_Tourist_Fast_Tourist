require 'csv'
require_relative 'find_flight'
require_relative 'flight'

class TravelFinder

  def initialize(flight_finder)
    @flight_finder = flight_finder
  end

  def find_flights!(file)
    flight_list = get_flights(file)
    converted_list = @flight_finder.convert_price_to_integer(flight_list)

    display_steve(steve_pick(converted_list))
    display_jen(jen_pick(converted_list))
  end

  def display_steve(steves_pick)
    if steves_pick.is_a? String
      puts steves_pick
    else
      puts "#{steves_pick.get_departure} " + "#{steves_pick.get_arrival} " + "#{total_price}" 
    end
  end  

  def display_jen(jens_pick)
    if jens_pick.is_a? String
      puts jens_pick
    else
      puts "#{jens_pick.get_departure} " + "#{jens_pick.get_arrival} " + "#{jens_pick.get_price}" 
    end
  end


  def get_flights(file)
    flights_array = []
    csv_data = CSV.foreach(file) do |row|
        if row[1] != nil
             flight = Flight.new(row)
             flights_array << flight
        elsif row.empty?
          flights_array << row 
        end
    end
    flights_array
  end

  def get_block(original_file)
      flights_block = []
     original_file.each do |flight| 
        flights_block << flight
        break if flight == []
      end
    flights_block
  end
end