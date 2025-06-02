# Created 09/29/2023 by Khushi Patel
# Edited 10/02/2023 by Khushi Patel (refactor generateAllSchedules)
# Edited 10/03/2023 by Khushi Patel (refactor generateAllSchedules)
# Edited 10/04/2023 by Jason Su (implemented and documented earlyStart, lateStart, earlyEnd, lateEnd)
# Edited 10/04/2023 by Victor Madelaine (implement getValidCombinations)
# Edited 10/11/2023 by Victor Madelaine (fix getValidCombinations and implement getCombinations)

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

  # Created 09/29/2023 by Khushi Patel
  # Edited 10/04/2023 by Khushi Patel (change the arguments for overlaps?)
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

  # Created 10/04/2023 by Victor Madelaine
  # Edited 10/11/2023 by Victor Madelaine (fixed bug with creating combinations)
  # Generates and returns an array with all valid schedules in @allClasses
  # @returns array of valid schedules
  def getValidCombinations
    validClassCombinations = ScheduleGeneration.getCombinations @allClasses
    # remove invalid schedules and create objects
    validClassCombinations.reject! {|comb| !Schedule.noConflicts? comb}
    validClassCombinations.map {|arr| Schedule.new arr}
  end

  # Created 10/11/2023 by Victor Madelaine
  # creates an HTML file from all schedules in @allSchedules
  def createHTMLSchedule name
    createHTML = HTMLGenerator.new name, @allSchedules
    createHTML.generateHTMLFile
  end

  # Created 10/04/2023 by Jason Su
  # Edited 10/04/2023 by Jason Su (implemented method and documentation)
  # Sort and return a new array of all schedules by the earliest start time
  def earlyStart
    @allSchedules.sort_by { |schedule| schedule.startTime }
  end

  # Created 10/04/2023 by Jason Su
  # Edited 10/04/2023 by Jason Su (implemented method and documentation)
  # Sort and return a new array of all schedules by the latest start time
  def lateStart
    @allSchedules.sort_by { |schedule| schedule.startTime }.reverse
  end

  # Created 10/04/2023 by Jason Su
  # Edited 10/04/2023 by Jason Su (implemented method and documentation)
  # Sort and return a new array of all schedules by the earliest end time
  def earlyEnd
    @allSchedules.sort_by { |schedule| schedule.endTime }
  end

  # Created 10/04/2023 by Jason Su
  # Edited 10/04/2023 by Jason Su (implemented method and documentation)
  # Sort and return a new array of all schedules by the latest end time
  def lateEnd
    @allSchedules.sort_by { |schedule| schedule.endTime }.reverse
  end

  # Created 10/11/2023 by Victor Madelaine
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
