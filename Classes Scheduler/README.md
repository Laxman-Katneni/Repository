# Project-3-Runtime-Terror

3901

## Execution Instructions

Install mechanize, nokogiri, and geocoder:
    - gem install mechanize
    - gem install nokogiri
    - gem install geocoder

To run the GetClassInfo.rb file, simply type this into the terminal -> Ruby "getClassInfo.rb
To run the test cases for GetClassInfo.rb file simply type this into the terminal -> sudo ruby test/TestGetClassInfo.rb

Description of what we made:

This program will scrape all of the class information from URLs <https://cse-portal.webapps.engineering.osu.edu/oportal/schedule_display> and <https://cse.osu.edu/courses?name=CSE%20&field_subject_target_id=All&field_campus_target_id=All&field_academic_career_target_id=All&field_level_target_id=All>
    It will ask user for an input of what classes (class numbers) they wish to add to the schedule.
    It then prints them all in one array with it's specific class section numbers, class times, days, instructors, and locations.
    Then it will generate html file with all the possible schedules with no time conflicts
    It also prints to the console a short description of the course you are wishing to take

## Managers

    - Landon McElroy, Overall Project Manager
    - Jason Su, Implementation Manager
    - Lucky Katneni, Documentation Manager
    - Victor Madelaine, Testing Manager
    - Khushi Patel, Meeting Manager

## Test Plan

Tested all the classes in our repository in the test folder to ensure they weren't broken.

Concepts applied from lectures:
    - Regular expressions
    - Code blocks
    - Hash maps/ Data structures
    - Symbols
    - Class definitions, self methods, instance variables, class variables and modules
    - Loop statements: while, until, for-in, for-each

## Contribution

- Landon contributed in GetClassInfo.rb (mechanize), htmlGenerator.rb, test.html, button functionality between schedules, and some test cases
- Victor contributed in ClassOSU.rb, Event.rb, GetClassInfo.rb, htmlGenerator.rb, test.html, Location.rb, Schedule.rb and ScheduleGeneration.rb, including css, html portion and their test cases
- Lucky contributed in Location.rb, Event.rb, GetClassInfo.rb (scrape another website) and test cases
- Jason contributed in Schedule.rb and ScheduleGeneration.rb and their test cases
- Khushi contributed in ClassOSU.rb, ScheduleGeneration.rb and GetClassInfo.rb and their test cases

## First Meeting

    Meeting Time: Sep. 25, Mon, 17:00 - 19:00 (weekly mandatory meeting)
    Goal of the Meeting: Complete the “Managers, use cases, and the first sprint” assignment
    Attendees: Landon, Victor, Jason, and Khushi
    Notes: Lucky wasn’t able to attend the meeting due to the time constraint on his flight.
    Contribution:
        - All team members worked together and participated fully in the discussions.
        - Determined all the use cases for the Web Scraping (details included in 3.)
        - The team decided to scrape CSE Class Schedule for project 3.
        - Designed the test plan and decided what to do for our sprints (details included in 4.)
        - Victor created some function definition in class Schedule
        - Landon created some function definition in class Class
        - Created classes for testClasses and testSchedule.
        - Determine what class Class and class Schedule should include.
        - Decided what each team member should work on in class Class and class Schedule during our first sprint, making sure everyone gets an equal amount of work to do.
        - Decided on the meeting time for this week to work on the first sprint
        - Wed. 18:00 - TBD (mandatory meeting)

## Sprint #1

    Meeting Record (Sprint #1)
    Meeting Time: Sep. 27, Wed, 17:00 - 19:00 
    Goal of the Meeting: Complete the assigned tasks for each member from last meeting
    Attendees: Landon, Victor, Jason, Khushi and Lucky
    Notes: Victor wasn’t able to attend the meeting due sickness, however, he did finish his portion and collaborated with us through text to determine what we should achieve this week.
    Contribution:
        - All team members worked together and participated fully in the discussions.
        - Landon worked on getting mechanize and nokogiri to work and worked on test cases as well
        - Victor created an Event.rb, Location.rb files and worked on documenting the files
        - Jason worked on dayStartTime test cases and dayStartTime methods
        - Khushi worked on departmentHash and classhash function and created test cases for them
        - Lucky worked on location.rb file, getting distance to and from class via walking, biking, and driving

    Achieved:
        - Mechanize and Nokogiri installed successfully with no errors or warnings
        - Started writing test cases
        - Completed most of the methods that were assigned to each team member

    Mandatory Meeting: Oct. 2 , Mon, 17:30 - 19:00
    Next Sprint Meeting: Oct. 4 , Wed, 17:30 - TBD

## Second Meeting

    Meeting Record (Second Team Meeting and Sprint #2)
    Meeting Time: Oct 2, Mon, 17:00 - 18:15 (weekly mandatory meeting)
    Goal of the Meeting: to finish up the methods in all the classes and work on mechanize
    Attendees: Landon, Victor, Jason, Lucky, and Khushi
    Contribution:
        - All team members engaged in the discussion 
        - Victor worked on fixing Schedule.rb Class to clean up bugs
        - Landon worked on getting mechanize to work for all the classes that user inputs, class names, .click to gather more information
        - Jason worked on finishing up noConflict? function in Schedule.rb Class
        - Lucky worked on Event and Location class, and the test cases for them
        - Khushi worked on generateAllSchedule in Event.rb class and worked on README.md file
    Achieved:
        - Finished all the functions in Event.rb and Location.rb Classes
        - Fixed a bug in Schedule.rb Class with generateSchedule
        - Worked on documentation for all the classes edited

    Next Sprint Meeting: Oct 4, Wed, 17:30 - TBD

## Sprint #2

    Meeting Record (Sprint #2)
    Meeting Time: Oct 4, Wed, 17:30 - 18:15 
    Goal of the Meeting: to finish up the methods in all the classes and work on mechanize
    Attendees: Landon, Victor, Jason, Lucky, and Khushi
    Contribution:
        - All team members engaged in the discussion 
        - Victor worked on scraping part of the project and created getClassCombinations in ScheduleGenereation file
        - Landon worked on scraping the website
        - Jason worked on new methods for class start times and end times
        - Lucky worked on managing the time, worked on an option for military time or a standard time for schedule
        - Khushi worked on generateAllSchedule test cases  and worked on README.md file
        - All of us needed to work on documentation, put single line comments within block of code.
    Achieved:
        - Finished all the functions remaining
        - Achieved almost all the core function that we would need as of now while working in scraping
        - Worked on documentation for all the classes edited/created
        - We figured out how to run GetClassInfo file, just type Ruby "getClassInfo.rb" into the terminal
        - To run it's test cases, we used "sudo ruby test/TestGetClassInfo.rb" (ignore " ")

    Next Mandatory Meeting: Oct 9, Mon, 17:30 - TBD

## Third Meeting

    Meeting Record (Third Team Meeting and Sprint #3):
    Meeting Time: Oct 9, Mon, 17:00 - 18:15 (weekly mandatory meeting)
    Goal of the Meeting: to fix some issues and make sure everything works fine before next sprint starts
    Attendees: Landon, Victor, Jason, Lucky, and Khushi
    Contribution:
        - We made sure everyone was on track with their tasks.
        - Everyone started working on what they had left to implement
        - Victor worked on the frontend side of the project, schedule1.html, schedule2.html, htmlGenerator.rb file
        - Landon added buttons to front end to scroll through the schedules
        - Khushi worked on GetClassInfo.rb file to convert the data into vlaid class objects and worked on createClassFromData function to get values of the buildings for us to use geocoder for location and README.md file. 
        - Lucky worked on getClassDescrip, sample.rb, test2.html and output.html file to scrape another website.
        - Jason worked on the test cases for the methods he created.

    Achieved:
        - Made sure all data is converted to the valid class object.
        - Fixed bugs in getting data from website.
        - Made sure we only pushed well documented code.

    Next Sprint Meeting: Oct 11, Wed, 17:30 - TBD

## Sprint #3

    Meeting Record (Sprint #3):
    Meeting Time: Oct 11, Wed, 17:30 - 18:15
    Goal of the Meeting: to submit the project
    Contribution:
        - We all worked on getting this project done and have it submitted in a timely manner.

    Achieved:
        - Project submission.
