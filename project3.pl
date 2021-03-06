/* # Prolog-diagnostic
 This is an implementation of the prolog diagnostic program.

This prolog program will help yo identify the type of travel you should do.

Completed by Oleg Tielushko U48136789 and Tyler Brown U47820527
    
    This program will help determine the user their next vacation destination spot using backwards-chaining inference engine Prolog
    
    start with ?- start. 

Note: The program was compiled and ran in GNU prolog, therefore the function assert() had to be replaced with a function asserta(); 
(see line 113, 114 of project3.pl)
*/

start :- hypothesize(Animal),
      write('I guess that you should do this for your next travel trip: '),
      write(Animal),
      nl,
      undo.

/* hypotheses to be tested */
hypothesize(camping) :- camping, !.
hypothesize(surfing) :- surfing, !.
hypothesize(sightseeing) :- sightseeing, !.
hypothesize(roadTrip) :- roadTrip, !.
hypothesize(beachTrip) :- beachTrip, !.
hypothesize(cycling) :- cycling, !.
hypothesize(canoeing) :- canoeing, !.
hypothesize(skiing) :- skiing, !.
hypothesize(cruise) :- cruise, !.
hypothesize(themePark) :- themePark, !.
hypothesize(unknown). /* the program could not come out with conclusion */

/* travel type identification rules */
camping :-  outdoors, 
            weeklong,
            verify(living_outside),
            verify(no_amenities). 

surfing :- sunshine,
           water,
           verify(surfing_board).

sightseeing :- car,
               daytrip, 
               verify(explore_your_city).

roadTrip :- car, 
            weeklong,
            verify(visit_many_cities).


beachTrip :- sunshine,
             water,
             verify(sun_bathe).

cycling :- weekend,
           sport,
           verify(have_a_bicycle). 

canoeing :- sport,
            water,
            verify(have_a_boat).

skiing :- outdoors,
          weeklong,
          verify(visit_mountains),
          verify(travel_in_winter), 
          verify(have_skis).

cruise :- relaxing,
          weeklong,
          verify(drink_alcohol),
          verify(visit_many_countries).

themePark :- outdoors,
             weekend,
             verify(like_cartoons),
             verify(like_rollercoasters).
  

/* classification rules */
outdoors :- verify(go_outdoors), !.
outdoors :- verify(enjoy_nature).

weeklong :- verify(travel_for_a_week).

sunshine :- verify(enjoy_the_sun).

weekend  :- verify(travel_for_a_weekend).

daytrip  :- verify(travel_for_a_day).

water    :- outdoors,
            daytrip,
            verify(go_on_water).

moving   :- verify(not_stay_in_one_place). 
         
car      :- moving,
            verify(have_a_car).

sport    :- moving,
            outdoors,
            verify(enjoy_physical_activity).

relaxing :- verify(relaxing_vacation), !.

relaxing :- verify(nothing_to_do).


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