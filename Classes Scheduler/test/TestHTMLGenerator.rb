# Created 10/01/2023 by Victor Madelaine

require 'test/unit'
require_relative "../Event"
require_relative "../ClassOSU"
require_relative "../Schedule"
require_relative '../htmlGenerator'

class TestHTMLGenerator < Test::Unit::TestCase
# Test generateHTMLFile   
    def testGenerateHTMLFile1
        # create objects
        class1 = ClassOSU.new "class1", 1234, "9:00", "10:00", ["monday", "wednesday", "friday"], "Bradley Hall", "prof something"
        class2 = ClassOSU.new "class2", 1234, "11:00", "12:00", ["monday", "wednesday", "friday"], "Hagerty Hall", "prof something"
        class3 = ClassOSU.new "class3", 1234, "13:00", "14:00", ["tuesday", "thursday"], "Scott Laboratory", "prof something"
        class4 = ClassOSU.new "class4", 1234, "8:00", "9:00", ["tuesday", "thursday"], "Dreese Laboratories", "prof something"
        class5 = ClassOSU.new "class5", 1234, "12:30", "13:30", ["monday", "wednesday", "friday"], "Hitchcock Hall", "prof something"
        class6 = ClassOSU.new "class6", 4321, "9:10", "10:10", ["tuesday", "thursday"], "Bolz Hall", "prof something"
        classes1 = [class1, class2, class3, class4, class5, class6]
        schedule1 = Schedule.new classes1
        class7 = ClassOSU.new "class7", 1234, "9:00", "10:00", ["monday", "wednesday", "friday"], "Bradley Hall", "prof something"
        class8 = ClassOSU.new "class8", 1234, "11:00", "12:00", ["monday", "wednesday", "friday"], "Hagerty Hall", "prof something"
        class9 = ClassOSU.new "class9", 1234, "13:00", "14:00", ["tuesday", "thursday"], "Scott Laboratory", "prof something"
        class10 = ClassOSU.new "class10", 1234, "8:00", "9:00", ["tuesday", "thursday"], "Dreese Laboratories", "prof something"
        class11 = ClassOSU.new "class11", 1234, "12:30", "13:30", ["monday", "wednesday", "friday"], "Hitchcock Hall", "prof something"
        class12 = ClassOSU.new "class12", 4321, "9:10", "10:10", ["tuesday", "thursday"], "Bolz Hall", "prof something"
        class13 = ClassOSU.new "class13", 1234, "Proffessor blah"
        classes2 = [class7, class8, class9, class10, class11, class12, class13]
        schedule2 = Schedule.new classes2
        schedule3 = Schedule.new [class1, class2, class3, class13]
        generator = HTMLGenerator.new "schedule 1", [schedule1, schedule3, schedule2]
        generator.generateHTMLFile
    end

    def testGenerateHTMLFile2
        # create objects
        class1 = ClassOSU.new "class1", 1234, "9:00", "10:00", ["monday", "wednesday", "friday"], "Bradley Hall", "prof something"
        class2 = ClassOSU.new "class2", 1234, "11:00", "12:00", ["monday", "wednesday", "friday"], "Hagerty Hall", "prof something"
        class3 = ClassOSU.new "class3", 1234, "13:00", "14:00", ["tuesday", "thursday"], "Scott Laboratory", "prof something"
        class4 = ClassOSU.new "class4", 1234, "8:00", "9:00", ["tuesday", "thursday"], "Dreese Laboratories", "prof something"
        class5 = ClassOSU.new "class5", 1234, "12:30", "13:30", ["monday", "wednesday", "friday"], "Hitchcock Hall", "prof something"
        class6 = ClassOSU.new "class6", 4321, "9:10", "10:10", ["tuesday", "thursday"], "Bolz Hall", "prof something"
        class7 = ClassOSU.new "class4", 1234, 'Proffessor blah'
        classes = [class1, class2, class3, class4, class5, class6, class7]
        schedule = Schedule.new classes
        generator = HTMLGenerator.new "schedule 2", [schedule]
        generator.generateHTMLFile
    end
end