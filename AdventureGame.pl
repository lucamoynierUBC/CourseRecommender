% rooms
room(quiet_room, 'Quiet Room', 'You are in the quiet study section, chairs and tables are flipped, there is a trail of blood but it leads nowhere. This is where the murder took place.').
room(emerging_media_lab, 'Emerging Media Lab', 'You are in the emerging media lab. You see see the coveted Apple Vision Pro smashed on the ground.').
room(bathroom, 'Bathroom', 'You enter the bathroom, nothing is amiss. The custodial staff have been taking good care of this area. Nothing to look at.'). 
room(hallway, 'Hallway', 'You enter the hallway... Where do you go?').
room(ikes, 'Ikes Cafe', 'You are in Ikes Cafe. The smell of cinnamon buns fills the air. On the counter, you see some utensils. One knife sticks out more than the others. There is a lanyard on the floor.').
room(entrance, 'Entrance', 'You enter the IKB, its heavy metal doors are rusted, from the constant downpour and neglect').
room(dodson, 'Dodson Room', 'You enter the Dodson Room. There are some pamhplets on the table, as well as a bazooka on display.').

% possible murder weapons
weapon(knife, 'a butter knife, accessibly sharpened.').
weapon(laptop, 'an old laptop with the resemblence of a brick, with a large dent in it').
weapon(bazooka, 'an old WW2 bazooka, used against the Nazis. Left behind by a history presentation in Dodson Room.'). 
weapon(lanyard, 'a blue UBC landyard... 1st years...'). 

% inspecting the objects
% quiet room:
inspect(chairs, 'The chairs and tables are flipped. Was there a physical altercation between the victim and the murderer?').
inspect(tables, 'The chairs and tables are flipped. Was there a physical altercation between the victim and the murderer?').
inspect(blood, 'The blood on the floor is dry. The victim was hit or stabbed with something.').

% emerging media lab
inspect(laptop, 'An old, heavy laptop with the resemblence of a brick, with a large dent in it. You try to turn it on but nothing happens.').
inspect(applevision, 'The broken Apple Vision Pro is on the floor. Some of the pieces are missing, so someone tried to clean up the mess.').

% bathroom
% there's nothing?

% Ike's
inspect(knife, 'The knife is different than all the other knives on the counter. It looks clean.').
inspect(lanyard, 'You feel your first-year memories creeping up, but you brush away the thoughts. You realize that the lanyard is large enough to fit around someones neck.').

% Dodson
inspect(bazooka, 'One of the largest weapons you have seen. It has no ammunition.').
inspect(pamhplets, 'The pamphlets are contain the short biographies of the presenters of a History presentation.').

inspect(_, 'Invalid input.').


move_rooms(Old, New) :- connected(Old, New).

% cy
connected(quiet_room, hallway).
connected(hallway, quiet_room).
connected(emerging_media_lab, hallway).
connected(hallway, emerging_media_lab).
connected(bathroom, hallway).
connected(hallway, bathroom).
connected(ikes, hallway).
connected(hallway, ikes).
connected(entrance, hallway).
connected(hallway, entrance).

% room contains...
contains(ikes, butterknife).
contains(emerging_media_lab, laptop).
contains(bazooka, dodson).
contains(quiet_room, lanyard).

suspect(president_bacon, 'President Bacon', 'Recently appointed UBC President.').
suspect(ex_president_ono, 'Ex-President Ono', 'Former president of UBC.').
suspect(lily, 'Lily Bryant', 'CPSC 312 TA.').
suspect(evangeline, 'Evangeline Lilly', 'Actress and UBC alum.').

interrogate :-
    write('The suspects for the murder are waiting outside with your colleague. It is time to start the'), nl,
    write('interrogation. The indiviudals who were detained for questioning are the following:'), nl, nl,
    write('     Santa Ono, former president of UBC, who said he was visiting campus for a trip down memory lane.'), nl, nl,
    write('     Benoit Antoine Bacon, current president of UBC, who said he was walking around to meet with students'), nl, 
    write('     and get feedback on increasing yearly tuition.'), nl, nl,
    write('     Lily Bryant, TA for CPSC 312, who said she was grading the Prolog midterms.'), nl, nl,
    write('     And finally, Evangeline Lilly, UBC alum and famous actress known for her performance in Lost.'), nl, 
    write('     She was at UBC to film an Ant-Man and the Wasp movie and went into IKB to use the washroom.'), nl, nl,
    get_suspect.
    

print_location :-
    current_room(Current),
    room(Current, _, Desc),
    write(Desc),nl,nl,
    write('You can move to the following: '), nl, nl,
    list_places(Current), nl, nl,
    %write('Where would you like to move to?'), nl, nl.
    get_user_input.

get_user_input:-
    nl, write('Type a command:'), nl, nl,
    readln(Input),
    command(X, Input),
    process_input(X),
    get_user_input.

get_suspect :-
    write('You can interrogate a suspect: e.g. interrogate santa ono'), nl,
    write('Or you can arrest a suspect: make arrest'), nl, 
    write('Be careful, you cannot revert an arrest.'), nl, nl,
    readln(Input),
    question(Input),
    get_suspect.

detective_handbook :-
    write('You have learned from your trusty detective guidebook that you must ask the following questions,'), nl, 
    write('verbatim, for a successful interrogation.'), nl, nl,
    write('     why were you at ikb on the day of the murder'), nl,
    write('     did you know the suspect personally'), nl,
    write('     what exactly were you doing when the murder took place'), nl,
    write('     no more questions'), nl, nl,
    write('What do you ask? Example: no more questions'), nl, nl.

question([interrogate, santa, ono]) :-
    nl, write('You are questioning Santa Ono.'), nl, nl,
    detective_handbook,
    readln(Input),
    ask_suspect(Input, santa),
    question([interrogate, santa, ono]).

question([interrogate, benoit, antoine, bacon]) :-
    nl, write('You are questioning Benoit-Antoine Bacon.'), nl, nl,
    detective_handbook,
    readln(Input),
    ask_suspect(Input, bacon),
    question([interrogate, benoit, antoine, bacon]).

question([interrogate, lily, bryant]) :-
    nl, write('You are questioning Lily Bryant.'), nl, nl,
    detective_handbook,
    readln(Input),
    ask_suspect(Input, lily),
    question([interrogate, lily, bryant]).

question([interrogate, evangeline, lilly]) :-
    nl, write('You are questioning Evangeline Lilly.'), nl, nl,
    detective_handbook,
    readln(Input),
    ask_suspect(Input, evangeline),
    question([interrogate, evangeline, lilly]).

question([make, arrest]) :-
    nl, write('Who is guilty of David Pooles murder?'), nl, nl,
    write('Santa Ono'), nl,
    write('Benoit-Antoine Bacon'), nl,
    write('Lily Bryant'), nl,
    write('Evangeline Lily'), nl, nl,
    readln(Input),
    arrest(Input).

question([interrogate, _]) :-
    nl, write('That is not a suspect. Please try again.'), nl, nl,
    interrogate.

question([_,_]) :-
    nl, write('Invalid input. Please try again.'), nl, nl,
    interrogate.

question([_]) :-
    nl, write('Invalid input. Please try again.'), nl, nl,
    interrogate.

% Santa Ono's Questioning
ask_suspect([why, were, you, at, ikb, on, the, day, of, the, murder], santa) :-
    write('Former UBC president responds:'), nl, nl,
    write('"Michigan was boring this time of the year, and I wanted to visit Vancouver to see some relatives and enjoy the scenery."'), nl,
    write('"I was also craving a cinnamon bun from Ikes Cafe, so I went into IKB."'), nl, nl,
    write('Press return to continue.'), nl, nl,
    readln([]).

ask_suspect([did, you, know, the, suspect, personally], santa) :-
    write('Former UBC president responds:'), nl, nl,
    write('"I did not. However, I knew that Professor Poole is... was one of our most esteemed professors."'), nl,
    write('"I was very sad to hear his passing."'), nl, nl,
    write('Press return to continue.'), nl, nl,
    readln([]).

ask_suspect([what, exactly, were, you, doing, when, the, murder, took, place], santa) :-
    write('Former UBC president responds:'), nl, nl,
    write('"I was enjoying my cinnamon bun on the outdoor patio."'), nl, nl,
    write('Press return to continue.'), nl, nl,
    readln([]).

ask_suspect([no, more, questions], santa) :-
    write('Former UBC president responds:'), nl, nl,
    write('"Good luck detective."'), nl, nl,
    write('Press return to continue.'), nl, nl,
    readln([]),
    interrogate.


% Bacon's questioning
ask_suspect([why, were, you, at, ikb, on, the, day, of, the, murder], bacon) :-
    write('The UBC president responds:'), nl, nl,
    write('"I was chatting with students to get their feedback on the tuition increase.'), nl,
    write('It is nice to be out of office and see what the campus life is like."'), nl, nl,
    write('Press return to continue.'), nl, nl,
    readln([]).

ask_suspect([did, you, know, the, suspect, personally], bacon) :-
    write('The UBC president responds:'), nl, nl,
    write('"I had briefly met him at a Science Faculty meeting.'), nl,
    write('We just chatted about how A.I. can be implemented in our current science courses."'), nl,
    write('Although I have to say, I am not really a big fan of A.I.'), nl,nl,
    write('Press return to continue.'), nl, nl,
    readln([]).

ask_suspect([what, exactly, were, you, doing, when, the, murder, took, place], bacon) :-
    write('Former UBC president responds:'), nl, nl,
    write('"I was on the second floor when I saw a history presentation going on in the'), nl,
    write('Dodson Room. I decided to stay and listen to the last 5 minutes of the presentation."'), nl, nl,
    write('Press return to continue.'), nl, nl,
    readln([]).

ask_suspect([no, more, questions], bacon) :-
    write('The UBC president responds:'), nl, nl,
    write('"Thank you for your time."'), nl, nl,
    write('Press return to continue.'), nl, nl,
    readln([]),
    interrogate.

% Lily's questioning
ask_suspect([why, were, you, at, ikb, on, the, day, of, the, murder], lily) :-
    write('Lily responds:'), nl, nl,
    write('"I was at the Quiet Room to get some grading done. There is usually'), nl,
    write('no one in that room, and I prefer to work alone."'), nl, nl,
    write('Press return to continue.'), nl, nl,
    readln([]).

ask_suspect([did, you, know, the, suspect, personally], lily) :-
    write('Lily responds:'), nl, nl,
    write('"Of course! I TA his course, and we have weekly check-ins.'), nl,
    write('He was on his way to meet me to talk about a change in the syllabus.'), nl,
    write('Maybe if I was in another building he would not have been murdered..."'), nl, nl,
    write('She sighed with regret.'), nl, nl,
    write('Press return to continue.'), nl, nl,
    readln([]).

ask_suspect([what, exactly, were, you, doing, when, the, murder, took, place], lily) :-
    write('Lily responds:'), nl, nl,
    write('"I was in the quiet room grading the exams, when my laptop suddenly died.'), nl,
    write('I went downstairs to the Emerging Media Lab to borrow a laptop, but I"'), nl,
    write('accidentally bumped into the table, and the Apple Vision Pros on the table'), nl,
    write('fell off. I was trying to clean up the pieces.'), nl, nl,
    write('Press return to continue.'), nl, nl,
    readln([]).

ask_suspect([no, more, questions], lily) :-
    write('Lily responds:'), nl, nl,
    write('"I hope you can find whoever committed this awful crime."'), nl, nl,
    write('Press return to continue.'), nl, nl,
    readln([]),
    interrogate.


% Evangeline's questioning
ask_suspect([why, were, you, at, ikb, on, the, day, of, the, murder], evangeline) :-
    write('The famous actress responds:'), nl, nl,
    write('"We are filming a movie on campus and the nearest washroom was in this building."'), nl, nl,
    write('Press return to continue.'), nl, nl,
    readln([]).

ask_suspect([did, you, know, the, suspect, personally], evangeline) :-
    write('The famous actress responds:'), nl, nl,
    write('"No, why would I? It has been a long time since I was a student at UBC."'), nl, nl,
    write('Press return to continue.'), nl, nl,
    readln([]).

ask_suspect([what, exactly, were, you, doing, when, the, murder, took, place], evangeline) :-
    write('The famous actress responds:'), nl, nl,
    write('"Like I said, I was using the washroom. I do not think you need the details."'), nl, nl,
    write('Press return to continue.'), nl, nl,
    readln([]).

ask_suspect([no, more, questions], evangeline) :-
    write('The famous actress responds:'), nl, nl,
    write('"Why am I even a suspect? Anyways, good luck with the investigation."'), nl, nl,
    write('Press return to continue.'), nl, nl,
    readln([]),
    interrogate.

ask_suspect([_], _) :-
    write('Please follow the detective guidebook.'), nl, nl,
    interrogate.

arrest([santa, ono]) :-
    write('You arrested Santa Ono.'), nl,
    write('GAME OVER: You have arrested the wrong suspect!'),
    halt(0).
arrest([benoit, antoine, bacon]) :-
    write('You arrested Benoit-Antoine Bacon.'), nl,
    write('You have identified the murderer!'), nl,
    write('You have used your unmatched detective skills to solve another mystery.'), nl, nl,
    write('Press return to continue.'), nl,
    readln([]),
    write('During trial, Bacon admits that he wanted to eliminate Professor Poole'), nl,
    write('because he believes that A.I. is a threat to society, and he wants to stop'), nl,
    write('the field from evolving.'), nl, nl,
    write('Press return to continue.'), nl, nl,
    readln([]),
    write('As he was watching the presentation, he saw Professor Poole go into the empty quiet room'), nl,
    write('where Lily had just left to go downstairs. He trapped him in the quiet room to eliminate him.'), nl, nl,
    write('Press return to continue.'), nl, nl,
    readln([]),
    write('Professor Poole tried to fight off the murderer, but alas, the murderer drew his knife and'), nl,
    write('ended the fight swiftly. He then cleaned the knife in the washroom and discreetly placed'), nl,
    write('it on the kitchen counter at Ikes, successfully hiding the murder weapon.'), nl, nl,
    write('UBC is grateful to you for solving this mystery!'), nl, nl,
    halt(0).
arrest([lily, bryant]) :-
    write('You arrested Lily Bryant.'), nl,
    write('GAME OVER: You have arrested the wrong suspect!'),
    halt(0).
arrest([evangeline, lily]) :-
    write('You arrested Evangeline Lily.'), nl,
    write('GAME OVER: You have arrested the wrong suspect!'),
    halt(0).

process_input([]) :-
    write('You have to act fast! Time is of the essence.'), nl, nl,
    get_user_input.

process_input([goto, NewRoom]) :-
    current_room(Current),
    % connected(Current, NewRoom),
    change_room(NewRoom),
    write('You have moved to '), write(NewRoom), nl, nl,
    print_location.

process_input([leave, NewRoom]) :-
    interrogate.

process_input([inspect, Object]) :-
    inspect(Object, Description),
    write(Description).
    

change_room(NewRoom) :-
    retract(current_room(_)),
    assertz(current_room(NewRoom)).

% List the places that a room is connected to. 
% list_places(Room):- 
%     connected(Room, Places),
%     write(Places).
list_places(Room):- 
    connected(Room, Place),
    room(Place, Name, _),
    write('- '), write(Place), nl, fail.
list_places(_).


% current_room(Room):- room(Room,_,_).

:- dynamic current_room/1.
play :-
    write('A horrible murder has taken place at IKB. UBCs beloved professor David Poole has'), nl, 
    write('been slain. No one was able to solve the mystery and apprehend the murderer. You are our only hope'), nl,
    write('IKB has since fallen into a state of misery and despair. You enter through its front doors. Its quiet.'), nl,
    write('You are going to inspect IKB for any clues, and at any time you can leave to meet'), nl,
    write('your colleague outside, who has detained the suspects for your questioning.'), nl, nl,
    assertz(current_room(entrance)),
    print_location.
    get_user_input.
    
% NLP

% "goto" verbs have a place and an object, identifying many ways to leave a place
verb(place, goto, [X|Y]-[X|Y]):- room(X, _, _).
verb(place, goto, [go, to|X]-X).
verb(place, goto, [walk, to|X]-X).
verb(place, goto, [head, to|X]-X).
verb(place, goto, [go, towards|X]-X).
verb(place, goto, [walk, towards|X]-X).
verb(place, goto, [head, towards|X]-X).
verb(place, goto, [move, towards|X]-X).
verb(place, goto, [move, to|X]-X).
verb(place, goto, [proceed, to|X]-X).
verb(place, goto, [proceed, towards|X]-X).
verb(place, goto, [travel, to|X]-X).
verb(place, goto, [travel, towards|X]-X).
verb(place, goto, [stroll, to|X]-X).
verb(place, goto, [stroll, towards|X]-X).

% Same as above, but verbs for leaving a place. 
verb(place, leave, [leave|X]-X).
verb(place, leave, [exit|X]-X).
verb(place, leave, [depart|X]-X).
verb(place, leave, [take, off, from|X]-X).
verb(place, leave, [set, out, from|X]-X).
verb(place, leave, [embark, from|X]-X).
verb(place, leave, [withdraw, from|X]-X).
verb(place, leave, [vacate|X]-X).
verb(place, leave, [retreat, from|X]-X).
verb(place, leave, [step, out, of|X]-X).
verb(place, leave, [walk, out, of|X]-X).
verb(place, leave, [bail, out, of|X]-X).
verb(place, leave, [flee, from|X]-X).
verb(place, leave, [escape, from|X]-X).
verb(place, leave, [get, out, of|X]-X).
verb(place, leave, [clear, out, of|X]-X).
verb(place, leave, [move, out, of|X]-X).
verb(place, leave, [pull, out, of|X]-X).

% Verbs for inspecting an object/weapon
verb(inspectable, inspect, [inspect|X]-X).
verb(inspectable, inspect, [examine|X]-X).
verb(inspectable, inspect, [scan|X]-X).
verb(inspectable, inspect, [look, at|X]-X).
verb(inspectable, inspect, [analyze|X]-X).
verb(inspectable, inspect, [views|X]-X).
verb(inspectable, inspect, [check, out|X]-X).
verb(inspectable, inspect, [investigate|X]-X).
verb(inspectable, inspect, [audit|X]-X).
verb(inspectable, inspect, [go, over|X]-X).
verb(inspectable, inspect, [inspect|X]-X).
verb(inspectable, inspect, [explore|X]-X).
verb(inspectable, inspect, [study|X]-X).

% Nouns are all the rooms and objects in our game, made exception for rooms that are longer than two letters.
noun(place, R, [R|X]-X) :- room(R, _, _).
noun(place, 'ikb', [ikb|X]-X).
noun(place,  quiet_room, [quiet, room|X]-X).
noun(place, emerging_media_lab, [emerging, media, lab|X]-X).
noun(inspectable, R, [R|X]-X) :- inspect(R,_).
noun(inspectable, 'apple', [apple|X]-X) :- inspect(applevision, _).
noun(inspectable, 'glasses', [glasses|X]-X) :- inspect(applevision, _).

det([the|X]- X).
det([a|X]-X).
det([an|X]-X).

object(Type, N, S1-S3) :-
    det(S1-S2),
    noun(Type, N, S2-S3).
  object(Type, N, S1-S2) :-
    noun(Type, N, S1-S2).

command([V,O], InList) :-
    verb(Object_Type, V, InList-S1),
    object(Object_Type, O, S1-[]).

