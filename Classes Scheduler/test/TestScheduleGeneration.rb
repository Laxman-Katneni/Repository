# Created 10/02/2023 by Khushi Patel
# Edited 10/02/2023 by Khushi Patel (added test cases for addClass and generateAllSchedules)
# Edited 10/11/2023 by Victor Madelaine (added test cases for getValidCombinations and getCombinations)

require_relative "../ClassOSU"
require_relative "../Schedule"
require_relative "../Event"
require_relative "../ScheduleGeneration"
require "test/unit"

class TestScheduleGeneration < Test::Unit::TestCase
# Setup
  # Created 10/04/2023 by Victor Madelaine
  def setup
    @mwf9_00 = ClassOSU.new "mwf9_00", "9:00", "10:00", ["monday", "wednesday", "friday"]
    @mwf9_30 = ClassOSU.new "mwf9_30", "9:30", "10:30", ["monday", "wednesday", "friday"]
    @mwf10_00 = ClassOSU.new "mwf10_00", "10:00", "11:00", ["monday", "wednesday", "friday"]
    @mwf10_30 = ClassOSU.new "mwf10_30", "10:30", "11:30", ["monday", "wednesday", "friday"]
    @mwf11_00 = ClassOSU.new "mwf11_00", "11:00", "12:00", ["monday", "wednesday", "friday"]
    @mwf11_30 = ClassOSU.new "mwf11_30", "11:30", "12:30", ["monday", "wednesday", "friday"]
    @mwf12_00 = ClassOSU.new "mwf12_00", "12:00", "13:00", ["monday", "wednesday", "friday"]
    @mwf12_30 = ClassOSU.new "mwf12_30", "12:30", "13:30", ["monday", "wednesday", "friday"]
    @tt9_00 = ClassOSU.new "tt9_00", "9:00", "10:00", ["tuesday", "thursday"]
    @tt9_30 = ClassOSU.new "tt9_30", "9:30", "10:30", ["tuesday", "thursday"]
    @tt10_00 = ClassOSU.new "tt10_00", "10:00", "11:00", ["tuesday", "thursday"]
    @tt10_30 = ClassOSU.new "tt10_30", "10:30", "11:30", ["tuesday", "thursday"]
    @tt11_00 = ClassOSU.new "tt11_00", "11:00", "12:00", ["tuesday", "thursday"]
    @tt11_30 = ClassOSU.new "tt11_30", "11:30", "12:30", ["tuesday", "thursday"]
    @tt12_00 = ClassOSU.new "tt12_00", "12:00", "13:00", ["tuesday", "thursday"]
  end

# Test getClassCombinations
  # Created 10/11/2023 by Victor Madelaine
  def testGetValidCombinations1
    # initialize objects
    classes1 = [@mwf9_00]
    generator = ScheduleGeneration.new [classes1]
    # create expected results
    combo1 = Schedule.new classes1
    combinations = [combo1]
    # check that the method returns the correct schedules
    assert_equal combinations.length, generator.allSchedules.length
    for i in 0..combinations.length-1
      assert_equal combinations[i].classes.to_set, generator.allSchedules[i].classes.to_set
    end
  end

  # Created 10/11/2023 by Victor Madelaine
  def testGetValidCombinations2
    # initialize objects
    classes1 = [@mwf9_00, @mwf9_30]
    generator = ScheduleGeneration.new [classes1]
    # create expected results
    combo1 = Schedule.new [@mwf9_00]
    combo2 = Schedule.new [@mwf9_30]
    combinations = [combo1, combo2]
    # check that the method returns the correct schedules
    assert_equal combinations.length, generator.allSchedules.length
    for i in 0..combinations.length-1
      assert_equal combinations[i].classes.to_set, generator.allSchedules[i].classes.to_set
    end
  end

  # Created 10/11/2023 by Victor Madelaine
  def testGetValidCombinations3
    # initialize objects
    classes1 = [@mwf9_00, @mwf9_30]
    classes2 = [@mwf11_00]
    generator = ScheduleGeneration.new [classes1, classes2]
    # create expected results
    combo1 = Schedule.new [@mwf9_00, @mwf11_00]
    combo2 = Schedule.new [@mwf9_30, @mwf11_00]
    combinations = [combo1, combo2]
    # check that the method returns the correct schedules
    assert_equal combinations.length, generator.allSchedules.length
    for i in 0..combinations.length-1
      assert_equal combinations[i].classes.to_set, generator.allSchedules[i].classes.to_set
    end
  end

  # Created 10/11/2023 by Victor Madelaine
  def testGetValidCombinations4
    # initialize objects
    classes1 = [@mwf11_00]
    classes2 = [@mwf9_00, @mwf9_30]
    generator = ScheduleGeneration.new [classes1, classes2]
    # create expected results
    combo1 = Schedule.new [@mwf9_00, @mwf11_00]
    combo2 = Schedule.new [@mwf9_30, @mwf11_00]
    combinations = [combo1, combo2]
    # check that the method returns the correct schedules
    assert_equal combinations.length, generator.allSchedules.length
    for i in 0..combinations.length-1
      assert_equal combinations[i].classes.to_set, generator.allSchedules[i].classes.to_set
    end
  end

  # Created 10/11/2023 by Victor Madelaine
  def testGetValidCombinations5
    # initialize objects
    classes1 = [@mwf9_30]
    classes2 = [@mwf9_00]
    generator = ScheduleGeneration.new [classes1, classes2]
    combinations = []
    # check that the method returns the correct schedules
    assert_equal combinations.length, generator.allSchedules.length
  end

  # Created 10/11/2023 by Victor Madelaine
  def testGetValidCombinations6
    # initialize objects
    classes1 = [@mwf9_30, @mwf9_30]
    classes2 = [@mwf9_00, @mwf10_00]
    generator = ScheduleGeneration.new [classes1, classes2]
    combinations = []
    # check that the method returns the correct schedules
    assert_equal combinations.length, generator.allSchedules.length
  end

  # Created 10/11/2023 by Victor Madelaine
  def testGetValidCombinations7
    # initialize objects
    classes1 = [@mwf11_00, @mwf9_30]
    classes2 = [@mwf9_00, @mwf9_30]
    generator = ScheduleGeneration.new [classes1, classes2]
    # create expected results
    combo1 = Schedule.new [@mwf9_00, @mwf11_00]
    combo2 = Schedule.new [@mwf9_30, @mwf11_00]
    combinations = [combo1, combo2]
    # check that the method returns the correct schedules
    assert_equal combinations.length, generator.allSchedules.length
    for i in 0..combinations.length-1
      assert_equal combinations[i].classes.to_set, generator.allSchedules[i].classes.to_set
    end
  end

  # Created 10/11/2023 by Victor Madelaine
  def testGetValidCombinations8
    # initialize objects
    classes1 = [@mwf11_00, @mwf12_30]
    classes2 = [@mwf9_00, @mwf9_30]
    generator = ScheduleGeneration.new [classes1, classes2]
    # create expected results
    combo1 = Schedule.new [@mwf9_00, @mwf11_00]
    combo2 = Schedule.new [@mwf9_30, @mwf11_00]
    combo3 = Schedule.new [@mwf9_00, @mwf12_30]
    combo4 = Schedule.new [@mwf9_30, @mwf12_30]
    combinations = [combo1, combo2, combo3, combo4]
    # check that the method returns the correct schedules
    assert_equal combinations.length, generator.allSchedules.length
    for i in 0..combinations.length-1
      assert_equal combinations[i].classes.to_set, generator.allSchedules[i].classes.to_set
    end
  end

# Test getClassCombinations
  # Created 10/11/2023 by Victor Madelaine
  # Test with 1 array of length 1
  def testGetCombinations1 
    # initialize objects
    arr = [[1]]
    # create expected results
    combinationsExpected = [[1]]
    combinations = ScheduleGeneration.getCombinations arr
    # check that the method returns the correct output
    assert_equal combinationsExpected.to_set, combinations.to_set
  end

  # Created 10/11/2023 by Victor Madelaine
  # test with 1 array of length 2
  def testGetCombinations2 
    # initialize objects
    arr = [[1,2]]
    # create expected results
    combinationsExpected = [[1],[2]]
    combinations = ScheduleGeneration.getCombinations arr
    # check that the method returns the correct output
    assert_equal combinationsExpected.to_set, combinations.to_set
  end

  # Created 10/11/2023 by Victor Madelaine
  # test with 1 array of length 2, 1 array of length 1
  def testGetCombinations3 
    # initialize objects
    arr = [[1,2],[3]]
    # create expected results
    combinationsExpected = [[1,3],[2,3]]
    combinations = ScheduleGeneration.getCombinations arr
    # check that the method returns the correct output
    assert_equal combinationsExpected.to_set, combinations.to_set
  end

  # Created 10/11/2023 by Victor Madelaine
  # test with 2 arrays of length 2
  def testGetCombinations4 
    # initialize objects
    arr = [[1,2],[3,4]]
    # create expected results
    combinationsExpected = [[1,3],[2,3],[1,4],[2,4]]
    combinations = ScheduleGeneration.getCombinations arr
    # check that the method returns the correct output
    assert_equal combinationsExpected.to_set, combinations.to_set
  end

  # Created 10/11/2023 by Victor Madelaine
  # test with 2 arrays of length 2, 1 array of length 1
  def testGetCombinations5 
    # initialize objects
    arr = [[1,2],[3,4], [5]]
    # create expected results
    combinationsExpected = [[1,3,5],[2,3,5],[1,4,5],[2,4,5]]
    combinations = ScheduleGeneration.getCombinations arr
    # check that the method returns the correct output
    assert_equal combinationsExpected.to_set, combinations.to_set
  end

  # Created 10/11/2023 by Victor Madelaine
  # test with 3 arrays of length 2
  def testGetCombinations6 
    # initialize objects
    arr = [[1,2],[3,4], [5,6]]
    # create expected results
    combinationsExpected = [[1,3,5],[2,3,5],[1,4,5],[2,4,5],[1,3,6],[2,3,6],[1,4,6],[2,4,6]]
    combinations = ScheduleGeneration.getCombinations arr
    # check that the method returns the correct output
    assert_equal combinationsExpected.to_set, combinations.to_set
  end

# # Test add class
  def test_add_class_successful
    # Create a ScheduleGeneration instance
    scheduleGenerator = ScheduleGeneration.new

    # Define some sample class sections
    classSection1 = ClassOSU.new "Math 101", "101", "Math", "9:00 AM", "10:00 AM", ["Monday"], ["Room A", "Building X"], "John Danny" 
    classSection2 = ClassOSU.new "Physics 101", "102", "Physics", "10:30 AM", "11:30 AM", ["Tuesday"], ["Room B", "Building Y"], "Jane Smith"

    # Add the first class section to the schedule
    result1 = scheduleGenerator.addClass(classSection1)

    # Attempt to add a class that doesn't overlap with the existing class
    result2 = scheduleGenerator.addClass(classSection2)

    # Assert that the class was added successfully (should return true)
    assert_equal(true, result1)

    # Assert that the class was added successfully (should return true)
    assert_equal(true, result2)

  end

  def test_add_class_conflict
    # Create a ScheduleGeneration instance
    scheduleGenerator = ScheduleGeneration.new

    # Define some sample class sections
    classSection1 = ClassOSU.new("Class A", "101", "Math", Event.new("8:00 AM", "9:30 AM", ["Monday"]), "Building A", "Room 101", "Instructor A", "Fall")
    overlappingClass = ClassOSU.new("Class B", "201", "Science", Event.new("8:30 AM", "10:00 AM", ["Monday"]), "Building B", "Room 201", "Instructor B", "Fall")

    # Add the first class section to the schedule
    result1 = scheduleGenerator.addClass(classSection1)

    # Attempt to add a class that overlaps with the existing class
    result2 = scheduleGenerator.addClass(overlappingClass)

    # Assert that the class was added successfully (should return true)
    assert_equal(true, result1)

    # Assert that the class was not added due to conflicts (should return false)
    assert_equal(false, result2)
  end
end
