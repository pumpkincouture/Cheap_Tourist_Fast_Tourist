require '../lib/find_flight.rb'
require '../lib/flight.rb'
require '../lib/travel_finder.rb'
require_relative 'flight_mock'
require_relative 'spec_helper'

describe "FindFlight" do
  list = '../lib/Simple-input.csv'
	
	before :each do
		@flight_finder = FindFlight.new
		@travel_finder = TravelFinder.new(@flight_finder)
		@flight_mock = FlightMock.new
	end

	it "returns a sorted list by cheap flight" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)

		expect(@flight_finder.sort_by_cheap(refine_data)[-1].price).to eq("400.00")
	end

	xit "returns multiple cheap flights" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)
		sort_list = @flight_finder.sort_by_cheap(refine_data)

		expect(@flight_finder.multiple_cheap_flights(sort_list)[0][0].price).to eq("100.00")
	end

	it "returns direct flights" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)
		sorted_list = @flight_finder.sort_by_cheap(refine_data)

		expect(@flight_finder.find_direct_flights(sorted_list)[0].price).to eq("300.00")
	end

	it "returns indirect flights" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)
		sorted_list = @flight_finder.sort_by_cheap(refine_data)
	
	  expect(@flight_finder.find_indirect_flights(sorted_list)[0].price).to eq("100.00")		
	end
end