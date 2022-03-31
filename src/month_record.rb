# frozen_string_literal: false

require 'csv'
require 'colorize'
class MonthRecord
  def initialize(data, city)
    data = data.split('/')
    @year = data[0]
    @month = data[1]
    cityname = city.split('/')
    @city = cityname[0].downcase
    @line_num = '00'
  end

  def set_monthname
    @month = Date::ABBR_MONTHNAMES[@month.to_i]
    @city = @city.capitalize if @city == 'dubai' || @city == 'murree'
  end

  # task 3
  def display_chart_double_line(max_temp, min_temp, num)
    if max_temp.nil? || max_temp == 'Max TemperatureCC'
      return false
    else
      print "#{num} "
      temp = max_temp.to_i
      temp.times do
        print '+'.red
      end
      puts " #{max_temp.to_i}C "
    end

    if min_temp.nil? || min_temp == 'Min TemperatureCC'
      false
    else
      print "#{num} "
      temp = min_temp.to_i
      temp.times do
        print '+'.blue
      end
      puts " #{min_temp.to_i}C "
    end
  end

  # task 4
  def display_chart(max_temp, min_temp)
    if max_temp.nil? || max_temp == 'Max TemperatureCC'
      return false
    else
      temp = max_temp.to_i
      temp.times do
        print '+'.red
      end
    end
    if min_temp.nil? || min_temp == 'Min TemperatureCC'
      return false
    else
      temp = min_temp.to_i
      temp.times do
        print '+'.blue
      end
    end

    print " #{max_temp.to_i}C-#{min_temp.to_i}C "
  end

  def readfile
    if File.file?("./#{@city}_weather/#{@city}_weather_#{@year}_#{@month}.txt")
      filedata = CSV.open("./#{@city}_weather/#{@city}_weather_#{@year}_#{@month}.txt", headers: true)
      filedata.each do |row|
        next unless @line_num.to_i <= 30

        display_chart_double_line(row[1], row[3], @line_num.next!)
        print "#{@line_num} "
        display_chart(row[1], row[3])
        puts ''
      end
    else
      puts ' sorry no record exists'.red
    end
  end

  def display
    set_monthname
    readfile
  end
end
