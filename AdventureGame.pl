% rooms
room(quiet_room, 'Quiet Room', 'You are in the quiet study section, chairs and tables are flipped, there is a trail of blood but it leads nowhere').
room(emerging_media_lab, 'Emerging Media Lab', 'You are in the emerging media lab. You see see the coveted Apple Vision Pro smashed on the ground.').
room(bathroom, 'Bathroom', 'You enter the bathroom, nothing is amiss. You realize you have to take a piss'). 
room(hallway, 'Hallway', 'You enter the hallway... where do you go?').
room(ikes, 'Ikes Cafe', 'You are in Ikes Cafe. The smell of cinnamon buns fills the air.').
room(entrance, 'Entrance', 'You enter the IKB, its heavy metal doors are rusted, from the constant downpour and neglect').
room(dodson, 'Dodson Room', 'You enter the Dodson Room. All the curtains are closed. Was someone hiding something?').


% possible murder weapons
weapon(butterknife, 'a butter knife, accessibly sharpened.').
weapon(laptop, 'an old laptop with the resemblence of a brick, with a large dent in it').
weapon(bazooka, 'an old WW2 bazooka, used against the Nazis. Left behind by a history presentation in Dodson Room.'). 
weapon(lanyard, 'a blue UBC landyard... 1st years...'). 

% inspecting the weapons
inspect(butterknife, 'The knife has recently been cleaned. A few water droplets shine under the fluorescent lights.').
inspect(laptop, 'The laptop is heavy. You try to turn it on but nothing happens.').
inspect(bazooka, 'One of the largest weapons you have seen. It has no ammunition.').
inspect(lanyard, 'You feel your first-year memories creeping up, but you brush away the thoughts. You realize that the lanyard is large enough to fit around someones neck.').

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

suspects(president_bacon, 'President Bacon', 'Recently appointed UBC President.').
suspects(ex_president_ono, 'Ex-President Ono', 'Former president of UBC.').
suspects(trudeau, 'Justin Trudeau', 'Current prime minister of Canada, a UBC alum').

print_location :-
    current_room(Current),
    room(Current, _, Desc),
    write(Desc),nl,nl,
    write('You can move to the following: '), nl, nl,
    list_places(Current), nl, nl,
    %write('Where would you like to move to?'), nl, nl.
    get_user_input.

get_user_input:-
    write('Type a command:'), nl, nl,
    readln(Input),
    process_input(Input),
    get_user_input.

process_input([]) :-
    write('You are too slow! The murderer still lurks in the shadows! They eliminate you in your hesitation...'), nl, nl,
    halt(0).

process_input([goto, NewRoom]) :-
    current_room(Current),
    % connected(Current, NewRoom),
    change_room(NewRoom),
    write('You have moved to '), write(NewRoom), nl, nl,
    print_location.
    

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
    write('A horrible murder has taken place at IKB. UBCs beloved professor David Poole has been slain. No one can solve the mystery and apprehend the murderer! You are our only hope'), nl,
    write('IKB has since fallen into a state of misery and despair. You enter through its front doors. Its quiet.'), nl,
    assertz(current_room(entrance)),
    print_location.
    get_user_input.
    
% NLP
verb(place, goto, [X|Y]-[X|Y]):- room(X, _, _).
verb(place, goto, [go, to|X]-X).
verb(place, goto, [walk, to|X]-X).
verb(place, goto, [head, to|X]-X).
verb(place, goto, [go, towards|X]-X).
verb(place, goto, [walk, towards|X]-X).
verb(place, goto, [head, towards|X]-X).

noun(place, R, [R|X]-X) :- room(R, _, _).
noun(place, 'quiet room', [quiet, room|X]-X).
noun(place, 'emerging media lab', [ermerging, media, lab|X]-X).

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

