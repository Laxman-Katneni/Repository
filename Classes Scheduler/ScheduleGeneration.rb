# @Authors @Team Run-time-terror - Victor Madelaine, Jason Su, Laxman Katneni, Khushi Patel, Landon McElroy

require_relative "Schedule"
require_relative "Event"
require_relative "ClassOSU"
require_relative "Location"
require_relative "htmlGenerator"

class ScheduleGeneration
  def initialize allClasses
    # An array of arrays to store all offered sections of classes
    @allClasses = allClasses 
    # An array to store the user's schedules
    @allSchedules = self.getValidCombinations 
  end

  attr_accessor :allSchedules, :allClasses


  # ensures that a class is only added to the user's schedule
  # @param newClass the class to be added to the schedule
  # @return true or false
  def addClass newClass
      if @schedule.all? { |existingClass| !existingClass.event.overlaps?(newClass.event) }
        @schedule << newClass
        return true
      else
        return false 
    end
  end


  # Generates and returns an array with all valid schedules in @allClasses
  # @returns array of valid schedules
  def getValidCombinations
    validClassCombinations = ScheduleGeneration.getCombinations @allClasses
    # remove invalid schedules and create objects
    validClassCombinations.reject! {|comb| !Schedule.noConflicts? comb}
    validClassCombinations.map {|arr| Schedule.new arr}
  end

  # creates an HTML file from all schedules in @allSchedules
  def createHTMLSchedule name
    createHTML = HTMLGenerator.new name, @allSchedules
    createHTML.generateHTMLFile
  end


  # Sort and return a new array of all schedules by the earliest start time
  def earlyStart
    @allSchedules.sort_by { |schedule| schedule.startTime }
  end



  # Sort and return a new array of all schedules by the latest start time
  def lateStart
    @allSchedules.sort_by { |schedule| schedule.startTime }.reverse
  end

 
  # Sort and return a new array of all schedules by the earliest end time
  def earlyEnd
    @allSchedules.sort_by { |schedule| schedule.endTime }
  end


  # Sort and return a new array of all schedules by the latest end time
  def lateEnd
    @allSchedules.sort_by { |schedule| schedule.endTime }.reverse
  end


  # Given an array of arrays, return an array of all possible combinations choosing one element from each array
  # @param sectionArray   an array of arrays
  # @return an array of arrays containing all possible combinations
  def self.getCombinations sectionArray
    if sectionArray.length == 1
      return sectionArray[0].map {|section| [section]}
    else
      return (sectionArray[0].product getCombinations sectionArray[1..-1]).each{|combo| combo.flatten!}
    end
  end
end
