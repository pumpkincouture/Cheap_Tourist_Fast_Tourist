require_relative 'spec_helper'

describe "TravelFinder" do
	list = '../data/Simple-input.csv'
	
	before :each do 
		@travel_finder = TravelFinder.new(@flight_finder)
	end

	it "returns a flight list" do
		expect(@travel_finder.get_flights(list)[1].origin).to eq("A")
		expect(@travel_finder.get_flights(list)[2].destination).to eq("Z")
		expect(@travel_finder.get_flights(list)[4].departure).to eq("11:30")
	end

	xit "returns a cleaned up list" do
		expect(@travel_finder.delete_whitespace(@travel_finder.get_flights(list))[0].origin).to eq("2")
	  expect(@travel_finder.delete_whitespace(@travel_finder.get_flights(list))[1].origin).to eq("3")
	  expect(@travel_finder.delete_whitespace(@travel_finder.get_flights(list))[2].origin).to eq("A")
	end
end