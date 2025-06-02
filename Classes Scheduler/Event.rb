# Created 09/27/2023 by Victor Madelaine
# Edited 09/29/2023 by Lucky Katneni (implement event class - Overlaps)
# Edited 10/01/2023 by Lucky Katneni (Overlaps Edited and Created TimeParse)
# Edited 10/01/2023 by Victor Madelaine (implement spaceInBetween)
# Edited 10/04/2023 by Lucky Katneni (Created formatTime)

class Event 
    def initialize startTime, endTime, days
        @startTime = startTime
        @endTime = endTime
        @startParsed = timeParse startTime
        @endParsed = timeParse endTime
        @days = days
    end

    attr_accessor :startTime, :endTime, :startParsed, :endParsed, :days

    # Edited 09/29/2023 by Lucky Katneni (Implemented it)
    # Checks if self overlaps with the given [event]. returns false if events do not overlap, returns true otherwise
    # @param event Event object to compare to
    # @return Boolean with true if events overlap and false otherwise
    def overlaps? event

        # check if events have common days
        hasCommonDays = false

        # iterate through each day in self to check for common days
        @days.each do |day|
            if event.days.include? day
                hasCommonDays = true
            end
        end


        # if events have common days, check if they overlap in time
        hasCommonDays && (@startParsed < event.endParsed && @endParsed > event.startParsed)

    end


    # Created 10/01/2023 by Lucky Katneni
    # Parses the time in HH:MM to minutes from midnight
    # @param time String with the time in HH:MM format
    # @return Integer with the time in minutes from midnight
    def timeParse time
        # Array with first element hour and the second the minute
        timeArray = (time.split ":", 2).map{ |num| num.to_i}
        # return the time in minutes
        timeArray[0]*60 + timeArray[1]
    end

    # Created 10/04/2023 by Lucky Katneni
    # Returns the time in am/pm format
    # @param time String with the time in HH:MM format
    # @return String with the time in am/pm format
    def formatTime time
        # Array with first element hour and the second the minute
        timeArray = (time.split ":", 2).map{ |num| num.to_i}
        timeInString = ""
        am_pm = "pm"
        # return the time in am/pm format
        if timeArray[0] > 12
            timeArray[0] = timeArray[0]-12
        elsif timeArray[0] < 12
            am_pm = "am"
        end

        # if the minute is less than 10, add a 0 in front of it
        if timeArray[1] < 10
            timeInString = "#{timeArray[0]}:0#{timeArray[1]} #{am_pm}"
        else
            timeInString = "#{timeArray[0]}:#{timeArray[1]} #{am_pm}"
        end

    end


    # Created 10/01/2023 by Victor Madelaine
    # returns the space in between self and [event] in minutes
    # @param event Event object to compare to
    # @return Integer with the amount of minutes between the start of self and end of [event]
    def spaceInBetween event
        event.startParsed - @endParsed
    end

    #Created 10/02/2023 by Victor Madelaine
    # returns the length of self in minutes
    # @return Integer with the length of self in minutes
    def length
        @endParsed - @startParsed
    end
end