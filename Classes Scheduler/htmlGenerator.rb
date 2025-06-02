#@Authors @Team Run-time-terror - Victor Madelaine, Jason Su, Laxman Katneni, Khushi Patel, Landon McElroy
require_relative "Event"
require_relative "ClassOSU"
require_relative "Schedule"
require_relative "Location"

# This class creates an html file from a given schedule
class HTMLGenerator
    # HTML code that is constant for all HTML files
    TIMECOLUMN = "\n\t\t<div class=\"time\">\n\t\t\t<div>8:00  -</div>\n\t\t\t<div>9:00  -</div>\n\t\t\t<div>10:00 -</div>\n\t\t\t<div>11:00 -</div>\n\t\t\t<div>12:00 -</div>\n\t\t\t<div>1:00  -</div>\n\t\t\t<div>2:00  -</div>\n\t\t\t<div>3:00  -</div>\n\t\t\t<div>4:00  -</div>\n\t\t\t<div>5:00  -</div>\n\t\t\t<div>7:00  -</div>\n\t\t\t<div>8:00  -</div>\n\t\t\t<div style=\"height: 15px\">9:00  -</div>\n\t\t</div>"
    DAYSROW = "\n\t<div class=\"weekdays\">\n\t\t<div style=\"width:5%\"></div>\n\t\t<div>Monday</div>\n\t\t<div>Tuesday</div>\n\t\t<div>Wednesday</div>\n\t\t<div>Thursday</div>\n\t\t<div>Friday</div>\n\t</div>"
    SCRIPT = "\n\t<script>\n\t\tfunction showOtherCalendar(shown, next) {\n\t\t\tdocument.getElementById(shown).style.display = \"none\";\n\t\t\tdocument.getElementById(next).style.display = \"block\";\n\t\t}\n\t</script>"
    CSSLINKS = "\n\t<link rel=\"stylesheet\" href=\"style.css\" >\n\t <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css\">"
    # Colors assigned to classes
    COLORS = ["blue", "red", "orange", "purple", "green", "yellow", "pink"]

    # @param name       String title for HTML file creation
    # @param schedule   Schedule object to create HTML file from
    def initialize name, schedules
        @name = name
        @schedulesToGenerate = schedules
    end

    attr_accessor :name, :scheduleToCreate


    # creates html file and writes html code using private methods
    # @return HTML file and puts file in htmlFiles folder
    def generateHTMLFile
        # generate HTML code
        text = self.createHeader + self.createBody + "\n</html>"
        # create file and write HTML code to it
        fileName = "./htmlFiles/#{@name}.html"
        file = File.new fileName, "w"
        file.write text
        file.close
    end


    # returns a string for the html header according to @name
    # @return String with HTML header
    private def createHeader
        "<!DOCTYPE html>\n<head>\n\t<title>#{@name}</title>#{CSSLINKS}#{SCRIPT}\n</head>"
    end


    # returns a string for the html body according to @scheduleToCreate
    # @return String with HTML body
    private def createBody
        str = "\n<body>#{DAYSROW}"
        @schedulesToGenerate.each{|schedule| str += self.createSchedule schedule}
        str += "\n</body>"
        str
    end


    # @param schedule   schedule to to create the html <div> tag for
    # @return String with HTML <div> tag for the schedule
    private def createSchedule schedule
        str = "\n\t<div id=\"calendar#{@schedulesToGenerate.find_index schedule}\""
        str += " style=\"display: none\"" if (@schedulesToGenerate.find_index(schedule) != 0) 
        str += ">\n\t<div class=\"days\">#{TIMECOLUMN}#{self.createCalendarElements schedule}\n\t</div>#{self.createAsynchInfo schedule}#{self.buttonGenerator schedule}\n\t</div>"
    end


    # Returns html <div> tag (String) with contents of the calendar for the given schedule
    # @param schedule   schedule to create the calendar from
    # @return String with HTML <div> tag for the classes for each day of the week
    private def createCalendarElements schedule
        string = ""
        [:monday, :tuesday, :wednesday, :thursday, :friday].each{|day| string += self.createDay schedule, day}
        string
    end
    # Returns html <div> tag (String) for the given day in the given schedule
    # @param schedule   schedule to access the classes from
    # @param day        symbol for the day to access the classes from
    # @return String with HTML <div> tag for all the classes of given day
    private def createDay schedule, day
        string = "\n\t\t<div>"
        # check if there are classes that day
        unless schedule.schedule[day].length == 0
            # create spacer between start and first class
            dayStart = Event.new "8:00", "8:00", [day]
            firstClass = schedule.schedule[day][0]
            string += HTMLGenerator.createSpacer dayStart.spaceInBetween firstClass.event
            # add classes
            for index in 0...schedule.schedule[day].length do
                string += self.createClass schedule, day, index
                # add spacer if it is not the last class
                unless index == schedule.schedule[day].length - 1
                    string += self.createTravelInfo schedule, day, index
                end
            end
        end
        string + "\n\t\t</div>"
    end


    # creates div HTML tag (String) acting as a spacer between classes
    # @param pixels    Integer for the amount of pizels the height of the spacer is
    # @return String with HTML <div> tag spacer between classes
    def self.createSpacer pixels
        "\n\t\t\t<div style=\"height: #{pixels}px; padding:0\"></div>"
    end


    # creates HTML <div> tag for a class within schedule according to the given day and index within the hash map
    # @param schedule   schedule to access the class from
    # @param day        symbol for the day to access the classes from schedule
    # @param index      Integer index of the day to create the div class for
    # @return String with HTML <div> tag representing the given class
    private def createClass schedule, day, index
        selectedClass = schedule.schedule[day][index]
            color = COLORS[(schedule.classes.find_index selectedClass).to_i]
        if selectedClass.event != nil
            "\n\t\t\t<div class=\"class\" style=\"background-color: #{color}; height: #{selectedClass.event.length}px \">\n\t\t\t\t<span class=\"className\"> #{selectedClass.className}</span><br>\n\t\t\t\t<span class=\"classInfo\">#{selectedClass.location.name}<br>#{selectedClass.event.startTime} - #{selectedClass.event.endTime}<br>#{selectedClass.instructor}</span>\n\t\t\t</div>"
        else
            "\n\t\t\t<div class=\"class\" style=\"background-color: #{color}; height: 30px;\">\n\t\t\t\t<span class=\"className\"> #{selectedClass.className}</span><br>\n\t\t\t\t<span class=\"classInfo\">#{selectedClass.instructor}</span>\n\t\t\t</div>"
        end
    end


    # creates HTML div tag showing walking, biking, and driving times from a class to another class
    # @param schedule   schedule to access the information from
    # @param day        symbol for the day to create the travel info for
    # @param index      Integer index of the class before the travel info
    # @return String with HTML <div> tag representing the travel info between the two classes
    private def createTravelInfo schedule, day, index
        selectedClass = schedule.schedule[day][index]
        nextClass = schedule.schedule[day][index + 1]
        height = selectedClass.event.spaceInBetween nextClass.event
        if height >= 50
            str = "\n\t\t\t<div class=\"between\" style=\"height: #{height}px\">\n\t\t\t\t<span>walking <i class=\"fa fa-male\"></i>: #{selectedClass.location.walkingTime nextClass.location} minutes</span>\n\t\t\t\t<span>biking <i class=\"fa fa-bicycle\"></i>: #{selectedClass.location.bikingTime nextClass.location} minutes</span>\n\t\t\t\t<span>driving <i class=\"fa fa-car\"></i>: #{selectedClass.location.drivingTime nextClass.location} minutes</span>\n\t\t\t</div>"
        elsif height >= 15
            str = "\n\t\t\t<div class=\"between\" style=\"height: #{height}px\">\n\t\t\t\t<span>walking <i class=\"fa fa-male\"></i>: #{selectedClass.location.walkingTime nextClass.location} minutes</span>\n\t\t\t</div>"
        else
            str = HTMLGenerator.createSpacer height
        end
        str
    end
    

    # creates HTML div tag displaying asynchronous classes
    # @return String with HTML <div> tag representing the asynchronous classes of the @schedulToCreate
    private def createAsynchInfo schedule
        str = ""
        if schedule.schedule[:asynch].length > 0
            str = "\n\t<div class=\"asynchronous\">"
            for i in 0...schedule.schedule[:asynch].length do 
                str += self.createClass schedule, :asynch, i
            end
            str += "\n\t</div>"
        end
        str
    end


    # creates HTML button tag for the next and previous buttons
    # @return |String| with HTML <button> tag representing the next and previous buttons
    private def buttonGenerator schedule
        str = ""
        if @schedulesToGenerate.length > 1
            str = "\n\t<div class=\"button\">"
            i = @schedulesToGenerate.find_index(schedule)
            if i == 0
                str += "\n\t\t<button class=\"next-button\" onclick=\"showOtherCalendar('calendar#{i}', 'calendar#{i + 1}')\">next</button>"
            elsif i == @schedulesToGenerate.length - 1
                str += "\n\t\t<button class=\"prev-button\" onclick=\"showOtherCalendar('calendar#{i}', 'calendar#{i - 1}')\">previous</button>"
            else
                str += "\n\t\t<button class=\"prev-button\" onclick=\"showOtherCalendar('calendar#{i}', 'calendar#{i - 1}')\">previous</button>"
                str += "\n\t\t<button class=\"next-button\" onclick=\"showOtherCalendar('calendar#{i}', 'calendar#{i + 1}')\">next</button>"
            end
            str += "\n\t</div>"
        end
        str
    end
end
