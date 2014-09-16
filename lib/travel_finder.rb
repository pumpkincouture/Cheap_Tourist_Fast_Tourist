require 'csv'
require_relative 'find_flight'
require_relative 'flight'

class TravelFinder

	def initialize(flight_finder)
    @flight_finder = flight_finder
	end

  def find_flights!(file)
    # get_info = get_flights(file)
    # refine_list = refine_list(get_info)
    # block = get_block(get_info)


    # block.each do |block|
    #   p block
    # end
     
      
    # end       
    # end
    
    # end
    # print_white(get_info)
    # refine_data = delete_whitespace(get_info)
    # sort_list = @flight_finder.sort_by_cheap(refine_data)
    # converted_list = @flight_finder.convert_time_to_integer(refine_data)
    # @flight_finder.find_direct_flights(converted_list)
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






  # def refine_list(flight_list)
  #   flight_block = []
  #   flight_blank = []
  #   # p flight_list
  #   flight_list.each do |row|
  #     if row != []
  #         flight_block << row
  #     elsif row == []
  #       flight_blank << row
  #     end
  #   end
  #   p flight_block
  # end

  def delete_whitespace(list)
    list.each do |row|
      list.delete(row) if row.destination && row.departure== nil
    end
    list
  end


  def print_white(list)
    p list[0].destination
  end
end