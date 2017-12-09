;;;Author:  Benjamin Chi, Heather Cates, Ross Moriwaki
;;;Class:  ICS313 (Programming Theory) 



Welcome to the Marvelously Mysterious Mansion Murder!  
This is a text based mystery game implemented in CommonLisp.  

STARTING THE GAME:



1.  Start your Lisp interpreter (ex. Emacs, LispWorks, Clisp)


2.  Load the game with (load "<insert file path here>")


3.  Next start the in game repl with (game-repl)

4.  This will display an in game command line so you do not need to use parenthesis every time you enter a command


5.  On the in game command line enter “start” to start the game


__________________________

GAME “FEATURES”:


In some cases due to the large amounts of text a stack overflow may occur.  If so extend the stack and restart the game repl if necessary.  
In LispWorks the final winning message in the game will cause a stack overflow (deep) due to the length of the final dialogue.


Sometimes NIL will randomly print to the screen due to empty parameters being passed to the print function. 
This will not affect your game progress or settings.

Given the large amount of dialogue indenting, spacing, and newlines may be slightly out of place.  
This will not affect your game progress or settings.