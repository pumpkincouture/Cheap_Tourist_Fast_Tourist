require '../lib/find_flight.rb'
require '../lib/flight.rb'
require '../lib/travel_finder.rb'
require_relative 'flight_mock'

RSpec.configure do |config|
  config.failure_color = :red
  config.success_color = :green
  config.detail_color = :yellow
  config.tty = true
  config.color = true
  config.formatter = :documentation
end