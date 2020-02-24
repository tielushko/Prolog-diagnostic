/* prolog program to identify the type of travel you should do.  

    start with ?- start.     */

start :- hypothesize(Animal),
      write('I guess that you should do this for your next travel trip: '),
      write(Animal),
      nl,
      undo.

/* hypotheses to be tested */
hypothesize(Camping) :- Camping, !.
hypothesize(Surfing) :- Surfing, !.
hypothesize(Sightseeing) :- Sightseeing, !.
hypothesize(RoadTrip) :- RoadTrip, !.
hypothesize(BeachTrip) :- BeachTrip, !.
hypothesize(Cycling) :- Cycling, !.
hypothesize(Canoeing) :- Canoeing, !.
hypothesize(Skiing) :- Skiing, !.
hypothesize(Cruise) :- Cruise, !.
hypothesize(ThemePark) :- ThemePark, !.
hypothesize(unknown). /* the program could not come out with conclusion */

/* travel type identification rules */
Camping :- outdoors,
           weeklong.

Surfing :- sunshine,
           weekend,
           water,
           verify(surfing_board).

Sightseeing :- car,
               weekend, 
               verify(explore_your_city).

RoadTrip :- car, 
            weeklong,
            verify(visit_many_cities).


BeachTrip :- sunshine,
             weekend,
             water,
             verify(sun_bathe).

Cycling :- outdoors,
           weekend,
           sport,

Canoeing :- outdoors,
            weekend,
            sport,
            water,

Skiing :- outdoors,
          sport,
          weeklong,

Cruise :- water, 
          relaxing,
          weeklong,
          verify(drink_alcohol),
          verify(visit_many_countries).

ThemePark :- outdoors,
             weekend,
             verify(like_cartoons),
             verify(like_rollercoasters).
  

/* classification rules */


/* how to ask questions */
ask(Question) :-
    write('Do you want to do the following: '),
    write(Question),
    write('? '),
    read(Response),
    nl,
    ( (Response == yes ; Response == y)
      ->
       asserta(yes(Question)) ; /* note that this was fixed from assert() as GNU prolog does not support assert but instead asserta */
       asserta(no(Question)), fail).

:- dynamic(yes/1,no/1).

/* How to verify something */
verify(S) :-
   (yes(S) 
    ->
    true ;
    (no(S)
     ->
     fail ;
     ask(S))).

/* undo all yes/no assertions */
undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.