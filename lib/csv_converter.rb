require 'csv'

class CsvConverter

	def convert_file(file)
		text_file = open file, 'r+'
		insert_commas = text_file.readlines.map { |e| e.gsub! /\s+/, ',' }
		text_file.rewind
		text_file.puts insert_commas
		text_file.close



		# file = File.readlines(file).each do |line|
		# 	line.gsub! /\s+/, ','
		# end
	 #  string_file = file.join("")
	end

end