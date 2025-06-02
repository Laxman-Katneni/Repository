# Created 09/29/2023 by Lucky Katneni
# Edited 10/01/2023 by Lucky Katneni (Implemented Test Cases for Overlaps)
# Edited 10/02/2023 by Victor Madelaine (Implemented Test Cases for spaceInBetween)
# Edited 10/04/2023 by Lucky Katneni (Implemented Test Cases for timeParse, timeFormat)


require 'test/unit'
require_relative '../Event'

class TestEvent < Test::Unit::TestCase

    def setup 
        #create sample events
        @event1 = Event.new "9:00", "10:00", ["Monday"]
        @event2 = Event.new "11:30", "12:45", ["Monday", "Wednesday", "Friday"]
        @event3 = Event.new "12:30", "14:00", ["Monday", "Wednesday"]
        @event4 = Event.new "9:55", "11:30", ["Monday", "Thursday"]   
        @event5 = Event.new "12:00", "14:00", ["Monday", "Wednesday"]     
    end

    # Testing when events do not overlap
    def testOverlaps1
        #test if events overlap
        assert_equal false, @event1.overlaps?(@event3)
    end

    # Testing when the first event starts before the second event
    def testOverlaps2
        #test if events overlap
        assert_equal true, @event1.overlaps?(@event4)
    end

    # Testing when the first event starts after the second event
    def testOverlaps3
        #test if events overlap
        assert_equal true, @event3.overlaps?(@event2)
    end

    # Test TimeParse
    def testTimeParse1
        # Call method
        time = @event1.timeParse @event1.startTime
        assert_equal 540, time
    end

    # Test formatTime for time before 12:00pm
    def testFormatTime1
        # Call method
        time = @event1.formatTime @event1.startTime
        assert_equal "9:00 am", time
    end

    # Test formatTime for time after 12:00pm
    def testFormatTime2
        # Call method
        time = @event3.formatTime @event3.startTime
        assert_equal "12:30 pm", time
    end

    # Test formatTime for time at 12:00pm
    def testFormatTime3
        # Call method
        time = @event5.formatTime @event5.startTime
        assert_equal "12:00 pm", time
    end

    
    # Test spaceInBetween
    def testSpaceInBetween1
        # Create objects
        event01 = Event.new "9:00", "10:00", []
        event02 = Event.new "11:00", "12:00", []
        # Call method
        space = event01.spaceInBetween event02
        assert_equal 60, space
    end

    def testSpaceInBetween2
        # Create objects
        event01 = Event.new "9:00", "10:00", []
        event02 = Event.new "10:30", "12:00", []
        # Call method
        space = event01.spaceInBetween event02
        assert_equal 30, space
    end

    def testSpaceInBetween3
        # Create objects
        event01 = Event.new "9:00", "10:00", []
        event02 = Event.new "10:05", "12:00", []
        # Call method
        space = event01.spaceInBetween event02
        assert_equal 5, space
    end

    def testSpaceInBetween4
        # Create objects
        event01 = Event.new "9:00", "10:00", []
        event02 = Event.new "11:30", "12:00", []
        # Call method
        space = event01.spaceInBetween event02
        assert_equal 90, space
    end

    def testSpaceInBetween5
        # Create objects
        event01 = Event.new "10:00", "11:00", []
        event02 = Event.new "9:00", "10:00", []
        # Call method
        space = event01.spaceInBetween event02
        assert_equal -120, space
    end
end