operator(rewind_movie_2,
		[counter_at_two_hours, not_movie_rewound],
		[not_movie_rewound],
		[movie_rewound]).
   
operator(rewind_movie, 
	[counter_at_other_than_two_hours, not_movie_rewound],
	[not_movie_rewound],
	[movie_rewound]).


operator(reset_counter1, 
	[counter_at_other_than_two_hours],
	[counter_at_other_than_two_hours],
	 [counter_at_zero]).

operator(reset_counter2, 
	[counter_at_two_hours],
	[counter_at_two_hours],
	 [counter_at_zero]).


operator(get_chips(X),
	[dont_have_chips],
	[dont_have_chips],
	[have_chips]):-chips(Domain), member(X, Domain).
  
operator(get_dip(X), 
	[dont_have_dip], 
	[dont_have_dip], 
	[have_dip]):-dip(Domain), member(X, Domain).

operator(get_pop(X), 
	[dont_have_pop], 
	[dont_have_pop], 
	[have_pop]):-pop(Domain), member(X, Domain).

operator(get_cheese(X),
	[dont_have_cheese],
	[dont_have_cheese],
	[have_cheese]):-cheese(Domain), member(X, Domain).
  
operator(get_crackers(X),
	[dont_have_crackers],
	[dont_have_crackers],
	[have_crackers]):-crackers(Domain), member(X, Domain).

