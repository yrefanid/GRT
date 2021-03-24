(define (domain mystery-strips)
   (:predicates
       (city ?x)
       (truck ?x)
       (package ?x)
       (connected ?n1 ?n2)
       (at ?v ?n)
       (in ?c ?v)
)


(:xors	
	((xor (at ?truck ?) ) (constants (truck ?truck )))
	((xor (at ?obj ?) (in ?obj ?)) (constants (package ?obj)))
)

   (:action load
       :parameters (?c ?v ?n)
       :precondition (and (package ?c)
			  (truck ?v)
			  (at ?c ?n)
                          (at ?v ?n)
			  (city ?n))
       :effect (and (not (at ?c ?n))
                    (in ?c ?v)))

   (:action move
       :parameters (?v ?n1 ?n2)
       :precondition (and (at ?v ?n1)
			  (city ?n1)
			  (truck ?v)
                          (connected ?n1 ?n2)
			  (city ?n2))
       :effect (and (not (at ?v ?n1))
                    (at ?v ?n2)))

   (:action unload
       :parameters (?c ?v ?n )
       :precondition (and (in ?c ?v)
			  (package ?c)
			  (truck ?v)
                          (at ?v ?n)
			  (city ?n))
       :effect (and (not (in ?c ?v))
                    (at ?c ?n)))
)