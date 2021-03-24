(define (domain movie-strips)
  (:predicates (movie-rewound)
               (counter-at-two-hours)
	         (counter-at-other-than-two-hours)
               (counter-at-zero)
               (have-chips)
               (have-dip)
               (have-pop)
               (have-cheese)
               (have-crackers)
               (chips ?x)
               (dip ?x)
               (pop ?x)
               (cheese ?x)
               (crackers ?x))

  (:action rewind-movie-2
           :parameters ()
	   :precondition ( and (counter-at-two-hours) )
           :effect (and (movie-rewound)))
  
  (:action rewind-movie
           :parameters ()
	   :precondition ( and (counter-at-other-than-two-hours) )
           :effect (and  (movie-rewound) ))
                        ;; Let's assume that the movie is 2 hours long

  (:action rewind-movie3
           :parameters ()
	   :precondition ( and (counter-at-zero) )
           :effect (and (movie-rewound) ))
                        ;; Let's assume that the movie is 2 hours long
                        

  (:action reset-counter
           :parameters ()
           :effect (and (counter-at-zero)))

  ;;; Get the food and snacks for the movie
  (:action get-chips
           :parameters (?x)
           :precondition (and (chips ?x))
           :effect (and (have-chips)))
  
  (:action get-dip
           :parameters (?x)
           :precondition (and (dip ?x))
           :effect (and (have-dip)))

  (:action get-pop
           :parameters (?x)
           :precondition (and (pop ?x))
           :effect (and (have-pop)))
  
  (:action get-cheese
           :parameters (?x)
           :precondition (and (cheese ?x))
           :effect (and  (have-cheese)))

  (:action get-crackers
           :parameters (?x)
           :precondition (and (crackers ?x))
           :effect (and (have-crackers)))
  
)
