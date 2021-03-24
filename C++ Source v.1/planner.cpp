#include "planner.h"



clock_t ftime1;
clock_t ftime2;
clock_t ftime3;
clock_t ftime4;
clock_t ftime5;
long double dt3;	// Enriched goal state
long double dt1;	// Graph creation time
long double dt2;	// Search time
long double dt;		// Total time

bool display_messages=false;
 
// predicates
int			nof_predicates=0;
predicate	predicates[max_nof_predicates];
bool		constant_predicates[max_nof_predicates];

// objects
int		nof_objects=0;
char	objects[max_nof_objects][sof_object_name+1];

// constants
fact	constants[max_nof_constants];
int		nof_constants=0;

bool is_a_constant(fact f)	// This function checks if fact f is included in the list of constants
{	
	int i;
	for(i=0;i<nof_constants;i++)
		if (constants[i]==f) return true;
	return false;
}


Operator* Operators0=new Operator[max_nof_operators0];
Operator* Operators=new Operator[max_nof_operators];

Operator* Normal_Operators=Operators;
int nof_operators0=0;
int nof_operators=0;

state initial;
state goal;
state goal1;
	
extern void create_demo();
extern int bfs_solve();


clock_t start;
clock_t finish;   
double  duration;

void test_facts();
void test_linked_hash_entries();

void check_new_goals();

void main(int argc, char* argv[])
{
//	Process the input data.
	if (!process_command_line(argc, argv))
		exit(0);

	mem_init();	
	
	if (!load_domain())
	{
		cout << "ERRORS while loading domain. Operation aborted." << endl;
		exit(0);
	}
	if (!load_problem())
	{
		cout << "ERRORS while loading problem. Operation aborted." << endl;
		exit(0);
	}

if (display_messages)
	cout << endl << "Number of operators: " << nof_operators << endl;

	//	display_operators();
	

	ftime1=clock();
	start = clock();
	create_inverted_operators();
	clock_t t1;
	t1=clock();
	create_all_facts();

 	ftime4=clock();
	complete_goal_state();
	ftime5=clock();
	dt3=(ftime5-ftime4)/CLOCKS_PER_SEC;
	
	// first setting the distance of the new_goals to 0 and then 
	// adding the original goals...
	add_goals(&goal);
	//	add_goals(&goal1);	// in case where the enriched goal state
							// is constructed manually...

	find_all_distances();
/*
//	check_new_goals();
	fact f1=fact("not_served", "p0");
	fact f2=fact("not_boarded", "p0");
	fact f3=fact("boarded", "p0");
	fact f4=fact("served", "p0");
	
	hash_entry* h1=get_fact_pointer(&f1);
	hash_entry* h2=get_fact_pointer(&f2);
	hash_entry* h3=get_fact_pointer(&f3);
	hash_entry* h4=get_fact_pointer(&f4);
	
	
	cout << f1 << ", " << h1->distance << endl;
	cout << f2 << ", " << h2->distance << endl;
	cout << f3 << ", " << h3->distance << endl;
	cout << f4 << ", " << h4->distance << endl;
*/	
//	display_hash_table();
	release_memory();
	ftime2=clock();
	dt1=(ftime2-ftime1)/CLOCKS_PER_SEC -dt3;
	if (display_messages)
		cout <<dt1<< endl;
//	display_operators();
	bfs_solve();
	
}


void check_new_goals()
{
	linked_hash_entry* enriched=new_goals;
	while (enriched!=NULL)
		if (enriched->entry->distance<0)
			abort();
		else
			enriched=enriched->next;
}