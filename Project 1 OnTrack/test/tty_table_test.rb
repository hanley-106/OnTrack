# Created by Von M 1/24/2020

require "tty-table"

table = TTY::Table.new ['header1','header2'], [['a1', 'a2'], ['b1', 'b2']]

puts table.render(:ascii)
