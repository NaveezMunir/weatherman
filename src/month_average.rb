# frozen_string_literal: true

require 'csv'
require 'colorize'
require 'date'
class MonthAverage
  def initialize(data, city)
    data = data.split('/')
    @year = data[0]
    @month = data[1]
    cityname = city.split('/')
    @city = cityname[0].downcase
    @sum_max = 0
    @sum_min = 0
    @sum_hum = 0
    @count_max = 0
    @count_min = 0
    @count_humd = 0
    @maximum_temp = 0
    @minimum_temp = 0
    @showresult = true
  end

  def set_month_name
    @month = Date::ABBR_MONTHNAMES[@month.to_i]
    @city = @city.capitalize if @city == 'dubai' || @city == 'murree'
  end

  def add_min_temp(temp, date)
    if temp.nil? || date.include?('<!--') || temp == 'Min TemperatureCC'
      false
    else
      @count_min += 1
      @sum_min += temp.to_i
    end
  end

  def add_max_temp(temp, date)
    if temp.nil? || date.include?('<!--') || temp == 'Max TemperatureCC'
      false
    else
      @count_max += 1
      @sum_max += temp.to_i
    end
  end

  def add_humd(humd, date)
    if humd.nil? || date.include?('<!--') || humd == 'Mean Humidity'
      false
    else
      @count_humd += 1
      @sum_hum += humd.to_i
    end
  end

  def read_file
    if File.file?("./#{@city}_weather/#{@city}_weather_#{@year}_#{@month}.txt")
      filedata = CSV.open("./#{@city}_weather/#{@city}_weather_#{@year}_#{@month}.txt", headers: true)
      filedata.each do |row|
        add_max_temp(row[1], row[0])
        add_min_temp(row[3], row[0])
        add_humd(row[8], row[0])
      end
    else
      @showresult = false
      puts ' sorry no record exists'.red
    end
  end

  def display_results
    puts "Highest Average: #{@sum_max / @count_max}C"
    puts "Lowest Average: #{@sum_min / @count_min}C"
    puts "Average Humidity: #{@sum_hum / @count_humd}%"
  end

  def display
    set_month_name
    read_file
    display_results if @showresult
  end
end
