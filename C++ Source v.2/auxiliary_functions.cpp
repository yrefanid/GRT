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

int O(char name[])
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
// number of the the resource that corresponds to that object. If there is no resource-object,
// the function returns -1.

int R(char name[])
{
	int obj=O(name);
	if (obj==0)
		return -1;

	int i;
	for(i=0;i<nof_resources;i++)
		if (resources[i].object_ID==obj)
			return i;

	return -1;
};

int R_ID(int Object_ID)
{
	int i;
	for(i=0;i<nof_resources;i++)
		if (resources[i].object_ID==Object_ID)
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
 
// forces GRT not to look for idle objects
		else if (strcmp2(argv[i],"-echo"))
		{
			display_short_messages=true;
			i++;
		}

// Forces GRT to use the GRT-R heuristic, in the case where there are consumable resources
// The default is not to use the GRT-R even in the case or presence of consumable resources.
		else if (strcmp2(argv[i],"-GRTR"))
		{
			ignore_consumable_resources=false;
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
	cout << "-GRTR		: In case of domain with resources, this switch uses the special resource heuristic" << endl;
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

// This function creates the vector with the init consumable resources
void create_init_vector()
{
	init_vector=new vector();
	init_vector->elements[0]=30000;
	int i;
	for (i=0;i<nof_consumable_resources;i++)
		init_vector->elements[i+1]=initial->resource_vector[objects[consumable_resources[i]].resource];
}



// function "max" constructs a new vector v, from the max elements of 
// vectors v1 and v2
void max(vector* v1, vector* v2, vector* v)
{
	int i;
	for (i=0;i<=nof_consumable_resources;i++)
		if (v1->elements[i]>=v2->elements[i]) 
			v->elements[i]=v1->elements[i];
		else
			v->elements[i]=v2->elements[i];
}

// function "min" constructs a new vector v, from the min elements of 
// vectors v1 and v2
void min(vector* v1, vector* v2, vector* v)
{
	int i;
	for (i=0;i<=nof_consumable_resources;i++)
		if (v1->elements[i]<=v2->elements[i]) 
			v->elements[i]=v1->elements[i];
		else
			v->elements[i]=v2->elements[i];
}

// function "sum" sums the elements of vectors v1 and v2 
// to the elements of vector v.
void sum (vector* v1, vector* v2, vector* v)
{
	int i;
	for (i=0;i<=nof_consumable_resources;i++)
		v->elements[i]=v1->elements[i]+v2->elements[i];
}
