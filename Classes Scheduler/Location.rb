# @author Victor Madelaine & Laxman Katneni

require 'geocoder'

class Location 
    # Created 10/11/2023 by Victor Madelaine
    BUILDINGLOCATIONS = {
        "Hitchcock Hall": Geocoder.coordinates("Hitchcock Hall Ohio"),
        "Mendenhall Laboratory": Geocoder.coordinates("Mendenhall Laboratory Ohio"),
        "Caldwell Laboratory": Geocoder.coordinates("Caldwell Laboratory Ohio"),
        "Baker Systems Engineering": Geocoder.coordinates("Baker Systems Engineering Ohio"),
        "Dreese Laboratory": Geocoder.coordinates("Dreese Laboratory Ohio"),
        "Scott Laboratory" => Geocoder.coordinates("Scott Laboratory Ohio"),
        "Smith Laboratory" => Geocoder.coordinates("Smith Laboratory Ohio"),
        "Chemical and Biomolecular Engineering and Chemistry Building" => Geocoder.coordinates("Chemical and Biomolecular Engineering and Chemistry Building Ohio"),
        "Enarson Classroom Building" => Geocoder.coordinates("Enarson Classroom Building Ohio"),
        "Journalism Building" => Geocoder.coordinates("Journalism Building Ohio"),
        "Knowlton Hall" => Geocoder.coordinates("Knowlton Hall Ohio"),
        "Psychology Building" => Geocoder.coordinates("Psychology Building Ohio"),
        "Pomerene Hall" => Geocoder.coordinates("Pomerene Hall Ohio"),
        "Ramseyer Hall" => Geocoder.coordinates("Ramseyer Hall Ohio"),
        "Cockins Hall" => Geocoder.coordinates("Cockins Hall Ohio"),
        "Enarson Hall" => Geocoder.coordinates("Enarson Hall Ohio"),
        "Hagerty Hall" => Geocoder.coordinates("Hagerty Hall Ohio"),
        "Arps Hall" => Geocoder.coordinates("Arps Hall Ohio"),
        "Derby Hall" => Geocoder.coordinates("Derby Hall Ohio"),
        "Bolz Hall" => Geocoder.coordinates("Bolz Hall Ohio"),
        "Townshend Hall" => Geocoder.coordinates("Townshend Hall Ohio"),
        "Schoenbaum Hall" => Geocoder.coordinates("Schoenbaum Hall Ohio"),
        "Fontana Laboratory" => Geocoder.coordinates("Fontana Laboratory Ohio"),
        "Hopkins Hall" => Geocoder.coordinates("Hopkins Hall Ohio"),
        "Evans Laboratory" => Geocoder.coordinates("Evans Laboratory Ohio"),
        "University Hall" => Geocoder.coordinates("University Hall Ohio"),
        "McPherson Laboratory" => Geocoder.coordinates("McPherson Laboratory Ohio")
    }

    # Created 09/29/2023 by Lucky Katneni           
    def initialize name, address = nil
        @name = name
        @address = address
        if BUILDINGLOCATIONS.has_key? name
            @coordinates = BUILDINGLOCATIONS[name]
        else
            @coordinates = Geocoder.coordinates "#{name} Ohio"
        end
    end

    attr_accessor :name, :address, :coordinates

    # Created 09/29/2023 by Lucky Katneni
    # gets the coordinates of self
    # @return array of coordinates
    def selfCoordinates
        coordinates = Geocoder.coordinates @address
        raise "Unable to obtain coordinates for #{@address}" unless coordinates
        coordinates
    end

    # Created 09/29/2023 by Lucky Katneni
    # gets the coordinates of [location]
    # @param location   location object to get the coordinates from
    # @return array of coordinates
    def locationCoordinates location
        coordinates = Geocoder.coordinates location.address
        raise "Unable to obtain coordinates for #{location.address}" unless coordinates
        coordinates
    end


    # Created 09/29/2023 by Lucky Katneni
    # calculates the distance between self and [location] using [formula]
    # @param location   location object to get the distance from
    # @param formula    formula to calculate the distance
    # @return floating point number in the hundredths for the distance between self and [location]
    def calculateDistance location, formula
        Geocoder::Calculations.distance_between @coordinates, location.coordinates, formula: formula
    end


    # Created 09/29/2023 by Lucky Katneni
    # returns the walking distance between self and [location]
    # @param location   location object to get the distance from
    # @return floating point number in the hundredths for the walking distance between self and [location]
    def walkingDistance location
        calculateDistance location, :haversine
        # :haversine is the formula for walking distance as it is the most accurate for straightlines
    end

    # Created 09/29/2023 by Lucky Katneni
    # returns the biking or Driving distance between self and [location]
    # @param location   location object to get the distance from
    # @return floating point number in the hundredths for the biking or driving distance between self and [location]
    def bikingorDrivingDistance location
        calculateDistance location, :spherical
        # :spherical is the formula for driving distance as it kinda accounts for turns even though its not too accurate
    end

    # Created 10/06/2023 by Victor Madelaine
    # Edited 10/09/2023 by Victor Madelaine (round answer for ease of display)
    # returns the time needed to walk from self to location in minutes
    # @param location   location object to get the time difference from
    # @return floating point number in the hundredths for the walking distance in minutes
    def walkingTime location
        (((self.walkingDistance location) / 3) * 60).round(2)
    end

    # Created 10/06/2023 by Victor Madelaine
    # Edited 10/09/2023 by Victor Madelaine (round answer for ease of display)
    # returns the time needed to bike from self to location in minutes
    # @param location   location object to get the time difference from
    # @return floating point number in the hundredths for the biking distance in minutes
    def bikingTime location
        (((self.bikingorDrivingDistance location) / 12.5) * 60).round(2)
    end

    # Created 10/06/2023 by Victor Madelaine
    # Edited 10/09/2023 by Victor Madelaine (round answer for ease of display)
    # returns the time needed to drive from self to location in minutes
    # @param location   location object to get the time difference from
    # @return floating point number in the hundredths for the driving distance in minutes
    def drivingTime location
        (((self.bikingorDrivingDistance location) / 18.5) * 60).round(2)
    end
end
