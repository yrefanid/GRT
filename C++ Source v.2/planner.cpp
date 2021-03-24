#include "planner.h"

level* subproblem_level=NULL;
bool xor_enabled=false;
bool no_xors=false;

int max_time=0;
int search_strategy=1;

int appl_counter=0;

clock_t ftime1;
clock_t ftime2;
clock_t ftime3;
clock_t ftime4;
clock_t ftime5;
long double mutexes_time;
long double find_distances_time;
long double detect_idle_objects_time;
long double bfs_solve_time;
long double complete_goals_time;
long double add_delete_GRG_levels_time;

long double dt3;	// Enriched goal state
long double dt1;	// Graph creation time
long double dt2;	// Search time
long double dt;		// Total time

clock_t t_loading;
clock_t t_assign_costs;
clock_t t_idle_level=0;
clock_t t_create_facts=0;

bool display_messages=false;
bool display_short_messages=false;
 
// predicates
int			nof_predicates=0;
predicate	predicates[max_nof_predicates];
bool		constant_predicates[max_nof_predicates];

// objects
int		nof_objects=0;
//char	objects[max_nof_objects][sof_object_name+1];
object	objects[max_nof_objects];

// Resources
int nof_resources=0;
Resource resources[max_nof_resources];	//	This table points to the table 'objects',
										//	that is, to the objects that are resources.

bool ignore_consumable_resources=true;

int consumable_resources[max_nof_resources];	// pointers to the objects...
int nof_consumable_resources=0;

vector* init_vector;

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

void count_normal_actions()
{
	int counter=0;
	complete_state_action* all_actions=normal_actions_head;
	while (all_actions!=NULL)
	{
		counter++;
		all_actions=all_actions->next;
	}	
	cout << "ALL NORMAL ACTIONS=" << counter << endl;
}

void count_applied_normal_actions()
{
	int counter=0;
	complete_state_action* all_actions=normal_actions_head;
	while (all_actions!=NULL)
	{
		if (all_actions->first_application==false)
			counter++;
		all_actions=all_actions->next;
	}	
	cout << "APPLIED ALL NORMAL ACTIONS=" << counter << endl;
}

int TOTAL_FACTS=0;
int ACHIEVED_FACTS=0;

void count_fact(hash_entry* h)
{
	TOTAL_FACTS++;
}

void count_achieved_fact(hash_entry* h)
{
	if (h->achieved)
		ACHIEVED_FACTS++;
}

void count_all_facts()
{
	for_every_hash_entry(count_fact);
	cout << "TOTAL FACTS=" << TOTAL_FACTS+nof_constants << endl;
}

void count_achieved_facts()
{
	for_every_hash_entry(count_achieved_fact);
	cout << "ACHIEVED FACTS=" << ACHIEVED_FACTS+nof_constants << endl;
}

Operator* Operators=new Operator[max_nof_operators];

Operator* Normal_Operators=Operators;
//int nof_operators0=0;
int nof_operators=0;

state* initial;
state* goal;

//extern void create_demo();
extern int bfs_solve(state*);

clock_t start;
clock_t finish;   
double  duration;

void test_facts();
void test_linked_hash_entries();

action* solution;

void create_init_vector();

void create_actions();

void main(int argc, char* argv[])
{
//	Process the input data.
	if (!process_command_line(argc, argv))
		exit(0);

	t_loading=clock();
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
	t_loading=clock()-t_loading;

	cout << "Problem name: " << problem_name << endl;
	cout << "Switches: ";
	if (NO_RELATED)
		cout << "-NO_RELATED ";
	else
		cout << "-RELATED ";

	if (reduced_enriched)
		cout << "-r0 ";
	if (copy_from_initial)
		cout << "-r2 ";
	if (enriched_no_used)
		cout << "-r1 ";
	if (search_strategy==1)
		cout << "-BEST ";
	else
		cout << "-HILL ";

	if (!idle_flag)
		cout << "-NOIDLE ";

	if (no_xors)
		cout << "-NOXORS ";

	cout << endl;

if (display_messages)
	cout << endl << "Number of operators: " << nof_operators << endl;
 
//	display_operators();
	
	ftime1=clock();
	start = clock();
	create_inverted_operators();

	t_create_facts=t_create_facts-clock();
	create_actions();
	create_inverted_actions();
	t_create_facts=t_create_facts+clock();

	//cout << t_create_facts*1000/CLOCKS_PER_SEC << endl;
	// create the table of consumable resources
	int i;
	for(i=0;i<nof_resources;i++)
		if (resources[i].type==1)
		{
			consumable_resources[nof_consumable_resources]=resources[i].object_ID;
			resources[i].consumable_ID=nof_consumable_resources;
			nof_consumable_resources++;
		}

	// mark objects with the consumable_resource_ID,
	// to which objects correspond.
	for(i=0;i<nof_consumable_resources;i++)
		objects[consumable_resources[i]].consumable_resource=i;

	if (display_messages) 
		display_consumable_resources();

	create_init_vector();


//	cout << *init_vector << endl;
	mutexes_time=clock();
//	count_all_facts();
//	count_normal_actions();
	compute_mutexes();
//	count_achieved_facts();
//	count_applied_normal_actions();
   	mutexes_time=clock()-mutexes_time;



//	create_actions();


	//if (nof_resources>0)
	t_assign_costs=clock();
	assign_inverted_actions_costs();
	t_assign_costs=clock()-t_assign_costs;

	state* final_state;
	final_state=new state();
	final_state->nullify();

	solution=NULL;
	find_distances_time=0;
	detect_idle_objects_time=0;
	bfs_solve_time=0;
	complete_goals_time=0;
	add_delete_GRG_levels_time=0;

//	clock_t t_init=clock();
//	cout << t_init << endl;


	solve_subproblems(final_state);

	ftime3=clock();
	dt2=(double)(ftime3-ftime2)/CLOCKS_PER_SEC;
	dt=(double) (ftime3)/CLOCKS_PER_SEC ;

	int steps=0;
	action* t_plan;
	t_plan=solution;
	while (t_plan!=NULL)
	{
		steps++;
		t_plan=t_plan->next;
	}

//	cout << endl << "TOTAL SOLUTION" << endl;
//	cout <<         "==============" << endl;
	cout << problem_name << "," ;
	cout << 1000*dt << ",";
	cout << steps ;
	if (display_short_messages)
	{	
		t_plan=solution;
		while (t_plan!=NULL)
		{
			cout << "," << *t_plan ;
			t_plan=t_plan->next;
		}
	}

	cout << endl << endl;
					
	if (output_file_provided)
	{
		ofstream outfile;
		outfile.open(output_file,ios::app);
		outfile << problem_name << "," ;
		outfile << dt << ",";
		outfile << steps ;
		t_plan=solution;
		while (t_plan!=NULL)
		{
			outfile << "," << *t_plan ;
			t_plan=t_plan->next;
		}
		outfile << endl;
		outfile.close();
	} 
	if (display_messages)
	{
		cout << "TOTAL TIME=" << 1000*dt << endl;
		cout << "STEPS=" << steps << endl;
		cout << "LOADING FILES=" << t_loading*1000/CLOCKS_PER_SEC << endl;
		cout << "ALL FACTS=" << t_create_facts*1000/CLOCKS_PER_SEC << endl;
		cout << "MUTEXES TIME=" << mutexes_time *1000 /CLOCKS_PER_SEC << endl;
		cout << "IDLE LEVELS=" << t_idle_level *1000 /CLOCKS_PER_SEC << endl;
		cout << "ASSIGN COSTS=" << t_assign_costs*1000/CLOCKS_PER_SEC << endl;
		cout << "DISTANCES_TIME=" << find_distances_time *1000 /CLOCKS_PER_SEC << endl;
		cout << "DETECT IDLE OBJECTS TIME=" << detect_idle_objects_time*1000 /CLOCKS_PER_SEC << endl;
		cout << "BFS SOLVE TIME=" << bfs_solve_time << endl;
		cout << "COMPLETE GOALS TIME=" << complete_goals_time << endl;
		cout << "ADD/DELETE GRG LEVELS=" << add_delete_GRG_levels_time << endl;
	}


}


void solve_subproblems(state* final_state)
{
	if (display_short_messages)
	{
		cout << endl << endl;
		if (subproblem_level==NULL)
		{
			cout << "SOLVING MAIN PROBLEM" << endl;
			cout << "====================" << endl;
		}
		else
		{
			cout << "SOLVING SUBPROBLEM " ;
			display_current_subproblem_level();
			cout << endl;
			cout << "=====================" << endl ;
		}
		cout << "INITIAL STATE: " << *initial << endl << endl;
		cout << "GOAL STATE: " << *goal << endl << endl;
	}
	t_idle_level=t_idle_level-clock();
	add_idle_level();
	t_idle_level=t_idle_level+clock();

	clock_t t;
	clock_t t1;
	t=clock();	
	if (idle_flag)
		detect_idle_objects();

//	display_objects();
		
	t1=clock();
	detect_idle_objects_time=detect_idle_objects_time+(t1-t);
	
	nof_enabled_facts=0;
	t=clock();
	for_every_hash_entry(add_GRG_level);
	t1=clock();
	add_delete_GRG_levels_time=add_delete_GRG_levels_time+t1-t;

	nof_set_facts=0;
	nof_applied_inverted_actions=0;

	linked_hash_entry* new_goals;
	t=clock(); 
	complete_goals(&new_goals);
	t1=clock();
	complete_goals_time=complete_goals_time+t1-t;
 
	// first setting the distance of the new_goals to 0 and then 
	// adding the original goals...
	add_goals(goal);
	t=clock();
	if (ignore_consumable_resources)
	{
		nof_consumable_resources=0;
		for (int i=0;i<nof_resources;i++)
			resources[i].type=2;
	}

	find_all_distances(new_goals);

//	for_every_hash_entry(display_entry_related);
//	for_every_hash_entry(display_fact_distances);
	
	t1=clock();
	find_distances_time=(double) find_distances_time+(t1-t);
	
	if (xor_enabled && !no_xors)
		xor_routines(final_state);
	else
		search_routines(final_state);
	
	//bfs_solve(final_state);
	t=clock();
	for_every_hash_entry(delete_GRG_level);	
	t1=clock();
	add_delete_GRG_levels_time=add_delete_GRG_levels_time+t1-t;

	t_idle_level=t_idle_level-clock();
	delete_idle_level();
	t_idle_level=t_idle_level+clock();
}

