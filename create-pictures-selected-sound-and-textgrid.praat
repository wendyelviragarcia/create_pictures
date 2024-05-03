############################################################################################################################################################################################
# 
# create_pictures-with-tiers.praat (v.4.1 -March 2015-)
# Laboratori de Fonètica (Universitat de Barcelona)
# 
#						DESCRIPTION
#	This script creates and saves pictures (PNG, PDF, wmf, eps, PraatPic) of a selected sound and opcionally textgrid.
#	The pictures contain a waveform, a spectrogram, an optional F0 track and a the content of the tiers of the TextGrid associated with the sound file. 
# 
#	The script is designed to carry out some operations automatically:
#	1) It detects automatically the F0 range of the picture of EACH sentence (unless you choose to specify it manually). 
#	2)In order to correct those cases in which Praat detects F0 in fricatives (what Boersma calls "to hallucinate pitches")the script gets 
#	the pitch from a filtered sound in which all frecuencies beyond 1000Hz have been cancelled. 
#	2) It recognizes automatically the number of tiers in EACH textgrid and draws the picture consequently (i.e. in the picture there will be 
#	no unnecessary white space between the tiers and the spectrogram).
#	3) It establishes automatically the number of marks on the y axis and their placement. It places the first mark at the lowest multiple of 50 Hz within the range 
#	of the picture (e.g. at 50 Hz, or 100 Hz, or 150 Hz...). The following marks are placed every 50/100/150 Hz (depending on the range of the utterance).  
#	In the INSTRUCTIONS section you will find details about the other characteristics and options of the script (e.g changing the dynamic range, 
#	choosing the level of smooth in the F0 track, changing the axis' names, choosing the speakers range of F0...)
# 	 
#	
# 
#						INSTRUCTIONS
#	0. Before you start: Create the TextGrids with the same name of the sound they are made for. Save them in a folder. 
#
#	1. Open the script (Open/Read from file...), click Run in the upper menu and Run again. 
#	2. Set the parameters.
#		a) The 3 first fields are for the folders where you have your files. In the first field, write the name of the folder where you have your sound files.
#			In the second field, write the name of the folder where you have your Textgrids. In the third field, write the name of the folder where 
#			you want the pictures to be saved. Important: always write the path without bar at the end "/".
#		b) By changing the dynamic range you can make your spectrograms look 'cleaner'. The lowest it is, the lighter the spectrogram looks.
#		c) Choose whether you want to draw the F0 curve or not. The F0 curve will be written twice, once in white and once in thinner black (Welby 2003).
#		d) Then specify if you want the F0 range to be defined automatically or manually. If you choose to set it manually, 
#		in the next window you'll be asked to define the F0 minimum and F0 maximum.
#		e) Choose if you want the F0 minimum and F0 maximum marks to appear on the y axis (if you place them, they might overlap with other marks).
#		Note that the F0 minimum and F0 maximum marks are placed at 'rounded' values, that means that 377.8 Hz is rounded to 380 Hz and 51.2 Hz is rounded to 50 Hz.
#		f) Decide how much you want the F0 curve to be smoothed. In this field, you need to enter the bandwidth (in Hertz). If you want a 
#		very smoothed curve, you should choose a smaller bandwidth (e.g. 10), whereas if you want a less smoothed curve you should choose a bigger bandwidth (e.g. 50).
#		Don't write 0 in here, because your curve would become plain.
#		g)In the next two choice menus, you can choose the label of the axes (in different languages). You can also decide not to label either or both of them.
#		h) You can change the picture width.
#		i)Mark the formats in which you want to save the pictures. Notice that PDF will only run if you are working on a Mac and wmf is only for Windows. PNG for Windows and presumably Linux.
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
#		d) Change the time marks of the x axis. By default, there is a mark without number at every 0.2 seconds and a mark with number at every 0.5 (the number appears 
#		written above the mark.)
#		e) If you are drawing the f0 curve and you've chosen "Show more options", you can choose here how do you want Praat to select the better candidates to be F0. 
#			The script runs with the autocorrelation method (Boersma, 1993) which is optimized for human intonation research, so if you are working with speech, 
#			you don't need to change anything.
#			Here you'll be asked for the octave cost, octave jump cost, the voiced/unvoiced cost and the voicing_threshold.
#
#
#
#		Click OK (the Revert button goes back to the Standards of the form)
#	
#	3. Now search your pictures, they have to be in the folder you specified in the first form.
#
#
#
#						CREDITS
# Feedback is always welcome, please if you notice any bugs or come up with anything that can improve this script, let me know!
# 	
# Wendy Elvira-García
# wendyelviragarcia@gmail.com
# october 2013
# tested on Praat 5.3.73 for Windows and Mac
# If it doesn't run on Linux, check the syntax of lines: 470 & 486 and mail me I'll be grateful.
#
# Citation: Elvira García, Wendy & Roseano, Paolo (2014). Create pictures with tiers. Praat script. (Retrieved from http://stel.ub.edu/labfon/en/praat-scripts)
#
# The first version of this script was inspired by:
# draw-waveform-sgram-f0.praat
# Pauline Welby (2003) with the modifications made by Paolo Roseano (2011)
# 
#
###################################################################################################################################
# PREDEFINED VARIBLES

spectrogram_maximum_frequency = 5000
let_me_modify_my_pitch = 0

# time marks each x seconds
    time_mark_with_number = 0.5
    time_mark_without_number = 0.1
	 
# variables to find F0 path 
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

############################		FORMULARIO		###################################################################

form Create_pictures
   
    
	
	
    positive Dynamic_range 45
    boolean Draw_F0_curve yes
    optionmenu Range 1
	option Define range automatically
	option Define range manually
    comment Do you want the f0min and f0max values to appear in the y axis?
    boolean f0min_f0max_marks 0
    positive Smooth 10
	boolean let_me_modify_my_pitch 0
    
   
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
    
    comment Do you want to save the picture?
    boolean PNG 1
   sentence Pictures_folder C:\Users\username\Desktop
    comment You can change more parametres:
    boolean Show_more_options 0
endform



#################		FORMULARIO OPCIONES		################################################################

if show_more_options = 1 or range = 2 or draw_F0_curve = 0
	beginPause ("Options")
		if range = 2 and draw_F0_curve = 1
			comment ("Introduce manually the range of the speaker.")
			sentence ("Manual_range", "50-250")
		endif

		if draw_F0_curve = 1
			comment ("Spectrogram settings")
    			positive ("Spectrogram_maximum_frequency", 5000)
		endif

		if draw_F0_curve = 0
			comment ("Spectrogram settings")
    			positive ("Spectrogram_maximum_frequency", 8000)
			comment ("¿Every how many Hertzs do you want a frequency mark?")
    			positive ("Frequency_marks_every", 2000)
			
		endif

		if show_more_options = 1
			comment ("¿Every how many seconds do you want a time mark in the waveform?")
			positive ("time_mark_without_number at every (seconds)", 0.1)
 			positive ("time_mark_with_number at every (seconds)", 0.5 )
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



#######################################################################################################
#variables de range
if range = 2
	f0max =  extractNumber (manual_range$, "-")
	f0max$ = "'f0max'"
	f0min$ = "'manual_range$'" - "'f0max$'" 
	f0min$= "'f0min$'" - "-"
	f0min = 'f0min$'
endif

#################		EMPIEZA EL SCRIPT		#########################################################

base$ = selected$ ("Sound")
#textgrid$ = selected$ ("TextGrid")



# Dibuja el oscilograma, espectrograma el pitch, el TextGrid y una caja alrededor de todo ello.
	# Fuente de texto y color
	Times
	Font size... 14
	Line width... 1
	Black

	# Hace la ventana rosa para el oscilograma
    Viewport... 0 'picture_width' 0 2
	# Dibuja el oscilograma
	select Sound 'base$'
	Draw... 0 0 0 0 no curve
 
	
		select Sound 'base$'
		To Spectrogram... 0.005 'spectrogram_maximum_frequency' 0.002 20 Gaussian
		# Crea la ventana de imagen para el espectrograma
		Viewport... 0 'picture_width' 1 4
		# Dibuja el espectrograma
		select Spectrogram 'base$'
		Paint... 0 0 0 0 100 yes dynamic_range 6 0 no
	

	if draw_F0_curve = 1
		if range = 1
			# Crea objeto pitch con unos valores estándar muy grandes para que quepa todo
			select Sound 'base$'
			#elimina todas las frecuencias superiores a 900Hz para minimizar los Pitch de las fricativas que están a 2000 y 3000 Hz
			Filter (stop Hann band): 900, 20000, 100
			select Sound 'base$'_band
			To Pitch (ac)... 0.005 50 15 no 0.03 'voicing_threshold' 'octave_cost' 'octave_jump_cost' 'voiced_unvoiced_cost' 650
			#D. Hirst lines (getting pitch floor and ceiling)
			q1 = Get quantile... 0 0 0.25 Hertz
			q3 = Get quantile... 0 0 0.75 Hertz
			f0min = q1*0.75
			f0max = q3*1.5			
			Rename... pitch_viejo
			select Sound 'base$'_band
			To Pitch... 0.005 'f0min' 'f0max'
			Smooth... smooth
			if let_me_modify_my_pitch=1
				pause Select your corrected pitch
			endif
		endif

		if range = 2 
			# Crea objeto pitch
			select Sound 'base$'
			Filter (stop Hann band): 900, 20000, 100
			To Pitch (ac)... 0.005 'f0min' 15 no 0.03 'voicing_threshold' 'octave_cost' 'octave_jump_cost' 'voiced_unvoiced_cost' 'f0max'
			Smooth... smooth
			if let_me_modify_my_pitch=1
				pause Select your corrected pitch
			endif
		endif

		# Dibuja el pitch
		# Linea blanca de debajo
		Line width... 10
		White
		Viewport... 0 'picture_width' 1 4
		select Pitch 'base$'_band
		Draw... 0 0 'f0min' 'f0max' no

		# Como una linea negra
		Line width... 6
		Black
		Draw... 0 0 'f0min' 'f0max' no
	
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
			One mark left... f0min_redondeado yes no no
			One mark left... f0max_redondeado yes no no

			#One mark left... 'f0max' yes no no
			#One mark left... 'f0min' yes no no
		endif
		
		
		# Determina cada cuánto (50, 100 o 150Hz) tiene que haber marcas según lo grande que sea el range del hablante
		speakers_range = f0max - f0min


		if speakers_range >= 500
			intervalo_entre_marcas = 150
		elsif speakers_range >= 300
			intervalo_entre_marcas = 100
		elsif speakers_range < 300
			intervalo_entre_marcas = 50
		endif

		numero_de_marcasf0 = (speakers_range/intervalo_entre_marcas)+ 1
	
		# Determina cuál será la primera marca que aparezca en el espectrograma según cuál sea el f0 min que se ha indicado
		
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
	
		# Pone las marcas de F0 en Hz según los parámetros anteriores.
		for i to numero_de_marcasf0
			marca = marca + intervalo_entre_marcas
			marca$ = "'marca'"
			if marca <= f0max
				do ("One mark left...", 'marca', "yes", "yes", "no", "'marca$'")
			endif
		endfor

		
		#Dibuja la caja
		Draw inner box
		Draw... 0 0 'f0min' 'f0max' no
		
		#Determina el texto que aparecerá como título del eje y
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
			#escribe el título del eje y
			Text left... yes 'label_of_the_frequency_axis$'
		endif
	endif


	#si no se va a poner el F0 que salgan las marcas de valor frecuencial del espectrograma
	if draw_F0_curve = 0
		do ("Marks left every...", 1, frequency_marks_every, "yes", "yes", "no")


	
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
	endif


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

	#Pone las marcas del eje de tiempo
	Marks top every... 1 'time_mark_without_number' no yes no
	Marks top every... 1 'time_mark_with_number' yes yes no
	

#######################		DIBUJA EL TEXTGRID		####################################
	
		#Busca cuantos tiers hay en el texgrid
		selectObject: "TextGrid " + base$
		numberOfTiers = Get number of tiers

		# Define el tamaño de la caja para textgrid según el número de tiers que se ha indicado
		cajatextgrid = (4 + 0.5 * 'numberOfTiers') - 0.02 * 'numberOfTiers'
		

		# Ventana rosa para los textgrid
		Viewport... 0 'picture_width' 1 'cajatextgrid'
		

		# Dibuja el TextGrid
		
		select TextGrid 'base$'
		Draw... 0 0 yes yes no

		# Crea ventana para línea exterior
		Viewport... 0 'picture_width' 0 'cajatextgrid'
		# Dibuja la línea exterior
		Black
		Draw inner box
	
  #############################		GUARDA LA IMAGEN ##############################
  	

	if pNG = 1
		Save as 600-dpi PNG file: pictures_folder$ + "/" + base$ + ".png"
		# borra la caja de picture si no dibujaría encima
		Erase all
		echo Picture saved in 'pictures_folder$'
	endif
	
	
	#limpiezas
	
	# Limpia objetos
	selectObject: "Pitch pitch_viejo"
	plusObject: "Pitch " +base$+ "_band"
	plusObject: "Pitch " +base$+ "_band"
	plusObject: "Sound " +base$+ "_band"
	plusObject: "Spectrogram " +base$
	Remove
 

