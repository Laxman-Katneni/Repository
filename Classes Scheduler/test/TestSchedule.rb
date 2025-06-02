# Created 09/25/2023 by Victor Madelaine
# Edited 09/26/2023 by Victor Madelaine (create test cases for generateSchedule)
# Edited 09/30/2023 by Jason Su (created test cases for dayStartTime)
# Edited 10/01/2023 by Jason Su (added test cases for dayStartTime and dayEndTime)
# Edited 10/02/2023 by Jason Su (added test cases for noConflicts?)
# Edited 10/04/2023 by Jason Su (added and modified test cases for noConflicts?)

require_relative "../ClassOSU"
require_relative "../Schedule"
require_relative "../Event"
require "test/unit"

class TestSchedule < Test::Unit::TestCase
# Test noConflicts?
    # Created 10/04/2023 by Jason Su
    # Edited 10/04/2023 by Jason Su (completed test case implementation and documentation)
    # Test with an empty schedule
    def testNoConflicts1
        # initialize variables
        classes = []
        # method call
        noConflicts = Schedule.noConflicts? classes
        # check if method worked properly
        assert_equal true, noConflicts
    end

    # Created 09/25/2023 by Jason Su
    # Edited 10/02/2023 by Jason Su (completed test case implementation and documentation)
    # Edited 10/04/2023 by Jason Su (modified test case implementation and documentation)
    # Test with a schedule without any conflict (gaps between classes)
    def testNoConflicts2
        # initialize variables
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday", "wednesday", "friday"]
        class2 = ClassOSU.new "class2", "10:20", "11:40", ["monday", "wednesday", "friday"]
        class3 = ClassOSU.new "class3", "12:50", "13:45", ["tuesday", "wednesday", "thursday" ,"friday"]
        class4 = ClassOSU.new "class4", "14:00", "15:00", ["tuesday", "wednesday", "thursday" ,"friday"]
        class5 = ClassOSU.new "class5", "11:10", "12:15", ["tuesday", "thursday"]
        class6 = ClassOSU.new "class6", "15:10", "16:15", ["tuesday", "thursday"]
        classes = [class1, class2, class3, class4, class5, class6]
        # method call
        noConflicts = Schedule.noConflicts? classes
        # check if method worked properly
        assert_equal true, noConflicts
    end

    # Created 09/25/2023 by Jason Su
    # Edited 10/02/2023 by Jason Su (completed test case implementation and documentation)
    # Edited 10/04/2023 by Jason Su (modified test case implementation and documentation)
    # Test with a schedule with one set of conflict
    def testNoConflicts3
        # initialize variables
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday", "wednesday", "friday"]
        class2 = ClassOSU.new "class2", "10:20", "11:40", ["monday", "wednesday", "friday"]
        class3 = ClassOSU.new "class3", "12:50", "14:50", ["tuesday", "wednesday", "thursday" ,"friday"]
        class4 = ClassOSU.new "class4", "14:00", "15:00", ["tuesday", "wednesday", "thursday" ,"friday"]
        class5 = ClassOSU.new "class5", "11:10", "12:15", ["tuesday", "thursday"]
        class6 = ClassOSU.new "class6", "15:10", "16:15", ["tuesday", "thursday"]
        classes = [class1, class2, class3, class4, class5, class6]
        # method call
        noConflicts = Schedule.noConflicts? classes
        # check if method worked properly
        assert_equal false, noConflicts
    end

    # Created 09/25/2023 by Jason Su
    # Edited 10/02/2023 by Jason Su (completed test case implementation and documentation)
    # Edited 10/04/2023 by Jason Su (modified test case implementation and documentation)
    # Test with a schedule with two sets of conflict (one set of conflict: previous class ends exactly when next class starts)
    def testNoConflicts4
        # initialize variables
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday", "wednesday", "friday"]
        class2 = ClassOSU.new "class2", "10:20", "11:40", ["monday", "wednesday", "friday"]
        class3 = ClassOSU.new "class3", "12:50", "14:50", ["tuesday", "wednesday", "thursday" ,"friday"]
        class4 = ClassOSU.new "class4", "14:00", "15:10", ["tuesday", "wednesday", "thursday" ,"friday"]
        class5 = ClassOSU.new "class5", "11:10", "12:15", ["tuesday", "thursday"]
        class6 = ClassOSU.new "class6", "15:10", "16:15", ["tuesday", "thursday"]
        classes = [class1, class2, class3, class4, class5, class6]
        # method call
        noConflicts = Schedule.noConflicts? classes
        # check if method worked properly
        assert_equal false, noConflicts
    end


# Test dayStartTime
    # Created 09/25/2023 by Jason Su
    # Edited 09/27/2023 by Jason Su (implemented test case and documentation)
    # Edited 09/30/2023 by Jason Su (completed test case implementation and documentation)
    # Test with a day without any class
    def testDayStartTime1
        # initialize variables
        classes = []
        schedule = Schedule.new classes
        # method call
        startTime = schedule.dayStartTime "monday"
        # check if method worked properly
        assert_equal "", startTime
    end

    # Created 09/25/2023 by Jason Su
    # Edited 09/30/2023 by Jason Su (completed test case implementation and documentation)
    # Test with a day with one class
      def testDayStartTime2
        # initialize variables
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday"]
        classes = [class1]
        schedule = Schedule.new classes
        # method call
        startTime = schedule.dayStartTime "monday"
        # check if method worked properly
        assert_equal "9:00", startTime
    end
    
    # Created 09/25/2023 by Jason Su
    # Edited 09/30/2023 by Jason Su (completed test case implementation and documentation)
    # Test with a day with two classes (same day)
    def testDayStartTime3
        # initialize variables
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday"]
        class2 = ClassOSU.new "class2", "11:00", "12:00", ["monday"]
        classes = [class1, class2]
        schedule = Schedule.new classes
        # method call
        startTime = schedule.dayStartTime "monday"
        # check if method worked properly
        assert_equal "9:00", startTime
    end

    # Created 09/27/2023 by Jason Su
    # Edited 09/30/2023 by Jason Su (completed test case implementation and documentation)
    # Test with a day with three classes (same day)
    def testDayStartTime4
        # initialize variables
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday"]
        class2 = ClassOSU.new "class2", "11:00", "12:00", ["monday"]
        class3 = ClassOSU.new "class3", "13:00", "14:00", ["monday"]
        classes = [class1, class2, class3]
        schedule = Schedule.new classes
        # method call
        startTime = schedule.dayStartTime "monday"
        # check if method worked properly
        assert_equal "9:00", startTime
    end

    # Created 09/30/2023 by Jason Su
    # Edited 09/30/2023 by Jason Su (completed test case implementation and documentation)
    # Test with days with two classes (different days)
    def testDayStartTime5
        # initialize variables
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday"]
        class2 = ClassOSU.new "class2", "11:00", "12:00", ["monday"]
        class3 = ClassOSU.new "class3", "7:00", "8:00", ["tuesday"]
        class4 = ClassOSU.new "class4", "10:00", "11:00", ["tuesday"]
        classes = [class1, class2, class3, class4]
        schedule = Schedule.new classes
        # method call
        startTime = schedule.dayStartTime "tuesday"
        # check if method worked properly
        assert_equal "7:00", startTime
    end

    # Created 09/30/2023 by Jason Su
    # Edited 09/30/2023 by Jason Su (completed test case implementation and documentation)
    # Test with days with three classes (different days)
    def testDayStartTime6
        # initialize variables
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday"]
        class2 = ClassOSU.new "class2", "11:00", "12:00", ["monday"]
        class3 = ClassOSU.new "class3", "13:00", "14:00", ["monday"]
        class4 = ClassOSU.new "class4", "7:00", "8:00", ["tuesday"]
        class5 = ClassOSU.new "class5", "10:00", "11:00", ["tuesday"]
        class6 = ClassOSU.new "class6", "14:00", "15:00", ["tuesday"]
        classes = [class1, class2, class3, class4, class5, class6]
        schedule = Schedule.new classes
        # method call
        startTime = schedule.dayStartTime "tuesday"
        # check if method worked properly
        assert_equal "7:00", startTime
    end

    # add more test cases for testDayStartTime with classes not listed in order


# Test dayEndTime
    # Created 09/25/2023 by Jason Su
    # Edited 10/01/2023 by Jason Su (completed test case implementation and documentation)
    # Test with a day without any class
    def testDayEndTime1
        # initialize variables
        classes = []
        schedule = Schedule.new classes
        # method call
        endTime = schedule.dayEndTime "monday"
        # check if method worked properly
        assert_equal "", endTime
    end

    # Created 09/25/2023 by Jason Su
    # Edited 10/01/2023 by Jason Su (completed test case implementation and documentation)
    # Test with a day with one class
    def testDayEndTime2
        # initialize variables
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday"]
        classes = [class1]
        schedule = Schedule.new classes
        # method call
        endTime = schedule.dayEndTime "monday"
        # check if method worked properly
        assert_equal "10:00", endTime
    end

    # Created 09/25/2023 by Jason Su
    # Edited 10/01/2023 by Jason Su (completed test case implementation and documentation)
    # Test with a day with two classes (same day)
    def testDayEndTime3
        # initialize variables
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday"]
        class2 = ClassOSU.new "class2", "11:00", "12:00", ["monday"]
        classes = [class1, class2]
        schedule = Schedule.new classes
        # method call
        endTime = schedule.dayEndTime "monday"
        # check if method worked properly
        assert_equal "12:00", endTime
    end

    # Created 10/01/2023 by Jason Su
    # Edited 10/01/2023 by Jason Su (completed test case implementation and documentation)
    # Test with a day with three classes (same day)
    def testDayEndTime4
        # initialize variables
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday"]
        class2 = ClassOSU.new "class2", "11:00", "12:00", ["monday"]
        class3 = ClassOSU.new "class3", "13:00", "14:00", ["monday"]
        classes = [class1, class2, class3]
        schedule = Schedule.new classes
        # method call
        endTime = schedule.dayEndTime "monday"
        # check if method worked properly
        assert_equal "14:00", endTime
    end

    # Created 10/01/2023 by Jason Su
    # Edited 10/01/2023 by Jason Su (completed test case implementation and documentation)
    # Test with days with two classes (different days)
    def testDayEndTime5
        # initialize variables
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday"]
        class2 = ClassOSU.new "class2", "11:00", "12:00", ["monday"]
        class3 = ClassOSU.new "class3", "7:00", "8:00", ["tuesday"]
        class4 = ClassOSU.new "class4", "10:00", "11:00", ["tuesday"]
        classes = [class1, class2, class3, class4]
        schedule = Schedule.new classes
        # method call
        endTime = schedule.dayEndTime "tuesday"
        # check if method worked properly
        assert_equal "11:00", endTime
    end

    # Created 10/01/2023 by Jason Su
    # Edited 10/01/2023 by Jason Su (completed test case implementation and documentation)
    # Test with days with three classes (different days)
    def testDayEndTime6
        # initialize variables
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday"]
        class2 = ClassOSU.new "class2", "11:00", "12:00", ["monday"]
        class3 = ClassOSU.new "class3", "13:00", "14:00", ["monday"]
        class4 = ClassOSU.new "class4", "7:00", "8:00", ["tuesday"]
        class5 = ClassOSU.new "class5", "10:00", "11:00", ["tuesday"]
        class6 = ClassOSU.new "class6", "14:00", "15:00", ["tuesday"]
        classes = [class1, class2, class3, class4, class5, class6]
        schedule = Schedule.new classes
        # method call
        endTime = schedule.dayEndTime "tuesday"
        # check if method worked properly
        assert_equal "15:00", endTime
    end

    # add more test cases for testDayStartTime with classes not listed in order


# generateSchedule
    # Created 09/26/2023 by Victor Madelaine
    # test with @classes being empty
    def testGenerateSchedule1
        # initialize variables
        classesExpected = []
        schedule = Schedule.new classesExpected
        scheduleExpected = {monday: [], tuesday: [], 
                        wednesday: [], thursday: [], 
                        friday: [], asynch: []}
        # check if method worked properly
        assert_equal scheduleExpected, schedule.schedule
        assert_equal classesExpected, schedule.classes
    end

    # Created 09/26/2023 by Victor Madelaine
    # test with one class on monday
    def testGenerateSchedule2
        # create classes
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday"]
        # initialize variables
        classesExpected = [class1]
        schedule = Schedule.new classesExpected
        scheduleExpected = {monday: [class1], tuesday: [], 
                        wednesday: [], thursday: [], 
                        friday: [], asynch: []}
        # check if method worked properly
        assert_equal scheduleExpected, schedule.schedule
        assert_equal classesExpected, schedule.classes
    end

    # Created 09/26/2023 by Victor Madelaine
    # test with one class on tuesday
    def testGenerateSchedule3
        # create classes
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["tuesday"]
        # initialize variables
        classesExpected = [class1]
        schedule = Schedule.new classesExpected
        scheduleExpected = {monday: [], tuesday: [class1], 
                        wednesday: [], thursday: [], 
                        friday: [], asynch: []}
        # check if method worked properly
        assert_equal scheduleExpected, schedule.schedule
        assert_equal classesExpected, schedule.classes
    end

    # Created 09/26/2023 by Victor Madelaine
    # test with one class on mnonday, one class on thursday
    def testGenerateSchedule4
        # create classes
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday"]
        class2 = ClassOSU.new "class2", "12:00", "13:00", ["thursday"]
        # initialize variables
        classesExpected = [class1, class2]
        schedule = Schedule.new classesExpected
        scheduleExpected = {monday: [class1], tuesday: [], 
                        wednesday: [], thursday: [class2], 
                        friday: [], asynch: []}
        # check if method worked properly
        assert_equal scheduleExpected, schedule.schedule
        assert_equal classesExpected, schedule.classes
    end

    # Created 09/26/2023 by Victor Madelaine
    # test with two classes on wednesday
    def testGenerateSchedule5
        # create classes
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["wednesday"]
        class2 = ClassOSU.new "class2", "12:00", "13:00", ["wednesday"]
        # initialize variables
        classesExpected = [class1, class2]
        schedule = Schedule.new classesExpected
        scheduleExpected = {monday: [], tuesday: [], 
                        wednesday: [class1, class2], thursday: [], 
                        friday: [], asynch: []}
        # check if method worked properly
        assert_equal scheduleExpected, schedule.schedule
        assert_equal classesExpected, schedule.classes
    end

    # Created 09/26/2023 by Victor Madelaine
    # test with one class on monday, wednesday friday
    def testGenerateSchedule6
        # create classes
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday", "wednesday", "friday"]
        # initialize variables
        classesExpected = [class1]
        schedule = Schedule.new classesExpected
        scheduleExpected = {monday: [class1], tuesday: [], 
                        wednesday: [class1], thursday: [], 
                        friday: [class1], asynch: []}
        # check if method worked properly
        assert_equal scheduleExpected, schedule.schedule
        assert_equal classesExpected, schedule.classes
    end

    # Created 09/26/2023 by Victor Madelaine
    # test with one class on monday, wednesday, friday and 
    # one class one class on tuesday and thurday
    def testGenerateSchedule7
        # create classes
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday", "wednesday", "friday"]
        class2 = ClassOSU.new "class2", "12:00", "13:00", ["tuesday", "thursday"]
        # initialize variables
        classesExpected = [class1, class2]
        schedule = Schedule.new classesExpected
        scheduleExpected = {monday: [class1], tuesday: [class2], 
                        wednesday: [class1], thursday: [class2], 
                        friday: [class1], asynch: []}
        # check if method worked properly
        assert_equal scheduleExpected, schedule.schedule
        assert_equal classesExpected, schedule.classes
    end

    # Created 09/26/2023 by Victor Madelaine
    # test with two classes on monday, wednesday, friday
    def testGenerateSchedule8
        # create classes
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday", "wednesday", "friday"]
        class2 = ClassOSU.new "class2", "12:00", "13:00", ["monday", "wednesday", "friday"]
        # initialize variables
        classesExpected = [class1, class2]
        schedule = Schedule.new classesExpected
        scheduleExpected = {monday: [class1, class2], tuesday: [], 
                        wednesday: [class1, class2], thursday: [], 
                        friday: [class1, class2], asynch: []}
        # check if method worked properly
        assert_equal scheduleExpected, schedule.schedule
        assert_equal classesExpected, schedule.classes
    end 

    # Created 10/02/2023 by Victor Madelaine
    # test with two classes on monday inserted in wrong order
    def testGenerateSchedule9
        # create classes
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday"]
        class2 = ClassOSU.new "class2", "12:00", "13:00", ["monday"]
        # initialize variables
        classesExpected = [class2, class1]
        schedule = Schedule.new classesExpected
        scheduleExpected = {monday: [class1, class2], tuesday: [], 
                        wednesday: [], thursday: [], 
                        friday: [], asynch: []}
        # check if method worked properly
        assert_equal scheduleExpected, schedule.schedule
        assert_equal classesExpected, schedule.classes
    end 

    # test with asynchronous class
    def testGenerateSchedule10
        # create classes
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday"]
        class2 = ClassOSU.new "class2", "12:00", "13:00", ["monday"]
        class3 = ClassOSU.new "class3", 1234, "proffe Maddox"
        # initialize variables
        classesExpected = [class2, class1, class3]
        schedule = Schedule.new classesExpected
        scheduleExpected = {monday: [class1, class2], tuesday: [], 
                        wednesday: [], thursday: [], 
                        friday: [], asynch: [class3]}
        # check if method worked properly
        assert_equal scheduleExpected, schedule.schedule
        assert_equal classesExpected, schedule.classes
    end 

    # test with asynchronous class
    def testGenerateSchedule11
        # create classes
        class1 = ClassOSU.new "class1", "9:00", "10:00", ["monday"]
        class2 = ClassOSU.new "class2", "12:00", "13:00", ["monday"]
        class3 = ClassOSU.new "class3", 1234, "proffe Maddox"
        class4 = ClassOSU.new "class4", 1235, "proffe Paddox"
        # initialize variables
        classesExpected = [class4, class2, class1, class3]
        schedule = Schedule.new classesExpected
        scheduleExpected = {monday: [class1, class2], tuesday: [], 
                        wednesday: [], thursday: [], 
                        friday: [], asynch: [class4, class3]}
        # check if method worked properly
        assert_equal scheduleExpected, schedule.schedule
        assert_equal classesExpected, schedule.classes
    end 

    def test_generate_schedule_multi_day_events
        # Create instances of the Class class
        class1 = ClassOSU.new "Math","10:00", "11:30", ["monday"]
        class2 = ClassOSU.new "History", "12:00", "13:30", ["monday", "tuesday"]
        class3 = ClassOSU.new "English", "14:00", "15:30", ["monday", "wednesday"]
        # Instantiate the Schedule class and pass the classes to generate the schedule
        mySchedule = Schedule.new([class3, class2, class1])
        # Define the expected output
        #expected_schedule = { monday: [class1, class1], tuesday: [class2, class2], wednesday: [class3, class3], thursday: [], friday: [] }
        expected_schedule = { monday: [class1, class2 ,class3], tuesday: [class2], 
                            wednesday: [class3], thursday: [], friday: [], asynch: [] }
        
        #puts expected_schedule
        # Use assert_equals to compare the expected output with the actual output
        assert_equal(mySchedule.schedule, expected_schedule)
    end
end
