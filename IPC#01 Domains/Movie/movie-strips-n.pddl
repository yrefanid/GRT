(define (domain movie-strips)
  (:predicates (movie-rewound)
		(not-movie-rewound)
               (counter-at-two-hours)
	       (counter-at-other-than-two-hours)
               (counter-at-zero)
               (have-chips)
               (have-dip)
               (have-pop)
               (have-cheese)
               (have-crackers)
	       (dont-have-chips)
               (dont-have-dip)
               (dont-have-pop)
               (dont-have-cheese)
               (dont-have-crackers)
               (chips ?x)
               (dip ?x)
               (pop ?x)
               (cheese ?x)
               (crackers ?x))
  
  (:action rewind-movie-2
           :parameters ()
	   :precondition ( and (counter-at-two-hours) (not-movie-rewound))
           :effect (and (not (not-movie-rewound)) (movie-rewound)))
  
  (:action rewind-movie
           :parameters ()
	   :precondition ( and (counter-at-other-than-two-hours) (not-movie-rewound))
           :effect (and (not (not-movie-rewound)) (movie-rewound) ))
                        ;; Let's assume that the movie is 2 hours long

  (:action rewind-movie3
           :parameters ()
	   :precondition ( and (counter-at-zero) (not-movie-rewound))
           :effect (and (not (not-movie-rewound)) (movie-rewound) ))
                        ;; Let's assume that the movie is 2 hours long
                        

  (:action reset-counter1
           :parameters ()
	   :precondition (counter-at-other-than-two-hours) 
           :effect (and (not (counter-at-other-than-two-hours) ) (counter-at-zero)))

  (:action reset-counter2
           :parameters ()
	   :precondition (counter-at-two-hours) 
           :effect (and (not (counter-at-two-hours) ) (counter-at-zero)))



  ;;; Get the food and snacks for the movie
  (:action get-chips
           :parameters (?x)
           :precondition (and (dont-have-chips) (chips ?x))
           :effect (and (not (dont-have-chips)) (have-chips)))
  
  (:action get-dip
           :parameters (?x)
           :precondition (and (dont-have-dip) (dip ?x))
           :effect (and (not (dont-have-dip)) (have-dip)))

  (:action get-pop
           :parameters (?x)
           :precondition (and (dont-have-pop) (pop ?x))
           :effect (and (not (dont-have-pop)) (have-pop)))
  
  (:action get-cheese
           :parameters (?x)
           :precondition (and (dont-have-cheese) (cheese ?x))
           :effect (and (not (dont-have-cheese)) (have-cheese)))
  
  (:action get-crackers
           :parameters (?x)
           :precondition (and (dont-have-crackers) (crackers ?x))
           :effect (and (not (dont-have-crackers)) (have-crackers)))
)
