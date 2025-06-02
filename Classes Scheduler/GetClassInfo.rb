# Created 9/25/2023 by Landon McElroy
# Edited 10/09/2023 by Lucky Katneni (added getClassDescrip method)

require 'mechanize'
require 'nokogiri'
require_relative "Event"
require_relative "Location"
require_relative "ClassOSU"
require_relative "ScheduleGeneration"

module GetClassInfo

    # Created 10/09/2023 by Khushi Patel
    BUILDINGNAMES = {
        "HI" => "Hitchcock Hall",
        "ML" => "Mendenhall Laboratory",
        "CL" => "Caldwell Laboratory",
        "BE" => "Baker Systems Engineering",
        "DL" => "Dreese Laboratory",
        "SOE" => "Scott Laboratory",
        "SON" => "Scott Laboratory",
        "SM" => "Smith Laboratory",
        "CBEC" => "Chemical and Biomolecular Engineering and Chemistry Building",
        "EA" => "Enarson Classroom Building",
        "JR" => "Journalism Building",
        "KN" => "Knowlton Hall",
        "PS" => "Psychology Building",
        "PO" => "Pomerene Hall",
        "RA" => "Ramseyer Hall",
        "CH" => "Cockins Hall",
        "EN" => "Enarson Hall",
        "HA" => "Hagerty Hall",
        "AP" => "Arps Hall",
        "DB" => "Derby Hall",
        "BO" => "Bolz Hall",
        "TO" => "Townshend Hall",
        "SB" => "Schoenbaum Hall",
        "FL" => "Fontana Laboratory",
        "HC" => "Hopkins Hall",
        "EL" => "Evans Laboratory",
        "UH" => "University Hall",
        "MP" => "McPherson Laboratory"
    }

    # Created 10/09/2023 by Khushi Patel
    DAYNAMES = {
        "M" => "monday",
        "T" => "tuesday",
        "W" => "wednesday",
        "R" => "thursday",
        "F" => "friday",
    }

    # Created 9/25/2023 by Landon McElroy
    # generates the class name given its department and class number
    # @return [Array] the class information
    def self.className 
        decision = nil
        # User input
        classCombo = GetClassInfo.getUserData
        allClasses = []
        # get information for class numbers
        classCombo.each{|classNum| allClasses << GetClassInfo.getClassData(classNum)}
        # create schedules and html file 
        createdSchedule = ScheduleGeneration.new allClasses
        createdSchedule.createHTMLSchedule "Schedules"     
    # return classCombo
    end

    # Created 9/25/2023 by Landon McElroy
    # Prompts user to input class number(s) and outputs an array with said number(s)
    # @return [Array] the class information
    def self.getUserData
        decision = nil
        classNums = []
        while decision != "n" do
            print "Enter class number: "
            class_number = gets.chomp
            while class_number.length != 4 do
                print "Invalid input. Please enter a 4 digit number: "
                class_number = gets.chomp
            end
            print "Would you like to add any other classes? (y/n): "
            decision = gets.chomp
            classNums.push class_number
            if decision == "n" && classNums.length == 1
                puts "You have added #{classNums.length} class."
            elsif decision == "n" && classNums.length > 1
                puts "You have added #{classNums.length} classes."
            elsif decision != "y" && decision != "n"
                print "Invalid input. Please enter y or n: "
                decision = gets.chomp
            end
        end
        classNums
    end

    # Created 9/25/2023 by Landon McElroy
    # Edited 10/8/2023 bu Khushi Patel (created a valid class objects for data)
    # use user inputted class number to search for a link containing the same number
    # if found, get the text of the link
    # if not found, return an error message and exit
    # @param classNumber the class number
    # @return [Array] the class information
    def self.getClassData classNumber
        allClasses = []
        agent = Mechanize.new
        page = agent.get "https://cse-portal.webapps.engineering.osu.edu/oportal/schedule_display/index?strm=1238&catalog_nbr=&location=&instructor="
        doc = Nokogiri::HTML page.body

        if element = doc.css('a').find { |a| a.text.include?(classNumber) }
            className = element.text.match(/([A-Z]{2,}\s\d{4})/)[1]
            puts "Class name: #{className}"
            puts getClassDescrip(classNumber)
            # modify URL to include catalog number and get page HTML
            page = agent.get "https://cse-portal.webapps.engineering.osu.edu/oportal/schedule_display/index?strm=1238&catalog_nbr=#{classNumber}&location=&instructor="
            doc = Nokogiri::HTML page.body

            # get the table element
            table = doc.css("div#c#{classNumber} table.table-condensed")

            # loop through the rows and extract the data from each cell
            table.css('tr').each do |row|
                cells = row.css 'td'
                data = cells.map { |cell| cell.text.strip }
                data.reject! &:empty?
                
            
                # check if data is not empty before accessing its elements
                unless data.empty?
                    data.flatten!
                    classSection = data[0].gsub(/\s+/, "")
                    formattedLocation = BUILDINGNAMES[data[2].gsub(/\d+/, "")]
                    days = []
                    DAYNAMES.each do |letter, day|
                        if data[3].include? letter
                            days << day
                        end
                    end
                    startTime = data[3].slice(-13, 6)
                    endTime = data[3].slice(-5, 5)
                    instructor = data[4]
                    
                    # create class object
                    newClass = ClassOSU.new className, classSection, startTime, endTime, days, formattedLocation, instructor, GetClassInfo.getClassDescrip(classNumber)

                    # add class object to array
                    allClasses << newClass
                end
            end
        end
        allClasses
    end


    # Created 10/09/2023 by Lucky Katneni
    # Uses the class number to get the class description
    # @param classNumber the class number
    # @return [String] the class description
    def self.getClassDescrip classNumber
        agent = Mechanize.new
        page = agent.get "https://cse.osu.edu/courses"

        doc = Nokogiri::HTML page.body

        # check if the class number is valid
        element = doc.css('span.accordion-title').find { |span| span.text.include?("CSE #{classNumber}") }
        if element
            # modify URL to include catalog number and get page HTML
            page = agent.get "https://cse.osu.edu/courses?name=CSE%20#{classNumber}&field_subject_target_id=All&field_campus_target_id=All&field_academic_career_target_id=All&field_level_target_id=All"
            doc = Nokogiri::HTML page.body

            descriptionElement = doc.at_css('p.description')

            if descriptionElement
                descriptionElement.text
            else
                "Description is not available"
            end
        else
            puts "Error: Catalog number not found"
        end
    end
    GetClassInfo.className
end
   