 
# create_pictures-with-tiers.praat (v.4.4 -April 2017-)
# Laboratori de Fonètica (Universitat de Barcelona)
 
						DESCRIPTION
	This script creates and saves pictures (PNG, PDF, wmf, eps, PraatPic) of all the Sound and TextGrid files it finds in a folder.
  The pictures contain a waveform (optional), a spectrogram(optional), the F0 track (optional) and a the content of the tiers of the TextGrid associated with the sound file (optional). 
 
	The script is designed to carry out some operations automatically:
	
	1) If you are drawing a TextGrid, it recognizes automatically the number of tiers in EACH textgrid and draws the picture consequently (i.e. in the picture there will be 
	no unnecessary white space between the tiers and the spectrogram).
	2) It converts the TextGrid to backslash trigraphs before drawing, so you won't have problems plotting symbols like % or ¡
	3) It detects automatically the F0 range of the picture of EACH sentence (unless you choose to specify it manually). 
	4)In order to correct those cases in which Praat detects F0 in fricatives (what Boersma calls "to hallucinate pitches")the script gets 	the pitch from a filtered sound in which all frequencies beyond 1000Hz have been cancelled. 
	5) It establishes automatically the number of marks on the y axis and their placement. It places the first mark at the lowest multiple of 50 Hz within the range 
	of the picture (e.g. at 50 Hz, or 100 Hz, or 150 Hz...). The following marks are placed every 50/100/150 Hz (depending on the range of the utterance).  
	
	In the INSTRUCTIONS section you will find details about the other characteristics and options of the script (e.g changing the dynamic range, 
	choosing the level of smooth in the F0 track, changing the axis' names, choosing the speakers range of F0...)
 	 
	
 
						INSTRUCTIONS
	0. Before you start:
		- Check that your .wav filename does not contain white spaces. 
		- If  you want to draw TextGrids, create the TextGrids with the same name of the sound they are made for. Save them in a folder. 

	1. Open the script (Open/Read from file...), click Run in the upper menu and Run again. 
	2. Set the parameters.
		a) The 3 first fields are for the folders where you have your files. In the first field, write the name of the folder where you have your sound files.
		In the second field, write the name of the folder where you have your Textgrids. In the third field, write the name of the folder where 
			you want the pictures to be saved. Important: always write the path without bar at the end "/".
		b) By changing the dynamic range you can make your spectrograms look 'cleaner'. The lowest it is, the lighter the spectrogram looks.
	c) Choose whether you want to draw the F0 curve or not. The F0 curve will be written twice, once in white and once in thinner black (Welby 2003).
		d) Then specify if you want the F0 range to be defined automatically or manually. If you choose to set it manually, 
	in the next window you'll be asked to define the F0 minimum and F0 maximum.
		e) Choose if you want the F0 minimum and F0 maximum marks to appear on the y axis (if you place them, they might overlap with other marks).
		Note that the F0 minimum and F0 maximum marks are placed at 'rounded' values, that means that 377.8 Hz is rounded to 380 Hz and 51.2 Hz is rounded to 50 Hz.
		f) Decide how much you want the F0 curve to be smoothed. In this field, you need to enter the bandwidth (in Hertz). If you want a 
		very smoothed curve, you should choose a smaller bandwidth (e.g. 10), whereas if you want a less smoothed curve you should choose a bigger bandwidth (e.g. 50).
		Don't write 0 in here, because your curve would become plain.
		g)In the next two choice menus, you can choose the label of the axes (in different languages). You can also decide not to label either or both of them.
		h) You can change the picture width.
		i)Mark the formats in which you want to save the pictures. Notice that PDF will only run if you are working
		 on a Mac and wmf is only for Windows. PNG for Windows and presumably Linux.
		j)Mark whether you want more options or not. (See below for details)
		Click OK

		MORE OPTIONS WINDOW
		If you chose the more options button or if you chose to set the speaker's range manually, a new window will appear. In this window you can:
	a) Set the F0 range in the picture. You must write the numbers separated by a hyphen. This field will only appear if you chose "Set the range manually" 
		in the previous form.
  		b) Choose the spectrogram range. This is by default from 0 to 5000Hz.
		c) If you have chosen not to draw the F0 curve, you can select here how many marks of frequency you want in the spectrogram. 
		You'll be asked every how many Hz you want a mark.
		d) Change the time marks of the x axis. By default, there is a mark without number at every 0.2 seconds and a mark with number at every 0.5 (the number appears 
		written above the mark.)
		e) If you are drawing the f0 curve and you've chosen "Show more options", you can choose here how do you want Praat to select the better candidates to be F0. 
			The script runs with the autocorrelation method (Boersma, 1993) which is optimized for human intonation research, so if you are working with speech, 
			you don't need to change anything.
			Here you'll be asked for the octave cost, octave jump cost, the voiced/unvoiced cost and the voicing_threshold.


	Click OK (the Revert button goes back to the Standards of the form)

	3. Now search your pictures, they have to be in the folder you specified in the first window (the form).



#						CREDITS
Feedback is always welcome, please if you notice any bugs or come up with anything that can improve this script, let me know!
Wendy Elvira-García
wendyelviragarcia@gmail.com
october 2013
tested on Praat 5.3.73 for Windows and Mac
If it doesn't run on Linux, check the syntax of lines: 470 & 486 and mail me I'll be grateful.

Citation: Elvira García, Wendy (2017). Create pictures with tiers v.4.4. Praat script. (Retrieved from http://stel.ub.edu/labfon/en/praat-scripts)

The first version of this script was inspired by:
draw-waveform-sgram-f0.praat
Pauline Welby (2003) with the modifications made by Paolo Roseano (2011)

# 						LICENSE
Copyright (C) 2017  Wendy Elvira

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 3
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You can find the terms of the GNU General Public License here
http://www.gnu.org/licenses/gpl-3.0.en.html

