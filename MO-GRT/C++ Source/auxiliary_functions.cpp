#include "planner.h"


// Function same_char() checks if two chars are "case-insensitive" equals
bool same_char(char c1, char c2)
{
	if (c1==c2)
		return true;
	if (c1>='A' && c1<='Z' && c2==c1+32)
		return true;
	if (c2>='A' && c2<='Z' && c1==c2+32)
		return true;
	return false;
}

// Function 'strcomp' compares two strings, 's1' and 's2', which must have maximum size 'length'.
// It returns 'true' if the strings are equal, otherwise it returns 'false'.
bool strcomp(char s1[], char s2[], unsigned int length)
{
	if (strlen(s1)==strlen(s2) && strlen(s1)<=length)
	{
		unsigned int i;
		for(i=0;i<strlen(s1);i++) if (!same_char(s1[i],s2[i])) return false;
		return true;
	}
	else
		return false;
};



// Function strcmp2() checks if two strings are "case-insensitive" equals
bool strcmp2(char s1[], char s2[])
{
	int i=0;
	do
	{
		if (s1[i]==0 && s2[i]==0)
			return true;
		if (!same_char(s1[i], s2[i]))
			return false;
		i++;
	}
	while (i<=255);
	return false;
}

// Function 'O' takes string 'name' for input and returns an integer that indicates the 
// number of the object with the string as name. If there is no object with this name, 
// the function returns 0.

int Obj(char name[])
{
	if (strlen(name)>sof_object_name)
	{
		cout << "ERROR: Size of object name '" << name << "' exceeds " << sof_object_name << endl;
		return 0;
	}
	else
	{
		int i;
		for(i=1;i<=nof_objects;i++)
			if (strcmp2(name, objects[i].name))
				return i;
		// cout << "ERROR: There is no object with name '" << name <<"'." << endl; 
		return 0;
	}
};


// Function 'R' takes objects's name 'name' for input and returns an integer that indicates the 
// number of the the criterion that corresponds to that object. If there is no criterion-object,
// the function returns -1.

int R(char name[])
{
	int obj=Obj(name);
	if (obj==0)
		return -1;

	int i;
	for(i=0;i<nof_criteria;i++)
		if (criteria[i].object_ID==obj)
			return i;

	return -1;
};

int R_ID(int Object_ID)
{
	int i;
	for(i=0;i<nof_criteria;i++)
		if (criteria[i].object_ID==Object_ID)
			return i;

	cout << "ERROR while using R_ID function." << endl;
	abort();
}


// Function 'P' takes string 'name' for input and returns an integer that indicates the 
// number of the predicate with the string as name. If there is no predicate with this name, 
// the function returns -1.
int P(char name[])
{
	if (strlen(name)>sof_predicate_name)
	{
		cout << "ERROR: Size of predicate name '" << name << "' exceeds " << sof_predicate_name << endl;
		return -1;
	}
	else
	{
		int i;
		for(i=0;i<=nof_predicates;i++)
			if (strcomp(name, predicates[i].name, sof_predicate_name))
				return i;
		cout << "ERROR: There is no predicate with name '" << name <<"'." << endl; 
		return -1;
	}
};


int val(char* ch)
{
	unsigned int i=0;
	bool flag=true;
	while (i<strlen(ch) && flag)
	{
		if (ch[i]<'0' || ch[i]>'9')
			flag=false;
		else
			i++;
	}

	if (!flag)
		return 0;

	long int result=0;
	i=0;
	while (i<strlen(ch) )
	{
		result=10*result + (ch[i] - '0');
		i++;
	}

	return result;
}



// this function checks whether 
bool instantiable_with_list(fact f, int sof_list, fact list_of_facts[])
{
	int i;
	for(i=0;i<sof_list;i++)
		if (list_of_facts[i].instantiable(f))
			return true;
	return false;
}

bool output_file_provided=false;
void command_line_info();

bool process_command_line(int argc, char* argv[])
{
	if (argc==0)
	{
		cout << "Command line syntax:" << endl;
		cout << "Program -d domain_file -p problem_file" << endl;
		return false;
	}
/*
	if (argc==2*int(argc/2))
	{
		cout << "ERROR: Bad number of arguments." << endl;
		cout << "Arguments must be an even number." << endl;
		return false;
	}
*/


	bool domain_file_provided=false;
	bool problem_file_provided=false;
	
	int i;	
	i=1;
	while (i<argc)
	{
		if (strcmp2(argv[i],"-echo1"))
		{
			display_messages=true;
			i++;
		}
		
		// R0 forces GRT to use from the enriched goal state only
		// the most promising facts, i.e. the first facts that will be tryied,
		// from each group of mutual exclusive facts...
		
		else if (strcmp2(argv[i],"-r0"))
		{
			reduced_enriched=true;
			i++;
		}

		// R2 forces GRT to use from the enriched goal state first the facts
		// that are included in the initial state (by removing all the other facts
		// that are mutual exclusive with them).
		// If -r0 is used in combination with -r2, the enriched goal facts that are mutexed with 
		// other enriched goal facts included in the initial state are not removed,
		// but they are used later 'on demand'.

		else if (strcmp2(argv[i],"-r2"))
		{
			reduced_enriched=true;
			copy_from_initial=true;
			i++;
		}

		// this f lag indicates not to mark enriched facts are used...
		else if (strcmp2(argv[i],"-r1"))
		{
			enriched_no_used=true;
			i++;
		}
	
// forces GRT not to look for idle objects
		else if (strcmp2(argv[i],"-noidle"))
		{
			idle_flag=false;
			i++;
		}

// forces GRT not to look for idle objects
		else if (strcmp2(argv[i],"-no_init"))
		{
			enrich_initial=false;
			i++;
		}

		else if (strcmp2(argv[i],"-noxors"))
		{
			no_xors=true;
			i++;
		}

// forces GRT not to use related facts, so being similar to HSP
		else if (strcmp2(argv[i],"-norel"))
		{
			NO_RELATED=true;
			i++;
		}

// deactivates the relaxed dominance pruning heuristic
		else if (strcmp2(argv[i],"-nordph"))
		{
			no_rdph=true;
			i++;
		}

// forces GRT not to look for idle objects
		else if (strcmp2(argv[i],"-echo"))
		{
			display_short_messages=true;
			i++;
		}

// Forces GRT to use the GRT-R heuristic, in the case where there are monotonic criteria
// The default is not to use the GRT-R even in the case or presence of monotonic criteria.
		else if (strcmp2(argv[i],"-MO"))
		{
			ignore_criteria=false;
			i++;
		}

// NOTE: If neither -r1 nor -r2 are used, GRT assigns to all the facts of the enriched
// goal state distances equal to 0.

		else if (strcmp2(argv[i],"-d"))
		{
			if (i==argc-1)
			{
 				cout << "Missing domain file name." << endl;
				command_line_info();
				return false;
			}
			strcpy(domain_file, argv[i+1]);
			domain_file_provided=true;
			i=i+2;
		}

		else if (strcmp2(argv[i],"-scale"))
		{
			if (i>=argc-3)
			{
				cout << "Missing scale date." << endl;
				command_line_info();
				return false;
			}
			multiply_scale=true;
			multiply_scale_criterion=val(argv[i+1]);
			if (strcmp2("mul", argv[i+2]))
				multiply_scale_type=1;
			else if (strcmp2("div", argv[i+2]))
				multiply_scale_type=2;
			else
			{
				cout << "Missing scale multiplier type " << endl;
				command_line_info();
				return false;
			}
			multiply_scale_number=val(argv[i+3]);
			i=i+4;
		}


		else if (strcmp2(argv[i],"-time"))
		{
			if (i==argc-1)
			{
				cout << "Missing time limit." << endl;
				command_line_info();
				return false;
			}
			max_time=val(argv[i+1]);
			i=i+2;
		}

		else if (strcmp2(argv[i],"-strategy"))
		{
			if (i==argc-1)
			{
				cout << "Missing strategy." << endl;
				command_line_info();
				return false;
			}
			if (strcmp2(argv[i+1],"best"))
				search_strategy=1;
			else if (strcmp2(argv[i+1],"hill"))
				search_strategy=2;
			else
			{
				cout << "ERROR: Bad search strategy keyword";
				command_line_info();
				return false;
			}

			i=i+2;
		}

		else if (strcmp2(argv[i],"-OS"))
		{
			if (i==argc-1)
			{
				cout << "Missing OSystem." << endl;
				command_line_info();
				return false;
			}
			if (strcmp2(argv[i+1],"win"))
				OSystem=1;
			else if (strcmp2(argv[i+1],"unix"))
				OSystem=2;
			else
			{
				cout << "ERROR: Bad operating system keyword";
				command_line_info();
				return false;
			}

			i=i+2;
		}


		else if (strcmp2(argv[i],"-p"))
		{
			if (i==argc-1)
			{
				cout << "Missing problem file name." << endl;
				command_line_info();
				return false;
			}
			strcpy(problem_file, argv[i+1]);
			problem_file_provided=true;
			i=i+2;
		}
		else if (strcmp2(argv[i],"-o"))
		{
			if (i==argc-1)
			{
				cout << "Missing output file name." << endl;
				command_line_info();
				return false;
			}
			strcpy(output_file, argv[i+1]);
			output_file_provided=true;
			i=i+2;
		}
		else
		{
			cout << "ERROR - Bad argument: " << argv[i] << endl;
			command_line_info();
			return false;
		}
	}

	if (!domain_file_provided)
	{
		command_line_info();
		return false;
	}

	if (!problem_file_provided)
	{
		command_line_info();
		return false;
	}

	if (display_messages)
	{
		for(i=1;i<argc;i++)
			cout<< argv[i]<< endl;
	}

	return true;
}


void command_line_info()
{
	cout << "Syntax: grt -d domain_file -p probem_file [-o output_file] [-echo] [-echo1] [-time MAX_TIME] [-r0] [-r1] [-r2] [-r3] [-NOIDLE]  [-NO_INIT] [-strategy best|hill] [-os win|unix] [-GRTR] [-NOXORS]" << endl;
	cout << "Switches:" << endl;
	cout << "-echo		: Displays limited messages" << endl;
	cout << "-echo1		: Full debugging messages" << endl;
	cout << "-strategy best|hill	: Selects the search strategy (default best)" << endl;
	cout << "-time MAX_TIME	: Stops execution after MAX_TIME minutes" << endl;
	cout << "-r0		: Enriches the goal state with the most promising facts" << endl;
	cout << "-r2		: Enriches the goal state using the initial state facts" << endl;
	cout << "-r1		: When using one of the -r0/r2 switches, this switch does not reject " << endl;
	cout << "			  the facts that are mutual exclusive with the first selected facts." << endl;
	cout << "			  Also with this switch the first distance for each achieved fact is used." << endl;
	cout << "-NOIDLE	: Does not eliminate irrelevant objects" << endl;
	cout << "os win|unix: Selects the operating system (win is default)" << endl;
	cout << "NO_INIT	: Does not enhance the domain definition" << endl;
	cout << "-MO		: In case of domain with criteria, this switch uses the special criterion heuristic" << endl;
	cout << "-NOXORS	: Does not decompose problems, even if XOR constraints have been provided" << endl;
}


void check_time()
{
	clock_t t;
	long double ft;
	t=clock();
	ft=(long double) t/CLOCKS_PER_SEC;
	if (max_time>0 && ft>max_time*60)
	{
		cout << "Time limit: " << max_time << " minutes." << endl;
		cout << "Elapsed time: " << ft << " secs." << endl;
		cout << "Execution aborted." << endl;
		abort();
	}
}

// This function repeats on the elements of the hash table.
// For each element in the hash table, it calls the function f (passed as parameter).
// Function 'for_every_hash_entry' can be used for various purposes.
void for_every_hash_entry(void f(hash_entry*))
{
	void* ptr;
	int vars[max_arity];
	int i;
	// for every predicate...
	for(i=0;i<nof_predicates;i++) if (!constant_predicates[i])
	{
		int j;
		for(j=0;j<max_arity;j++) vars[j]=1;
		if (predicates[i].arity>0)
		{
			if (hash_table[i].forward!=NULL)
			{
				while (vars[0]<=nof_objects)
				{
					ptr=hash_table[i].forward;
					bool flag;
					flag=true;
					j=0;
					while (j<predicates[i].arity && flag)
						if ((((pointer*) ptr)[vars[j]-1]).forward==NULL)
						{
							flag=false;
							int k;
							for(k=j+1;k<max_arity;k++) vars[k]=1;
							vars[j]++;
							if (vars[j]>nof_objects && j>0)
							{
								vars[j]=1;
								bool flag2=true;
								j--;
								while (j>=0 && flag2)
								{
									vars[j]++;
									if (vars[j]<=nof_objects)
										flag2=false;
									else 
									{
										if (j>0)
											vars[j--]=1;
										else
											flag2=false;
									}
								} 
							}
						}
						else
						{
							ptr=(((pointer*) ptr)[vars[j]-1]).forward;
							j++;
						}
					if (flag)
					{
						// Call to the parameter function...
						f(((hash_entry*) ptr));

						j--;
						vars[j]++;
						if (vars[j]>nof_objects && j>0)
						{
							vars[j]=1;
							bool flag2=true;
							j--;
							while (j>=0 && flag2)
							{
								vars[j]++;
								if (vars[j]<=nof_objects)
									flag2=false;
								else
								{
									if (j>0)
										vars[j--]=1;
									else
										flag2=false;
								}
							}
						}
					}	// if (flag)
				}	// while (vars[0]<nof_objects
			}	// if (hash_table[i].forward!=NULL)
//			else
//			{
//				THIS POINT WOULD BE REACED IF THERE IS A PREDICATE,
//				A GROUP OF OBJECTS OF WHICH HAVE NOT BEEN ACHIEVED.
//				WITH THE WORD 'GROUP' I MEAN ALL THE OBJECTS FOR A SPECIFIC
//				INSNANTIATION OF THE FIRSTs ARGUMETNS (FIRSTs>=0)
//				cout << "ERROR 48567294739457" << endl;
//				abort();
//			}
		}	
		else	// if (predicates[i].arity>0)
		{
			ptr=hash_table[i].forward;
			f((hash_entry*) ptr);
		}
	}		
}


// function "max_min" constructs a new vector v, from the maximum elements of 
// the criteria that increase and the minimum elements of criteria that decrease 
// (length is considered as an increasing criterion)
// This is used for the construction of the actions' vectors in the
// reachability analysis phase.
void max_min(vector* v1, vector* v2, vector* v)
{
	if (v1->elements[0]>v2->elements[0])
		v->elements[0]=v1->elements[0];
	else
		v->elements[0]=v2->elements[0];

	int i;
	for (i=1;i<=nof_criteria;i++)
		// if it is an increasing criterion
		if (criteria[i-1].type==1)	
		{
			if (v1->elements[i]>=v2->elements[i]) 
				v->elements[i]=v1->elements[i];
			else
				v->elements[i]=v2->elements[i];
		}
		// if it is a decreasing criterion
		else if (criteria[i-1].type==2)	
		{
			if (v1->elements[i]<=v2->elements[i]) 
				v->elements[i]=v1->elements[i];
			else
				v->elements[i]=v2->elements[i];
		}
		else
			v->elements[i]=0;
}


// function "min_max" constructs a new vector v, from the minimum elements of 
// the criteria that increase and the maximum elements of criteria that decrease 
// (length is considered as an increasing criterion)
// Criteria of type 3 (which both increase and decrease are set to 0).
void min_max(vector* v1, vector* v2, vector* v)
{
	if (v1->elements[0]<v2->elements[0])
		v->elements[0]=v1->elements[0];
	else
		v->elements[0]=v2->elements[0];

	int i;
	for (i=1;i<=nof_criteria;i++)
		// if it is an increasing criterion
		if (criteria[i-1].type==1)	
		{
			if (v1->elements[i]<=v2->elements[i]) 
				v->elements[i]=v1->elements[i];
			else
				v->elements[i]=v2->elements[i];
		}
		// if it is a decreasing criterion
		else if (criteria[i-1].type==2)
		{
			if (v1->elements[i]>=v2->elements[i]) 
				v->elements[i]=v1->elements[i];
			else
				v->elements[i]=v2->elements[i];
		}
		else
			v->elements[i]=0;
}


// function "sum" sums the elements of vectors v1 and v2 
// to the elements of vector v.
void sum (vector* v1, vector* v2, vector* v)
{
	int i;
	for (i=0;i<=nof_criteria;i++)
		v->elements[i]=v1->elements[i]+v2->elements[i];
}

// This function checks whether a vector of monotonic criteria has even one dimension 
// out of the strict bounds of the corresponding criterion.
bool out_of_bounds(vector* v)
{
	int i=1;
	bool out_of_bounds=false;
	while (i<=nof_criteria && !out_of_bounds)
	{
		// Reachability analysis concerns the monotonic criteria only.
		if (criteria[i-1].type==1 || criteria[i-1].type==2)
		{
			if (criteria[i-1].bounded_from)
			{
				if (v->elements[i]<criteria[i-1].from)
					out_of_bounds=true;
			}
			if (criteria[i-1].bounded_to)
			{
				if (v->elements[i]>criteria[i-1].to)
					out_of_bounds=true;
			}
		}
		i++;
	}
	return out_of_bounds;
}


// This function checks whether a vector of monotonic criteria has even one dimension 
// out of the STRICT remaining bounds of the corresponding criterion.
bool out_of_remaining_bounds(vector* v, state* s)
{
	if (v->elements[0]+s->state_vector->elements[0]>length_to)
		return true;

	int i=1;
	while (i<=nof_criteria)
	{
		if (criteria[i-1].bounded_from)
		{
			if (v->elements[i]+s->state_vector->elements[i] < criteria[i-1].from)
				return true;
		}
		if (criteria[i-1].bounded_to)
		{
			if (v->elements[i] + s->state_vector->elements[i] > criteria[i-1].to)
				return true;
		}
		i++;
	}
	return false;
}



// This function checks whether a vector has smaller or equal values in the increasing criteria 
// and greater or equal values in the increasing criteria. 
// (length is considered an increasing criterion)
// The function is used to quick reject a new cost-vector in the reachability analysis,
// when this is absolutely worst than the current cost-vector of an action or a fact.
bool is_abs_min_equal(vector* v1, vector* v2)
{
	if (v1->elements[0]>v2->elements[0])
		return false;
	int i;
	for (i=1;i<=nof_criteria;i++)
		if (criteria[i-1].type==1)
		{
			if (v1->elements[i]>v2->elements[i])
				return false;
		}
		else if (criteria[i-1].type==2)
		{
			if (v1->elements[i]<v2->elements[i])
				return false;
		}
	return true;
}



// This function checks whether vector v1 is totally better than vector v2.
// This means that: 
// - v1 has better or equal values in all criteria 
// - v1 has smaller or equal values in criteria with hard upper bound (provided that the criteria can increase)
// - v1 has higher or equal value in criteria with hard low bound (provided that they can decrease)
// More checks that performed:
// For criteria that can increase with soft upper bound we need the best combined value in the rest of the criteria
// For criteria that can decrease with soft lower bound we need the best combined value in the rest of the criteria

bool totally_better_equal(vector* v1, vector* v2)
{
	if (v1->elements[0]>v2->elements[0])
		return false;

	int i;
	for (i=1;i<=nof_criteria;i++)
	{
	
	// If criterion [i-1] is a worsening criterion...
		// An increasing worsening criterion...	
		if (criteria[i-1].max_better==true && (criteria[i-1].type==2 || criteria[i-1].type==3))
			if (v1->elements[i]<v2->elements[i])
				return false;
		// or a decreasing worsening criterion.
		if (criteria[i-1].max_better==false && (criteria[i-1].type==1 || criteria[i-1].type==3))
			if (v1->elements[i]>v2->elements[i])
				return false;

	// If criterion [i-1] is an improving criterion...
		// An increasing improving criterion
		if (criteria[i-1].max_better==true && (criteria[i-1].type==1 || criteria[i-1].type==3))
			// if it has a soft upper bound...
			if (criteria[i-1].bounded_to==true)
			{
				if (v1->elements[i]>v2->elements[i])
					return false;
			}
			else // ... or if it has a soft upper bound.
			{
				if (vector_grade(v1,1,i,initial,true)>vector_grade(v2,1,i,initial,true))
					return false;
			}

		// A decreasing improving criterion
		if (criteria[i-1].max_better==false && (criteria[i-1].type==2 || criteria[i-1].type==3))
			// if it has a soft upper bound...
			if (criteria[i-1].bounded_from==true)
			{
				if (v1->elements[i]<v2->elements[i])
					return false;
			}
			else // ... or if it has a soft upper bound.
			{
				if (vector_grade(v1,1,i,initial,true)>vector_grade(v2,1,i,initial,true))
					return false;
			}
	}		
	return true;
}


// This function checks whether a vector has smaller or equal values in the increasing criteria 
// and greater or equal values in the increasing criteria.
// Moreover the two vectors should not be identical.
// (length is considered an increasing criterion)
bool is_abs_min(vector* v1, vector* v2)
{
	bool at_least_one=false;
	if (v1->elements[0]>v2->elements[0])
		return false;
	if (v1->elements[0]<v2->elements[0])
		at_least_one=true;
	int i;
	for (i=1;i<=nof_criteria;i++)
		if (criteria[i-1].type==1)
		{
			if (v1->elements[i]>v2->elements[i])
				return false;
			if (v1->elements[i]<v2->elements[i])
				at_least_one=true;
		}
		else if (criteria[i-1].type==2)
		{
			if (v1->elements[i]<v2->elements[i])
				return false;
			if (v1->elements[i]>v2->elements[i])
				at_least_one=true;
		}
	return at_least_one;
}

// This function checks wether vector v1 has a lower value 
// in dimension i, with respect to vector v2.
// Dimension i is an increasing criterion (either improving or worsening)
bool is_min_i(vector* v1, vector* v2, int i)
{
	if (i==0)
	{
		if (v1->elements[0]<v2->elements[0])
			return true;
		else
			return false;
	}
	else
	{
		// worsening criterion
		if (!criteria[i-1].max_better)
		{
			if (v1->elements[i]<v2->elements[i])
				return true;
			else
				return false;
		}
		else
		{
			if (criteria[i-1].bounded_to)
			{
				if (v1->elements[i]<v2->elements[i])
					return true;
				else
					return false;
			}
			else
			{
				if (vector_grade(v2,1,i,initial,true)>vector_grade(v1,1,i,initial, true))
					return true;
				else
					return false;
			}
		}
	}
}




// This function checks wether vector v1 has a greater value 
// in dimension i, with respect to vector v2.
// Dimension i is a  decreasing criterion (either improving or worsening)
bool is_max_i(vector* v1, vector* v2, int i)
{
	// worsening criterion
	if (criteria[i-1].max_better)
	{
		if (v1->elements[i]>v2->elements[i])
			return true;
		else
			return false;
	}
	else
	{
		if (criteria[i-1].bounded_from)
		{
			if (v1->elements[i]>v2->elements[i])
				return true;
			else
				return false;
		}
		else
		{
			if (vector_grade(v2,1,i,initial,true)>vector_grade(v1,1,i,initial,true))
				return true;
			else
				return false;
		}
	}
}


// This function evaluates a vector. 
// If excluded_criterion >=0, this criterion is not considered. Usually excluded_criterion=-1.
// 'direction' determines the kind of the vector that is evaluated. If direction==0 it 
// is an actual  state vector, whereas if direction==1 it is an estimated fact or remaining plan vector.
// ATTENTION: Currently the function considers the initial bounds only.
// State* s is the current state, the resource consumption of which has to be subtracted from
// the scales of the criteria, when estimating the distance between facts or this state and the goals.
// ATTENTION2: In case this function is called in the heuristic construction phase, state 's' must
// always be the initial state. In case this function is called in the search phase, state 's' 
// must always be the current state.
long vector_grade(vector* v, int direction, int excluded_criterion, state* s, bool single_fact) {
	double grade=0;
	int sum_of_weights=0;
	if (excluded_criterion!=0 && direction==1)
	{
		sum_of_weights+=length_weight;
		int length=v->elements[0];
		int length_total;
		if (direction==1)
			length_total=length+s->state_vector->elements[0];
		else
			length_total=length;

		// adjusting the length, in case it is out of bounds.
		if (!single_fact && direction==1 && length_total<length_from) length=length_from-s->state_vector->elements[0];
		if (length_total>length_to) length+=length_total-length_to;

		// computing the length contribution...
			
		grade=(double) agenda_hash_size*length_weight*(length-length_from)/((double) length_to-length_from);
		
	}

	int i;
	for(i=1;i<=nof_criteria;i++)
	{
		if (i!=excluded_criterion)
		{
			int new_left_bound, new_right_bound;
			sum_of_weights+=criteria[i-1].weight;
			// computing the new bounds for the specific criterion...
			if (direction==0)
			{
				new_left_bound=criteria[i-1].from;
				new_right_bound=criteria[i-1].to;
			}
			else
			{
				new_left_bound=criteria[i-1].from-initial->state_vector->elements[i];
				new_right_bound=criteria[i-1].to-initial->state_vector->elements[i];
			}
			int el=v->elements[i];
			int el_total;
			if (direction==1)
				el_total=el+s->state_vector->elements[i];
			else
				el_total=el;

			int init_left_bound=criteria[i-1].from;
			int init_right_bound=criteria[i-1].to;

			// In case of smaller better values...
			if (!criteria[i-1].max_better)
			{
				if (el_total>init_right_bound)
				{
					// greater values worst and bounded
					if (criteria[i-1].bounded_to)
						el+=3*(el_total-init_right_bound);
					// greater values worst but not bounded
					else
						el+=el_total-init_right_bound;
				}

				if (el_total<init_left_bound)
				{
					// smaller values best but bounded. We have to worsen the values
					// four times the initial "improvement"
					if (criteria[i-1].bounded_from)
						el+=3*(init_left_bound-el_total);	// increase el, as a penalty...
					else	// smaller values best and not bounded.
						if (!single_fact && direction==1)
							el=init_left_bound-s->state_vector->elements[i];
				}
			
			}
			else // if (!criteria[i-1].max_better)
			{
				if (el_total<init_left_bound)
				{
					// smaller values worst and bounded
					if (criteria[i-1].bounded_from)
						el-=3*(init_left_bound -el_total);
					// smaller values worst but not bounded
					else
						el-=(init_left_bound -el_total);
				}

				if (el_total>init_right_bound)
				{
					// greater values best but bounded. We have to worsen the values
					// four times the initial "improvement"
					if (criteria[i-1].bounded_to)
						el-=3*(el_total-init_right_bound);
					else	// smaller values best and not bounded.
						if (!single_fact && direction==1)
							el=init_right_bound-s->state_vector->elements[i];
				}
			}

			// the contribution of criterion i to the overal score of the vector.
			if (criteria[i-1].max_better)
				grade+=(double) agenda_hash_size*criteria[i-1].weight*(new_right_bound-el)/((double) new_right_bound-new_left_bound);
			else
				grade+=(double) agenda_hash_size*criteria[i-1].weight*(el-new_left_bound)/((double) new_right_bound-new_left_bound);
		}
	}
//	if (grade<0)
//		cout << "bingo" << endl;
	if (sum_of_weights>0)
		return (long) grade/sum_of_weights;
	else
		return (long) grade;
}
