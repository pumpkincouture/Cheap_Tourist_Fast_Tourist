require_relative 'spec_helper'

describe "FindFlight" do
  list = '../data/test-cases.csv'
	
	before :each do
		@flight_finder = FindFlight.new
		@travel_finder = TravelFinder.new(@flight_finder)
		@flight_mock = FlightMock.new
	end
  
	it "converts price" do
	  get_list = @travel_finder.get_flights(list)

		expect(@flight_finder.convert_price_to_integer(get_list)[0].price).to eq(100)
	end

	it "finds flight durations" do
		get_list = @travel_finder.get_flights(list)
		convert_price = @flight_finder.convert_price_to_integer(get_list)

		expect(@flight_finder.find_all_durations(convert_price)[0].duration).to eq(1.0)
	end

	it "returns direct flights" do
    converted_list = @flight_finder.find_all_durations(@flight_finder.convert_price_to_integer(@travel_finder.get_flights(list)))

		expect(@flight_finder.find_direct_flights(converted_list)[0].price).to eq(300)
	end

	it "returns first leg" do
    converted_list = @flight_finder.find_all_durations(@flight_finder.convert_price_to_integer(@travel_finder.get_flights(list)))

		expect(@flight_finder.find_first_leg(converted_list)[0].price).to eq(100)		
	end

	it "returns second leg" do
    converted_list = @flight_finder.find_all_durations(@flight_finder.convert_price_to_integer(@travel_finder.get_flights(list)))

		expect(@flight_finder.find_second_leg(converted_list)[0].price).to eq(100)
	end

	it "returns third leg" do
    converted_list = @flight_finder.find_all_durations(@flight_finder.convert_price_to_integer(@travel_finder.get_flights(list)))

		expect(@flight_finder.find_third_leg(converted_list)[0].price).to eq(100)
	end

	it "combines flight legs" do
		get_list = @travel_finder.get_flights(list)
    converted_list = @flight_finder.find_all_durations(@flight_finder.convert_price_to_integer(@travel_finder.get_flights(list)))
    first_leg = @flight_finder.find_first_leg(converted_list)
		second_leg = @flight_finder.find_second_leg(converted_list)
		third_leg = @flight_finder.find_third_leg(converted_list)

		expect(@flight_finder.gather_legs(first_leg, second_leg, third_leg)).to be true
	end

	xit "picks for Jen" do
    converted_list = @flight_finder.find_all_durations(@flight_finder.convert_price_to_integer(@travel_finder.get_flights(list)))
		direct_flights = @flight_finder.find_direct_flights(converted_list)
		direct_flight_pick = @flight_finder.shortest_or_cheapest_direct(direct_flights, @flight_finder.check_direct_duration(direct_flights))
		indirect_flight_duration = @flight_finder.find_indirect_duration(@flight_finder.fastest_first_leg(@flight_finder.find_first_leg(converted_list)), @flight_finder.fastest_second_leg(@flight_finder.find_second_leg(converted_list)), @flight_finder.fastest_third_leg(@flight_finder.find_third_leg(converted_list)))
		total_price = @flight_finder.find_total_price(@flight_finder.fastest_first_leg(@flight_finder.find_first_leg(converted_list)), @flight_finder.fastest_second_leg(@flight_finder.find_second_leg(converted_list)), @flight_finder.fastest_third_leg(@flight_finder.find_third_leg(converted_list)))
		combined_itinerary = @flight_finder.combine_indirect_flights(@flight_finder.fastest_first_leg(@flight_finder.find_first_leg(converted_list)), @flight_finder.fastest_third_leg(@flight_finder.find_third_leg(converted_list)), total_price)

		expect(@flight_finder.pick_for_jen(direct_flight_pick, indirect_flight_duration, combined_itinerary).price).to eq(300)
	end

	xit "picks for Steve" do
    converted_list = @flight_finder.find_all_durations(@flight_finder.convert_price_to_integer(@travel_finder.get_flights(list)))
		direct_flights = @flight_finder.find_direct_flights(converted_list)
		direct_flight_pick = @flight_finder.shortest_or_cheapest_direct(direct_flights, @flight_finder.check_direct_duration(direct_flights))
		cheap_first_leg = @flight_finder.cheapest_first_leg(@flight_finder.find_first_leg(converted_list))
		cheap_second_leg = @flight_finder.cheapest_second_leg(@flight_finder.find_second_leg(converted_list))
		cheap_third_leg = @flight_finder.cheapest_third_leg(@flight_finder.find_third_leg(converted_list))
		indirect_flight_duration = @flight_finder.find_indirect_duration(cheap_first_leg, cheap_second_leg, cheap_third_leg)
		total_price = @flight_finder.find_total_price(cheap_first_leg, cheap_second_leg, cheap_third_leg)
		combined_itinerary = @flight_finder.combine_indirect_flights(cheap_first_leg, cheap_third_leg, total_price)

		expect(@flight_finder.pick_for_steve(direct_flight_pick, total_price, combined_itinerary)).to eq("09:00 16:30 175")
	end	
end