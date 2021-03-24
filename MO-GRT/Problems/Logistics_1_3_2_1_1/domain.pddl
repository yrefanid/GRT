;; logistics domain
;;

(define (domain logistics)
  (:requirements :strips) 
  (:predicates 	(package ?obj)
	       	(truck ?truck)
		(airplane ?airplane)
                (airport ?airport)
               	(location ?loc)
		(in-city ?obj ?city)
                (city ?city)
		(at ?obj ?loc)
		(in ?obj ?obj)
		(terminal ?t)
		(van ?v)
)

(:action load-truck
  :parameters
   (?obj
    ?truck
    ?loc)
  :precondition
   (and (package ?obj) (truck ?truck) (location ?loc)
   (at ?truck ?loc) (at ?obj ?loc))
  :effect
   (and (not (at ?obj ?loc)) (in ?obj ?truck))
:criteria (amount cost 2) (amount duration 1)
)

(:action load-airplane
  :parameters
   (?obj
    ?airplane
    ?loc)
  :precondition
   (and (package ?obj) (airplane ?airplane) (location ?loc)
   (at ?obj ?loc) (at ?airplane ?loc))
  :effect
   (and (not (at ?obj ?loc)) (in ?obj ?airplane))
:criteria (amount cost 3) (amount duration 2)
)

(:action unload-truck
  :parameters
   (?obj
    ?truck
    ?loc)
  :precondition
   (and (package ?obj) (truck ?truck) (location ?loc)
        (at ?truck ?loc) (in ?obj ?truck))
  :effect
   (and (not (in ?obj ?truck)) (at ?obj ?loc))
:criteria (amount cost 2) (amount duration 1)
)

(:action unload-airplane
  :parameters
   (?obj
    ?airplane
    ?loc)
  :precondition
   (and (package ?obj) (airplane ?airplane) (location ?loc)
        (in ?obj ?airplane) (at ?airplane ?loc))
  :effect
   (and (not (in ?obj ?airplane)) (at ?obj ?loc))
:criteria (amount cost 3) (amount duration 2)
)

(:action drive-truck
  :parameters
   (?truck
    ?loc-from
    ?loc-to
    ?city)
  :precondition
   (and (truck ?truck) (location ?loc-from) (location ?loc-to) (city ?city)
   (at ?truck ?loc-from)
   (in-city ?loc-from ?city)
   (in-city ?loc-to ?city))
  :effect
   (and (not (at ?truck ?loc-from)) (at ?truck ?loc-to))
:criteria (amount cost 10) (amount duration 10)
)

(:action fly-airplane
  :parameters
   (?airplane
    ?loc-from
    ?loc-to)
  :precondition
   (and (airplane ?airplane) (airport ?loc-from) (airport ?loc-to)
	(at ?airplane ?loc-from))
  :effect
   (and (not (at ?airplane ?loc-from)) (at ?airplane ?loc-to))
:criteria (amount cost 50) (amount duration 10)
)

(:action drive-van
  :parameters
   (?van
    ?terminal-from
    ?terminal-to)
  :precondition
   (and (van ?van) (terminal ?terminal-from) (terminal ?terminal-to)
	(at ?van ?terminal-from))
  :effect
   (and (not (at ?van ?terminal-from)) (at ?van ?terminal-to))
:criteria (amount cost 20) (amount duration 100)
)

(:action load-van
  :parameters
   (?obj
    ?van
    ?terminal)
  :precondition
   (and (package ?obj) (van ?van) (terminal ?terminal)
   (at ?van ?terminal) (at ?obj ?terminal))
  :effect
   (and (not (at ?obj ?terminal)) (in ?obj ?van))
:criteria (amount cost 2) (amount duration 1)
)

(:action unload-van
  :parameters
   (?obj
    ?van
    ?terminal)
  :precondition
   (and (package ?obj) (van ?van) (terminal ?terminal)
        (at ?van ?terminal) (in ?obj ?van))
  :effect
   (and (not (in ?obj ?van)) (at ?obj ?terminal))
:criteria (amount cost 2) (amount duration 1))
)
