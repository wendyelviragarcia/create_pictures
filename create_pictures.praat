############################################################################################################################################################################################
# 
# create_pictures-with-tiers.praat (v.6 -2022-)
# Wendy Elvira-García
# Laboratori de Fonètica (Universitat de Barcelona)
# 
#						DESCRIPTION
#	This script creates and saves pictures (PNG, PDF, wmf, eps, PraatPic) of all the Sound and optionally a matching TextGrid file it finds in a folder.
#	The pictures contain a waveform (optional), a spectrogram (optional), the F0 track (optional) the intensity track (optional), formant track and the content of the tiers of the TextGrid associated with the sound file (optional) and only if it finds one. 
# 
#	The script is designed to carry out some operations automatically:
#	
#	1) If you are drawing a TextGrid, it recognizes automatically the number of tiers in EACH textgrid and draws the picture consequently (i.e. in the picture there will be 
#	no unnecessary white space between the tiers and the spectrogram).
#	2) It converts the TextGrid to backslash trigraphs before drawing, so you won't have problems plotting symbols like % or phonetic symbols
#	3) It detects automatically the F0 range of the picture of EACH sentence (unless you choose to specify it manually). 
#	4)In order to correct those cases in which Praat detects F0 in fricatives (what Boersma calls "to hallucinate pitches")the script gets 
#	the pitch from a filtered sound in which all frequencies beyond 1000Hz have been cancelled. In addition, it uses Hirst's code "pitch in two steps" to find the speaker range
#	5) It establishes automatically the number of marks on the y-axis and their placement. It places the first mark at the lowest multiple of 50 Hz within the range 
#	of the picture (e.g. at 50 Hz, or 100 Hz, or 150 Hz...). The following marks are placed every 50/100/150 Hz (depending on the range of the utterance).  
#	
#	In the INSTRUCTIONS section you will find details about the other characteristics and options of the script (e.g changing the dynamic range, 
#	choosing the level of smoothness in the F0 track, changing the axis' names, choosing the speaker's range of F0...)
# 	 
#	
# 
#						INSTRUCTIONS
#	0. Before you start:
#		- Check that your .wav filename does not contain white spaces. 
#		- If you want to draw TextGrids, create the TextGrids with the same name as the sound they are made for. Save them in a folder. 
#
#	1. Open the script (Open/Read from file...), click Run in the upper menu and Run again. 
#	2. Set the parameters.
#		a) The 3 first fields are for the folders where you have your files. In the first field, write the name of the folder where you have your sound files.
#			In the second field, write the name of the folder where you have your Textgrids. In the third field, write the name of the folder where 
#			you want the pictures to be saved. Use / in mac and \ in windows
#		b) By changing the dynamic range you can make your spectrograms look 'cleaner'. The lowest it is, the lighter the spectrogram looks.
#		c) Choose what do you want to draw, waveform, spectrogram, and intensity. And whether you want to draw the F0 curve or not. The F0 curve will be written twice, once in white and once in thinner black (Welby 2003).
#		d) Then specify if you want the F0 range to be defined automatically or manually. If you choose to set it manually, 
#		in the next window you'll be asked to define the F0 minimum and F0 maximum.
#		e) Choose if you want the F0 minimum and F0 maximum marks to appear on the y-axis (if you place them, they might overlap with other marks).
#		Note that the F0 minimum and F0 maximum marks are placed at 'rounded' values, which means that 377.8 Hz is rounded to 380 Hz and 51.2 Hz is rounded to 50 Hz.
#		f) Decide how much you want the F0 curve to be smoothed. In this field, you need to enter the bandwidth (in Hertz). If you want a 
#		very smoothed curve, you should choose a smaller bandwidth (e.g. 10), whereas if you want a less smoothed curve you should choose a bigger bandwidth (e.g. 50).
#		Don't write 0 in here, because your curve would become plain.
#		g)In the next two choice menus, you can choose the label of the axes (in different languages). You can also decide not to label either or both of them.
#		h) You can change the picture width.
#		i) Mark the formats in which you want to save the pictures. Notice that PDF will only run if you are working
#		 on a Mac and wmf is only for Windows. PNG for Windows and presumably Linux.
#		j)Mark whether you want more options or not. (See below for details)
#		Click OK
#
#		MORE OPTIONS WINDOW
#		If you chose the more options button or if you chose to set the speaker's range manually, a new window will appear. In this window you can:
#		a) Set the F0 range in the picture. You must write the numbers separated by a hyphen. This field will only appear if you chose "Set the range manually" 
#		in the previous form.
#  		b) Choose the spectrogram range. This is by default from 0 to 5000Hz.
#		c) If you have chosen not to draw the F0 curve, you can select here how many marks of frequency you want in the spectrogram. 
#		You'll be asked every how many Hz you want a mark.
#		d) Change the time marks of the x-axis. By default, there is a mark without a number at every 0.2 seconds and a mark with a number at every 0.5 (the number appears 
#		written above the mark.)
#		e) If you are drawing the f0 curve and you've chosen "Show more options", you can choose here how do you want Praat to select the better candidates to be F0. 
#			The script runs with the autocorrelation method (Boersma, 1993) which is optimized for human intonation research, so if you are working with speech, 
#			You don't need to change anything.
#			Here you'll be asked for the octave cost, octave jump cost, the voiced/unvoiced cost and the voicing_threshold.
#
#
#
#		Click OK (the Revert button goes back to the Standards of the form)
#	
#	3. Now search your pictures, they have to be in the folder you specified in the first window (the form).
#
#
#
#						CREDITS
# Feedback is always welcome, please if you notice any bugs or come up with anything that can improve this script, let me know!
# 	
# Wendy Elvira-García 
# wendyelviragarcia@gmail.com // www.wendyelvira.ga
# first version: october 2013
#
# Citation: Elvira García, Wendy (2022). Create pictures with tiers v.6. Praat script. (Retrieved from https://github.com/wendyelviragarcia/create_pictures)
#
# The first version of this script was inspired by:
# draw-waveform-sgram-f0.praat
# Pauline Welby (2003) with the modifications made by Paolo Roseano (2011)

# 						LICENSE
# Copyright (C) 2022  Wendy Elvira

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 3
# of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You can find the terms of the GNU General Public License here
# http://www.gnu.org/licenses/gpl-3.0.en.html
#
###################################################################################################################################
# FIXED VARIBLES 

spectrogram_maximum_frequency = 5000
let_me_modify_my_pitch = 0
frequency_marks_every= 1000

#variables para el tiempo cada (ms)
    time_mark_with_number = 0.5
    time_mark_without_number = 0.1
	 
# variables de puntos susceptibles de ser F0
	voicing_threshold = 0.45
	octave_cost = 0.01
	octave_jump_cost = 0.35
	voiced_unvoiced_cost = 0.14
	
if praatVersion < 5366
	exit Your Praat version ('praatVersion') is too old. Download the new one.
endif
	
if praatVersion < 5373 and macintosh = 1
	exit Your Praat version ('praatVersion') is too old. Download the new one.
endif

############################		FORM		###################################################################

form Create_pictures
    comment Where are your files?
    sentence Sounds_folder /Users/weg/Desktop/test
    sentence TextGrids_folder /Users/weg/Desktop/test
    sentence Pictures_folder /Users/weg/Desktop/test
	boolean Draw_waveform yes
	boolean Draw_spectrogram 1
	boolean Draw_intensity 1
	boolean Draw_formants 0
	boolean Draw_TextGrid 1
	boolean Draw_pulses 1

    positive Dynamic_range 45
    boolean Draw_F0_curve no
    optionmenu Range 1
	option Define range automatically
	option Define range manually
    comment Do you want the f0min and f0max values to appear in the y axis?
    boolean f0min_f0max_marks 0
    positive Smooth 10
    
   
    optionmenu Label_of_the_time_axis 8
		option No text
		option Tiempo (s)
		option Temps (s)
		option Time(s)
		option Tempo (s)
		option Zeit (s)
		option Denbora (s)
		option (s)
   
    optionmenu Label_of_the_frequency_axis 2
		option No text
		option F0 (Hz)
		option Frequency (Hz)
		option Frecuencia (Hz)
		option Freqüència (Hz)
		option Frequência (Hz)
		option Frequenza (Hz)
		option Frequenz (Hz)
		option Maiztasuna (Hz)
		option Fréquence (Hz)
		option (Hz)
   
    positive Picture_width 7
    
    comment In which format(s) do you want the picture?
    optionmenu Picture_Format 1
	option PNG_300_dpi
    option PNG_600_dpi
    option PDF_(for_Mac_and_Linux)
    option Windows_Media_File_(.wmf_(Windows_only))
    option EPS
    option praatPic
	
    comment You can change more parametres:
    boolean Show_more_options 0
endform



#################		FORM OPTIONS		###############################

if show_more_options = 1 or range = 2 or draw_F0_curve = 0
	beginPause ("Options")
		if range = 2 and draw_F0_curve = 1
			comment ("Introduce manually the range of the speaker.")
			sentence ("Manual_range", "50-250")
		endif

		if draw_spectrogram = 1 and show_more_options = 1 and draw_F0_curve = 1
			comment ("Spectrogram settings")
    			positive ("Spectrogram_maximum_frequency", 5000)
		endif

		if draw_F0_curve = 0 and draw_spectrogram = 1
			comment ("Spectrogram settings")
    			positive ("Spectrogram_maximum_frequency", 5000)
			comment ("¿Every how many Hertzs do you want a frequency mark?")
    			positive ("Frequency_marks_every", 2000)
			
		endif

		if show_more_options = 1
			comment ("¿Every how many seconds do you want a time mark in the waveform?")
			positive ("time_mark_with_number", 0.1)
 			positive ("time_mark_without_number", 0.5 )
		endif

		if draw_F0_curve = 1 and show_more_options = 1
			comment ("Find the F0 path")
			positive ("voicing_threshold", 0.45)
			positive ("octave_cost", 0.01)
			positive ("octave_jump_cost", 0.35) 
			positive ("voiced_unvoiced_cost", 0.14)
		endif
   	
	endPause ("OK", 1)
endif



########################################################################
# range variables
if range = 2
	f0max =  extractNumber (manual_range$, "-")
	f0max$ = "'f0max'"
	f0min$ = "'manual_range$'" - "'f0max$'" 
	f0min$= "'f0min$'" - "-"
	f0min = 'f0min$'
endif

#################		 SCRIPT BEGGINS		#####################

# creates list of every file in folder
myFileList= Create Strings as file list: "mywavlist", sounds_folder$ + "/" + "*"
numberOfFiles = Get number of strings

for stri to numberOfFiles
	filename$ = Get string: stri
	if (right$(filename$, 4) <> ".wav") and (right$(filename$, 4) <> ".WAV")
 		Remove string: stri
 		stri= stri-1
 		numberOfFiles= numberOfFiles-1
 	endif
endfor

numberOfFiles = Get number of strings
if numberOfFiles = 0 
	exitScript: "There are no .wav or .WAV files in folder" + sounds_folder$
endif

Erase all

#loop beggins, the following actions will be performed for all wavs in the folder
for ifile to numberOfFiles
	#selects the file number x from the object Strings mywavlist
	select Strings mywavlist
	fileName$ = Get string: ifile
    spaces = index (fileName$, " ")
	
	if spaces <> 0
		exit "Filenames cannot contain spaces"
	endif
		
	base$ = fileName$ - ".wav"
	base$ = base$ - ".WAV"

	# Reads Sound
	mySound = Read from file: sounds_folder$+ "/" + fileName$

	

	# Fuente de texto y color
	Times
	Font size: 14
	Line width: 1
	

	# Pictures waveform
	if draw_waveform = 1
		# Hace la ventana rosa para el oscilograma
	    Viewport... 0 'picture_width' 0 2
		selectObject: mySound
		Grey
		Draw: 0, 0, 0, 0, "no", "curve"

		# Label x axis
		if label_of_the_time_axis <> 1
			if label_of_the_time_axis = 2
				label_of_the_time_axis$ = "Tiempo (s)"
			elsif label_of_the_time_axis = 3
				label_of_the_time_axis$ = "Temps (s)"
			elsif label_of_the_time_axis = 4
				label_of_the_time_axis$ = "Time(s)"
			elsif label_of_the_time_axis = 5
				label_of_the_time_axis$ = "Tempo(s)"
			elsif label_of_the_time_axis = 6
				label_of_the_time_axis$ = "Zeit (s)"
			elsif label_of_the_time_axis = 7
				label_of_the_time_axis$ = "Denbora(s)"
			elsif label_of_the_time_axis = 8
				label_of_the_time_axis$ = "(s)"
			endif
			#escribe el título del eje x (de tiempo)
			Text top... no 'label_of_the_time_axis$'
		endif

		#marks on time
		Marks top every... 1 'time_mark_without_number' no yes no
		Marks top every... 1 'time_mark_with_number' yes yes no


	endif

	if draw_pulses = 1
		if draw_waveform = 1
	 		Viewport... 0 'picture_width' 0 2
			selectObject: mySound
			myPoints= To PointProcess (periodic, cc): 75, 600
			Navy
			Draw: 0, 0, "no"
			removeObject: myPoints
		else
		 beginPause: "Pause"
          comment: "You need a waveform to draw pulses,"
          comment: "I'm not drawing the pulses but I'll do the rest."
      	 clicked = endPause: "Proceed", 1
		endif
	endif


 
	if draw_spectrogram = 1
		# Creates objet Spectrogram 
		selectObject: mySound
		mySpectrogram = To Spectrogram: 0.005, spectrogram_maximum_frequency, 0.002, 20, "Gaussian"

		# Crea la ventana de imagen para el espectrograma
		Viewport: 0, picture_width, 1, 4
		# Dibuja el espectrograma
		Black
		selectObject: mySpectrogram
		Paint: 0, 0, 0, 0, 100, "yes", dynamic_range, 6, 0, "no"
		Draw inner box

		Marks left every: 1, frequency_marks_every, "yes", "yes", "no"

		if label_of_the_frequency_axis <> 1	
			if label_of_the_frequency_axis = 2
				label_of_the_frequency_axis$ = "Hz"
			elsif label_of_the_frequency_axis = 3
				label_of_the_frequency_axis$ = "Frequency (Hz)"
			elsif label_of_the_frequency_axis = 4
				label_of_the_frequency_axis$ = "Frecuencia (Hz)"
			elsif label_of_the_frequency_axis = 5
				label_of_the_frequency_axis$ = "Freqüència (Hz)"
			elsif label_of_the_frequency_axis = 6
				label_of_the_frequency_axis$ = "Frequência (Hz)"
			elsif label_of_the_frequency_axis = 7
				label_of_the_frequency_axis$ = "Frequenz (Hz)"
			elsif label_of_the_frequency_axis = 8
				label_of_the_frequency_axis$ = "Maiztasuna (Hz)"
			elsif label_of_the_frequency_axis = 9
				label_of_the_frequency_axis$ = "Fréquence (Hz)"
			elsif label_of_the_frequency_axis = 10
				label_of_the_frequency_axis$ = "(Hz)"
			endif
		#escribe el texto del eje y, si no hay curva de f0
		Text left... yes 'label_of_the_frequency_axis$'
		endif

		removeObject: mySpectrogram
	endif




	

	if draw_intensity = 1
		# Crea la ventana de imagen para la intensidad
		if draw_waveform = 1
			# if we are drawing the waveform intensity is in the waveform
			Viewport: 0, picture_width, 0, 2
		else
			# if we don't have a vaweform we put the intensity over the spectrogram
			Viewport: 0, picture_width, 1, 4
		endif 

		select Sound 'base$'
		myInt= To Intensity: 100, 0, "no"
		Line width: 4
		White
		Draw: 0, 0, 0, 0, "no"
		Line width: 4
		
		Olive
		Draw: 0, 0, 0, 0, "no"
		Line width: 2
	 
		if draw_F0_curve = 0 or draw_waveform = 1
			Marks right every: 1, 10, "yes", "yes", "no"
			Text right: "yes", "Int. (dB)"
		endif
		removeObject: myInt
	endif

	if draw_F0_curve = 1
		if range = 1
			Viewport: 0, picture_width, 1, 4

			# creates pitch object with default values
			select Sound 'base$'
			#removes fricatives almost-formants between 2000 and 3000 Hz, special for peninsular spanish sibilants
			soundBand= Filter (stop Hann band): 900, 20000, 100
			select Sound 'base$'_band
			pitch_gran_rango= To Pitch (ac)... 0.005 50 15 no 0.03 'voicing_threshold' 'octave_cost' 'octave_jump_cost' 'voiced_unvoiced_cost' 650
			Rename: "greatRange"
			#D. Hirst lines (getting pitch floor and ceiling)
			q1 = Get quantile... 0 0 0.25 Hertz
			q3 = Get quantile... 0 0 0.75 Hertz
			f0min = q1*0.75
			f0max = q3*1.8			
			select Sound 'base$'_band
			myNonSmoothedPitch= To Pitch... 0.005 'f0min' 'f0max'
			Rename: "nonSmoothedPitch"
			myPitch= Smooth... smooth
			Rename: "myPitch"
			if let_me_modify_my_pitch=1
				pause Select your corrected pitch
				myPitch = selected ("Pitch")
				Rename: "myPitch"
			endif
		endif

		if range = 2 
			# Crea objeto pitch
			select Sound 'base$'
			soundBand= Filter (stop Hann band): 900, 20000, 100
			myNonSmoothedPitch = To Pitch (ac)... 0.005 'f0min' 15 no 0.03 'voicing_threshold' 'octave_cost' 'octave_jump_cost' 'voiced_unvoiced_cost' 'f0max'
			Rename: "nonSmoothedPitch"
			myPitch= Smooth: smooth
			Rename: "myPitch"
			if let_me_modify_my_pitch = 1
				pause Select your corrected pitch
				myPitch = selected ("Pitch")
			endif
		endif
		
		# Dibuja el pitch
		# Linea blanca de debajo
		Line width: 10
		White
		Viewport... 0 'picture_width' 1 4
		selectObject: myPitch
		Draw... 0 0 'f0min' 'f0max' no

		# Como una linea azul
		Line width: 6
		Cyan
		Draw: 0, 0, f0min, f0max, "no"
		
	
		# #Dibuja las s de F0. Eje y
		Line width... 1

		# Pone las marcas de f0 máxima y mínima si así se ha indicado en el formulario
		if f0min_f0max_marks = 1
			f0min$ = fixed$(f0min, 0)
			f0max$= fixed$(f0max, 0)
			f0min_redondeado = number (f0min$)
			f0max_redondeado = number (f0max$)
			f0max_redondeado = f0max_redondeado/10
			f0min_redondeado = f0min_redondeado/10
			f0max_redondeado$ = fixed$(f0max_redondeado, 0)
			f0max_redondeado = number (f0max_redondeado$)
			f0min_redondeado$ = fixed$(f0min_redondeado, 0)
			f0min_redondeado = number (f0min_redondeado$)
			f0min_redondeado = f0min_redondeado * 10
			f0max_redondeado = f0max_redondeado * 10
			One mark right... f0min_redondeado yes no no
			One mark right... f0max_redondeado yes no no

			#One mark right... 'f0max' yes no no
			#One mark right... 'f0min' yes no no
		endif
		
		
		# Determines pitch marks (each 50, 100 or 150Hz) depending on speakers range
		speakers_range = f0max - f0min


		if speakers_range >= 500
			intervalo_entre_marcas = 150
		elsif speakers_range >= 300
			intervalo_entre_marcas = 100
		elsif speakers_range < 300
			intervalo_entre_marcas = 50
		endif

		numero_de_marcasf0 = (speakers_range/intervalo_entre_marcas)+ 1
	
		# Determines first mark in the spectrogram depending on  f0 min introduced by the user
		
		if f0min >= 250
			marca = 250
		elsif f0min >= 200
			marca = 200
		elsif f0min >= 150
			marca = 150
		elsif f0min >= 100
			marca = 100
		elsif f0min >= 50
			marca = 50
		elsif f0min < 50
			marca = 0
		endif
	
		# writes F0 in Hz according to parameters
		for i to numero_de_marcasf0
			marca = marca + intervalo_entre_marcas
			marca$ = "'marca'"
			if marca <= f0max
				do ("One mark right...", 'marca', "yes", "yes", "no", "'marca$'")
			endif
		endfor

		
		#draws black box
		Line width: 1
		Draw inner box

		Cyan
		
		#Determines  title of x axis
		if label_of_the_frequency_axis <> 1
			if label_of_the_frequency_axis = 2
				label_of_the_frequency_axis$ = "F0 (Hz)"
			endif
			if label_of_the_frequency_axis = 3
				label_of_the_frequency_axis$ = "Frequency (Hz)"
			elsif label_of_the_frequency_axis = 4
				label_of_the_frequency_axis$ = "Frecuencia (Hz)"
			elsif label_of_the_frequency_axis = 5
				label_of_the_frequency_axis$ = "Freqüència (Hz)"
			elsif label_of_the_frequency_axis = 6
				label_of_the_frequency_axis$ = "Frequência (Hz)"
			elsif label_of_the_frequency_axis = 7
				label_of_the_frequency_axis$ = "Frequenz (Hz)"
			elsif label_of_the_frequency_axis = 8
				label_of_the_frequency_axis$ = "Maiztasuna (Hz)"
			elsif label_of_the_frequency_axis = 9
				label_of_the_frequency_axis$ = "Fréquence (Hz)"
			elsif label_of_the_frequency_axis = 10
				label_of_the_frequency_axis$ = "(Hz)"
			endif
			#writes titles y axis
			Text right... yes 'label_of_the_frequency_axis$'
		endif
						removeObject: myNonSmoothedPitch,pitch_gran_rango, myPitch, soundBand

	endif

	if draw_formants = 1	
		select Sound 'base$'
		Viewport... 0 'picture_width' 1 4
		# creates formant objects
		myFormants = To Formant (burg): 0, 5, spectrogram_maximum_frequency, 0.025, 50

		Line width: 10
		White
		Speckle: 0, 0, spectrogram_maximum_frequency, 30, "no"
		Line width: 6
		Maroon
		Speckle: 0, 0, spectrogram_maximum_frequency, 30, "no"
		removeObject: myFormants
	endif


	

	
	
#######################		DIBUJA EL TEXTGRID		####################################
	if draw_TextGrid = 1
		Line width: 1

		if fileReadable (textGrids_folder$ + "/" + base$ +".TextGrid" )
			myText = Read from file: textGrids_folder$ +"/"+ base$+".TextGrid"
			Convert to backslash trigraphs

			## deals with unicode characters
			numberOfTiers = Get number of tiers

			# EXTRA % does not work as unicode, so a rough replacement is done
			if numberOfTiers >= 1
				for tier to numberOfTiers
					selectObject: myText
					isInterval= Is interval tier: tier
					if isInterval= 1
						nIntervals = Get number of intervals: tier
						Replace interval text: tier, 0, nIntervals, "%", "\% ", "Literals"
						Replace interval text: tier, 0, nIntervals, "\\", "\", "Literals"
					endif
					if isInterval=0
						nPoints = Get number of points: tier
						Replace point text: tier, 0, nPoints, "%", "\% ", "Literals"
						Replace point text: tier, 0, nPoints, "\\", "\", "Literals"
					endif
				endfor
			else
			exitScript: "No tiers in your TextGrid: " + base$
			endif
		

		#Defines de size of the box depending on the number of tiers in the textgrid
		cajatextgrid = (4 + 0.5 * 'numberOfTiers') - 0.02 * 'numberOfTiers'
		

		# selects pink window for the textwrif
		Viewport... 0 'picture_width' 1 'cajatextgrid'
		

		# Dibuja el TextGrid
		Grey
		select TextGrid 'base$'
		Draw... 0 0 yes yes no


		else
			pauseScript: "There is no TextGrid for the Sound " + base$
			cajatextgrid = 4

		endif
	
		

		# selects window for box
		if draw_waveform=1
			Line width: 1
			Grey
			Viewport... 0 'picture_width' 0 'cajatextgrid'
		else 
			Grey
			Viewport... 0 'picture_width' 1 'cajatextgrid'
		endif
		Draw inner box

	else
		# If the textgrid is not drawn i select the viewport again with the whole picture 

		if draw_waveform=1
			Grey
			Viewport... 0 'picture_width' 0 4
		else
			Grey
			Viewport... 0 'picture_width' 1 4
		endif
		
		Draw inner box
	endif
  #############################		SAVES IMAGE ##############################
  	
	if picture_Format = 1
		Save as 300-dpi PNG file: pictures_folder$ + "/" + base$ + ".png"
	endif

	if picture_Format = 2
		Save as 600-dpi PNG file: pictures_folder$ + "/" + base$ + ".png"
	endif
	
  	if picture_Format = 3
  		Save as PDF file: pictures_folder$ +"/"+ base$ + ".pdf"
	endif
	
	if picture_Format = 4
		Write to Windows metafile: pictures_folder$+"/"+base$+".wmf"
	endif

	if picture_Format = 5
		Write to EPS file: pictures_folder$ +"/"+ base$ ".eps"
	endif

	if picture_Format = 6
		Write to praat picture file: pictures_folder$ + "/"+ base$ +".praapic"
	endif
	
	# erases the picture window for the next figure
	Erase all

	# cleaning objects
	select all
	minus Strings mywavlist
	Remove
   	
endfor

################################################################
#	AFTER LOOP ACTIONS 
################################################################

#  final cleaning
select Strings mywavlist
Remove
numberOfprocessed = ifile-1
numberOfprocessed$ = fixed$(numberOfprocessed,0)
writeInfoLine:  numberOfprocessed$ + " pictures have been created."
appendInfoLine: "The picture files are in " + pictures_folder$
