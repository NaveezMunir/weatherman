# frozen_string_literal: true

require 'colorize'
require './month_average'
require './month_record'
require './year_record'
first_param = ARGV[0].to_s
second_param = ARGV[1].to_s
third_param = ARGV[2].to_s
case first_param
when '-a'
  average = MonthAverage.new(second_param, third_param)
  average.display
when '-c'
  month_record_display = MonthRecord.new(second_param, third_param)
  month_record_display.display
when '-e'
  year = YearRecord.new(second_param, third_param)
  year.display
end
