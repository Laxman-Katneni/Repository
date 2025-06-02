# Created 10/2/2023 by Landon McElroy
# Edited 10/09/2023 by Lucky Katneni (added test cases for getClassDescription)

require 'mechanize'
require 'nokogiri'
require_relative '../GetClassInfo'
require 'test/unit'

class TestGetClassInfo < Test::Unit::TestCase

    # Created 09/29/2023 by Landon McElroy
    def test_classInfo_getClassNumber
        # generate sample user input for department and class number
        department = "CSE"
        class_number = "2421"

        # use user inputted department and class number to search for a link containing the same number
        agent = Mechanize.new;
        page = agent.get "https://cse-portal.webapps.engineering.osu.edu/oportal/schedule_display/index?strm=1238&catalog_nbr=&location=&instructor=&commit=Clear+Filters"
        html_string = page.body
        doc = Nokogiri::HTML(html_string)
        element = doc.css('a').find { |a| a.text.include?(department && class_number)}
        text = element.text
        assert_equal("CSE 2421 Systems I: Introduction to Low-Level Programming and Computer Organization U 4", text)
    end

    # Created 10/09/2023 by Lucky Katneni
    def test_getClassDescrip
        classNumber = "2421"
        expectedDescrip = "Description: Introduction to computer architecture at machine and assembly language level; pointers and addressing; C programming at machine level; computer organization.\nPrereq: 2122, 2123, or 2231; and 2321 or Math 2566; and enrollment in CSE, CIS, Data Analytics, Music (BS), Eng Physics, or Math major. Units: 4.0"

        assert_equal(expectedDescrip, GetClassInfo.getClassDescrip(classNumber))
    end
end