# Created 09/30/2023 by Lucky Katneni
# Edited 10/01/2023 by Lucky Katneni (Implemented Test Cases for all the methods in Location)

require 'test/unit'
require_relative '../Location'

class TestLocation < Test::Unit::TestCase
    
    # test initialize method
    def testInitialize
        location = Location.new("Hitchcock Hall", "2070 Neil Ave, Columbus, OH 43210")

        assert_equal("Hitchcock Hall", location.name)
        assert_equal("2070 Neil Ave, Columbus, OH 43210", location.address)
    end

    # test location_coordinates method
    def testLocationCoordinates
        location1 = Location.new "Hitchcock Hall", "2070 Neil Ave, Columbus, OH 43210"

        # Check if the coordinates are correct
        assert_equal([40.003957, -83.01581], location1.locationCoordinates(location1))
    end

    # test self_coordinates method
    def testCalculateDistance
        location1 = Location.new("Hitchcock Hall", "2070 Neil Ave, Columbus, OH 43210")
        location2 = Location.new("Dreese Laboratories", "2015 Neil Ave, Columbus, OH 43210")

        # Using assertindelta to account for the fact that the distance is not exact
        assert_in_delta(0.093, location1.calculateDistance(location2, :haversine), 0.15)
    end

    def testWalkingDistance
        location1 = Location.new("Hitchcock Hall", "2070 Neil Ave, Columbus, OH 43210")
        location2 = Location.new("Dreese Laboratories", "2015 Neil Ave, Columbus, OH 43210")

        # Using assertindelta to account for the fact that the distance is not exact
        assert_in_delta(0.093, location1.walkingDistance(location2), 0.15)
    end

    def testBikingorDrivingDistance
        location1 = Location.new("Hitchcock Hall", "2070 Neil Ave, Columbus, OH 43210")
        location2 = Location.new("Dreese Laboratories", "2015 Neil Ave, Columbus, OH 43210")

        assert_in_delta(0.093, location1.bikingorDrivingDistance(location2), 0.15)
        # Using assertindelta to account for the fact that the distance is not exact
    end
end