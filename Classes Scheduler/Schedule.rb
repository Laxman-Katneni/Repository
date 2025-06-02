# Created 09/25/2023 by Victor Madelaine
# Edited 09/25/2023 by Victor Madelaine (implement generate schedule)
# Edited 09/27/2023 by Jason Su (implement dayStartTime)
# Edited 09/29/2023 by Victor Madelaine (edit generate schedule to implement event class)
# Edited 10/01/2023 by Jason Su (implement dayStartTime, dayEndTime)
# Edited 10/02/2023 by Jason Su (implement noConflicts?)
# Edited 10/04/2023 by Victor Madelaine (implement sort in generate schedule)
# Edited 10/04/2023 by Jason Su (make changes to noConflicts?)
# Edited 10/09/2023 by Victor Madelaine (add functionality for asynchronous classes in generateSchedule)
# Edited 10/11/2023 by Victor Madelaine (re-implement noConflicts? method)
# Edited 10/11/2023 by Jason Su (documentation, added @param, @return)
require_relative "Event"
require_relative "ClassOSU"

class Schedule 
    def initialize classes
        @classes = classes
        self.generateSchedule
    end

    attr_accessor :classes, :schedule

    # Created 09/25/2023 by Jason Su
    # Edited 10/02/2023 by Jason Su (implemented method and documentation)
    # Edited 10/04/2023 by Jason Su (make changes to method so it also works without a schedule being generated)
    # Edited 10/11/2023 by Victor Madelaine (fix method)
    # return true if @classes has no conflicts, false otherwise
    # @param classes [Array<ClassOSU>] an array of ClassOSU objects
    # @return [Boolean]
    def self.noConflicts? classes
        for i in 0..classes.length-1 do
            for j in i+1..classes.length-1 do
                return false if classes[i].event.overlaps? classes[j].event
            end
        end
        # return true if no conflicts are found
        true
    end

    # Created 09/25/2023 by Jason Su
    # Edited 09/27/2023 by Jason Su (implemented method and documentation)
    # Edited 09/30/2023 by Jason Su (completed method implementation and documentation)
    # Edited 10/01/2023 by Jason Su (update with terse code)
    # given a day, return the start of the first class of that day
    # @param day [String] the day of the week
    # @return [String] the start time of the first class of that day
    def dayStartTime day
        # get the classes of the day from the hash (an array of classes)
        classesOfDay = @schedule[day.to_sym]
        if classesOfDay.length < 1 then ""
        else classesOfDay[0].event.startTime end
    end

    # Created 09/25/2023 by Jason Su
    # Edited 10/01/2023 by Jason Su (completed method implementation and documentation)
    # Edited 10/01/2023 by Jason Su (update with terse code)
    # given a day, return the end of the last class of that day
    # @param day [String] the day of the week
    # @return [String] the end time of the last class of that day
    def dayEndTime day
        # get the classes of the day from the hash (an array of classes)
        classesOfDay = @schedule[day.to_sym]
        if classesOfDay.length < 1 then ""
        else classesOfDay[-1].event.endTime end
    end

    # Created 09/25/2023 by Victor Madelaine
    # Edited 09/26/2023 by Victor Madelaine (implemented method and documentation)
    # Edited 09/29/2023 by Victor Madelaine (use event object in Class class)
    # Edited 10/04/2023 by Victor Madelaine (implement sort to put classes in correct order)
    # Edited 10/09/2023 by Victor Madelaine (add functionality for asynchronous classes)
    # Creates a hash map by days of the week and populates the hash map @schedule with Class objects from @classes
    # @return [void]
    private def generateSchedule
        @schedule = {monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], asynch: []}
        # populate hash map with values from @classes
        @classes.each do |c|
            if c.respond_to?(:event) && c.event != nil
              c.event.days.each{|day| @schedule[day.downcase.to_sym] << c}
            else
              @schedule[:asynch] << c
            end
          end
        # sort hash maps arrays by class start time
        @schedule.each {|day, classes| classes.sort! {|class1,class2| class2.event.spaceInBetween class1.event} unless day == :asynch}
    end
end
