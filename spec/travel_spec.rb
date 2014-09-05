require_relative '../lib/travel_finder.rb'
require_relative '../lib/flights.rb'
require_relative 'spec_helper.rb'

describe "TravelFinder" do
	list = './lib/sample-input.csv'
	
	before :each do 
		@travel_finder = TravelFinder.new
	end

	it "returns a flight list" do
		expect(@travel_finder.get_flights(list)[3].origin).to eq("A")
		expect(@travel_finder.get_flights(list)[3].destination).to eq("B")
		expect(@travel_finder.get_flights(list)[4].departure).to eq("11:30")
	end
end