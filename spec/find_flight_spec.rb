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

	xit "returns a sorted list by cheap flight" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)

		expect(@flight_finder.sort_by_cheap(refine_data)[-1].price).to eq("400.00")
	end

	it "converts time into integers" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)

		expect(@flight_finder.convert_time_to_integer(refine_data)[0].arrival).to eq(1000)
	end

	it "converts price into integers" do
	  get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)
		convert_time = @flight_finder.convert_time_to_integer(refine_data)

		expect(@flight_finder.convert_price_to_integer(convert_time)[0].price).to eq(100)
	end

	it "finds all flight durations" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)
		convert_time = @flight_finder.convert_time_to_integer(refine_data)
		convert_price = @flight_finder.convert_price_to_integer(convert_time)

		expect(@flight_finder.find_all_durations(convert_time)[0].duration).to eq(100)
	end

	it "returns direct flights" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)
		convert_time = @flight_finder.convert_time_to_integer(refine_data)
		convert_price = @flight_finder.convert_price_to_integer(convert_time)
		all_durations = @flight_finder.find_all_durations(convert_price)

		expect(@flight_finder.find_direct_flights(all_durations)[0].price).to eq(300)
	end

	it "returns first leg of indirect flight" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)
		convert_time = @flight_finder.convert_time_to_integer(refine_data)
		convert_price = @flight_finder.convert_price_to_integer(convert_time)
		all_durations = @flight_finder.find_all_durations(convert_price)
		
	  expect(@flight_finder.find_first_leg(all_durations)[0].price).to eq(100)		
	end

	it "returns second leg of indirect flight" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)
		convert_time = @flight_finder.convert_time_to_integer(refine_data)
		convert_price = @flight_finder.convert_price_to_integer(convert_time)
		all_durations = @flight_finder.find_all_durations(convert_price)

		expect(@flight_finder.find_second_leg(all_durations)).to eq([])
	end

	it "returns third leg of indirect flight" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)
		convert_time = @flight_finder.convert_time_to_integer(refine_data)
		convert_price = @flight_finder.convert_price_to_integer(convert_time)
		all_durations = @flight_finder.find_all_durations(convert_price)

	  expect(@flight_finder.find_third_leg(all_durations)[0].price).to eq(100)
	end

	it "finds how many flights have the same duration" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)
		convert_time = @flight_finder.convert_time_to_integer(refine_data)
		convert_price = @flight_finder.convert_price_to_integer(convert_time)
		all_durations = @flight_finder.find_all_durations(convert_price)
		direct_flights = @flight_finder.find_direct_flights(all_durations)

		expect(@flight_finder.check_direct_duration(direct_flights)).to eq(2)
	end

	it "returns shortest direct flight" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)
		convert_time = @flight_finder.convert_time_to_integer(refine_data)
		convert_price = @flight_finder.convert_price_to_integer(convert_time)
		all_durations = @flight_finder.find_all_durations(convert_price)
		direct_flights = @flight_finder.find_direct_flights(all_durations)
		direct_duration = @flight_finder.check_direct_duration(direct_flights)

		expect(@flight_finder.shortest_or_cheapest_direct(direct_flights, direct_duration).duration).to eq(200)
	end

	it "finds fastest first leg flight" do 
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)
		convert_time = @flight_finder.convert_time_to_integer(refine_data)
		convert_price = @flight_finder.convert_price_to_integer(convert_time)
		all_durations = @flight_finder.find_all_durations(convert_price)
		first_leg = @flight_finder.find_first_leg(all_durations)

		expect(@flight_finder.fastest_first_leg(first_leg).duration).to eq(100)
	end

	it "finds fastest second leg flight" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)
		convert_time = @flight_finder.convert_time_to_integer(refine_data)
		convert_price = @flight_finder.convert_price_to_integer(convert_time)
		all_durations = @flight_finder.find_all_durations(convert_price)
		second_leg = @flight_finder.find_second_leg(all_durations)
	
		expect(@flight_finder.fastest_second_leg(second_leg)).to eq([])
	end

  it "finds fastest third leg flight" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)
		convert_time = @flight_finder.convert_time_to_integer(refine_data)
		convert_price = @flight_finder.convert_price_to_integer(convert_time)
		all_durations = @flight_finder.find_all_durations(convert_price)
		third_leg = @flight_finder.find_third_leg(all_durations)

		expect(@flight_finder.fastest_third_leg(third_leg).duration).to eq(200)
	end

	xit "finds the fastest indirect flight" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)
		convert_time = @flight_finder.convert_time_to_integer(refine_data)
		convert_price = @flight_finder.convert_price_to_integer(convert_time)
		all_durations = @flight_finder.find_all_durations(convert_price)
		first_leg = @flight_finder.find_first_leg(all_durations)
	  second_leg = @flight_finder.find_second_leg(all_durations)
		third_leg = @flight_finder.find_third_leg(all_durations)
		first_leg_fastest = @flight_finder.fastest_first_leg(first_leg)
		second_leg_fastest = @flight_finder.fastest_second_leg(second_leg)
		third_leg_fastest = @flight_finder.fastest_third_leg(third_leg)

		expect(@flight_finder.combine_indirect_flights(first_leg_fastest, second_leg_fastest, third_leg_fastest).duration).to eq(500)
	end

it "finds total duration of indirect flights" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)
		convert_time = @flight_finder.convert_time_to_integer(refine_data)
		convert_price = @flight_finder.convert_price_to_integer(convert_time)
		all_durations = @flight_finder.find_all_durations(convert_price)
		first_leg = @flight_finder.find_first_leg(all_durations)
	  second_leg = @flight_finder.find_second_leg(all_durations)
		third_leg = @flight_finder.find_third_leg(all_durations)
		first_leg_fastest = @flight_finder.fastest_first_leg(first_leg)
		second_leg_fastest = @flight_finder.fastest_second_leg(second_leg)
		third_leg_fastest = @flight_finder.fastest_third_leg(third_leg)

		expect(@flight_finder.find_total_duration(first_leg_fastest, second_leg_fastest, third_leg_fastest)).to eq(300)
	end

it "finds total price of indirect flights" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)
		convert_time = @flight_finder.convert_time_to_integer(refine_data)
		convert_price = @flight_finder.convert_price_to_integer(convert_time)
		all_durations = @flight_finder.find_all_durations(convert_price)
		first_leg = @flight_finder.find_first_leg(all_durations)
	  second_leg = @flight_finder.find_second_leg(all_durations)
		third_leg = @flight_finder.find_third_leg(all_durations)
		first_leg_fastest = @flight_finder.fastest_first_leg(first_leg)
		second_leg_fastest = @flight_finder.fastest_second_leg(second_leg)
		third_leg_fastest = @flight_finder.fastest_third_leg(third_leg)

		expect(@flight_finder.find_total_price(first_leg_fastest, second_leg_fastest, third_leg_fastest)).to eq(300)
end

it "compares direct flight times with indirect flight times" do
		get_list = @travel_finder.get_flights(list)
		refine_data = @travel_finder.delete_whitespace(get_list)
		convert_time = @flight_finder.convert_time_to_integer(refine_data)
		convert_price = @flight_finder.convert_price_to_integer(convert_time)
		all_durations = @flight_finder.find_all_durations(convert_price)
		direct_flights = @flight_finder.find_direct_flights(all_durations)
		direct_duration = @flight_finder.check_direct_duration(direct_flights)
		shortest_or_cheapest = @flight_finder.shortest_or_cheapest_direct(direct_flights, direct_duration)
		first_leg = @flight_finder.find_first_leg(all_durations)
	  second_leg = @flight_finder.find_second_leg(all_durations)
		third_leg = @flight_finder.find_third_leg(all_durations)
		first_leg_fastest = @flight_finder.fastest_first_leg(first_leg)
		second_leg_fastest = @flight_finder.fastest_second_leg(second_leg)
		third_leg_fastest = @flight_finder.fastest_third_leg(third_leg)
		indirect_flight_duration = @flight_finder.find_total_duration(first_leg_fastest, second_leg_fastest, third_leg_fastest)

		expect(@flight_finder.pick_for_jen(shortest_or_cheapest, indirect_flight_duration).price).to eq(300)
	end
end