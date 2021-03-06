# RUN "RESET" AFTER RUNNING THIS SCRIPT TO GET BACK TERMINAL INPUT(PROBLEM ISSUE WITH TERMINAL CONTROL CHARACTERS IN THREADS LOCKING IT UP)

# TODO ADD PITCH IN PLACE OF ONE FADER OF THE REVERB!!!
=begin

16 20 24 28 46 50 54 58 | XX
17 21 25 29 47 51 55 59 | 25
18 22 26 30 48 52 56 60 | 26
-------------------------
01 04 07 10 13 16 19 22   27
03 06 09 12 15 18 21 24
-------------------------
19 23 27 31 49 53 57 61   62

Les knobs et faders vont de 0 à 127.
les boutons sont "Note on" quand activé avec une valeur fixe à 127.

=end

def init()
#	puts "init()..."
	$TONE_MAX = 100
	$TIME_CHANGE_TONE = 50
end

def synth_square()
	in_cycle = 0
	period = 10 # SAMPLING_FREQUENCY / FREQUENCY.to_f
	i = 0
	j = $TIME_CHANGE_TONE
	samples = 150000.times.map do  # le temps total ou l'on va generer, chaque entier 1 par 1(times.map)
		output = in_cycle > 0.5 ? -0.5 : 0.5 # le 1er 0.5 est la periode su signal carré et les 2 autre 0.5 r
		in_cycle = (in_cycle + (1.0 / period)) % 1.0 # on garde un rapport de ratio avec le 1.0 /period
	  	
	  	# TONALITEE
		i+=1
  		if(i >= j) then # ici on choisi de changer la period(tonalité tt les 500 temps)
   			period = 10 + rand($TONE_MAX)
   			i = 0
  		end
  		j = $TIME_CHANGE_TONE

  		# TEMPS AUQUEL LA TONALITEE CHANGERA...
  		#j += 0.01 # ici on change la vitesse de repetition du block precedent(voir i == j)
  		#if(j >= 2000) then
   		#	j = 50
  		#end

  		output * 0.2 # 0.2 ici baisse le volume, alors que 2.0 l'augmenterais
	end
	print samples.pack('e*')
end

=begin
def synth_square_bis()
	in_cycle = 0
	period = 10 # SAMPLING_FREQUENCY / FREQUENCY.to_f
	i = 0
	j = $TIME_CHANGE_TONE
	samples = []
	0.upto(50000){
	#samples = 500000.times.map do  # le temps total ou l'on va generer, chaque entier 1 par 1(times.map)
		output = in_cycle > 0.5 ? -0.5 : 0.5 # le 1er 0.5 est la periode su signal carré et les 2 autre 0.5 r
		in_cycle = (in_cycle + (1.0 / period)) % 1.0 # on garde un rapport de ratio avec le 1.0 /period
	  	
	  	# TONALITEE
		i+=1
  		if(i >= j) then # ici on choisi de changer la period(tonalité tt les 500 temps)
   			period = 10 + rand($TONE_MAX)
   			i = 0
  		end
  		j = $TIME_CHANGE_TONE

  		# TEMPS AUQUEL LA TONALITEE CHANGERA...
  		#j += 0.01 # ici on change la vitesse de repetition du block precedent(voir i == j)
  		#if(j >= 2000) then
   		#	j = 50
  		#end

  		samples += [ output * 0.2 ]# 0.2 ici baisse le volume, alors que 2.0 l'augmenterais
	#end
	}
	print samples.pack('e*')
end
=end

# ------------------------------------------------------------------------
# Returns linear 0...X from the MIDI assigned ID from AKAI ---------------
$midi_pad_num_ids = [ 1,3,4,6,7,9,10,12,13,15,16,18,19,21,22,24 ]
def get_linear_PAD_ID(midi_input_1) # midi_input[1]
	id = -1
	0.upto($midi_pad_num_ids.size - 1){ |i|
		if(midi_input_1 == $midi_pad_num_ids[i]) then
			id = i;
			break
		end
	}
	return id
end
# ------------------------------------------------------------------------

def handle_input(midi_input = [ "0", 0, 0 ]) # midi_input = [ midi_name(string), midi_ID(int), midi_val(int 0-127) ]
####	puts midi_input.inspect

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	if(midi_input[0].include? "Note on") then
		# button to change samples bank to the left
		if (midi_input[1] == 26) then
		end
		# button to change samples bank to the right
		if (midi_input[1] == 25) then
		end
		# line 1 and 2 buttons plays samples - plays samples
	  	if (midi_input[1] < 16) then #
			id = get_linear_PAD_ID(midi_input[1])
		end
		# 
		if (midi_input[1] == 16) then
		end
		# 
		if (midi_input[1] == 18) then
		end
		# 
		if (midi_input[1] == 19) then
		end
		# 
		if (midi_input[1] == 21) then
		end
		# last button before 'solo', line 1 -
		if (midi_input[1] == 22) then
		end
		# last button before 'solo', line 2 - stops all sample plays instantly
		if (midi_input[1] == 24) then
#			puts "Play synth!"
			#Thread.new(){ 
			#	system("#{synth_square()} | play -t raw -b 32 -r 44100 -c 1 -e floating-point --endian little - ") 
			#}
			Thread.new(){
				synth_square()
			}
		end
	end
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


	####### PADS
	#######
	if(midi_input[0].include? "Note on") then
  		case midi_input[1]
			when 1;
			when 3;
			when 4;
			when 6;
			when 7;
			when 9;
			when 10;
			when 12;
			when 13;
			when 15;
			when 16;
			when 18;
			when 19;
			when 21;
			when 22;
			when 24;
  		end
  	end
  	
  	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# last line of knobs affect samples played with buttons
	if(midi_input[0].include? "Control") then
  		case midi_input[1]
			when 18; $TONE_MAX = midi_input[2] / 128.0 * 1000
			when 22; $TIME_CHANGE_TONE = midi_input[2] / 128.0 * 1000
				
			when 26;
				
			when 30;
				
			when 48;
				
			when 52;
				
			when 56;
				
			when 60;
			when 49;
				
			when 53;
				
			when 57;
				
			when 61;

			when 62;
		end
	end
  	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  	
	###### FADERS AND KNOBS
	######
	if(midi_input[0].include? "Control") then
=begin
  		case midi_input[1]
			#when 17;	t = Thread.new(){
			#			system("play 'Samples/Alien Intelligence watching us - It conquered the world 1956.ogg' speed #{midi_input[2] / 128.0 * 5.0} > /dev/null 2>&1")
			#		}
			
			#when 17;	$SLEEPME03 = midi_input[2] / 128.0 * 4
		end
=end
	end
end
