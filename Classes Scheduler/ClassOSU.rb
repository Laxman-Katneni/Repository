# @Team Run-time-terror - Victor Madelaine, Jason Su, Laxman Katneni, Khushi Patel, Landon McElroy

require_relative "Event"
require_relative "Location"
require_relative "Schedule"

class ClassOSU 

    def initialize *args
        if args.length == 3
            # Class object initialization for asynchronous class. 
            # @param args[0] className          String for the name of the class
            # @param args[1] classSection        Integer for the class number
            # @param args[2] instructor         String for instructor's name
            @className = args[0]
            @classSection = args[1]
            @event = nil
            @location = nil
            @instructor = args[2]

        elsif args.length == 4
            # Class object initialization for testing. 
            # @param args[0] className  String for the name of the class
            # @param args[1] startTime  String for the time class starts setup as "HH:MM"
            # @param args[2] endTime    String for the time class ends setup as "HH:MM"
            # @param args[3] days       Array of strings which is a subset of ["monday", "tuesday", "wednesday", "thursday", "friday"]
            @className = args[0]
            @classSection = nil
            @event = Event.new args[1], args[2], args[3]
            @location = nil
            @instructor = nil
        elsif args.length == 5
            # Class object initialization with premade Event object. 
            # @param args[0] className          String for the name of the class
            # @param args[1] classSection        Integer for the class number
            # @param args[2] event              Event object (see documentation in Event.rb)
            # @param args[3] locationName       String with name of building
            # @param args[4] instructor         String for instructor's name
            @className = args[0]
            @classSection = args[1]
            @event = args[2]
            @location = Location.new args[3]
            @instructor = args[4]
        elsif args.length == 7
            # Class object initialization with Event object made within. 
            # @param args[0] className          String for the name of the class
            # @param args[1] classSection        Integer for the class number
            # @param args[2] startTime          String for the time class starts setup as "HH:MM"
            # @param args[3] endTime            String for the time class ends setup as "HH:MM"
            # @param args[4] days               Array of strings which is a subset of ["monday", "tuesday", "wednesday", "thursday", "friday"]
            # @param args[5] locationName       String with name of building
            # @param args[6] instructor         String for instructor's name
            @className = args[0]
            @classSection = args[1]
            @event = Event.new args[2], args[3], args[4]
            @location = Location.new args[5]
            @instructor = args[6]
        elsif args.length == 8
            # Class object initialization with Event object made within. 
            # @param args[0] className          String for the name of the class
            # @param args[1] classSection        Integer for the class number
            # @param args[2] startTime          String for the time class starts setup as "HH:MM"
            # @param args[3] endTime            String for the time class ends setup as "HH:MM"
            # @param args[4] days               Array of strings which is a subset of ["monday", "tuesday", "wednesday", "thursday", "friday"]
            # @param args[5] locationName       String with name of building
            # @param args[6] instructor         String for instructor's name
            @className = args[0]
            @classSection = args[1]
            @event = Event.new args[2], args[3], args[4]
            @location = Location.new args[5]
            @instructor = args[6]
            @description = args[7]
        end
    end

    attr_accessor :className, :classSection, :event, :location, :instructor, :description
      

    # method used to put classes into a hash map by class number with values from classInfo
    # @param classes array of classes
    # @return classMap hash map of classes
    def classHash classes
        classMap = {}
        classes.each do |c|
          classNum = c.classSection
          # create an empty array if the class number doesn't exist in the map
          classMap[classNum] ||= []
          # add the class to the class number's array in the map
          classMap[classNum] << c
        end
        classMap
      end
end
