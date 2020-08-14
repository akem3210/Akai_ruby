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

# Note: We use 'play' but 'sox' can be used too
# 'soxi -D sample.wav' returns the duration in seconds.
# "sox "/mnt/D/Meme_Samples/Alice/A Very Merry Unbirthday to You-iL2Wm-PcfPo.ogg" -t alsa" use "sox" instead of "play" to play sound
=begin
-----------------------------------------------------------------------------------------------
PHASER

play -v 1.0 /mnt/D/Meme_Samples/SONGS/Song_2_Mexico.ogg rate ----phaser 0.6 0.66 3 0.6 2 -t----

 phaser gain-in gain-out delay decay speed [-s|-t]
              Add a phasing effect to the audio.  See [3] for a detailed description of phasing.

              delay/decay/speed gives the delay in milliseconds and the decay (relative to gain-in) with a  modula‐
              tion  speed  in Hz.  The modulation is either sinusoidal (-s)  - preferable for multiple instruments,
              or triangular (-t)  - gives single instruments a sharper phasing effect.  The decay  should  be  less
              than 0.5 to avoid feedback, and usually no less than 0.1.  Gain-out is the volume of the output.

              For example:
                 play snare.flac phaser 0.8 0.74 3 0.4 0.5 -t
              Gentler:
                 play snare.flac phaser 0.9 0.85 4 0.23 1.3 -s
              A popular sound:
                 play snare.flac phaser 0.89 0.85 1 0.24 2 -t
              More severe:
                 play snare.flac phaser 0.6 0.66 3 0.6 2 -t
-----------------------------------------------------------------------------------------------
FLANGER

play -v 1.0 /mnt/D/Meme_Samples/SONGS/Song_2_Mexico.ogg rate 44100 speed 1.0 flanger 3 9.5 0 70 2 sin 100 quadratic

       flanger [delay depth regen width speed shape phase interp]
              Apply a flanging effect to the audio.  See [3] for a detailed description of flanging.

              All parameters are optional (right to left).

                                          Range     Default   Description
                                delay     0 - 30       0      Base delay in milliseconds.
                                depth     0 - 10       2      Added swept delay in milliseconds.
                                regen    -95 - 95      0      Percentage regeneration (delayed
                                                              signal feedback).
                                width    0 - 100      71      Percentage of delayed signal mixed
                                                              with original.
                                speed    0.1 - 10     0.5     Sweeps per second (Hz).
                                shape                 sin     Swept wave shape: sine|triangle.
                                phase    0 - 100      25      Swept wave percentage phase-shift
                                                              for multi-channel (e.g. stereo)
                                                              flange; 0 = 100 = same phase on
                                                              each channel.
                                interp                lin     Digital delay-line interpolation:
                                                              linear|quadratic.

-----------------------------------------------------------------------------------------------
 overdrive [gain(20) [colour(20)]]
              Non linear distortion.  The colour parameter controls the amount of  even  harmonic  content  in  the
              over-driven output.
-----------------------------------------------------------------------------------------------
 pitch [-q] shift [segment [search [overlap]]]
              Change the audio pitch (but not tempo).

              shift  gives  the  pitch  shift as positive or negative `cents' (i.e. 100ths of a semitone).  See the
              tempo effect for a description of the other parameters.

              See also the bend, speed, and tempo effects.
-----------------------------------------------------------------------------------------------
tempo [-q] [-m|-s|-l] factor [segment [search [overlap]]]
              Change the audio playback speed but not its pitch. This effect uses the WSOLA algorithm. The audio is
              chopped  up  into  segments which are then shifted in the time domain and overlapped (cross-faded) at
              points where their waveforms are most similar as determined by measurement of `least squares'.

              By default, linear searches are used to find the best overlapping points. If the optional -q  parame‐
              ter is given, tree searches are used instead. This makes the effect work more quickly, but the result
              may not sound as good. However, if you must improve the processing speed, this generally reduces  the
              sound quality less than reducing the search or overlap values.

              The -m option is used to optimize default values of segment, search and overlap for music processing.

              The  -s  option is used to optimize default values of segment, search and overlap for speech process‐
              ing.

              The -l option is used to optimize default values of segment, search and overlap for `linear' process‐
              ing that tends to cause more noticeable distortion but may be useful when factor is close to 1.

              If -m, -s, or -l is specified, the default value of segment will be calculated based on factor, while
              default search and overlap values are based on segment. Any values you provide still  override  these
              default values.

              factor gives the ratio of new tempo to the old tempo, so e.g. 1.1 speeds up the tempo by 10%, and 0.9
              slows it down by 10%.

              The optional segment parameter selects the algorithm's segment size in  milliseconds.   If  no  other
              flags  are  specified, the default value is 82 and is typically suited to making small changes to the
              tempo of music. For larger changes (e.g. a factor of 2), 41 ms may give a better result.  The -m, -s,
              and  -l flags will cause the segment default to be automatically adjusted based on factor.  For exam‐
              ple using -s (for speech) with a tempo of 1.25 will calculate a default segment value of 32.

              The optional search parameter gives the audio length in milliseconds over which  the  algorithm  will
              search  for overlapping points.  If no other flags are specified, the default value is 14.68.  Larger
              values use more processing time and may or may not produce better results.  A  practical  maximum  is
              half the value of segment. Search can be reduced to cut processing time at the risk of degrading out‐
              put quality. The -m, -s, and -l flags will cause the search  default  to  be  automatically  adjusted
              based on segment.

              The  optional  overlap  parameter gives the segment overlap length in milliseconds.  Default value is
              12, but -m, -s, or -l flags automatically adjust overlap based on segment  size.  Increasing  overlap
              increases  processing  time and may increase quality. A practical maximum for overlap is the value of
              search, with overlap typically being (at least) a little smaller then search.

              See also speed for an effect that changes tempo and pitch together, pitch and bend for  effects  that
              change pitch only, and stretch for an effect that changes tempo using a different algorithm.
-----------------------------------------------------------------------------------------------
       reverb [-w|--wet-only] [reverberance (50%) [HF-damping (50%)
              [room-scale (100%) [stereo-depth (100%)
              [pre-delay (0ms) [wet-gain (0dB)]]]]]]

              Add  reverberation  to the audio using the `freeverb' algorithm.  A reverberation effect is sometimes
              desirable for concert halls that are too small or contain so many  people  that  the  hall's  natural
              reverberance  is  diminished.   Applying  a small amount of stereo reverb to a (dry) mono signal will
              usually make it sound more natural.  See [3] for a detailed description of reverberation.

              Note that this effect increases both the volume and the length of the audio, so to  prevent  clipping
              in these domains, a typical invocation might be:
                 play dry.wav gain -3 pad 0 3 reverb
              The -w option can be given to select only the `wet' signal, thus allowing it to be processed further,
              independently of the `dry' signal.  E.g.
                 play -m voice.wav "|sox voice.wav -p reverse reverb -w reverse"
              for a reverse reverb effect.
-----------------------------------------------------------------------------------------------
       reverse
              Reverse the audio completely.  Requires temporary file space to store the audio to be reversed.
-----------------------------------------------------------------------------------------------
       chorus gain-in gain-out <delay decay speed depth -s|-t>
              Add  a chorus effect to the audio.  This can make a single vocal sound like a chorus, but can also be
              applied to instrumentation.

              Chorus resembles an echo effect with a short delay, but whereas with echo the delay is constant, with
              chorus,  it  is  varied  using sinusoidal or triangular modulation.  The modulation depth defines the
              range the modulated delay is played before or after the delay. Hence the  delayed  sound  will  sound
              slower  or  faster,  that  is the delayed sound tuned around the original one, like in a chorus where
              some vocals are slightly off key.  See [3] for more discussion of the chorus effect.

              Each four-tuple parameter delay/decay/speed/depth gives the delay in milliseconds and the decay (rel‐
              ative  to  gain-in)  with  a  modulation  speed in Hz using depth in milliseconds.  The modulation is
              either sinusoidal (-s) or triangular (-t).  Gain-out is the volume of the output.

              A typical delay is around 40ms to 60ms; the modulation speed is best near 0.25Hz and  the  modulation
              depth around 2ms.  For example, a single delay:
                 play guitar1.wav chorus 0.7 0.9 55 0.4 0.25 2 -t
              Two delays of the original samples:
                 play guitar1.wav chorus 0.6 0.9   50 0.4 0.25 2 -t \
                    		         60  0.32 0.4 1.3 -s
              A fuller sounding chorus (with three additional delays):
                 play guitar1.wav chorus 0.5 0.9 50 0.4 0.25 2 -t \
                    60 0.32 0.4 2.3 -t 40 0.3 0.3 1.3 -s
-----------------------------------------------------------------------------------------------
 treble gain [frequency[k] [width[s|h|k|o|q]]]
              Apply a treble tone-control effect.  See the description of the bass effect for details.
-----------------------------------------------------------------------------------------------
 tremolo speed [depth]
              Apply  a  tremolo (low frequency amplitude modulation) effect to the audio.  The tremolo frequency in
              Hz is given by speed, and the depth as a percentage by depth (default 40).
-----------------------------------------------------------------------------------------------
 trim {position(+)}
              Cuts portions out of the audio.  Any number of positions may be given; audio is not sent to the  out‐
              put  until  the first position is reached.  The effect then alternates between copying and discarding
              audio at each position.  Using a value of 0 for the first position parameter allows copying from  the
              beginning of the audio.

              For example,
                 sox infile outfile trim 0 10
              will copy the first ten seconds, while
                 play infile trim 12:34 =15:00 -2:00
              and
                 play infile trim 12:34 2:26 -2:00
              will both play from 12 minutes 34 seconds into the audio up to 15 minutes into the audio (i.e. 2 min‐
              utes and 26 seconds long), then resume playing two minutes before the end of audio.

-----------------------------------------------------------------------------------------------

=end

# PLAY doz not handle MP3! I can haz Boa.

$meme_samples_dir = "/home/akem/Samples"

# ------------------------------------------------------------------------
def init()	
	puts "init()..."

	###########################################################	
	$meme_samples_filelist = Dir[ "#{$meme_samples_dir}/*.ogg" ]
	$meme_samples_filelist += Dir[ "#{$meme_samples_dir}/*.OGG" ]
	$meme_samples_filelist.sort!
#	puts $meme_samples_filelist.inspect
#	0.upto(13){ |i| puts "#{$meme_samples_filelist[i]}" }
	puts "Loaded #{$meme_samples_filelist.size} samples."
	
	###########################################################	
	$mode_list = [ "Samples",
		       "Drumkits",
		       "Pads",
		       "8Bits",
		       "MP3",
		       "Radio",
		       "Acid"
		     ]
	$mode_id = 0
	$mode = $mode_list[$mode_id]

	###########################################################	
	# Theses variables are used by the sample playing - affected to the last line of knobs and some sliders
	$sample_volume = 1.0
	$sample_speed = 1.0
	$sample_pitch = 0
	$sample_tempo = 1.0 # value 0.1 is so slicing cool, we tasted it!
	$sample_reverse = false
	$sample_sampling_rate = 44100
	$sample_start_pos = 0.0
	$sample_phaser = [ false, 0.95, 0.95, 3, 0.6, 2, "-t" ] # active gain-in gain-out delay decay speed [-s(inusoid)|-t(riangle)]
	$sample_flanger = [ false, 3, 9.5, 0, 70, 2, "sin", 100, "quadratic" ] # [active, delay depth regen width speed shape phase interp]
	$sample_reverb = [ false, 99, 99, 100, 100, 0, 0, ] # active, reverb, HF-damping, room-scale, stereo-depth, pre-delay, wet-gain
	$sample_overdrive = [ false, 10, 10 ] # active, [gain(20) [colour(20)]]

	puts "init().ok."
end

# ------------------------------------------------------------------------
def mode_Samples(midi_input = [ "0", 0, 0 ])
		# button to change samples bank to the left
		if (midi_input[1] == 26) then
			$meme_sample_ID_offset = ($meme_sample_ID_offset + 12) % $meme_samples_filelist.size
			puts "SAMPLES BANK: #{$meme_sample_ID_offset}"
			puts "- BANK SWITCH --------------------------------------------------->>>>"
			0.upto(9){ |i|
				puts "#{$meme_samples_filelist[$meme_sample_ID_offset + i]}"
			}
			puts "- BANK SWITCH ---------------------------------------------------<<<<"
		end
		# button to change samples bank to the right
		if (midi_input[1] == 25) then
			$meme_sample_ID_offset = ($meme_sample_ID_offset - 12) % $meme_samples_filelist.size
			puts "SAMPLES BANK: #{$meme_sample_ID_offset}"
			puts "- BANK SWITCH --------------------------------------------------->>>>"
			0.upto(9){ |i|
				puts "#{$meme_samples_filelist[$meme_sample_ID_offset + i]}"
			}
			puts "- BANK SWITCH ---------------------------------------------------<<<<"
		end
		# line 1 and 2 buttons plays samples - plays samples
	  	if (midi_input[1] < 16) then #
			id = get_linear_PAD_ID(midi_input[1])
			sid = ($meme_sample_ID_offset + id) % $meme_samples_filelist.size

			# Get play position infos relative to this sample for "trim" >>>>
			length = get_sample_length($meme_samples_filelist[sid])
			puts "l: #{length}"
			puts "sample_start_pos: #{$sample_start_pos}"
			start_pos = $sample_start_pos * length
			start_pos_HMS = Time.at(start_pos.to_i).utc.strftime("%H:%M:%S")
			puts "start_pos: #{start_pos}"
			puts "start_pos_HMS: #{start_pos_HMS}"
			# Get play position <<<<
			
			
			cmd = "play -v #{$sample_volume} \"#{$meme_samples_filelist[sid]}\" "
			cmd += "rate #{$sample_sampling_rate} "
			cmd += "speed #{$sample_speed} "
			cmd += "pitch #{$sample_pitch} "
			cmd += "tempo #{$sample_tempo} "
			cmd += "#{$sample_reverse == true ? "reverse" : ""} "
			cmd += "trim =#{start_pos_HMS} "
			
			cmd += $sample_phaser[0] == true ? "phaser #{$sample_phaser[1].round(2)} #{$sample_phaser[2].round(2)} #{$sample_phaser[3].round(2)} #{$sample_phaser[4].round(2)} #{$sample_phaser[5].round(2)} #{$sample_phaser[6]} " : ""
			cmd += $sample_flanger[0] == true ? "flanger #{$sample_flanger[1].round(2)} #{$sample_flanger[2].round(2)} #{$sample_flanger[3].round(2)} #{$sample_flanger[4].round(2)} #{$sample_flanger[5].round(2)} #{$sample_flanger[6]} #{$sample_flanger[7].round(2)} #{$sample_flanger[8]} " : ""
			cmd += $sample_reverb[0] == true ? "reverb #{$sample_reverb[1].round(2)} #{$sample_reverb[2].round(2)} #{$sample_reverb[3].round(2)} #{$sample_reverb[4].round(2)} #{$sample_reverb[5].round(2)} #{$sample_reverb[6].round(2)} " : ""
			cmd += $sample_overdrive[0] == true ? "overdrive #{$sample_overdrive[1].round(2)} #{$sample_overdrive[2].round(2)} " : ""
			
						
			cmd += " > /dev/null 2>&1" #[ false, 3, 9.5, 0, 70, 2, "sin", 100, "quadratic" ]

			puts cmd
			t = Thread.new(){
				system(cmd)
			}
		end
=begin
		# 
		if (midi_input[1] == 16) then
			play_random_clip()
			puts "play_random_clip()"
		end
		# 
		if (midi_input[1] == 18) then
			play_random_clip_fx_random()
			puts "play_random_clip_fx_random()"
		end
		# 
		if (midi_input[1] == 19) then
			slice_random_sample()
			puts "slice_random_sample()"
		end
		# 
		if (midi_input[1] == 21) then
			slice_random_sample_random_speed()
			puts "slice_random_sample_random_speed()"
		end
=end
		# last button before 'solo', line 1 -
		if (midi_input[1] == 22) then
			$sample_reverse = !$sample_reverse
			puts "REVERSE: #{$sample_reverse}"
		end
		# last button before 'solo', line 2 - stops all sample plays instantly
		if (midi_input[1] == 24) then
			cmd = "pkill -9 play > /dev/null 2>&1"
			puts cmd
			t = Thread.new(){
				system(cmd)
			}
		end
end
def mode_Drumkits(midi_input = [ "0", 0, 0 ])
end
def mode_Pads(midi_input = [ "0", 0, 0 ])
end
def mode_8Bits(midi_input = [ "0", 0, 0 ])
end
def mode_MP3(midi_input = [ "0", 0, 0 ])
end
def mode_Radio(midi_input = [ "0", 0, 0 ])
end
def mode_Acid(midi_input = [ "0", 0, 0 ])
end

# ------------------------------------------------------------------------
# Returns sample length in seconds
def get_sample_length(path)
	# This is equivalent to system() but grab stdout, but here we grab stderr too.
	sl = `soxi -D \"#{path}\" 2>&1`
	return sl.to_f
end

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
	if not defined? $meme_sample_ID_offset then
		$meme_sample_ID_offset = 0
	end
	if(midi_input[0].include? "Note on") then

		if (midi_input[1] == 19) then
			$mode_id = ($mode_id - 1) % $mode_list.size
			$mode = $mode_list[$mode_id]
			puts "Mode: previous #{$mode_list[$mode_id]}"
		end
		# 
		if (midi_input[1] == 21) then
			$mode_id = ($mode_id + 1) % $mode_list.size
			$mode = $mode_list[$mode_id]
			puts "Mode: next #{$mode_list[$mode_id]}"
		end

		case $mode
			when "Samples";  mode_Samples(midi_input)
		  	when "Drumkits"; mode_Drumkits(midi_input)
		       	when "Pads";     mode_Pads(midi_input)
		       	when "8Bits";    mode_8Bits(midi_input)
		        when "MP3";      mode_MP3(midi_input)
		       	when "Radio";    mode_Radio(midi_input)
		       	when "Acid";     mode_Acid(midi_input)
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

=begin
  			when 1;		t = Thread.new(){
	  					system("play -n synth pl C#{1 + rand(4)} pl E2 pl G#{1 + rand(4)} pl C3 pl E#{1 + rand(4)} pl G3 delay 0 .05 .1 .15 .2 .25 remix - fade 0 1.5 .1 norm -1 speed 0.2 > /dev/null 2>&1")
					}
  			when 03;	
  					if not defined? $RUNLOOP03 then
  						$RUNLOOP03 = false
  					end
  					if $RUNLOOP03 == false then
  						$RUNLOOP03 = true
  						$SLEEPME03 = 1.0
  						t = Thread.new(){
 							while $RUNLOOP03 == true do
  								t = Thread.new(){
	  								system("play 'Samples/bom.wav' > /dev/null 2>&1")
								}
								sleep($SLEEPME03)
							end
						}
					else
						$RUNLOOP03 = false
					end
=end
  		end
  	end
  	
  	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# last line of knobs affect samples played with buttons
	if(midi_input[0].include? "Control") then
  		case midi_input[1]
			when 18;	$sample_speed = midi_input[2] / 128.0 * 2.0
			when 22;	$sample_pitch = ((midi_input[2] / 128.0) - 0.5) * 2000
					puts $sample_pitch
			when 26;	$sample_tempo = midi_input[2] / 128.0 * 4.0

			when 30;	$sample_flanger[2] = midi_input[2] / 128.0 * 10.0 # depth
					$sample_flanger[0] = midi_input[2] == 0.0 ? false : true
			when 48;	$sample_flanger[4] = midi_input[2] / 128.0 * 100.0 # width
					$sample_flanger[0] = midi_input[2] == 0.0 ? false : true
			when 52;	$sample_flanger[5] = midi_input[2] / 128.0 * 10.0 # speedh
					$sample_flanger[0] = midi_input[2] == 0.0 ? false : true
			when 56;	$sample_flanger[7] = midi_input[2] / 128.0 * 100.0 # phase
					$sample_flanger[0] = midi_input[2] == 0.0 ? false : true
			when 60;	$sample_start_pos = midi_input[2] / 128.0 # position/trim
		end
	end
  	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  	
	###### FADERS
	######
	if(midi_input[0].include? "Control") then

  		case midi_input[1]
			when 19;	$sample_phaser[3] = midi_input[2] / 128.0 * 6 # delay
					$sample_phaser[0] = midi_input[2] == 0.0 ? false : true
			when 23;	$sample_phaser[5] = midi_input[2] / 128.0 * 2 # speed
					$sample_phaser[0] = midi_input[2] == 0.0 ? false : true
			when 27;	$sample_reverb[3] = midi_input[2] / 128.0 * 60 # reverb
					$sample_reverb[0] = midi_input[2] == 0.0 ? false : true
			when 31;	$sample_reverb[5] = midi_input[2] / 128.0 * 2 # HF-damping
					$sample_reverb[0] = midi_input[2] == 0.0 ? false : true
			when 49;	$sample_reverb[6] = midi_input[2] / 128.0 * 2 # room scale
					$sample_reverb[0] = midi_input[2] == 0.0 ? false : true
			when 53;	$sample_overdrive[1] = midi_input[2] / 128.0 * 20 # gain
					$sample_overdrive[0] = $sample_overdrive[1] > 0.0 ? true : false
			when 57;	$sample_overdrive[2] = midi_input[2] / 128.0 * 20 # colour
					$sample_overdrive[0] = $sample_overdrive[2] > 0.0 ? true : false
			when 61;
# MAGIC SLIDE TODO
			when 62;	$sample_volume = midi_input[2] / 128.0 #* 2
		end

	end
end
