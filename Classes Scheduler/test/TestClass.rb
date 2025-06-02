# Created 09/25/2023 by Victor Madelaine
# Edited 09/27/2023 by Landon McElroy (add test_initialize method)
# Edited 09/27/2023 by Khushi Patel (add test cases for hash department and hash class)
# Edited 09/29/ 2023 by Khushi Patel (fix syntax)

require_relative "../ClassOSU"
require 'test/unit'

class TestClass < Test::Unit::TestCase

    # Created 09/27/2023 by Khushi Patel
    def test_classHash1
        # Create a sample Class object
        class1 = ClassOSU.new "Math 101", "101", "Math", "9:00 AM", "10:00 AM", ["Monday"], ["Room A", "Building X"], "John Danny"
        ClassOSU.classHash([class1])

        assert_equal "Math 101", class1.className
    end

    # Created 09/27/2023 by Khushi Patel
    def test_classHash2
        # Create sample Class objects
        class1 = ClassOSU.new "Math 101", "101", "Math", "9:00 AM", "10:00 AM", ["Monday"], ["Room A", "Building X"], "John Danny" 
        class2 = ClassOSU.new "Physics 101", "102", "Physics", "10:30 AM", "11:30 AM", ["Tuesday"], ["Room B", "Building Y"], "Jane Smith"
        ClassOSU.classHash([class1, class2])

        assert_equal "Math 101", class1.className
        assert_equal "Physics 101", class2.className
    end
    
    # Created 09/27/2023 by Khushi Patel
    def test_classHash3
        # Create sample Class objects
        class1 = ClassOSU.new "Math 101", "101", "Math", "9:00 AM", "10:00 AM", ["Monday"], ["Room A", "Building X"], "John Danny"
        class2 = ClassOSU.new "Physics 101", "102", "Physics", "10:30 AM", "11:30 AM", ["Tuesday"], ["Room B", "Building Y"], "Jane Smith"
        ClassOSU.classHash([class1, class2])

        assert_equal "101", class1.classNumber
        assert_equal "102", class2.classNumber
    end
end
