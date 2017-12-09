;;;MMMM.lisp -- Marvelously Mystery Mansion Murder.  A text based mystery game in CommonLisp.
;;;Author:  Benjamin Chi, Heather Cates, Ross Moriwaki
;;;Class:  ICS313 (Programming Theory)
;;;


;;;The current location of the player.  Initalizes to living room.
(defparameter *location* 'livingroom)

;;;This variable becomes true if the bookcase in the library is examined
(defparameter *secret* '())

;;;A list of locations and their descriptions
(defparameter *nodes* '((livingroom ("
You're in a sprawling room decorated with worldly nicknacks, a large couch and an ornate endtable sit atop a lush Persian rug. The walls are a towering ivory, softened only by billowing curtains decorating an open window. A woman with a sharply cut black bob and deep plum lipstick stands next to a small cabinet, puffing anxiously on a long cigarette. Her anxious disposition tells you this woman is Betty Bennett, the deceased's aunt.
"))
                        (ballroom ("
A grand ballroom with ornately tiled floors is located here. Several glittering chandeliers light the room from an arched ceiling. A small stage that typically hosts the evening entertainment is now home only to a lonely piano. Vases filled with white lilies and lighted candelabras decorate the room. Sitting in a band chair next to the small stage is a woman with wavy blonde hair. She is quite distressed. From your earlier introduction, you recognize this woman as the widower, Daisy Bennett.
"))
                        (diningroom ("
The main dining room is located here. In the center of the room sits an elongated dining table draped in a cream table cloth surrounded by six mahogany chairs. The room is softly lighted by the setting sun glowing through unshaded windows. Across from the table is a large fireplace tiled in jade. A large grandfather clock ticks and tocks in the far right corner. Your woefully helpless companion, Holmes, is dutifully examining a singular spoon. The table is still set with this evening dinner. On the floor lays the body of the victim, a Mr. Wallace K. Bennett.
"))
                        (kitchen ("
A modest kitchen is located here. Pots and pans hang from hooks along the ceiling. Various produce decorate the countertops. An amber liquid drips to the tiled floor from beneath the sink. A slender man with slick black hair stands near a tall and well-worn pantry. From your earlier introductio you recognize this man is Jack Freeman, the deceased's best friend. 
"))
                        (library ("
The mansion's immense library is located here. The room is warmly lighted by a candle light chandelier, wood panel walls and leather bound books. This place smells of pipe tobacco and aged paper. A scuffed oak desk that appears to be several decades old sits alone on the far end of the room. A balding butler, who you recognize as Boris Markov, stands attentively and solemnly next to the rooms sole reading chair. A large bookshelf stands behind him.
"))
                        (bar ("
A secret bar is located here. The room is colored in gold and black and smells of spilled whiskey. Only two empty glasses decorate an otherwise empty bar top. A small trashcan sits beside a pair of stools. Behind the bar stands an old, wooden hutch filled to capacity with glittering bottles of various colored liquors. A dusty gramophone sits adjacent to the bar.
"))
                        (bedroom ("
A king bedroom is located here. The walls are colored monochromatic with little decoration. A large bed encompasses the majority of the space. A photo of Daisy, the deceased's wife, sits atop a small dresser next to the bed.
"))))

;;;A list of edges that connect the locations
(defparameter *edges* '((livingroom (library west door)
                                    (ballroom upstairs stairs)
                                    (diningroom east door))
                        (ballroom (livingroom downstairs stairs)
                                  (bedroom east hallway))
                        (diningroom   (livingroom west door)
                                      (kitchen south door))
                        (kitchen (diningroom north door))
                        (library (bar downstairs ladder)
                                 (livingroom east door))
                        (bar (library upstairs ladder))
                        (bedroom (ballroom west hallway))))

;;;A list of all available clues
(defparameter *valid-objects* '(glasses photo sink dinner trashcan body))

(defparameter *invalid-objects* '(bookshelf clock cabinet gramophone hutch pantry bed desk piano table nicknacks couch endtable rug window stage vases candelabras bandchair chairs fireplace pots pans hooks liquid liquor bar stools dresser curtains))

(defparameter *dull-objects* '())

;;;A list of clue locations
(defparameter *object-locations* '(
(body diningroom)
(dinner diningroom)
(clock diningroom)
(table diningroom)
(chairs diningroom) 
(fireplace diningroom)
(photo bedroom)
(bed bedroom)
(dresser bedroom)
(sink kitchen)
(pantry kitchen)
(trashcan bar)
(hutch bar)
(gramophone bar)
(liquor bar)
(stools bar)
(glasses bar)
(bookshelf library)
(desk library)
(cabinet livingroom)
(nicknacks livingroom)
(couch livingroom)
(endtable livingroom)
(rug livingroom)
(curtains livingroom)
(window livingroom)
(piano ballroom)
(stage ballroom)
(vases ballroom)
(candelabras ballroom)
(bandchair ballroom)	
))

;;;A list of detailed descriptions for objects when they are examined
(defparameter *object-description* '(
	(body ("
You bend down to  examine the body of the victim, Wallace Bennett. His body lays sprawled along the floor, his limbs contorted in unnatural positions. His head displays some slight blunt-force trauma which was evidently caused as the victim fell to the floor, slamming his head into the table. His lips are dry and colored a ghastly deep purple. From these clues you recognize the cause of death immediately: poisoning by Strychnine.
"))
	(dinner ("
A neatly prepared starting dish of a delicately prepared Watercress and Celeriac soup. It is evident that the extravagantly smelling dish has not been touched. What a shame.
"))
	(table ("
A slight spattering of blood lines the edge of the table. It is evident, however, that this is not the cause of death. There is nothing of interest to note here.
"))
(clock ("
A lovely old grandfather clock. It reads that the current time is 5:12 in the evening. There is nothing of relevance to note here.
"))
	(photo ("
Picking up the photo, you realize the back of the frame is loose as if having been opened many times before. Gently, you peel away the old wood backing of the frame revealing a note gingerly written on the back of the photograph. It reads, 'My dearest Daisy, it pains me gravely that you say you wish to remain wed to Wallace. Though he is my dear friend I know he is not good to you. I know he cannot care for you as I do. If I must admire you from afar, as much as it aches my soul, I shall. Forever yours, Jack.'
"))
	(sink ("
You open the cabinet below the sink to examine the origins of the amber liquid that is slowly draining onto the floor. Inside, you see a silver flask pouring its contents onto the otherwise spotless floor. Upon closer examination, you note the liquid is an aged whiskey.  Someone in this house greatly enjoys their alcohol.
"))
	(trashcan ("
Rummaging through the various papers that nearly engulf the bin, you find a small vial with remnants of a white crystalline powder. You recognize the powder as Strychnine.  This must be the murder weapon!
"))
	(bookshelf ("
This seems to be a pretty standard bookshelf.  Apparently Wallace was quite the reader.  
"))
	(cabinet ("
You open the cabinet to... nothing. There is nothing of importance to note here.
"))
	(gramophone ("
An amazing contraption that allows you to listen to recorded music. What will they think of next?
"))
	(hutch ("
An old wooden hutch filled to capacity with glittering bottles of various colored liquors. Nothing seems to be out of place here. 
"))
	(pantry ("
Your standard kitchen pantry, filled with various rations. There is nothing fishy here... well, except maybe the canned anchovies.
"))
	(bed ("
A very cozy looking master bed. It is still well made from the morning chores. 
"))
	(desk ("
This old scuffed desk may look out of place in the room, but there is nothing of significance to note. I doubt the victim was murdered over his lack of taste.
"))
	(piano ("
An extravagant piece of musical instrumentation, but otherwise unnoteworthy.
"))
        (clock ("
The pendulum in the grandfather clock ticks with a dutiful purpose, but you aren't being paid by the hour so it's probably best to get back to the investigation.
"))
        (nicknacks ("
An array of exotic and worldy nicknacks from places you've never been are arranged thoughtfully along the wall, but there is nothing of note amongst them.
"))
        (couch ("
Well worn and very comfortable, the couch adds a homely touch to the large room, but is otherwise unnoteworthy.
"))
        (endtable ("
An ornate endtable sits against the couch, but you find nothing after investigating.
"))
        (rug ("
You spend a minute walking around the room as you examine the rug, but besides the fine quality there is nothing to note.
"))
        (window ("
The open window lets in a cool breeze.  After a short respite, and having found nothing, you decide it's best to move on.
"))
        (curtains ("
The curtains sway peacefully by the window.  You check, but unfortunately the culprit isn't hiding behind them.
"))
        (stage ("
The small stage is finely decorated and must have been the source of many a party's entertainment, but somehow you can tell it hasn't been used in a while, home now only to a lone piano.
"))
        (vases ("
The vases are filled with fragrant lillies.  Beautiful, but adds nothing to the investigation.
"))
        (candelabras ("
The candelabras glow with a warm light, but there is nothing of note here.
"))
        (bandchair ("
Daisy sits upon the chair, her thoughts obviously on the death of her husband.  Besides it looking rather uncomfortable, you find nothing else of note.
"))
        (chairs ("
You examine the dark mahogony chairs that sit around the table, but find nothing noteworthy.
"))
        (fireplace ("
The fireplace sits silently, the jade glinting as you walk around it, though you find nothing of note.
"))
        (pots ("
A variety of pots and pans of varying sizes hang along the wall, but you find nothing out of place here.
"))
        (pans ("
A variety of pans and pots of varying sizes hang along the wall, but you find nothing out of place here.
"))
        (hooks ("
Small hooks hang from the ceiling, each one providing a home for various pots and pans, though you find nothing out of place here.
"))
        (liquid ("
The amber liquid appears to be leaking out from under the sink and smells of alcohol, perhaps there is something there.
"))
        (liquor ("
A wide variety of expensive and rare liquors are lined carefully along the bar top, but look unopened and untouched.  He was likely saving them for a special occassion, though he probably wishes he'd drank them sooner now.
"))
        (bar ("
The bar is stained with the spilled drinks of good times that were had here.  You look around but find nothing else of note.  Perhaps there are other clues around the room.
"))
        (stools ("
Wooden stools with small cushions sit against the bar.  You find nothing of note here.
"))
        (dresser ("
A photo of daisy sits upon this small dresser.  You look through the drawers but find nothing of note.
"))
        (glasses ("
Upon closer inspection of one of the glasses you notice a few droplets of amber liquid left.  Someone must have had a drink here recently.
"
))))

;;;A list for people
(defparameter *people* '(daisy boris jack betty holmes))

;;;A list for people locations
(defparameter *people-locations* '((daisy ballroom)
(boris library)
(betty livingroom)
(jack kitchen)
(holmes diningroom)))

;;;A list of the characters notes/inventory
(defparameter *notes*  '(jack affair trashcan))

(defparameter *clue-descriptions* '((body ("Wallace died from ingesting poison.")) 
                                    (cook ("Dinner was prepared by Boris.")) 
                                    (jack ("Jack and Boris are the only people that about the secret bar.")) 
                                    (affair ("Jack and Daisy were having an affair, but broke it off because of Wallace.")) 
                                    (daisy ("Daisy believes Wallace was sober.")) 
                                    (betty ("Betty believes Wallace was sober.  But she doesn't think Boris is.")) 
                                    (trashcan ("An empty bottle of poison was found in the trashcan of the hidden bar.")) 
                                    (sink ("A flask for carrying alcohol was found beneath the kitchen .")) 
                                    (photo ("A love letter was written from Jack to Daisy on the back of a photo.")) 
                                    (dinner ("No food was eaten from dinner.")) 
                                    (inheritance ("Betty expects an inheritance from Wallace.")) 
                                    (marriage ("Wallace and Daisy were having marital problems.")) 
                                    (bar ("There is a hidden bar in the library."))
                                    (glasses ("Wallace had a drink in the bar with another person."))))

(defun start ()
  '("===The Marvelously Mysterious Mansion Murder===

    You arrive at the Bennet Mansion as the sun begins to set, coloring it's cream colored walls a hue of apricot.  Just moments before you and your woefully hopeless detective friend (whom you affectionately and refer to as Holmes) received the call that led you to your current location. This evening Mr. Wallace Bennett was murdered in his own home. 
    As you open the door to the mansion, the house is in complete chaos. Raised voices, insults and accusations fly through the air as soft sobs fall on deaf ears. Holmes looks around before yelling, 'Silence!'.
    Suddenly, everyone in the room becomes aware of your presence and the room falls silent. All eyes fall on you and Mr Holmes. Realizing it is imperative that the witnesses are kept separately, you order each individual to a different room before beginning the investigation.

Type 'help' at anytime for game instructions.

"))

(defun notes ()
  (flatten (append '("
---NOTES---
") (loop for i in *notes*
        collect (append (cadr (assoc i *clue-descriptions*)) '("
"))) '("
")) ))

;;;Given a location and the nodes list, it prints out the description of the location
(defun describe-location (location nodes)
   (cadr (assoc location nodes)))

;;;A helper function for merging lists together
(defun flatten (l)
  (cond
    ((null l) nil)
    ((atom l) (list l))
    (t (loop for a in l appending (flatten a)))))

;;;Given the list of edges it prints how you get there and the direction
(defun describe-path (edge)
  `("There" is a ,(caddr edge) going ,(cadr edge) from here.))

;;;Not all locations have only 1 edge.  This function lists all the paths available.
(defun describe-paths (location edges)

  ;;The cdr part finds all the edges lists that correspond to the given location
  ;;The mapcar part take the describe-path function and applies it to each given edge
  ;;Apply then takes the append function and appends each item in the list together
  (append (apply #'append (mapcar #'describe-path (cdr (assoc location edges)))) '("
")) )

;;;Given a direction, moves to a new location
(defun walk (direction)
  
  ;;A local function that returns true if the direction matches an edge
  (labels ((correct-way (edge)
             (eq (cadr edge) direction)))

    ;Find-if searches each edge using correct-way and makes next the first edge that returns true
    (let ((next (find-if #'correct-way (cdr (assoc *location* *edges*)))))
      
      ;If next has a value, then the new location is set to next or the current edge
      (if next 
          (progn (setf *location* (car next)) 
                 
                 ;Prints out a description of the new location
                 (look))
          
          ;If next is nil then prints an error message
          '("
You walk straight into a wall. Youre doing a bang-up job. Get it? BANG up. No, but seriously you should probably try a different way. 

")))))

;;;Displays the objects at a given location
(defun objects-at (loc objs obj-loc)

   ;;A local function that takes an object and returns true if it's at the given location
   (labels ((is-at (obj)
              (eq (cadr (assoc obj obj-loc)) loc)))
       
       ;Removes objects from the list that are not in the given location
       (remove-if-not #'is-at objs)))

;;;Displays a description of the location using each of the functions above.  Appends them into one list.
(defun look ()
  (setf *print-length* 100000)
  (if (and (equal *secret* nil) (equal *location* 'library))
(append (describe-location *location* *nodes*)
       	   '("There is a door going east from here.
"))

(append (describe-location *location* *nodes*)
       	   (describe-paths *location* *edges*))))

;;;Function that allows you to examine objects in rooms
(defun examine (&optional obj)
	(cond

	;The player doesn't enter any input
	((equal obj nil) '(Examining nothing seems real exciting...))

	;The object is not in the game
	((and (not (member obj *valid-objects*))(not (member obj *invalid-objects*))(not (member obj *dull-objects*))) '(that object does not exist))
	
	;The object is not in the given location
	((and (not (member obj (objects-at *location* *valid-objects* *object-locations*))) (not (member obj (objects-at *location* *invalid-objects* *object-locations*))) (not (member obj (objects-at *location* *dull-objects* *object-locations*)))) '(that object is not in this location))
	
        ;The object is the bookcase in the library and you have knowledge of the hidden bar
        ((and (equal obj 'bookshelf) (member 'bar *notes*) (equal *secret* nil)) (setf *secret* 1) '("
Examining the bookshelf very closely you notice a book that is strangely out of place. As you attempt to reposition it, a hidden entrance slides into view. You see a ladder leading downstairs into a hidden room.
"))

	;The object is valid and has been discovered already
	((and (member obj *valid-objects*) (member obj *notes*)) (cadr (assoc obj *object-description*)) )

	;The object is valid and has not been discovered
	((member obj *valid-objects*) (add-clue obj) (append (cadr (assoc obj *object-description*))'("
---New clue added to your notes!---

")) )


	;The object is invalid
	((member obj *invalid-objects*) (cadr (assoc obj *object-description*)))
))

;;;A function to get more information from people
(defun talk (&optional person)
   (cond
	((equal person nil) '(I am not sure how much new information you are going to get by interrogating yourself."
"))
	((not (member person *people*)) '(Making up suspects now are we?"
"))
	((not (member person (objects-at *location* *people* *people-locations*))) '("
You can not talk to someone who is in a different room I mean, you could yell, but it probably is not a good idea to startle a potential murderer.
"))
	((equal person 'daisy) (talk-daisy))
	((equal person 'boris) (talk-boris))
	((equal person 'jack) (talk-jack))
	((equal person 'betty) (talk-betty))
	((equal person 'holmes) (talk-holmes))
   ))

;;;Daisy's dialogue depending on what's in the notes
(defun talk-daisy ()
(append
;If you have already talked to Daisy but you haven't found the letter
	(when (and (member 'daisy *notes*) (not (member 'letter *notes*)))
		'("
Im sorry, I have told you everything I know.

"))

	;If you have already talked to Daisy and you found the letter
	(when (and (member 'daisy *notes*) (member 'letter *notes*))
		'("
Im sorry, I have told you everything I know.

"))

	;If you haven't talked to Daisy at all
	(when (not (member 'daisy *notes*))
                (append '("
    You approach Daisy, delicately handing her your handkerchief. 
    'I am sorry for your loss' you say softly. 
    'I...I just cannot believe it. I... I thought things were going to get better. You know he stopped drinking? We were going to renew our vows, start fresh... and now...' She shook her head. 
    'I will do my best to figure this out m'am' you insist reassuringly. 

") (add-clue 'daisy)))
	
	;If you haven't talked to Daisy or Jack about the letter yet
	(when (and (not (member 'affair *notes*)) (member 'photo *notes*))
          (append '("
    'You have not been up-front with me,' you say sternly.  'I found a letter from Jack to you written on the back of a photograph.  Care to explain?' She gasps and cups her hands over her mouth, her face flushing red. 
    'I am not sure what to say...' she admitted after some time. 'We were going through a rough patch... and Jack, well Jack was always there. I know it was wrong.  That's why I ended things with him. I didn't want to but I had to.  I loved them both, but he knew I would always be with Wallace. He understood that.'

") (add-clue 'affair))))
)

;;;Jack's dialogue depending on what's in the notes
(defun talk-jack ()
(append
	;If you already know about the affair\, but you don't have the flask and you haven't talked to Daisy or Betty about Wallace's sobriety
	(when (and (member 'jack *notes*) (member 'affair *notes*) (not (or (member 'daisy *notes*) (member 'betty *notes*))) (not (member 'sink *notes*)))
		'("
I'm sorry, I've told you all that I know.
"))

	;If you know about the secret bar, but you don't know about the affair
	(when (and (member 'jack *notes*) (not (member 'affair *notes*)))
		'("
I'm sorry, I've told you all that I know.
"))

	;If you know about the secret bar and you know about the affair
	(when (and (member 'jack *notes*) (member 'affair *notes*))
		'("
I'm sorry, I've told you all that I know.
"))

	;If you haven't talked to Jack yet
	(when (not (member 'inheritance *notes*))
                (append '("
    'Do you mind if I ask you a few questions' you ask, walking up to Jack. 
    'Of couse.' 
    'How long have you and Wallace known each other?' 
    'Since we were kids' he said softly. 'I just can't believe he's gone.'
    'I'm sorry, I know this must be hard for you, but this investigation shouldn't take much longer. I do have to ask, and this may be difficult to answer, but do you know of anyone who may have reason to harm Wallace?' 
    He thinks for a moment before responding, 'Wallace was not the friendliest guy, but it wasn't like he made enemies easily. Most people, especially his relatives, only really saw him as money. Now that he is gone... well, lets just say there is a certain aunt that has made it pretty clear that she expects to inherit.'
") (add-clue 'inheritance)))

	;If you haven't talked to Jack or Daisy about the letter yet
	(when (and (not (member 'affair *notes*)) (member 'photo *notes*))
          (append '("
    'You have not been up-front with me' you say sternly. 'I found a photo in the bedroom with a message on the back.  It was signed by you.'
    He sucks in a tight breath and after a moment replies 'It wasn't like that. Daisy and I have not been together in some time. She made her choice. She wanted Wallace. He was like a brother to me, we just had the unfortunate circumstance of loving the same woman.'
    ") (add-clue 'affair)))

	;You have the flask and have talked to Daisy or Betty about Wallace's sobriety
	(when (and (member 'sink *notes*) (not (member 'jack *notes*)) (or (member 'daisy *notes*) (member 'betty *notes*)))
                (append '("
    You approach Jack with your recent discovery of the hidden flask beneath the sink.
    'I thought Wallace was sober?'
    'That's what the women think.  But truth is.  He never could stop drinking...' he started. 'He hid liquor everywhere in this house.  He even had an entire room dedicated to his finest inebriants.  In fact, I think the only two people that knew about his ongoing alcohol use were me and that butler.'
") (add-clue 'jack)))
))

;;;Boris' dialogue depending on what's in the notes
(defun talk-boris ()
(append
;If you have already talked to Boris but you haven't found the flask and you haven't talked to daisy or betty
	(when (and (member 'cook *notes*) (or (not (member 'sink *notes*))  (and (not (member 'daisy *notes*)) (not (member 'betty *notes*)))))
		'("
I'm sorry, I've told you all that I know.
"))

	;If you have already talked to Boris and you found the flask and you have talked to daisy  or betty
	(when (and (member 'cook *notes*) (or (member 'daisy *notes*) (member 'betty *notes*)))
		'("
I'm sorry, I've told you all that I know.
"))

	;If you haven't talked to Boris at all
	(when (not (member 'cook *notes*))
                (append '("
    You approach Borris, notes in hand and ask 'Can you please detail your whereabouts between 3 and 4 o'clock this evening?'
    'Of course, that would have been while I was cooking dinner for Master and Mistress Bennett  and their guests.' 
    'Cooking? Isn't that the job of... well a cook?' 
    'Normally yes, but Master Bennett was quite... particular. He trusted very few people in his life.  Apparently for good reason.'
    ") (add-clue 'cook)))
	
	;If you haven't talked to Boris about the bar yet
	(when (and (not (member 'bar *notes*)) (member 'sink *notes*) (or (member 'daisy *notes*) (member 'betty *notes*)))
          (append '("
    'What information can you give me regarding this' you ask Boris carefully, showing him the flask you found earlier in the kitchen. 
    'The master of the house had... a thirst for certain liquids.' 
    'You're saying this flask belonged to Wallace Bennet? I had heard that he was sober for some time now' you reply, unsure of the contradictory information.
    'Unfortunately not, despite having made a sincere effort, Master Wallace was still facing his demons. He didn't want the mistress of the house to know, it worried her deeply...so much so that he renovated the library to include a private drinking room.' 
    Hearing this news you feel you should investigate the bookshelf further. 
") (add-clue 'bar)))
))

;;;Betty's dialogue depending on what's in the notes
(defun talk-betty ()
        (append

	;If you have already talked to betty but you haven't found the sink yet
	(when (and (member 'marriage *notes*) (not (member 'betty *notes*)))
		'("
I'm afraid I've told you all that I know.
"))

	;If you have already talked to betty and you have found the flask
	(when (and (member 'betty *notes*) (member 'sink *notes*))
		'("
I'm afraid that I've told you all that I know.
"))

	;If you haven't talked to betty at all yet
	(when (not (member 'marriage *notes*))
                (append '("
    You approach Betty Bennett carefully asking 'Do you mind if I ask you a few questions?' 
    She takes another long drag of her cigarette before starting 'I'm not sure of how much assistance I can be but I'll tell you all that I know'. A think wisp of smoke dances out from her lips as she speaks. 
    'Well, do you have any reason to suspect anyone may want to harm your nephew?' 
    She takes another drag and the smoke billowing forward wraps around her words 'Wallace wasn't making many friends these days, but I can't imagine anyone hurting him.' 
    'Care to clarify' you ask, unsure of her meaning.
    'Wallace has been going through a rough patch is all. He and Daisy have been a bit strained and I think that put a lot of pressure on him. He's always been particular, but as of late he has cut off virtually everyone but family and trusted friends.' 
") (print nil) (add-clue 'marriage)))

	;If you haven't talked to Betty about Wallace's sobriety yet
	(when (and (not (member 'betty *notes*)) (member 'sink *notes*))
                (append '("
    'Ms. Bennett I found a flask below the sink. Can you tell me anything about it?' 
    'It must belong to that butler. The lady of the house abhors alcohol and dear Wallace has been sober for some time now.  That butler seems the type doesn't he?  You know, the type to be hiding a flask in a home that clearly forbids it.'
    'You really think he's the type?' you say skeptically.
    'Hmph,' she puffs with a smirk. 'I know he is.'
") (add-clue 'betty)))
)
)

;;;Holmes' dialogue
(defun talk-holmes ()
  '("
    Holmes turns the spoon in his hand eyeing it carefully and says 'I've a theory about this spoon, but I want to know your theories first. What do you think happened?'

To accuse someone use the accuse command followed by a name.
"))

(defun accuse (&optional person)
	(cond
	   ((equal person nil) '("In order to accuse someone, you must provide a name."))
           ((equal person (or '(me) '(myself) '(I))) '("Insert self accusation here")) 
           ((equal person 'holmes) '("'Me?!' He puffs his chest forward, huffing in disbelief. 'Truly, are you the worst detective alive! You and I both were at our headquarters at the time of the murder. 
      No, clearly dear pupil, this was no murder at all!' He shakes the spoon violently at you. 'Don't you see? The poor man choked on this spoon in a rush to eat that delicious smelling soup!' 
      You recall that the soup in the kitchen had not been touched, but without the evidence to convict nor a clue as to who actually committed the crime you are forced to accept Holmes's spoon theory.

      YOU LOSE.  GAME OVER.  TYPE 'START' TO TRY AGAIN OR QUIT TO LEAVE THE GAME"))
	   ((not (member person *people*)) '("You must accuse one of the suspects"))
	   ((equal person 'boris) '("You and Holmes approach Boris, the house's butler, to accuse him of the crime. 
      'You think what?!' He chokes on his words as you deliver your accusation. 'Quite clearly not! I have no reason to harm Master Wallace... and to think I trusted you to get to the bottom of this.
      I am very disappointed. I have been nothing but a faithful servant for these past years. At any point I could have harmed those that live here... why now? Honestly, are you even real detectives?'
      After a moment he lets out a breath and says 'The truth behind this murder is buried beneath lies. Maybe you need to dig deeper.'
      As you lead him away in cuffs, his words gnaw at your thoughts.  Maybe he's right.  Something doesn't quite fit...

     YOU LOSE.  GAME OVER.  TYPE 'START' TO TRY AGAIN OR 'QUIT' TO LEAVE THE GAME.
"))
	   ((equal person 'betty) '("You and Holmes gather each suspect into the living room, each eagerly awaiting your news. After a long moment you thrust your arm out and point directly at Betty stating confidently 
      'The murderer is none other than Betty, the deceased's scheming aunt!' The room fills with gasps of horror as Betty's face pales and contorts into an expression of utter confusion and panic. 
      'I did no such thing...' she huffs quickly, looking around in desperation for someone, anyone to come to her assistance.
      'Boris?' She said pleading to the old butler who stared in complete shock.
      'Daisy? Please... I didn't do this!' Suddenly she broke, realizing the madness of her current predicament she spun around quickly, pointing to you.
      'Maybe is was you, or...' spinging again she thrust her arm out violently toward Holmes
      'Perhapas you Mr Holmes....' 
      Finally, Daisy jumped up to steady Betty. 'I know it wasn't you...'
      She said softly, calming the frantic woman. Daisy turns to you hysterically saying 
      'Please detective, you have to believe me!  I didn't do it!' 
      'Tell that to the jury'
      As you walk out the house with a sobbing Betty Bennett in handcuffs you smile at the prospect of another solved case.  Too bad you're wrong.

      YOU LOSE.  GAME OVER.  TYPE 'START' TO TRY AGAIN OR 'QUIT' TO LEAVE THE GAME."))
	  ((equal person 'daisy) '("You and Holmes approach Daisy, the lady of the house, to accuse her of the crime. The moment the accusation escapes your mouth Daisy bursts into tears.
    'How dare you...' she sobs. 'I just lost my husband and instead of finding his killer you... you... Oh god' she wails.
    Suddenly, you hear footsteps approaching quickly from behind followed swiftly by a familiar voice.
    'Mistress, are you okay? I heard raised voices and....' Boris rushes to her side, quickly pulling a handkerchief and blotting her flushed face.
    'Oh Boris, it's just awful... they.... they think I killed Wallace!' Boris twists to face you. 
    'I am incredibly disappointed.' He shook his head while comforting Daisy. 'Clearly she did not commit this crime. I think you should reevaluate your evidence.' 
    Boris does have a point.  Maybe you should reevaluate the case and try not to send an innocent widow to jail.

     YOU LOSE.  GAME OVER.  TYPE 'START' TO TRY AGAIN OR 'QUIT' TO LEAVE THE GAME."
))
	  ((and (equal person 'jack) (member 'trashcan *notes*) (member 'affair *notes*) (member 'jack *notes*)) '("You and Holmes gather each suspect into the living room, each eagerly awaiting your news. After a long moment you begin to pace the floor.
      'I'm sure you are all wondering why I have gathered you all here, and I am confident that by now you have all correctly deduced that I have solved the mystery of this cruel murder. However, before I unmask the killer, allow me to detail the events leading up to our current circumstances.'
After a long moment, you begin 'Earlier in the evening, the house's butler, Boris was preparing the dinner of the evening. A few hours later, Wallace Bennett died of Strychnine Poisoning.'
      'The butler poisoned the food...' Jack offered.
      'Oh no, you see, this evening's meal was,  quite unfortunately, never touched. A shame really, it smelled lovely. However,'you continued 'Wallace was, in fact, poisoned.' 
      Daisy's hands shot to her mouth, her face looking anguished.
      'So, how was the master of the house poisoned, you may find yourself asking. This is exactly what I set to find out first, and I found the answer to that question in the kitchen.'
      'So it was the butler!' exclaimed Betty. 
      'No, you see, what I found was a flask hidden beneath the sink... a flask which belonged to no one other than Wallace Bennett. While the ladies of the house thought Wallace had given up drinking, the men knew quite well that he had not. The contents of this flask had been poisoned. However, while both men knew of Wallace's drinking habit and could have poisoned him, only one had any motive to commit the crime.'
      'But who would do such a thing, and why? The answer to that question was found in the master bedroom, where behind a photograph of the lady of the house I found a note describing the circumstances of an affair between Daisy and Jack.'
      You quickly continued before you can be interrupted 'This evening, Wallace invited you all to dinner. Jack arrived early and shared a drink with Mr Bennett before dinner in the secret bar he kept below the bar. Because of your feelings for Daisy and your assumption that she would inherit his fortune and ultimately come back to you, you poisoned Wallace's drink.'
      You turn quickly and thrust your arm out to point directly at Jack stating confidently 
      'The murderer is none other than Jack Freeman, the deceased's best friend!'
      The room fills with gasps of horror as Jack's eyes grow wide with shock.
       'I, uh... That's ridiculous.  I would never...' he stutters.
       'Please come with us Mr. Freeman.  We have a lot to talk about.'
Jack suddenly dashes towards the door in an attempt to escape.  Thinking quickly, you pull the rug from beneath his feet and he tumbles forward. As he tries to scramble to his feet, you stand towering above him. 
      'Jack Freeman, you are under arrest for the murder of Wallace Bennett.'
      As you handcuff him, he looks at the ground defeated, before turning his head to look back at Daisy.
      'We could have been together, my love.  With Wallace gone there was nothing that could have stopped us.'
       Horrified, a trembling Daisy looks at Jack and tearfully whispers, 'I could never love a murderer.  Detective take him away.  I never want to see him again.'
       You nod to her assuredly.  You should be proud of yourself.  You have successfully brought another murderer to justice.

        YOU WIN!  THAT WAS SOME FINE DETECTIVE WORK.  TYPE 'START' TO PLAY AGAIN OR 'QUIT' TO LEAVE THE GAME."
))
	  (t '("You and Holmes approach Jack, the deceased's best friend, to accuse him of the crime. 'Jack Freeman,' you say approaching him confidently 'you are under arrest for the murder of Wallace Bennett!' 
'Ha' he let out a short but resounding laugh 'and what evidence do you have of this?' ''I know it was you, that much is clear.'
'Oh really,' he starts, wearing a smug grin. 'Well, go on, arrest me then' he says, thrusting his wrists forward with a blatant cockiness that makes your blood boil. As you snap the cuffs into place and march him out the door you realize that he is right. Without sufficient evidence, this will never hold up in court. 

     YOU LOSE.  GAME OVER.  TYPE 'START' TO TRY AGAIN OR QUIT TO LEAVE THE GAME."

 ))
	)
)



(defun add-clue (clue)
  (cond 
      ((member clue *notes*) '("You already made a note of this"))
      ((member clue *valid-objects*) (push clue *notes*))
      (t (push clue *notes*) '("
---New clue added to your notes!---

"))
  ))


;;;Sets up a repl interface using read, eval, and print
(defun game-repl ()
    (princ "
Please enter a command: ")
    (let ((cmd (game-read)))
        (unless (eq (car cmd) 'quit)
            (game-print (game-eval cmd))
            (game-repl))))

;;;Removes parenthesis and quotes from output.
(defun game-read ()
    (let ((cmd (read-from-string (concatenate 'string "(" (read-line) ")"))))
         (flet ((quote-it (x)
                    (list 'quote x)))
             (cons (car cmd) (mapcar #'quote-it (cdr cmd))))))

(defparameter *allowed-commands* '(start look walk examine talk notes accuse))

;;;Only allows certain comands
(defun game-eval (sexp)
  (cond ;; made into cond since need to check if help or other valid command
   ((member (car sexp) '(help h ?)) ;;;ADDED HELP FUNCTION CHECK, CAN TYPE help, h or ? for help
    (help-me))
    ((member (car sexp) *allowed-commands*)
        (eval sexp))
    (t
        '(I do not know that command)))
)

;;;;;;;;;;;;;;;;;;
; HELP FUNCTION ;
;;;;;;;;;;;;;;;;;;

;; Help-me function is called when a user types h, help or ? in command line.
;; It prints help, instructions and hints to user

(defun help-me ()
  '("walk (walk direction): the walk command can be used to move around. Just type walk and a direction (eg walk west) to move from your current location.

   examine (examine object): Use the examine command to investigate objects in your location. If the object you examine is relevant to the case, it will be added to your notes!

   talk (talk name): You can talk to other characters that are in the same room as you by typing talk and the person's name.

   accuse (accuse name): The accuse command can only be used after talking with Holmes, which means you must be in the room with him as well.  If you believe you have figured out who the culprit is, and have all the evidence required to support it in your notes, you can accuse them by their first name. Be warned that you will lose if you accuse the wrong person, or if you accuse the culprit with insufficient evidence to support your accusation!

    look (look): The look command will tell you what is in the current room in the mansion.

    notes (notes): The notes command will allow you to look over the important details you have learned by interacting with the world using examine and talk.  Try using it when you need to refresh your memory about what people have said!

    start (start): The start command will restart the game you are currently playing.  There is no saving, so using this command will make you lose all your data, and you will start again from the beginning.  You've been warned!

    TIP FOR ENTERING COMMANDS:  If you're having trouble examining or talking to a particular object or person, re-read the description for the exact spelling of a name or object. If the object you're trying to examine still does not work, try examining related objects around it.  For example, if you want to examine flowers in a vase instead of (examine flowers) try (examine vase).
  "
 ))

;;;Takes a list of characters and edits them.
(defun tweak-text (lst caps lit)
  (when lst
    (let ((item (car lst))
          (rest (cdr lst)))
      (cond ((eql item #\space) (cons item (tweak-text rest caps lit)))
            ((member item '(#\! #\? #\.)) (cons item (tweak-text rest t lit)))
            ((eql item #\") (tweak-text rest caps (not lit)))
            (lit (cons item (tweak-text rest nil lit)))
            (caps (cons (char-upcase item) (tweak-text rest nil lit)))
            (t (cons (char-downcase item) (tweak-text rest nil nil)))))))

;;;Prints out the output to normal text.
(defun game-print (lst)
(setf *print-length* 1000)
    (princ (coerce (tweak-text (coerce (string-trim "() " (prin1-to-string lst)) 'list) t nil) 'string))
    (fresh-line))


