#@Authors @Team Run-time-terror - Victor Madelaine, Jason Su, Laxman Katneni, Khushi Patel, Landon McElroy
require_relative "Event"
require_relative "ClassOSU"

class Schedule 
    def initialize classes
        @classes = classes
        self.generateSchedule
    end

    attr_accessor :classes, :schedule


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


    # given a day, return the start of the first class of that day
    # @param day [String] the day of the week
    # @return [String] the start time of the first class of that day
    def dayStartTime day
        # get the classes of the day from the hash (an array of classes)
        classesOfDay = @schedule[day.to_sym]
        if classesOfDay.length < 1 then ""
        else classesOfDay[0].event.startTime end
    end


    # given a day, return the end of the last class of that day
    # @param day [String] the day of the week
    # @return [String] the end time of the last class of that day
    def dayEndTime day
        # get the classes of the day from the hash (an array of classes)
        classesOfDay = @schedule[day.to_sym]
        if classesOfDay.length < 1 then ""
        else classesOfDay[-1].event.endTime end
    end


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
