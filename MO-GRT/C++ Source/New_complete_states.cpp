// This file is an alternative method to compute the domain mutexes, using agenda instead of a 
// list of actions. Actions are inserted to the agenda when their preconditions haven been satisfied 
// and no mutex between them exists. Actions are re-inserted to the agenda when a mutex between another
// fact and a precondition fact is deleted, where the other fact is mutexed with an add effect of ther action.

// This file diifers from its previous version "New_complete_states.cpp" in that
// it represents mutexes with "linked_hash_entry"  structures (instead of "linked_fact" structures).


bool enrich_initial=true;

void test1();
void test2();
void test3();


#include "planner.h"



#define MUTEX_ADD 0
#define MUTEX_REMOVE 0
#define MUTEX_ACTION 0

linked_hash_entry* new_initials;

int nof_achieved_facts=0;

complete_state_action* normal_actions_head=NULL;
complete_state_action* normal_actions_tail=NULL;

linked_complete_state_action* c_agenda_head=NULL;
linked_complete_state_action* c_agenda_tail=NULL;

int nof2_actions=0;
int remove1=0;
int remove2=0;
int remove3=0;
int bingo1=0;
int bingo2=0;
int bingo3=0;
int bingo4=0;
int add_agenda=0;

// this function is defined in the file 'Grt.cpp'
bool instantiate_prec(fact* const_precs, int oper_id, int j, int vars[max_nof_parameters], 
		int back_points[max_sof_op_lists], int instantiated_by[max_sof_op_lists],
		int* max_instantiated);

// This function assigns with links to the act the preconditions facts in the hash table
void hash_table_normal_action(complete_state_action* act);

void add_to_agenda(complete_state_action*);


void create_normal_action(action* act)
{
	int oper_id=act->operator_id;
	int* vars=act->parameters;
	Operator* T_Operators;
	T_Operators=Operators;
	Operators=Normal_Operators;
	//cout << "Success" << endl;
	complete_state_action* new_action=new complete_state_action(act);
//	cout << *new_action->step << endl;
	nof2_actions++;
	if (normal_actions_head==NULL)
	{
		normal_actions_head=new_action;
		normal_actions_tail=new_action;
	}
	else
	{
		normal_actions_tail->next=new_action;
		normal_actions_tail=new_action;
	}
				
	hash_table_normal_action(new_action);	// add pointers to the precondition facts 
											// of the action into the hash table.

	// construct the criterion vector...
	if (nof_criteria>0)
	{
		new_action->action_cost=new vector();
		int ii;
		for (ii=0;ii<=nof_criteria;ii++)
			new_action->action_cost->elements[ii]=0;
		criterion_consumption* r;
		r=Operators[oper_id].criteria;
		while (r!=NULL)
		{
			if (r->object_ID>0)
			{
				new_action->action_cost->elements[1+objects[r->object_ID].criterion] +=
					r->amount;
			}
			else
			{
					new_action->action_cost->elements[1+objects[vars[-r->object_ID-1]].criterion] +=
					r->amount;
			}
			r=r->next;
		}
	}

	if (!new_action->has_dynamic_precs)
	{
		//cout << new_action->step << endl;
		add_to_agenda(new_action);
		// it is not needed to create new vector, however for just the case...
		if (nof_criteria>0)
		{
			new_action->total_cost=new vector();
			*new_action->total_cost=*new_action->action_cost;
		}
	}
	Operators=T_Operators;
	//cout << new_action->step << "   " << *new_action->action_cost << endl;
}



void create_normal_actions()
{
	Operators=Normal_Operators;
	action* t_action=all_actions;
	while (t_action!=NULL)
	{
		create_normal_action(t_action);
		t_action=t_action->next;
	}
}


// This function assigns with links to the act the preconditions facts in the hash table
void hash_table_normal_action(complete_state_action* act)
{
	linked_hash_entry* h=act->precs;
	while (h!=NULL)
	{
		h->entry->normal_actions=new linked_complete_state_action(act, h->entry->normal_actions);
		h=h->next;
	}

	h=act->add;
	while (h!=NULL)
	{
		h->entry->normal_actions_add=new linked_complete_state_action(act, h->entry->normal_actions_add);
		h=h->next;
	}
}


// Function 'complete_applicable' checks if the action pointer by 'agenda_head->step' pointer
// has all of its preconditions achieved and no mutex between them
bool complete_applicable(complete_state_action* act);


/* COMMENT: Adding actions to the tail of the agenda results in 
   significantly smaller number of iterations, than adding actions to the
   head of the agenda. This could be subject of investigation...

*/
// This function adds an action to the tail of the agenda...
void add_to_agenda(complete_state_action* act)
{
	if (!act->already_in_agenda)
	{
		add_agenda++;
//		cout << "Add to agenda " << add_agenda << ": " << act->step << endl;
		linked_complete_state_action* new_act=new linked_complete_state_action(act);
		if (c_agenda_head==NULL)
		{
			c_agenda_head=new_act;
			c_agenda_tail=new_act;
		}
		else
		{
			c_agenda_tail->next=new_act;
			c_agenda_tail=new_act;
		}
		act->already_in_agenda=true;
	}
}

/*
// This function adds an action to the head of the agenda...
void add_to_agenda(complete_state_action* act)
{
	if (!act->already_in_agenda)
	{
		add_agenda++;
//		cout << "Add to agenda " << add_agenda << ": " << act->step << endl;
		linked_complete_state_action* new_act=new linked_complete_state_action(act);
		if (c_agenda_head==NULL)
		{
			c_agenda_head=new_act;
			c_agenda_tail=new_act;
		}
		else
		{
			new_act->next=c_agenda_head->next;
			c_agenda_head->next=new_act;
		}
		act->already_in_agenda=true;
	}
}
*/


// This function checks whether actions having this fact as preconditions can be added to the agenda.
// The function is called each time a new fact (pointed by ptr) is achieved.
void potential_normal_actions1(hash_entry* ptr)
{
	linked_complete_state_action* act=ptr->normal_actions;
	while (act!=NULL)
	{
		if (complete_applicable(act->step))		// We check even if the action is 
												// already in the agenda, because
												// it may have now fewer cost...
			if (!act->step->already_in_agenda)
				add_to_agenda(act->step);
		act=act->next;
	}
}


// This function performs two operations:
// a)  It checks whether there are actions having facts f1 and f2 in their preconditions,
//     which are now applicable and if so, adds them in the agenda.
// b)  It adds to the agenda already applicable actions that have one of f1-f2 
//     in their preconditions, while the other fact is mutexed with one of their add effects.
void potential_normal_actions2(hash_entry* h1, hash_entry* h2)
{
	linked_complete_state_action* act1;
	linked_complete_state_action* act2;
//	cout << "Fact1: " << *f1 << endl;
//	cout << "Fact2: " << *f2 << endl;
	
	// Part A
	act1=h1->normal_actions;
	while (act1!=NULL)
	{
		if (act1->step->satisfied_prec)
		{
		//		cout << "Action1: " << act1->step->step << endl;
			linked_hash_entry* precs=act1->step->precs;
			bool flag=false;
			while (precs!=NULL && !flag)
			{
				if (precs->entry==h2)
				{	
					flag=true;
					if (complete_applicable(act1->step))
					{
//						cout << "BINGO1" << endl;
						bingo1++;
						add_to_agenda(act1->step);
					}
				}
				else
					precs=precs->next;
			}	//	while (precs!=NULL && !flag)
		}	// 	if (act1->step->satisfied_prec)
		act1=act1->next;
	}


	// Part B
	act1=h1->normal_actions;
	while (act1!=NULL)
	{
//		cout << "PART_B1: " << act1->step->step << endl;
		if (!act1->step->already_in_agenda)
			if (act1->step->no_mutex)
			{
				bool flag=false;	// indicates whether there is al least one add effect
									// that is mutexed with f2...
				int i=0;
				while (i<Operators[act1->step->step->operator_id].sof_lists[add_list] && !flag)
				{
					// get the hash pointer of an add effect fact...
					hash_entry* h=get_fact_pointer(&Operators[act1->step->step->operator_id].strips[add_list][i].instantiate(act1->step->step->parameters));
					linked_hash_entry* mutex=h->mutexes;
					while (mutex!=NULL && !flag)
					{
						if (mutex->entry==h2)
							flag=true;
						else
							mutex=mutex->next;
					}
					i++;
				}
			if (flag)
			{
//				cout << "BINGO2" << endl;
				bingo2++;
				add_to_agenda(act1->step);
			}
		}
		act1=act1->next;
	}

	act2=h2->normal_actions;
	while (act2!=NULL)
	{
//		cout << "PART_B2: " << act2->step->step << endl;
		if (!act2->step->already_in_agenda)
			if (act2->step->no_mutex)
			{
				bool flag=false;	// indicates whether there is al least one add effect
									// that is mutexed with f2...
				int i=0;
				while (i<Operators[act2->step->step->operator_id].sof_lists[add_list] && !flag)
				{
					// get the hash pointer of an add effect fact...
					hash_entry* h=get_fact_pointer(&Operators[act2->step->step->operator_id].strips[add_list][i].instantiate(act2->step->step->parameters));					
					linked_hash_entry* mutex=h->mutexes;
					while (mutex!=NULL && !flag)
					{
						if (mutex->entry==h1)
							flag=true;
						else
							mutex=mutex->next;
					}
					i++;
				}
			if (flag)
			{
//				cout << "BINGO3" << endl;
				bingo3++;
				add_to_agenda(act2->step);
			}
		}
		act2=act2->next;
	}
}


// This function adds (if possible) to the agenda actions that have 
// the "prec_mutexes" and the deleted preconditions in their add_list 
// and are not mutexed with any fact of "add1".
void potential_normal_actions3(linked_hash_entry* add1, linked_hash_entry* prec_mutexes)
{
//	cout << "Potential3" << endl;
	while (prec_mutexes!=NULL)
	{
		linked_complete_state_action* act=prec_mutexes->entry->normal_actions_add;
		while (act!=NULL)
		{
			if (!act->step->already_in_agenda && act->step->no_mutex)
				add_to_agenda(act->step);
			
			act=act->next;
		}
		prec_mutexes=prec_mutexes->next;
	}

	linked_hash_entry* deleted_precs=c_agenda_head->step->del;
	while (deleted_precs!=NULL)
	{
		linked_complete_state_action* act=deleted_precs->entry->normal_actions_add;
		while (act!=NULL)
		{
			if (!act->step->already_in_agenda && act->step->no_mutex)
				add_to_agenda(act->step);
			act=act->next;
		}
		deleted_precs=deleted_precs->next;
	}
}

void remove_mutex(hash_entry* f1, hash_entry* f2)
{
	linked_hash_entry* mutex=f1->mutexes;
	linked_hash_entry* mutex_prev=NULL;
	bingo4++;
//	cout << "Fact1: " << f1->f << endl;
//	cout << "Fact2: " << f2->f << endl;
//	cout << "BINGO4" << endl;
	bool flag=true;
	while (mutex!=NULL && flag)
	{
		if (mutex->entry==f2)
		{
			flag=false;
			if (mutex_prev!=NULL)
				mutex_prev->next=mutex->next;
			else
				f1->mutexes=mutex->next;
			delete mutex;
		}
		else
			mutex_prev=mutex;
			mutex=mutex->next;
	}
	if (flag)
	{
		cout << "ERROR 484739472934: Mutex not found." << endl;
		abort();
	}

	mutex=f2->mutexes;
	mutex_prev=NULL;
	flag=true;
	while (mutex!=NULL && flag)
	{
		if (mutex->entry==f1)
		{
			flag=false;
			if (mutex_prev!=NULL)
				mutex_prev->next=mutex->next;
			else
				f2->mutexes=mutex->next;
			delete mutex;
		}
		else
			mutex_prev=mutex;
			mutex=mutex->next;
	}
	if (flag)
	{
		cout << "ERROR 484739472934: Mutex not found." << endl;
		abort();
	}
}

		
// This function checks whether it is worthy to add a mutex between 'f' and 'add1' facts,
// where 'add1' is a newly achieved fact. 
bool test_to_remove_mutex(hash_entry* f, hash_entry* add1)
{
	bool flag=false;
//	cout << "Test to add mutex" << endl;
//	cout << "Fact1: " << f->f << endl;
//	cout << "Fact2: " << add1->f << endl;
	linked_complete_state_action* act=f->normal_actions_add;
	while (act!=NULL && !flag)
	{
//		cout << "Action in check: " << act->step->step << endl;
		// only applicable actions are considered
		if (act->step->no_mutex)

		//if(!act->step->first_application)	// this is important if the "try_to_remove_mutexes" call
											// is performed after the "add_new_prop" call.
		{
			// test if the preconditions of the action are not
			// mutual exclusice with the new fact...
			linked_hash_entry* precs=act->step->precs;
			bool flag2=true;
			while (precs!=NULL && flag2)
			{
				linked_hash_entry* mutex=precs->entry->mutexes;
				while (mutex!=NULL && flag2)
				{
					if (mutex->entry==add1)
						flag2=false;
					mutex=mutex->next;
				}	// while (mutex!=NULL && flag2)
				precs=precs->next;
			}	// while (precs!=NULL)
			flag=flag2;
		}	// if (act->step->no_mutex)
		act=act->next;
	}	// while (act!=NULL && !flag)
	return (flag);
}


// This function tries to remove some of the newly introduced mutexes between the 'add1' facts
// and the delete list of 'c_agenda_head' or the 'prec_mutexes' list.
void try_to_remove_new_mutexes(linked_hash_entry* prec_mutexes, linked_hash_entry* add1)
{
	while (add1!=NULL)
	{
		linked_hash_entry* del=c_agenda_head->step->del;
		while (del!=NULL)
		{
			if (test_to_remove_mutex(del->entry, add1->entry))
			{
				remove_mutex(del->entry, add1->entry);
				potential_normal_actions2(del->entry, add1->entry);
			}
			del=del->next;
		}	// while (del!=NULL)

		while (prec_mutexes!=NULL)
		{
			if (test_to_remove_mutex(prec_mutexes->entry, add1->entry))
			{
				remove_mutex(prec_mutexes->entry, add1->entry);
				potential_normal_actions2(prec_mutexes->entry, add1->entry);
			}
			prec_mutexes=prec_mutexes->next;
		}	// while (prec_mutexes->NULL)
		add1=add1->next;
	}	// while (add1!=NULL)
}

		


// Function 'add_prop' marks all the facts of the initial state as achieved.
void add_prop(fact* facts, unsigned int nof_facts) 
{
	
	unsigned int i;
	hash_entry* ptr;
	for(i=0;i<nof_facts;i++)
	{
		ptr=get_fact_pointer(&facts[i]);
		ptr->achieved=true;
		if (nof_criteria>0)
		{
			// The vector of the initial state facts should be equal to the 
			// initial amount of the monotonic criteria.
			ptr->init_vector=new vector();
			*ptr->init_vector=*initial->state_vector;
		}
		nof_achieved_facts++;
//		cout << "Fact inserted: " << facts[i] << endl;
		potential_normal_actions1(ptr);	// checks whether actions having this fact as 
											// precondition can be added to the agenda

#if MUTEX_ADD
		cout << "Achieved: " << ptr->f << endl;
#endif
	}
}

// Function 'add2_prop' marks all the facts in the linked fact likst 'ptr' as achieved.
void add2_prop(linked_hash_entry* add) 
{
	while (add!=NULL)
	{
		if (!add->entry->achieved)
		{
			add->entry->achieved=true;
			add->entry->forward_achieved_by=c_agenda_head->step;
			nof_achieved_facts++;
			if (nof_criteria>0)
			{
				add->entry->init_vector=new vector();
				*add->entry->init_vector=*c_agenda_head->step->total_cost;
			}
			potential_normal_actions1(add->entry);	// checks whether actions having this fact as 
												// precondition can be added to the agenda
#if MUTEX_ADD
			cout << "Achieved: " << add->entry->f << endl;
#endif
		}
		else
		{
			// This code concerns the case where a fact has been reachieved with a lower cost in a precense of criteria
			// (actually in this case only bounded monotonic criteria should be taken into account)
			// In this case the fact may reachieve actions in lower cost...
			if (nof_criteria>0)
			{
				if (!is_abs_min_equal(add->entry->init_vector, c_agenda_head->step->total_cost))
				{
					min_max(add->entry->init_vector, c_agenda_head->step->total_cost, add->entry->init_vector);
					potential_normal_actions1(add->entry);
				}
				else
					potential_normal_actions1(add->entry);
			}
		}
		add=add->next;
	}
}



// Function 'discriminate_adds' creates two linked lists of facts,
// which divide the facts of the add list of the 'agenda_head->step' action.
void discriminate_adds(linked_hash_entry** add1, linked_hash_entry** add2);


// This is a test function. It displays the facts of a list of linked facts.
void display_list(linked_hash_entry* ptr)
{
	while (ptr!=NULL)
	{
		cout << ptr->entry->f << endl;
		ptr=ptr->next;
	}
}


// Function 'find_mutexes' creates a linked fact list that consists of 
// all the facts that are mutual exclusive with 
// at least one precondition of 'agenda_head->step' action, and which are not included
// in the 'add2' linked fact list.
void find_mutexes(linked_hash_entry* add2, linked_hash_entry** prec_mutexes);

// Function 'add_del_mutexes' creates mutexes between the facts of the 'add1' list
// (which are newly achieved) and the facts in the delete list of 
// the 'agenda_head->step' action.
void add_del_mutexes(linked_hash_entry* add1);

// Function 'add_new_prec_mutexes' adds mutexes between the 'add1' facts and the facts 
// that are mutual exclusive with the preconditions of 'agenda_head->step' action.
void add_new_prec_mutexes(linked_hash_entry* add1, linked_hash_entry* prec_mutexes);

// Function 'remove_mutexes/1' removes any mutexes between the facts in the 
// list 'add'. 
void remove_mutexes(linked_hash_entry* add);

// Function 'not_deleted_preconditions' returns a linked_hash_entry list with 
// the preconditions of 'agenda_head->step' action, that are not included in
// its delete list.
void not_deleted_preconditions(linked_hash_entry** prec1);

// Function 'remove_mutexes/2' removes any mutexes between pairs of facts, 
// one from the first list and one from the second,,,
void remove_mutexes(linked_hash_entry* add2, linked_hash_entry* prec1);

// Function removes all the mutexes between the 'add2' facts and other facts, 
// where the other facts are not mutual exclusive with the preconditions.
void remove_non_prec_mutexes(linked_hash_entry* add2, linked_hash_entry* prec);

// Function 'find_new _goals' finds all the facts that are not included in the goal state
// and are not mutual exclusive with any fact of the goal state.
void find_new_goals(linked_hash_entry** new_goals);

void find_new_initials(linked_hash_entry** new_initials);

void add_new_goals(linked_hash_entry* new_goals);

void process_new_initials(linked_hash_entry* new_initials);

void complete_goals(linked_hash_entry** new_goals)
{
	*new_goals=NULL;
	find_new_goals(new_goals);
	if (display_messages)
	{
		cout << endl << "NEW GOALS" << endl;
		display_list(*new_goals);
		cout << endl;
	}
	add_new_goals(*new_goals);
}

// Function 'compute_mutexes' is the main function of this file. 
// It calls all the other functions.
void compute_mutexes()
{
	long double cft1;
	long double cft2;
	long double cft3;
	long double cdt1;	
	long double cdt2;	
	
	cft1=clock();
	create_normal_actions();
	cft2=clock();
	cdt1=(cft2-cft1)/CLOCKS_PER_SEC;

	add_prop(initial->facts, initial->size);
	int counter2=0;
//	display_normal_actions();

	while (c_agenda_head!=NULL)
	{
//		cout << c_agenda_head->step->step << endl;
		check_time();
		counter2++;
		//		cout << counter2 << endl;
//		if (counter2==18)
//			cout << endl;
//		test3();
#if MUTEX_ADD
//		if (!agenda_head->step->satisfied_prec)
			cout << endl<<  counter2 << ": " <<c_agenda_head->step->step << endl;
#endif
		linked_hash_entry* add1=NULL;
		linked_hash_entry* add2=NULL;
		if (c_agenda_head->step->first_application)
			discriminate_adds(&add1, &add2);
		else
		{
			add2=c_agenda_head->step->add;
			add1=NULL;
		}

		linked_hash_entry* add=c_agenda_head->step->add;
/*
		cout << "Add1" << endl;
		cout << "====" << endl;
		display_list(add1);
		cout << "Add2" << endl;
		cout << "====" << endl;
		display_list(add2);
		cout << endl;
*/
		linked_hash_entry* prec_mutexes=NULL;

		if (c_agenda_head->step->first_application)
		{
			if (add1!=NULL)
			{
				find_mutexes(add2, &prec_mutexes);
		// adds mutexes between the 'add1' facts and the delete list of 'agenda_head->step' action.
				add_del_mutexes(add1);
		// adds mutexes between the 'add1' facts and the facts that are mutual exclusive
		// with the preconditions of 'agenda_head->step' action;
				add_new_prec_mutexes(add1, prec_mutexes);

/*
// adds (if possible) to the agenda actions that have the prec_mutexes and the 
// deleted preconditions in their add_list and are not mutexed with any fact of add1.
//				potential_normal_actions3(add1, prec_mutexes);
*/

		// test if some of the newly introduced mutexes can be removed...
				try_to_remove_new_mutexes(prec_mutexes, add1);
			}
		}

		// marks all the facts in the 'add' list as achieved and assign to them
		// criteria vectors. This step should be repeated even if the action is 
		// re-applied, because the cost of the action may be now lower.
		// However, if there are no criteria, it is not necessary to re-apply
		// the action.
		if (nof_criteria>0)
			add2_prop(c_agenda_head->step->add);
		
		if (c_agenda_head->step->first_application)
		{
			if (add2!=NULL)
			{
				remove_mutexes(add2);
		// remove mutexes (if any) between the facts in the 'add2' and 'prec1' lists
				remove_mutexes(add2, c_agenda_head->step->non_deleted_precs);
			}
		}
			//if (!agenda_head->step->no_mutex)
		if (add2!=NULL)
			remove_non_prec_mutexes(add2, c_agenda_head->step->precs);

		delete_linked_hash_entry_list(prec_mutexes);						
		
		if (c_agenda_head->step->first_application)
		{
			delete_linked_hash_entry_list(add1);
			delete_linked_hash_entry_list(add2);
		}	
		
		c_agenda_head->step->first_application=false;
		
		// mark the action as applied
	
		// removes the first item of the agenda
		linked_complete_state_action* temp_agenda=c_agenda_head;
		c_agenda_head=c_agenda_head->next;
		temp_agenda->step->already_in_agenda=false;
		delete temp_agenda;
		if (c_agenda_head==NULL) c_agenda_tail=NULL;
		//test1();
		//test2();
		//test3();
	}
//	cout << "Goals: " << goal << endl;

	cft3=clock();
	cdt2=(cft3-cft2)/CLOCKS_PER_SEC;

	if (enrich_initial)
		find_new_initials(&new_initials);
//	display_list(new_initials);
	process_new_initials(new_initials);


	// delete_linked_hash_entry_list(new_goals);
	if (display_messages)
	{
		cout << "Iterations: " << counter2 << endl;
		cout << "Remove1: " << remove1 << endl;
		cout << "Remove2: " << remove2 << endl;
		cout << "Remove3: " << remove3 << endl;
		cout << "Bingo1: " << bingo1 << endl;
		cout << "Bingo2: " << bingo2 << endl;
		cout << "Bingo3: " << bingo3 << endl;
		cout << "Bingo4: " << bingo4 << endl;
		cout << "Goal state completed successfully..." << endl << endl;
		cout << "Creating normal operators:"  << cdt1 << endl;
		cout << "Find all mutexes : " << cdt2 << endl;
		cout << endl;
	}
}

// Function 'complete_applicable' checks if the action pointed by 'agenda_head->step' pointer
// has all of its preconditions achieved and no mutex between them
bool complete_applicable(complete_state_action* act)
{
	// checks if all the preconditions have been satisfied...
	// ... and they are not mutual exclusive with each other.
//	cout<< "Action in check: " << act->step;
	bool flag=true;
	
	if (!act->satisfied_prec)
	{
		linked_hash_entry* precs1;
		precs1=act->precs;
		while (precs1!=NULL && flag)
		{
			flag=precs1->entry->achieved;	// if it has been achieved
			precs1=precs1->next;
		}
		act->satisfied_prec=flag;
	}
		
	

	linked_hash_entry* precs1;
	if (act->satisfied_prec && !act->no_mutex)
	{
		precs1=act->precs;
		// checks for mutual exclusions...
		while (precs1!=NULL && flag)
		{
//			cout << "Prec1: " << precs1->entry->f << endl;
			linked_hash_entry* ptr2=precs1->entry->mutexes;
			while (ptr2!=NULL && flag)
			{
//				cout << "  Mutex with: " << ptr2->f << endl;
				linked_hash_entry* precs2;
				precs2=precs1->next;
				while (precs2!=NULL && flag)
				{
//					cout << "  Other precs: " << precs2->entry->f << endl;
					if (ptr2->entry==precs2->entry)
						flag=false;
					precs2=precs2->next;
				}
				ptr2=ptr2->next;
			}
			precs1=precs1->next;
		}
		act->no_mutex=flag;
	}


	// compute vector
	if (nof_criteria>0 && flag)
	{
		if (act->satisfied_prec && act->no_mutex)
		{
			// compute the max cost of the preconditions...
			vector* v=new vector();
			precs1=act->precs;
			while (precs1!=NULL )
			{
				max_min(v,precs1->entry->init_vector, v);
				precs1=precs1->next;
			}
			// add the cost of the application of the action...
			sum(v,act->action_cost,v);
			// if the total cost is not enough...
			
			if (out_of_bounds(v))
			//if (!(*v<=init_vector))
			{
				flag=false;
				delete v;
			}
			// else...
			else
			{
				// if the action had not already any cost, i.e. it is its first time
				// with sufficient cost...
				if (act->total_cost==NULL)
				{
					act->total_cost=v;
				}
				// else...
				else
				{
					// if the old cost is better or equal than the new cost, then ignore
					// the new cost...
					if (is_abs_min_equal(act->total_cost, v))
					{
						flag=false;
						delete v;
					}
					// else compute the min cost between the old and the new costs...
					else
					{
						min_max(v,act->total_cost, act->total_cost);
						delete v;
					}
				}
			}
		}
	}
	return flag;
}



// Function 'discriminate_adds' creates two linked lists of facts,
// which divide the facts of the add list of the 'agenda_head->step' action.
// The facts in the 'add1' lists are those facts that have not been achieved,
// while the facts in the 'add2' list are those that have been achieved.
void discriminate_adds(linked_hash_entry** add1, linked_hash_entry** add2)
{
	linked_hash_entry* adds=c_agenda_head->step->add;
	*add1=NULL;
	*add2=NULL;
	while (adds!=NULL)
	{
		if (adds->entry->achieved)
			*add2=new linked_hash_entry(adds->entry, *add2);
		else
			*add1=new linked_hash_entry(adds->entry, *add1);
		adds=adds->next;
	}
}

// Function 'included_in_linked_hash_entry_list' checks whether fact f is included
// in the linked_hash_entry list.
bool included_in_linked_hash_entry_list(hash_entry* f, linked_hash_entry* list);

// Function 'find_mutexes' creates a linked list of facts that consists of 
// all the facts that are mutual exclusive with 
// at least one precondition of 'agenda_head->step' action and which are not included
// in the 'add2' linked fact list.
void find_mutexes(linked_hash_entry* add2, linked_hash_entry** prec_mutexes)
{
	linked_hash_entry* ptr2;
	*prec_mutexes=NULL;
	linked_hash_entry* precs=c_agenda_head->step->precs;
	while (precs!=NULL)
	{
//		cout << "Prec: " << precs->entry->f << endl;
		ptr2=precs->entry->mutexes;
		while (ptr2!=NULL)
		{
//			cout << "   Fact: " << ptr2->f ;
			if (!included_in_linked_hash_entry_list(ptr2->entry, *prec_mutexes))
				if (!included_in_linked_hash_entry_list(ptr2->entry, add2))
				{
//					cout << "...OK";
					*prec_mutexes=new linked_hash_entry(ptr2->entry, *prec_mutexes);
				}
			ptr2=ptr2->next;
//			cout << endl;
		}
		precs=precs->next;
	}
}


// Function 'included_in_linked_hash_entry_list' checks whether fact f is included
// in the linked_hash_entry list.
bool included_in_linked_hash_entry_list(hash_entry* f, linked_hash_entry* list)
{
	bool flag=false;
	while (list!=NULL && !flag)
		if (f==list->entry)
			flag=true;
		else
			list=list->next;
	return flag;
}

 
// Function 'add_del_mutexes' creates mutexes between the facts of the 'add1' list
// (which are newly achieved) and the facts in the delete list of 
// the 'agenda_head->step' action.
void add_del_mutexes(linked_hash_entry* add1)
{
	linked_hash_entry* ptr;
	linked_hash_entry* add1_head=add1;
	ptr=c_agenda_head->step->del;
	while (ptr!=NULL)
	{
		add1=add1_head;
		while (add1!=NULL)
		{
			ptr->entry->mutexes=new linked_hash_entry(add1->entry, ptr->entry->mutexes);
			add1->entry->mutexes=new linked_hash_entry(ptr->entry, add1->entry->mutexes);
#if MUTEX_ADD
			cout << "Mutex: " << ptr->entry->f << " - " << add1->entry->f << endl;
#endif
			add1=add1->next;
		}
		ptr=ptr->next;
	}
}



// Function 'add_new_prec_mutexes' adds mutexes between the 'add1' facts and the facts 
// that are mutual exclusive with the preconditions of 'agenda_head->step' action.
void add_new_prec_mutexes(linked_hash_entry* add1, linked_hash_entry* prec_mutexes)
{
	linked_hash_entry* add1_head=add1;
	while (
		prec_mutexes!=NULL)
	{
//		cout << "Prec mutex: " << prec_mutexes->entry->f << endl;
		add1=add1_head;
		while (add1!=NULL)
		{
//			cout << "Add1 fact: " << add1->entry->f << endl;
			add1->entry->mutexes=new linked_hash_entry(prec_mutexes->entry, add1->entry->mutexes);
			prec_mutexes->entry->mutexes=new linked_hash_entry(add1->entry, prec_mutexes->entry->mutexes);
#if MUTEX_ADD
			cout << "Mutex: " << prec_mutexes->entry->f << " - " << add1->entry->f << endl;
#endif
			add1=add1->next;
		}
		prec_mutexes=prec_mutexes->next;
	}
}


// Function 'remove_mutexes' removes any possible mutexes between the facts in the add list
void remove_mutexes(linked_hash_entry* add)
{
	linked_hash_entry* ptr;
	linked_hash_entry* mutex;
	linked_hash_entry* mutex_prev;
	while (add!=NULL)
	{
		ptr=add->next;
		while (ptr!=NULL)
		{
			mutex=add->entry->mutexes;
			mutex_prev=NULL;
			bool flag=true;
			while (mutex!=NULL && flag)
				if (mutex->entry==ptr->entry)
				{
#if MUTEX_REMOVE
					cout << "Remove1: " << add->entry->f << " - " << ptr->entry->f << endl;
#endif 
					hash_entry* f1=add->entry;
					hash_entry* f2=ptr->entry;
					remove1++;
					flag=false;
					if (mutex_prev!=NULL)
						mutex_prev->next=mutex->next;
					else
						add->entry->mutexes=mutex->next;
					delete mutex;
					
					mutex=ptr->entry->mutexes;
					mutex_prev=NULL;
					bool flag2=true;
					while (mutex!=NULL && flag2)
						if (mutex->entry==add->entry)
						{
							flag2=false;
							if (mutex_prev!=NULL)
								mutex_prev->next=mutex->next;
							else
								ptr->entry->mutexes=mutex->next;
							delete mutex;
						}
						else
						{
							mutex_prev=mutex;
							mutex=mutex->next;
						}
					potential_normal_actions2(f1, f2);
				}	
				else
				{
				mutex_prev=mutex;
				mutex=mutex->next;
				}
			ptr=ptr->next;
		}
		add=add->next;
	}	
}



// Function 'remove_mutexes/2' removes any mutexes between pairs of facts, 
// one from the first list and one from the second,,,
void remove_mutexes(linked_hash_entry* add2, linked_hash_entry* prec1)
{
	linked_hash_entry* prec1_head=prec1;
	linked_hash_entry* mutex;
	linked_hash_entry* mutex_prev;
	while (add2!=NULL)
	{
		prec1=prec1_head;
		while (prec1!=NULL)
		{
			mutex=add2->entry->mutexes;
			mutex_prev=NULL;
			bool flag=true;
			while (mutex!=NULL && flag)
				if (mutex->entry==prec1->entry)
				{
#if MUTEX_REMOVE
					cout << "Remove2: " << add2->entry->f << " - " << prec1->entry->f << endl;
#endif
					remove2++;
					hash_entry* f1=add2->entry;
					hash_entry* f2=prec1->entry;
					flag=false;
					if (mutex_prev!=NULL)
						mutex_prev->next=mutex->next;
					else
						add2->entry->mutexes=mutex->next;
					delete mutex;
					
					mutex=prec1->entry->mutexes;
					mutex_prev=NULL;
					bool flag2=true;
					while (mutex!=NULL && flag2)
						if (mutex->entry==add2->entry)
						{
							
							flag2=false;
							if (mutex_prev!=NULL)
								mutex_prev->next=mutex->next;
							else
								prec1->entry->mutexes=mutex->next;
							delete mutex;
						}
						else
						{
							mutex_prev=mutex;
							mutex=mutex->next;
						}
					if (flag2)
					{
						cout << "ERROR 546437455: Complementarty mutex does not exist" << endl;
						abort();
					}
					potential_normal_actions2(f1, f2);
				}	
				else
				{
				mutex_prev=mutex;
				mutex=mutex->next;
				}
			prec1=prec1->next;
		}
		add2=add2->next;
	}	
}


// Function removes all the mutexes between the 'add2' facts and other facts, 
// where the other facts are not mutual exclusive with the preconditions.
void remove_non_prec_mutexes(linked_hash_entry* add2, linked_hash_entry* prec)
{
	linked_hash_entry* prec_head=prec;
	while (add2!=NULL)	// for every fact in the add2 list
	{
//		cout << "Add2 fact: " << add2->entry->f << endl;
		linked_hash_entry* mutex;
		linked_hash_entry* mutex_prev;
		mutex=add2->entry->mutexes;	// mutex is the linked_fact list of add2's mutexes...
		mutex_prev=NULL;
		while (mutex!=NULL)	// for every mutex with an add2's fact ... (1) 
		{
//			cout << "Mutex with:" << mutex->f << endl;
			bool flag=true;
			prec=prec_head;
			while (prec!=NULL && flag)	// for every precondition...
			{
				flag=(mutex->entry != prec->entry);	// the mutex should be different from any prec...
				prec=prec->next;
			}

			prec=prec_head;
			while (prec!=NULL && flag)	// for every precondition...
			{
				hash_entry* ptr2=mutex->entry; 	
				linked_hash_entry* mutex2=ptr2->mutexes;	// a mutex (2) of the mutex (1)
				while (mutex2!=NULL && flag) // for every mutex (2) of the mutex (1)
				{
					flag=(mutex2->entry!=prec->entry);	// the mutex should not be mutual exclusive
														// with any precondition...
					mutex2=mutex2->next;
				}
				prec=prec->next;
			}

			if (flag)
			{
				remove3++;
#if MUTEX_REMOVE
				cout << "Remove3: " << mutex->f << " - " << add2->entry->f << endl;
#endif 
				hash_entry* f1=mutex->entry;
				hash_entry* f2=add2->entry;
				
				if (mutex_prev!=NULL)
					mutex_prev->next=mutex->next;
				else
					add2->entry->mutexes=mutex->next;
				
				linked_hash_entry* mutex2;
				linked_hash_entry* mutex2_prev;
				hash_entry* ptr_mutex=mutex->entry;
				mutex2=ptr_mutex->mutexes;
				mutex2_prev=NULL;
				bool flag2=true;
				while (mutex2!=NULL && flag2)
					if (mutex2->entry==add2->entry)
					{
						flag2=false;
						if (mutex2_prev!=NULL)
							mutex2_prev->next=mutex2->next;
						else
							ptr_mutex->mutexes=mutex2->next;
						delete mutex2;
					}
					else
					{
						mutex2_prev=mutex2;
						mutex2=mutex2->next;
					}
				if (flag2)
				{
					cout << "ERROR 34235242: Complementarty mutex does not exist" << endl;
					abort();
				}
				linked_hash_entry* tmp=mutex;
				mutex=mutex->next;
				delete tmp;
				
				potential_normal_actions2(f1, f2);
			}
			else	// if (flag)
			{
				mutex_prev=mutex;
				mutex=mutex->next;
			}
		}
		add2=add2->next;
	}
}

// Function 'check_fact' returns true if fact f in not included in the goals and is
// not mutual exclusive with any goal. 
bool check_fact(fact* f, linked_hash_entry* goals_list);

// Function 'find_new_goals' finds all the facts that are not included in the goal state
// and are not mutual exclusive with any fact of the goal state.
void find_new_goals(linked_hash_entry** new_goals)
{
	int counter=0;
	*new_goals=NULL;
	linked_hash_entry* goals_list=NULL;
	int sz=0;
	for (sz=0;sz<goal->size;sz++)
	{
		hash_entry* ptr=get_fact_pointer(&goal->facts[sz]);
		if (ptr!=NULL)
			goals_list=new linked_hash_entry(ptr, goals_list);
		else
		{
			cout << "Non achievable goal fact: " << goal->facts[sz] << endl;
			abort();
		}
	}

	void* ptr;
	int vars[max_arity];
	int i;
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
						if ((((pointer*) ptr)[vars[j]-1]).forward==NULL || objects[vars[j]].idle->value)
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
						if (((hash_entry*) ptr)->achieved && !((hash_entry*) ptr)->new_fact )
						{
							//fact f=fact(i, vars);
							//if (check_fact(&f, goals_list))
//							cout << ((hash_entry*) ptr)->f << endl;
							if (check_fact(&((hash_entry*) ptr)->f, goals_list))
							{
								*new_goals=new linked_hash_entry(linked_hash_entry((hash_entry*) ptr, *new_goals));
							}
						}

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
			}	// if (hash_table[i]->ptr!=NULL)
		}	
		else	// if (predicates[i].arity>0)
		{
			ptr=hash_table[i].forward;
			if (((hash_entry*) ptr)->achieved)
			{
				
				if (check_fact(&((hash_entry*) ptr)->f, goals_list))
				{
					*new_goals=new linked_hash_entry(linked_hash_entry((hash_entry*) ptr, *new_goals));
				}
			}
			//cout << f ;
			//ptr=hash_table[i].ptr;
		}
	}		
}

// Function 'find_new_initials' finds all the facts that are not included in the initial state
// and are not mutual exclusive with any fact of the initial state.
void find_new_initials(linked_hash_entry** new_initials)
{
	*new_initials=NULL;
	linked_hash_entry* initials_list=NULL;
	int sz=0;
	for (sz=0;sz<initial->size;sz++)
		initials_list=new linked_hash_entry(get_fact_pointer(&initial->facts[sz]), initials_list);

	void* ptr;
	int vars[max_arity];
	int i;
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
						if (((hash_entry*) ptr)->achieved)
						{
							fact f=fact(i, vars);
							if (check_fact(&f, initials_list))
							{
								*new_initials=new linked_hash_entry(get_fact_pointer(&f), *new_initials);
							}
						}
						

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
			}	// if (hash_table[i]->ptr!=NULL)
		}	
		else	// if (predicates[i].arity>0)
		{
			fact f=fact(i, vars);
			if (check_fact(&f, initials_list))
			{
				*new_initials=new linked_hash_entry(get_fact_pointer(&f), *new_initials);
			}
			//cout << f ;
			ptr=hash_table[i].forward;
		}
	}		
}



// Function 'check_fact' returns true if fact f in not included in the goals and is
// not mutual exclusive with any goal. 
bool check_fact(fact* f, linked_hash_entry* goals_list)
{
	bool flag=true;
//	cout << *f << endl;
	while (goals_list!=NULL && flag)
	{
		flag=( *f != goals_list->entry->f);
		linked_hash_entry* mutex;
		mutex=goals_list->entry->mutexes;
		while (mutex!=NULL && flag)
		{
			if (mutex->entry->f==*f)
				flag=false;
			mutex=mutex->next;
		}
		goals_list=goals_list->next;
	}
	return flag;

}


// Function 'set_distance_related' sets the distance and the list of related facts
// of a fact in the hash table.
void set_distance_related(hash_entry* f, vector* v, linked_hash_entry* related, inverted_action* inv_act);

void add_new_goals(linked_hash_entry* new_goals)
{
	Operators=Inv_Operators;
	vector* v;
	v=new vector();

	linked_hash_entry* t_new_goals;
	t_new_goals=new_goals;
	while (t_new_goals!=NULL)
	{
		t_new_goals->entry->linked_enriched->value=true;
		t_new_goals=t_new_goals->next;
	}


	// if switch -r2 has been set, then
	// from the 'new_goals' apply immediately the facts that appear also 
	// in the initial state. Depending on the switch -r1, the mutexed fact are marked as used or not.

	if (copy_from_initial)
	{
		t_new_goals=new_goals;
		// check for each fact of the 'new_goals' if it is member of the initial state
		while (t_new_goals!=NULL)
		{
			// if the fact is member of the initial state...
			if (initial->included(t_new_goals->entry->f))
			{
				if (display_messages)
					cout << "ENRICHED FACT IN THE INITIAL = " << t_new_goals->entry->f << endl;

				if (!enriched_no_used)
				{
					linked_hash_entry* t2_new_goals=new_goals;
					// check for all the other facts of the 'new_goals' 
					// if they are not members of the initial state
					// and they are mutexed with the current fact...
					while (t2_new_goals!=NULL)
					{
						if (t2_new_goals!=t_new_goals)
						{
							bool found=false;
							linked_hash_entry* mutexes=t_new_goals->entry->mutexes;
							// for all the mutexes of the t_new_goals
							while (mutexes!=NULL && !found)
							{
								if (mutexes->entry==t2_new_goals->entry)
								{
									found=true;
									if (display_messages)
										cout << "ENRICHED FACT DISABLED = " << t2_new_goals->entry->f << endl;
									t2_new_goals->entry->linked_used->value=true;

								}
								else
									mutexes=mutexes->next;
							}
						}
						t2_new_goals=t2_new_goals->next;

					}
				}	// if (!reduced_enriched)
				t_new_goals->entry->linked_used->value=true;
				//cout << "Adding enriched goal fact " << t_new_goals->entry->f << endl;
				set_distance_related(t_new_goals->entry,v,NULL,NULL);
			}
			t_new_goals=t_new_goals->next;
		}
	}

	if (!reduced_enriched)
	{
		t_new_goals=new_goals;
		while (t_new_goals!=NULL)
		{
			t_new_goals->entry->linked_used->value=true;
			set_distance_related(t_new_goals->entry,v,NULL,NULL);
			t_new_goals=t_new_goals->next;
		}
	}

	Operators=Normal_Operators;
	delete v;
}




bool modify_operator(linked_hash_entry* new_initials, int* new_pred);

void process_new_initials(linked_hash_entry* new_initials)
{
	//display_messages=true;
	int new_pred=0;
	linked_hash_entry* new_initials0=new_initials;
	
	if (display_messages)
	{
		cout << "NEW INITIAL FACTS" << endl;
		cout << "=================" << endl;
	}
	
	while (new_initials!=NULL)
	{
		if (display_messages)
			cout << new_initials->entry->f << endl;
		new_initials->entry->enriched_init=true;
		new_initials=new_initials->next;
	}
	if (display_messages)
		cout << endl;
	
	new_initials=new_initials0;

	linked_hash_entry* ptr;
	while (new_initials!=NULL)
	{
		if (!new_initials->entry->enriched_init_used && predicates[new_initials->entry->f.pred].arity<=1)
		{
			if (modify_operator(new_initials, &new_pred))
			{
			
				new_initials->entry->enriched_init_used=true;
 				fact f;
				f.pred=nof_predicates-1;
				f.arguments[0]=new_initials->entry->f.arguments[0];
				insert_fact_to_hash_table(&f);
				hash_entry* h=get_fact_pointer(&f);
				h->achieved=true;
				h->new_fact=true;
				
				// create mutexes
				h->mutexes=new linked_hash_entry(new_initials->entry, h->mutexes);
				new_initials->entry->mutexes=new linked_hash_entry(h, new_initials->entry->mutexes);

				if (display_messages)
					cout << "Fact " << f << " added to the hash table." << endl;
				initial->add_fact(f);
			
				
				linked_hash_entry* mutex=new_initials->entry->mutexes;
				while (mutex!=NULL)
				{
					mutex->entry->enriched_init_used=true;
					mutex=mutex->next;
				}
				
				ptr=new_initials0;
				while (ptr!=NULL)
				{
					if (ptr->entry->enriched_init_used==false && ptr->entry->f.pred==new_initials->entry->f.pred)
					{
						ptr->entry->enriched_init_used=true;	
						f.arguments[0]=ptr->entry->f.arguments[0];
						insert_fact_to_hash_table(&f);
						if (display_messages)
							cout << "Fact " << f << " added to the hash table." << endl;
						initial->add_fact(f);
						hash_entry* h=get_fact_pointer(&f);
						h->achieved=true;
						h->mutexes=new linked_hash_entry(ptr->entry, h->mutexes);
						h->new_fact=true;
						ptr->entry->mutexes=new linked_hash_entry(h, ptr->entry->mutexes);
						
						mutex=ptr->entry->mutexes;
						while (mutex!=NULL)
						{
							mutex->entry->enriched_init_used=true;
							mutex=mutex->next;
						}
					}
					ptr=ptr->next;
				}
			}
		}
		new_initials=new_initials->next;
	}
	create_inverted_operators();

	if (display_messages)
		cout << "Initial state completed successfully..." << endl;

	//display_operators();
}



bool modify_operator(linked_hash_entry* new_initials, int* new_pred)
{
	int i=0;
	bool found=false;
	bool first_found=true;
	while (i<nof_operators)
	{
		int j=0;
		bool found_add=false;
		while (j<Operators[i].sof_lists[add_list] ) // && !found_add)
		{
			if (Operators[i].strips[add_list][j].pred==new_initials->entry->f.pred)
			{
				found_add=true;
				int k=0;
				bool found_prec=false;
				while (k<Operators[i].sof_lists[prec_list] && !found_prec)
				{
					if (Operators[i].strips[prec_list][k].pred==new_initials->entry->f.pred)
						found_prec=true;
					else
					{
						linked_hash_entry* mutex=new_initials->entry->mutexes;
						while (mutex!=NULL && !found_prec)
						{
							if (Operators[i].strips[prec_list][k].pred==mutex->entry->f.pred)
								found_prec=true;
							else
								mutex=mutex->next;
						}
					}
					k++;
				}
				if (!found_prec)
				{
					found=true;
					if (display_messages)
						cout << "Initial operator: " << Operators[i] << endl;
					if (first_found)
					{
						(*new_pred)++;
						predicates[nof_predicates].arity=predicates[new_initials->entry->f.pred].arity;
						strcpy(predicates[nof_predicates].name,"not_");
						strcat(predicates[nof_predicates].name,predicates[new_initials->entry->f.pred].name);
						if (display_messages)
							cout << "Predicate " << predicates[nof_predicates].name << "/" << predicates[nof_predicates].arity << " has been created." << endl;
						constant_predicates[nof_predicates]=false;
					}
					else
						nof_predicates--;
					
					Operators[i].strips[prec_list][Operators[i].sof_lists[prec_list]].pred=nof_predicates;
					Operators[i].strips[prec_list][Operators[i].sof_lists[prec_list]].arguments[0]=Operators[i].strips[add_list][j].arguments[0];
					Operators[i].sof_lists[prec_list]++;
					
					Operators[i].strips[delete_list][Operators[i].sof_lists[delete_list]].pred=nof_predicates;
					Operators[i].strips[delete_list][Operators[i].sof_lists[delete_list]].arguments[0]=Operators[i].strips[add_list][j].arguments[0];
					Operators[i].sof_lists[delete_list]++;
					
					if (display_messages)
						cout << "Modified operator: " << Operators[i] << endl;
					nof_predicates++;
					first_found=false;
				}
			}
			j++;
		}
		i++;
	}
	return found;
}