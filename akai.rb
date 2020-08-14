#!/usr/bin/env ruby
require "open3"
require "./commands.rb"
=begin
20:0   Note off                0, note 1, velocity 127
20:0   Control change          0, controller 19, value 103
=end

init()

IO.popen("aseqdump -p 20").each do |fd|
	s = fd.strip
	begin
		midi_input =	[ s.match(/ .*  /)[0].strip,
				  s.match(/.*0, ([^,]*),/)[1].strip.match(/ (.*)/)[1].to_i,
				  s.match(/.*0, [^,]*, (.*)/)[1].strip.match(/ (.*)/)[1].to_i
				]
	rescue
  		midi_input = ["0", 0, 0]
  	end
  	# see commands.rb
	handle_input(midi_input)
	
	if(midi_input[0].include? "Note on") and (midi_input[1] == 27) then
		begin
			puts "RELOADING CODE..."
			load("./commands.rb")
			init()
			puts "CODE RELOADED"
		rescue Exception => e
    			puts "ERROR RELOADING CODE: ", e
    			puts "RELOADING SAFE CODE..."
    			load("./safe_commands.rb")
    			init()
			puts "SAFE CODE RELOADED"
		end
	end
	
end
