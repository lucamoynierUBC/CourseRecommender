% rooms
room(quiet_room, 'Quiet Room', 'You are in the quiet study section, chairs and tables are flipped, there is a trail of blood but it leads nowhere').
room(emerging_media_lab, 'Emerging Media Lab', 'You are in the emerging media lab. You see see the coveted Apple Vision Pro smashed on the ground.').
room(bathroom, 'Bathroom', 'You enter the bathroom, nothing is amiss. You realize you have to take a piss'). 
room(hallway, 'Hallway', 'You enter the hallway... where do you go?').
room(ikes, 'Ikes Cafe', 'You are in Ikes Cafe. The smell of cinnamon buns fills the air.').
room(entrance, 'Entrance', 'You enter the IKB, its heavy metal doors are rusted, from the constant downpour and neglect').


% possible murder weapons
weapon(butterknife, 'A butter knife, accessibly sharpened.').
weapon(laptop, 'An old laptop with the resemblence of a brick, whith a large dent in it').
weapon(bazooka, 'An old WW2 bazooka, used against the Nazis. Left behind by a history presentation in Dodson Room.'). 
weapon(lanyard, 'A blue UBC landyard... 1st years...'). 

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

suspects(president_bacon, 'President Bacon', 'Recently appointed UBC President.').
suspects(ex_president_ono, 'Ex-President Ono', 'Former president of UBC.').
suspects(trudeau, 'Justin Trudeau', 'Current prime minister of Canada, a UBC alum').

print_location :-
    current_room(Current),
    room(Current, _, Desc),
    write(Desc),nl,nl,
    write('You can move to the following: '), nl, nl,
    list_places(Current), nl,
    write('Where would you like to move to?').
    get_user_input.

:- use_module(readLine,[readLine/1]).

get_user_input:-
    write('Type a command'),
    readln(Input),
    process_input(Input).

process_input([_]) :-
    write('You are too slow! The murderer still lurks in the shadows! They eliminate you in your hesitation').

process_input([go, to, NewRoom]) :-
    current_room(Current),
    % connected(Current, NewRoom),
    change_room(NewRoom),
    write('You have moved to '), write(NewRoom).
    print_location.
    

change_room(NewRoom) :-
    retract(current_room(_)),
    assertz(current_room(NewRoom)).

% List the places that a room is connected to. 
list_places(Room):- 
    connected(Room, Places),
    write(Places).
    

% current_room(Room):- room(Room,_,_).

:- dynamic current_room/1.
play :-
    write('A horrible murder has taken place at IKB. UBCs beloved professor David Poole has been slain. No one can solve the mystery and apprehend the murderer! You are our only hope'), nl,
    write('IKB has since fallen into a state of misery and despair. You enter through its front doors. Its quiet.'), nl,
    assertz(current_room(entrance)),
    print_location.
    
