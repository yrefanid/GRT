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

// Criteria
int nof_criteria=0;
Criterion criteria[max_nof_criteria];	//	This table points to the table 'objects',
										//	that is, to the objects that are criteria.

int past_weight=0;			// The weight of the past plan
int remaining_weight=1;		// The weight of the remaining_plan

int length_weight=1;
int length_from=0;
int length_to=1000;

bool ignore_criteria=true;

bool multiply_scale=false;
int multiply_scale_criterion=-1;
int multiply_scale_type=0;
int multiply_scale_number=1;


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

void create_actions();

void distribute_objects();

void change_scale();


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

//	display_operators();
//	display_predicates();
	
	if (!load_problem())
	{
 		cout << "ERRORS while loading problem. Operation aborted." << endl;
		exit(0);
	}

	
//	display_criteria();
//	display_objects();

 	t_loading=clock()-t_loading;
/*
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
*/
//	distribute_objects();
//	return;


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


	int i;


	//cout << t_create_facts*1000/CLOCKS_PER_SEC << endl;
	// create the table of monotonic criteria

	// mark objects with the monotonic_criterion_ID,
	// to which objects correspond.

	// This is a convenient way to perform the experiment with
	// the broader or narrower scales. The criterion the scale of which 
	// will be changed and the multiplier are provided as command line arguments.
	
	if (multiply_scale)
		change_scale();

	mutexes_time=clock();
//	count_all_facts();
//	count_normal_actions();
	compute_mutexes();
//	count_achieved_facts();
//	count_applied_normal_actions();
   	mutexes_time=clock()-mutexes_time;

	//for_every_hash_entry(display_entry);

	if (ignore_criteria)
	{
		nof_criteria=0;
		past_weight=0;
		remaining_weight=1;
		length_from=0;
		length_to=agenda_hash_size;
		length_weight=1;
		for (i=0;i<nof_criteria;i++)
			criteria[i].type=0;
	}

//	create_actions();


	//if (nof_criteria>0)

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

	cout << problem_name << ", " ;
	cout << 1000*dt;
	if (nof_criteria>0)
	{
		cout << ", "; 
		for(i=0;i<=nof_criteria;i++)
		{
			//cout << objects[criteria[i].object_ID].name << "=";
			cout << final_state->state_vector->elements[i];
			if (i+1<=nof_criteria)
				cout << ", ";
		}
	}
	cout << endl;

/*	if (display_short_messages)
	{	
		t_plan=solution;
		while (t_plan!=NULL)
		{
			cout << "," << *t_plan ;
			t_plan=t_plan->next;
		}
	}
*/	

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

//	display_calibration_values();
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

//	for_every_hash_entry(display_fact_distances);
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

int find_city(int location)
{
	int i;
	for(i=0;i<nof_constants;i++)
		if (strcmp2(predicates[constants[i].pred].name, "in-city") &&
			location==constants[i].arguments[0])
			return constants[i].arguments[1];
	return -1;
}

int find_initial_location(int obj)
{
	int i;
	for(i=0;i<initial->size;i++)
		if (strcmp2(predicates[initial->facts[i].pred].name, "at") &&
			obj==initial->facts[i].arguments[0])
			return initial->facts[i].arguments[1];
	return -1;
}



void distribute_objects()
{
	int i;
	int counter1=0;
	for(i=1;i<=nof_objects;i++)
		if (strncmp(objects[i].name, "obj", 3)==0)
			counter1++;
	cout << "Number of packages=" << counter1 << endl;
	int counter2=0;
	int counter3=0;
	int counter4=0;
	int counter5=0;
	int counter6=0;
	for (i=0;i<goal->size;i++)
		if (strcmp2(predicates[goal->facts[i].pred].name, "at") &&
			strncmp(objects[goal->facts[i].arguments[0]].name,"obj",3)==0)
		{
			counter2++;
			int goal_location=goal->facts[i].arguments[1];
			int initial_location=find_initial_location(goal->facts[i].arguments[0]);
			int goal_city=find_city(goal_location);
			int initial_city=find_city(initial_location);
			if (goal_location==initial_location)
				counter3++;
			else if (goal_city==initial_city)
				counter4++;
			else
			{
				counter5++;
				int k,l;
				cout << objects[goal_city].name << endl;
				cout << objects[initial_city].name << endl;
				k=objects[goal_city].name[3]-'0';
				l=objects[initial_city].name[3]-'0';
				counter6+=abs(k-l);
			}
		}
	cout << "Goal packages=" << counter2 << endl;
	cout << "Goal packages in the same location=" << counter3 << endl;
	cout << "Goal packages in the same city=" << counter4 << endl;
	cout << "Goal packages in different cities=" << counter5 << endl;
	cout << "Sum of differences between cities=" << counter6 << endl;
	cout << "Length max=" << counter4*4 +counter5*12+counter6-1 << endl;
	cout << "Cost max=" << counter4*46 +counter5*106+(counter6-1)*50 << endl;
	cout << "Duration max=" << counter4*22 +counter5*204+(counter6-1)*100<< endl;
	cout << endl;
}


void change_scale()
{
//bool multiply_scale=false;
//int multiply_scale_criterion=-1;
//int multiply_scale_type=0;
//int multiply_scale_number=1;
	int old_left;
	int old_right;
	if (multiply_scale_criterion==0)
	{
		old_left=length_from;
		old_right=length_to;
	}
	else
	{
		old_left=criteria[multiply_scale_criterion-1].from;
		old_right=criteria[multiply_scale_criterion-1].to;
	}

	int old_scale_width=old_right-old_left;
	int scale_center=(old_left+old_right)/2;
	int new_scale_width;
	if (multiply_scale_type==1)
		new_scale_width=old_scale_width*multiply_scale_number;
	else
		new_scale_width=int(old_scale_width/multiply_scale_number);
	int new_left=int(scale_center-new_scale_width/2);
	if (new_left<0)
		new_left=0;
	int new_right=new_left+new_scale_width;

	if (multiply_scale_criterion==0)
	{
		length_from=new_left;
		length_to=new_right;
	}
	else
	{
		criteria[multiply_scale_criterion-1].from=new_left;
		criteria[multiply_scale_criterion-1].to=new_right;
	}


	
}