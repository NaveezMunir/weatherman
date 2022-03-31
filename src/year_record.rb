# frozen_string_literal: true

require 'csv'
require 'colorize'
require 'date'
class YearRecord
  def initialize(data, city)
    data = data.split('/')
    @year = data[0]
    cityname = city.split('/')
    @city = cityname[0].downcase
    @maximum_temp = 0
    @maximum_temp_date = ''
    @minimum_temp = 50
    @minimum_temp_date = ''
    @max_humd = 0
    @max_humd_date = ''
  end

  def set_min_temp(temp, date)
    if temp.nil? || temp == 'Min TemperatureC'
      nil
    elsif temp.to_i < @minimum_temp
      @minimum_temp = temp.to_i
      @minimum_temp_date = date

    end
  end

  def set_max_temp(temp, date)
    if temp.nil? || temp == 'Max TemperatureC'
      nil
    elsif temp.to_i > @maximum_temp
      @maximum_temp = temp.to_i
      @maximum_temp_date = date
    end
  end

  def set_max_humd(humd, date)
    if humd.nil? || humd == 'Max humderatureC'
      nil
    elsif humd.to_i > @max_humd
      @max_humd = humd.to_i
      @max_humd_date = date
    end
  end

  def read_single_file(name, record_num)
    first_value = record_num
    filedata = CSV.open(name.to_s, headers: true)
    filedata.each do |row|
      if !row[3].nil? && first_value.zero? && row[3] != 'Min TemperatureC'
        @minimum_temp = row[3].to_i
        first_value += 1
      elsif @city != 'lahore' && first_value.zero?
        @minimum_temp = row[3].to_i
      end
      set_max_temp(row[1], row[0])
      set_min_temp(row[3], row[0])
      set_max_humd(row[7], row[0])
      first_value += 1
      # puts "testing val of j #{j}"
    end
  end

  def readfile
    record_num = 0
    @city = @city.capitalize if @city == 'dubai' || @city == 'murree'
    arr = Dir.glob("./#{@city}_weather/#{@city}_weather_#{@year}_*.txt")
    arr.each do |name|
      read_single_file(name, record_num)
      record_num += 1
    end
  end

  def display
    readfile
    d1 = Date.parse(@maximum_temp_date)
    max_temp_date = d1.strftime('%a %d %b %Y')
    d2 = Date.parse(@minimum_temp_date)
    min_temp_date = d2.strftime('%a %d %b %Y')
    d3 = Date.parse(@max_humd_date)
    max_humd_date = d3.strftime('%a %d %b %Y')
    puts "Hingest temp :#{@maximum_temp}C #{max_temp_date} "
    puts "Lowest temp :#{@minimum_temp}C #{min_temp_date} "
    puts "Humid :#{@max_humd}% #{max_humd_date} "
  end
end
