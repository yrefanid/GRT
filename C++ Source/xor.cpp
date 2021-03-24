#include "planner.h"

constraints* xors=NULL;

bool xor_routines_flag=true;

// Function 'get_ground_XOR' returns the ground_constraint structure 'ground_xor', 
// which contains f. If f is not XOR constrained, the function returns NULL in the field 'xors'
// of object ground_xor.
void get_ground_XOR(fact f, ground_constraint* ground_xor);


// Function 'find_pairs' finds for each goal fact its corresponding initial state fact,
// according to the general XOR-constraints definitions.
void find_pairs(pairs_of_facts** pairs)
{
	*pairs=NULL;
	int i;
	// for every goal-state fact...
	for(i=0;i<goal->size;i++)
	{
		ground_constraint xor_goal;
		// cout << goal.facts[i]<< endl;
		get_ground_XOR(goal->facts[i], &xor_goal);
//		cout << xor_goal << endl;
		if (xor_goal.xors!=NULL)
		{	
			//cout << xor_goal << endl;
			*pairs=new pairs_of_facts(*pairs);
			(*pairs)->goal=get_fact_pointer(&goal->facts[i]);
			int j=0;
			bool found=false;
			ground_constraint xor_initial;
			while (j<initial->size && !found)
			{
				//cout << initial.facts[j] << endl;
				get_ground_XOR(initial->facts[j], &xor_initial);
				if (xor_initial.xors!=NULL)
				{
					if (xor_initial==xor_goal)
					{
						(*pairs)->initial=get_fact_pointer(&initial->facts[j]);
						(*pairs)->ground_xor=xor_goal;
						found=true;
					}	// if (xor_initial==xor_goal)
					else 
						j++;
				}
				else
					j++;
			}	// while (j<initial.size && !found)
			if (!found)
			{
				cout << "ERROR 48492049204: Incomplete initial state" << endl;
				cout << "or bad XOR-constraints definition" << endl;
				cout << "Goal fact " << goal->facts[i] << " has not its corresponding initial fact." << endl;
				abort();
			}	
//			else	// if (!found)
//				cout << "Pair: " << initial.facts[j] << " - " << goal.facts[i] << "." << endl;
//				cout << pairs->ground_xor << endl;
		}	// if (xor_goal!=NULL)
	}	// for(i=0;i<goal.size;i++)
}


// Function 'get_ground_XOR' returns the ground_constraint structure 'ground_xor', 
// which contains f. If f is not XOR constrained, the function returns NULL to the field xors of object ground_xor.
// Fact f MUST be full-grounded, so that there is only one way to 
// be instantiable with each XOR fact.
void get_ground_XOR(fact f, ground_constraint* ground_xor)
{
	constraints* t_xors=xors;
	bool found=false;
	while (t_xors!=NULL && !found)
	{
//		cout << *t_xors << endl;
		constraint* t_xor=t_xors->xor;
		while (t_xor!=NULL && !found)
		{
//			cout << "Check for instantiation: " << t_xor->ands->f << endl;
			// check for possible instantitation
			if (t_xor->ands->f.instantiable(f))
			{
				// detect the parameters values under which the instantiation has been performed
				int parameters[max_nof_parameters];
				int i;
				for(i=0;i<max_nof_parameters;i++)
					parameters[i]=0;
				for(i=0;i<predicates[t_xor->ands->f.pred].arity;i++)
					if (t_xor->ands->f.arguments[i]<0)
						parameters[-t_xor->ands->f.arguments[i]-1]=f.arguments[i];

				// check the constants of the t_xors for the instantiation in case...
				bool constants_OK=true;
				linked_fact* xors_constants=t_xors->constants;
				
				while (xors_constants!=NULL && constants_OK)
				{
//					cout << "Un-instantiated constant fact: " << xors_constants->f << endl;
					fact constant=xors_constants->f.instantiate(parameters);
//					cout << "Instantiated constant fact: " << constant << endl;
					bool found_constant=false;
					int i=0;
					while (i<nof_constants && !found_constant)
					{
						if (constant==constants[i])
							found_constant=true;
						else
							i++;
					}
					if (!found_constant)
						constants_OK=false;
					else
						xors_constants=xors_constants->next;
				}
				
				if (constants_OK)
				{
					found=true;
					ground_xor->xors=t_xors;
					int i;
					for (i=0;i<predicates[f.pred].arity;i++)
						if (t_xor->ands->f.arguments[i]<0)
							ground_xor->parameters[-t_xor->ands->f.arguments[i]-1]=f.arguments[i];
				}
			}
			if (!found)
				t_xor=t_xor->next;
		}	// while (t_xor!=NULL)
		if (!found)
			t_xors=t_xors->next;
	}	// 	while (t_xors!=NULL)
	if (!found)
		ground_xor->xors=NULL;
}

// Function 'find_previous_fact' gets as input a XOR-constrained fact h
// and returns its previous fact h_prev, which is XOR constrained with h
// and has been deleted by the action that achieved h.
// Parameter 'ground_xor' denotes at which XOR-relation participate the two facts.
void find_previous_fact(hash_entry* h, ground_constraint ground_xor, hash_entry** h_prev);


// This function creates a new linked_subgoals object, together with a new 'subgoal' object,
// and makes the subgoal object to point in the 'h' fact (hash_entry).
void assert_subgoal(hash_entry* h, linked_subgoals** subgoals, linked_subgoals** subgoals_head)
{
	if (*subgoals==NULL)
	{
		*subgoals=new linked_subgoals(h);
		*subgoals_head=*subgoals;
	}
	else
	{
		(*subgoals)->next=new linked_subgoals(h);
		*subgoals=(*subgoals)->next;
	}
}

// This function checks whether action achieved_by has preconditions that are member of ground XOR relations
// different than ground_xor. If such a case, the function adds these preconditions as subgoals of type 1,
// and returns true. Parameter 'action_pos' is the position of the action that has the facts as preconditions.
// BE CAREFULL: The action is an inverted action, while the preconditions are the ones of the normal action.
// ATTENTION: There is an 'error' in this function: If the foreign precondition is also a delete effect,
// then instead of the foreign precondition we should add as a subgoal its corresponding add effect.
// This happens in situations where an action changes multiple facts of different XOR relations simultaneously.
// This situation does not arise in logistics-like domains.
bool foreign_preconditions(inverted_action* achieved_by, ground_constraint ground_xor, int action_pos,
						   linked_subgoals** subgoals, linked_subgoals** subgoals_head)
{
	bool found;
	found=false;
	int i;
	for (i=0;i<Normal_Operators[achieved_by->step->operator_id].sof_lists[prec_list];i++)
	if (!constant_predicates[Normal_Operators[achieved_by->step->operator_id].strips[prec_list][i].pred])
	{
	
		fact f;
		f=Normal_Operators[achieved_by->step->operator_id].strips[prec_list][i].instantiate(achieved_by->step->parameters);
		ground_constraint t_ground_xor;
		get_ground_XOR(f, &t_ground_xor);
		if (t_ground_xor.xors!=NULL && t_ground_xor!=ground_xor)
		{
			hash_entry* h;
			h=get_fact_pointer(&f);
			assert_subgoal(h, subgoals, subgoals_head);
			(*subgoals)->subgoalPtr->position=action_pos;
			(*subgoals)->subgoalPtr->subgoal_type=1;	// Precondition fact
			(*subgoals)->subgoalPtr->xor_relation=t_ground_xor;
			(*subgoals)->subgoalPtr->foreign_xor_relation=ground_xor;
			found=true;
		}
	}
	return found;
}


// Function 'find sequences' creates for each pair of XOR-constrained facts, one from
// the initial state and one from the goals, the sequence (in the form of linked_hash_entry list)
// of facts that achieved the initial state fact starting from the goal fact.
// The function creates also the subgoals of the problem.
void find_sequences(pairs_of_facts* pairs, linked_subgoals** subgoals)
{
	linked_subgoals* subgoals_head;

	*subgoals=NULL;
	subgoals_head=NULL;
	pairs_of_facts* t_pairs;
	t_pairs=pairs;
	while (t_pairs!=NULL)
	{
		int action_pos;
		action_pos=0;
		// A test for possible program error...
		if (t_pairs->initial->subproblem_distances->distances->achieved_by==NULL && t_pairs->initial!=t_pairs->goal)
		{
			cout << "ERROR: Initial state fact " << t_pairs->initial->f << " has not been achieved by any inverted action," << endl;
			cout << "while the corresponding goal fact " << t_pairs->goal->f << " is different." << endl;
			abort();
		}
		

		if (t_pairs->initial->subproblem_distances->distances->achieved_by==NULL)
		{
			assert_subgoal(t_pairs->initial, subgoals, &subgoals_head);
			(*subgoals)->subgoalPtr->position=action_pos;
			(*subgoals)->subgoalPtr->subgoal_type=0;	// Initial state fact
			(*subgoals)->subgoalPtr->xor_relation=t_pairs->ground_xor;
			(*subgoals)->subgoalPtr->foreign_xor_relation.xors=NULL;

			assert_subgoal(t_pairs->goal, subgoals, &subgoals_head);
			(*subgoals)->subgoalPtr->position=action_pos+1;
			(*subgoals)->subgoalPtr->subgoal_type=3;	// Goal fact
			(*subgoals)->subgoalPtr->xor_relation=t_pairs->ground_xor;
			(*subgoals)->subgoalPtr->foreign_xor_relation.xors=NULL;
		}
		else if (t_pairs->initial->subproblem_distances->distances->achieved_by!=NULL)
		{
			assert_subgoal(t_pairs->initial, subgoals, &subgoals_head);
			(*subgoals)->subgoalPtr->position=action_pos;
			(*subgoals)->subgoalPtr->subgoal_type=0;	// Initial state fact
			(*subgoals)->subgoalPtr->xor_relation=t_pairs->ground_xor;
			(*subgoals)->subgoalPtr->foreign_xor_relation.xors=NULL;

			if (display_messages)
				cout << endl<< "Sequence of facts" << endl << "==================" << endl;
			t_pairs->sequence=new linked_hash_entry(t_pairs->initial);
			linked_hash_entry* sequence_tail;
			sequence_tail=t_pairs->sequence;		// initially NULL...
			
			hash_entry* h;
			hash_entry* h_prev;
			linked_hash_entry* temp;
			
			h=t_pairs->initial;
			while (h->subproblem_distances->distances->achieved_by!=NULL)
			{
				action_pos++;
				if (display_messages)
					cout << "Fact: " << h->f<< "   Achieved by: " << h->subproblem_distances->distances->achieved_by->step << endl;
//				cout << t_pairs->ground_xor << endl;
				find_previous_fact(h, t_pairs->ground_xor, &h_prev);
				
				if (foreign_preconditions(h->subproblem_distances->distances->achieved_by,t_pairs->ground_xor,action_pos, subgoals, &subgoals_head) 
						|| h_prev->subproblem_distances->distances->achieved_by==NULL)
				{
					assert_subgoal(h_prev, subgoals, &subgoals_head);
					(*subgoals)->subgoalPtr->position=action_pos;
					if (h_prev->subproblem_distances->distances->achieved_by==NULL)
						(*subgoals)->subgoalPtr->subgoal_type=3;	// Goal fact
					else
						(*subgoals)->subgoalPtr->subgoal_type=2;	// Add effect
					(*subgoals)->subgoalPtr->xor_relation=t_pairs->ground_xor;
					(*subgoals)->subgoalPtr->foreign_xor_relation.xors=NULL;
				}

				temp=new linked_hash_entry(h_prev);
				if (sequence_tail==NULL)
				{
					t_pairs->sequence=temp;
					sequence_tail=temp;
				}
				else
				{
					sequence_tail->next=temp;
					sequence_tail=temp;
				}
				if (display_messages)
					cout << h_prev->f << endl;
				h=h_prev;
			}
		}
		t_pairs=t_pairs->next;
	}
	(*subgoals)=subgoals_head;
}

// Function 'find_previous_fact' gets as input a XOR-constrained fact h
// and returns its previous fact h_prev, which is XOR constrained with h
// and has been deleted by the action that achieved h.
// Parameter 'ground_xor' denotes at which XOR-relation participate the two facts.
void find_previous_fact(hash_entry* h, ground_constraint ground_xor, hash_entry** h_prev)
{
	action* step=h->subproblem_distances->distances->achieved_by->step;
	int i=0;
	bool found=false;
	while (i<Operators[step->operator_id].sof_lists[prec_list] && !found)
	{
		ground_constraint t_ground_xor;
		fact f=Operators[step->operator_id].strips[prec_list][i].instantiate(step->parameters);
//		cout << "Check fact: " << f << endl;
		//get_ground_XOR(Operators[step->operator_id].strips[prec_list][i].instantiate(step->parameters),&t_ground_xor);
		get_ground_XOR(f,&t_ground_xor);
//		cout << t_ground_xor<< endl;
		if (t_ground_xor.xors!=NULL && ground_xor==t_ground_xor)
		{
			found=true;
			*h_prev=get_fact_pointer(&Operators[step->operator_id].strips[prec_list][i].instantiate(step->parameters));
		}
		else
			i++;
	}
	
	if (!found)
	{
		cout << "ERROR 383482394149193023" << endl;
		abort();
	}
}

// This "test" function displays the inverted actions that achieved the initial state facts.
void test()
{
	cout << endl;
	cout << "ACTIONS THAT ACHIEVED THE INITIAL STATE FACTS" << endl;
	cout << "=============================================" << endl;
	int i;
	for(i=0;i<initial->size;i++)
	{
		hash_entry* h;
		h=get_fact_pointer(&initial->facts[i]);
		cout << "Fact: " << initial->facts[i] << endl;
		if (h->subproblem_distances->distances->achieved_by!=NULL)
			cout << "  Achieved by: " << h->subproblem_distances->distances->achieved_by->step << endl;
		else
			cout << endl;	// Some initial state facts are included in the
							// enriched goal state, so they have not been
							// achieved by any action.
	}
}


class subgoal_ordering
{
public:
	subgoal* before;
	subgoal* after;
	subgoal_ordering* next;

	subgoal_ordering()
	{
		before=NULL;
		after=NULL;
		next=NULL;
	}
	subgoal_ordering(subgoal_ordering* n)
	{
		before=NULL;
		after=NULL;
		next=n;
	}
};



int subgoal_can_be_included(linked_subgoals* current_subgoal, int level, linked_subgoals* subgoals, subgoal_ordering* orderings)
{
	// If the subgoal has already been assigned a level, then return false;
	if (current_subgoal->subgoalPtr->level>=0)
		return 0;
	// If the subgoal is of type 1, i.e. it is a precondition, then return false;
	if (current_subgoal->subgoalPtr->subgoal_type==1)
		return 0;

	
	// if the subgoal is ordered after another subgoal, that is not yet assigned a level
	// then return false
	bool flag1_order=true;
	while (orderings!=NULL && flag1_order)
	{
		if (orderings->after==current_subgoal->subgoalPtr)
		{
			linked_subgoals* ord_subgoals=subgoals;
			while (ord_subgoals!=NULL && flag1_order)
			{
				if (ord_subgoals->subgoalPtr==orderings->before
					&& ord_subgoals->subgoalPtr->level==-1)
					flag1_order=false;
				ord_subgoals=ord_subgoals->next;
			}
		}
		orderings=orderings->next;
	}

	if (!flag1_order)
		return false;

	int subgoals_added=0;
	bool flag=true;
	linked_subgoals* t_subgoal;
	t_subgoal=subgoals;
	while (t_subgoal!=NULL && flag)
	{
		// if there is already a subgoal of the same XOR relation at the current level...
		if (t_subgoal!=current_subgoal)
			if (t_subgoal->subgoalPtr->level==level)
				if (t_subgoal->subgoalPtr->xor_relation==current_subgoal->subgoalPtr->xor_relation)
					flag=false;
		// if there is an un-assigned-level subgoal of the same XOR relation in a previous position...
		if (t_subgoal!=current_subgoal)
			if (t_subgoal->subgoalPtr->level==-1)
				if (t_subgoal->subgoalPtr->subgoal_type!=1)
					if (t_subgoal->subgoalPtr->xor_relation==current_subgoal->subgoalPtr->xor_relation)
						if (t_subgoal->subgoalPtr->position<current_subgoal->subgoalPtr->position)
							flag=false;
		// if there is an un-assigned-level subgoal of the same XOR-relation of type=1.
		if (t_subgoal!=current_subgoal)
			if (t_subgoal->subgoalPtr->level==-1)
				if (t_subgoal->subgoalPtr->subgoal_type==1)
					if (t_subgoal->subgoalPtr->xor_relation==current_subgoal->subgoalPtr->xor_relation)
						flag=false;
		// check for foreign subgoals of type 1, for which other subgoals of the same foreign XOR relation
		// have already been assigned the current level...
		linked_subgoals* tt_subgoal;
		tt_subgoal=subgoals;
		while (tt_subgoal!=NULL && flag)
		{
			if (tt_subgoal!=current_subgoal)
				if (tt_subgoal->subgoalPtr->subgoal_type==1)
					if (tt_subgoal->subgoalPtr->position==current_subgoal->subgoalPtr->position)
						if (tt_subgoal->subgoalPtr->foreign_xor_relation==current_subgoal->subgoalPtr->xor_relation)
						// In this point there has been found a foreign XOR subgoal of the current subgoal.
						// It must be cheched that other subgoals of the foreign subgoal XOR-relation
						// have not already been assigned the current level...
						{
							linked_subgoals* ttt_subgoal;
							ttt_subgoal=subgoals;
							while (ttt_subgoal!=NULL && flag)
							{
								if (ttt_subgoal!=tt_subgoal)
									if (ttt_subgoal->subgoalPtr->level==level)
										if (ttt_subgoal->subgoalPtr->xor_relation==tt_subgoal->subgoalPtr->xor_relation)
											flag=false;
								ttt_subgoal=ttt_subgoal->next;
							}
						}
			tt_subgoal=tt_subgoal->next;
		}
		t_subgoal=t_subgoal->next;
	}

	if (flag)
	{
		current_subgoal->subgoalPtr->level=level;
		subgoals_added=1;
		// find other subgoals that are preconditions to actions adding
		// the current subgoal...
		t_subgoal=subgoals;
		while (t_subgoal!=NULL)
		{
			if (t_subgoal!=current_subgoal)
				if (t_subgoal->subgoalPtr->subgoal_type==1)
					if (t_subgoal->subgoalPtr->level==-1)
						if (t_subgoal->subgoalPtr->foreign_xor_relation==current_subgoal->subgoalPtr->xor_relation)
							if(t_subgoal->subgoalPtr->position==current_subgoal->subgoalPtr->position)
							{
								t_subgoal->subgoalPtr->level=level;
								subgoals_added++;
							}
			t_subgoal=t_subgoal->next;
		}
	}
	return subgoals_added;
}


// This function assigns all the subgoals a level, i.e. an intemediate state
// in which they belong...
void assign_levels(int* nof_subproblems, linked_subgoals* subgoals, subgoal_ordering* orderings)
{
	int level=0;
	linked_subgoals* t_subgoal;
	t_subgoal=subgoals;
	// count how many subgoals there are...
	int nof_subgoals=0;
	while (t_subgoal!=NULL)
	{
		nof_subgoals++;
		t_subgoal=t_subgoal->next;
	}

	// The main loop. At each iteration one subgoal must be assigned the current level, 
	// or the level have been increased by one...

	bool found_at_level=false;	// this flag indicates if at least one subgoal
								// has been added to the current level.
	while (nof_subgoals>0)
	{
		t_subgoal=subgoals;
		bool found=false;	// This flag indicates if another subgoal has been
							// added to the current level.
		while (!found && t_subgoal!=NULL)
		{
			int subgoals_added;
			subgoals_added=subgoal_can_be_included(t_subgoal,level,subgoals,orderings);
			if (subgoals_added>0)
			{
				found=true;
				found_at_level=true;
//				t_subgoal->subgoalPtr->level=level;
				nof_subgoals-=subgoals_added;
			}
			else
				t_subgoal=t_subgoal->next;
		}
		// If there is not other subgoal to be included in the current level...
		if (!found)
		{
			if (!found_at_level)
			{
				cout << "CRITICAL ERROR: No subgoal can be included in level " << level <<". ";
				cout << "Problem decomposition process aborted..." << endl;
				abort();
			}
			if (nof_subgoals>0) 
			{
				found_at_level=false;
				level=level+1;
			}
		}
	}
	*nof_subproblems=level;
}

// This function creates a linked list of states, each one of them is a subproblem
// to be solved. The first state is the initial state and the last state is
// the original goal state.
void create_subproblems(int nof_subproblems, linked_subgoals* subgoals, linked_states** subproblems)
{
	*subproblems=NULL;
	linked_states* subproblems_head=NULL;
	int i=0;
	while (i<=nof_subproblems)
	{
		if (*subproblems==NULL)
		{
			*subproblems=new linked_states();
			subproblems_head=*subproblems;
		}
		else
		{
			(*subproblems)->next=new linked_states();
			*subproblems=(*subproblems)->next;
		}
		(*subproblems)->s=new state();
		(*subproblems)->s->nullify();
		(*subproblems)->id=i;

		linked_subgoals* t_subgoal;
		t_subgoal=subgoals;
		while (t_subgoal!=NULL)
		{
			if (t_subgoal->subgoalPtr->level==i || 
				(t_subgoal->subgoalPtr->level<=i && t_subgoal->subgoalPtr->subgoal_type==3))
				(*subproblems)->s->add_fact(t_subgoal->subgoalPtr->h->f);
			t_subgoal=t_subgoal->next;
		}
		i++;
	}
	*subproblems=subproblems_head;
}

// This function adds a sub-problem level to the hash_entry h.
void add_GRG_level(hash_entry* h)
{
	if (h->achieved)
	{
		int i=0;
		bool enabled=true;
		while (i<predicates[h->f.pred].arity && enabled)
		{
			if (objects[h->f.arguments[i]].idle->value)
				enabled=false;
			else
				i++;
		}
		if (enabled)
		{
			if (h->achieved)
				 nof_enabled_facts++;
		}

		h->subproblem_distances=new linked_linked_distances(h->subproblem_distances);
		h->linked_enriched=new linked_bool(h->linked_enriched);
		h->linked_used=new linked_bool(h->linked_used);
		h->goal_fact_used=false;
	}
}

// This function deletes a sub-problem level from the hash_entry h.
void delete_GRG_level(hash_entry* h)
{
	if (h->achieved)
	{
		if (h->subproblem_distances!=NULL)
		{ 
			linked_linked_distances* p;
			p=h->subproblem_distances;
			h->subproblem_distances=h->subproblem_distances->next;

			// ATTENTION: HERE THERE IS A WARNING. OBJECT 'LINKED_DISTANCE' CONTAINS
			// POINTERS TO OTHER OBJECTS THAT SHOULD ALSO BE DELETED. A DESTRUCTOR
			// OF THE OBJECT SHOULD BE WRITTEN...
			delete p;
		}
		else
		{
			cout << "ERROR 383748204820403920" << endl;
			abort();
		}
	
		if (h->linked_enriched!=NULL)
		{
			linked_bool* p;
			p=h->linked_enriched;
			h->linked_enriched=h->linked_enriched->next;
			delete p;
		}
		else
		{
			cout << "ERROR 74846284027492493" << endl;
			abort();
		}

		if (h->linked_used!=NULL)
		{
			linked_bool* p;
			p=h->linked_used;
			h->linked_used=h->linked_used->next;
			delete p;
		}
		else
		{
			cout << "ERROR 74846284027492493" << endl;
			abort();
		}
	}
}

state get_subproblem_state(linked_states* subproblems, int counter)
{
	if (counter<0)
	{
		cout << "ERROR 8374894728240427" << endl;
		abort();
	}

	if (subproblems==NULL)
	{
		cout << "ERROR 83747294782954849" << endl;
		abort();
	}
	
	
	while (counter>0)
	{
		if (subproblems->next==NULL)
		{
			cout << "ERROR 746582027456394639357" << endl;
			abort();
		}
		subproblems=subproblems->next;
		counter--;
	}

	return *subproblems->s;
}


void set_subproblem_state(linked_states* subproblems, int counter, state* final_state)
{
	if (counter<0)
	{
		cout << "ERROR 8464739437239248" << endl;
		abort();
	}

	if (subproblems==NULL)
	{
		cout << "ERROR 5382673937349020429" << endl;
		abort();
	}
	
	
	while (counter>0)
	{
		if (subproblems->next==NULL)
		{
			cout << "ERROR 028345437392629537" << endl;
			abort();
		}
		subproblems=subproblems->next;
		counter--;
	}

	*subproblems->s=*final_state;
}


// This function completes the state of the last subproblem 
// with the missing facts of the original goal state...
void complete_last_subproblem(int nof_subproblems, linked_states* subproblems)
{
	if (subproblems==NULL)
	{
		cout << "ERROR 948563785628247" << endl;
		abort();
	}

	int i;
	for(i=0;i<nof_subproblems;i++)
	{
		if (subproblems->next==NULL)
		{
			cout << "ERROR 735274923745373927" << endl;
			abort();
		}
		subproblems=subproblems->next;
	}

	if (subproblems->next!=NULL)
	{
		cout << "ERROR 484738945037853350" << endl;
		abort();
	}

	for (i=0;i<goal->size;i++)
		if (!subproblems->s->included(goal->facts[i]))
			subproblems->s->add_fact(goal->facts[i]);
}




void display_orderings(subgoal_ordering* orderings)
{
	while (orderings!=NULL)
	{
		cout << endl;
		cout << "BEFORE: " << orderings->before->h->f << endl;
		cout << "AFTER: " << orderings->after->h->f << endl;

		orderings=orderings->next;
	}
	cout << endl;
}

// This function eliminates a subgoal of type 1, iff:
// a) there are not subgoals of type 2 of the same fact.
// b) there is a subgoal of type 3 of this fact.
// ATTENTION: If there is a subgoal of type 3, it is sure that there is not
// a subgoal of type 2 for the same fact, nor of type 0. So it is not needed to search for
// the not existense of subgoals of type 2 of the eliminated fact...

// In this case the subgoal of type 2 or type 3 which has the precondition of type 1
// cannot be achieved before the subgoal of type 3 of the eliminated fact...
void eliminate_redundant_subgoals(linked_subgoals** subgoals, subgoal_ordering** orderings)
{
	linked_subgoals* t1_subgoals=*subgoals;
	linked_subgoals* t1_prev=NULL;
	while (t1_subgoals!=NULL)
	{
		if (t1_subgoals->subgoalPtr->subgoal_type!=1)
		{
			t1_prev=t1_subgoals;
			t1_subgoals=t1_subgoals->next;
		}
		else
		{
			linked_subgoals* t2_subgoals=*subgoals;
			bool found=false;
			while (t2_subgoals!=NULL && !found)
			{
				if (t2_subgoals->subgoalPtr->subgoal_type!=3)
					t2_subgoals=t2_subgoals->next;
				else
				{
					if (t2_subgoals->subgoalPtr->h==t1_subgoals->subgoalPtr->h)
					{
						found=true;
						//cout << endl << t1_subgoals->subgoalPtr->h-> f << endl;
						//cout << t2_subgoals->subgoalPtr->h-> f << endl;

						linked_subgoals* t3_subgoals=*subgoals;
						bool found2=false;
						while (t3_subgoals!=NULL &&!found2)
						{
							if ( (t3_subgoals->subgoalPtr->subgoal_type==2 || t3_subgoals->subgoalPtr->subgoal_type==3)
								&& t3_subgoals->subgoalPtr->position==t1_subgoals->subgoalPtr->position
								&& t3_subgoals->subgoalPtr->xor_relation==t1_subgoals->subgoalPtr->foreign_xor_relation
								)
							{
								found2=true;
								*orderings=new subgoal_ordering(*orderings);
								(*orderings)->before=t2_subgoals->subgoalPtr;
								(*orderings)->after=t3_subgoals->subgoalPtr;
							}
							else
								t3_subgoals=t3_subgoals->next;
						}

						if (t1_prev!=NULL)
						{
							t1_prev->next=t1_subgoals->next;
							delete t1_subgoals;
							t1_subgoals=t1_prev->next;
						}
						else
						{
							*subgoals=(*subgoals)->next;
							delete t1_subgoals;
							t1_subgoals=*subgoals;
						}
					}
					else
						t2_subgoals=t2_subgoals->next;
				}
			}
			if (!found)
			{
				t1_prev=t1_subgoals;
				t1_subgoals=t1_subgoals->next;
			}
		}
	}
}

// this function removes a subgoals of type 2, which has as precondition sub1
void remove_type2_subgoal(linked_subgoals* sub1, linked_subgoals** subgoals)
{
	// cout << sub1->subgoalPtr->h->f << endl;
	linked_subgoals* sub2=*subgoals;
	linked_subgoals* sub2_prev=NULL;
	bool found2=false;
	while (sub2!=NULL && !found2)
	{
		if (sub2->subgoalPtr->subgoal_type==2 &&
			sub2->subgoalPtr->position==sub1->subgoalPtr->position &&
			sub2->subgoalPtr->xor_relation==sub1->subgoalPtr->foreign_xor_relation)
		{
			found2=true;
			// cout << sub2->subgoalPtr->h->f << endl;
			linked_subgoals* sub3=*subgoals;
			bool found3=false;
			while (sub3!=NULL && !found3)
			{
				if (sub3->subgoalPtr->subgoal_type==1 &&
					sub3!=sub1 &&
					sub3->subgoalPtr->position==sub2->subgoalPtr->position &&
					sub3->subgoalPtr->foreign_xor_relation==sub2->subgoalPtr->xor_relation)
				{
					// cout << sub3->subgoalPtr->h->f << endl;
					if (!initial->included(sub3->subgoalPtr->h->f))
						found3=true;
					else
						sub3=sub3->next;
				}
				else
					sub3=sub3->next;
			}

			if (!found3)
			{
				if (sub2_prev==NULL)
				{
					*subgoals=(*subgoals)->next;
					delete sub2;
					sub2=NULL;
				}
				else
				{
					sub2_prev->next=sub2->next;
					delete sub2;
					sub2=NULL;
				}
			}
		}
		else
		{
			sub2_prev=sub2;
			sub2=sub2->next;
		}
	}
}


// This function eliminates subgoals of type 1, which are members of the
// current initial state and for which there is no other subgoal 
// of the same ground_XOR_constraint... (and of typer 1???)
// For each one of these subgoals, it eliminates the corresponding 
// subgoals of type 2, if they do not have any other subgoal of type 1 demanding...
void eliminate_redundant_subgoals2(linked_subgoals** subgoals, subgoal_ordering** orderings)
{
	linked_subgoals* t1_subgoals=*subgoals;
	linked_subgoals* t1_prev=NULL;
	while (t1_subgoals!=NULL)
	{
		if (t1_subgoals->subgoalPtr->subgoal_type!=1)
		{
			t1_prev=t1_subgoals;
			t1_subgoals=t1_subgoals->next;
		}
		else
		{
			if (initial->included(t1_subgoals->subgoalPtr->h->f))
			{
				linked_subgoals* t2_subgoals=*subgoals;
				bool flag1=true;
				while (t2_subgoals!=NULL && flag1)
				{
					if (t2_subgoals->subgoalPtr!=t1_subgoals->subgoalPtr 
						&& t2_subgoals->subgoalPtr->xor_relation==t1_subgoals->subgoalPtr->xor_relation
						&& t2_subgoals->subgoalPtr->h!=t1_subgoals->subgoalPtr->h
						&& t2_subgoals->subgoalPtr->subgoal_type==1)
					flag1=false;
					else
						t2_subgoals=t2_subgoals->next;
				}

				if (flag1)
				{
					remove_type2_subgoal(t1_subgoals, subgoals);
					if (t1_prev!=NULL)
					{
						t1_prev->next=t1_subgoals->next;
						delete t1_subgoals;
						t1_subgoals=t1_prev->next;
					}
					else
					{
						*subgoals=(*subgoals)->next;
						delete t1_subgoals;
						t1_subgoals=*subgoals;
					}
				}
				else
				{
					t1_prev=t1_subgoals;
					t1_subgoals=t1_subgoals->next;
				}
			}
			else
			{
				t1_prev=t1_subgoals;
				t1_subgoals=t1_subgoals->next;
			}
		}
	}
}

void add_subproblem_level(int counter)
{
	level* t_level=subproblem_level;
	if (t_level==NULL)
	{
		t_level=new level();
		subproblem_level=t_level;
	}
	else
	{
		while (t_level->next!=NULL)
			t_level=t_level->next;
		t_level->next=new level();
		t_level=t_level->next;
	}
	t_level->l=counter;
}

void remove_subproblem_level()
{
	level* t_level=subproblem_level;
	if (t_level==NULL)
	{
		cout << "ERROR 39347234914012812120" << endl;
		abort();
	}

	if (t_level->next==NULL)
	{
		delete t_level;
		subproblem_level=NULL;
	}
	else
	{
		while (t_level->next->next!=NULL)
			t_level=t_level->next;

		delete t_level->next;
		t_level->next=NULL;
	}
}


void display_current_subproblem_level()
{
	level* t_level=subproblem_level;
	while (t_level!=NULL)
	{
		cout << t_level->l ;
		if (t_level->next!=NULL)
			cout << ":" ;
		t_level=t_level->next;
	}
}

extern int bfs_solve(state*);
extern int hill_climbing(state*);

void xor_routines(state* final_state)
{
	subgoal_ordering* orderings=NULL;

	int nof_subproblems;
	linked_states* subproblems;
	pairs_of_facts* pairs;
	linked_subgoals* subgoals;

	if (display_messages)
		display_xor_relations();
	
	Operators=Inv_Operators;
	if (display_messages)
		test();
//	Operators=Normal_Operators;
//	find_all_xor_relations();
	find_pairs(&pairs);
	if (display_messages)
		display_pairs(pairs);
//	Operators=Inv_Operators;	
	
	find_sequences(pairs, &subgoals);
	eliminate_redundant_subgoals(&subgoals, &orderings);
	eliminate_redundant_subgoals2(&subgoals, &orderings);

	if (display_messages)
		display_orderings(orderings);

	Operators=Normal_Operators;
	if (display_messages)
		display_sequences(pairs);
	if (display_messages)
		display_subgoals(subgoals);

	assign_levels(&nof_subproblems, subgoals, orderings);
	if (display_messages)
		print_leveled_subgoals(nof_subproblems,subgoals);

	if (nof_subproblems>1 && xor_routines_flag)
	{
		if (subproblem_level==NULL)
			cout << endl << "MAIN PROBLEM HAS BEEN ANALYSED INTO " << nof_subproblems << " SUBPROBLEMS..." << endl ;
		else
		{
			cout << endl << "SUBPROBLEM ";
			display_current_subproblem_level();
			cout << " HAS BEEN ANALYSED INTO " << nof_subproblems << " SUBPROBLEMS..." << endl;
		}

		create_subproblems(nof_subproblems, subgoals, &subproblems);
		// Copying the complete initial state as the initial state 
		// of the first subproblem
		*subproblems->s=*initial;
		// Complete the state of the last subproblem with the missing facts
		// of the original goal state...
		complete_last_subproblem(nof_subproblems, subproblems);

		if (display_messages)
			print_subproblems(subproblems);
		//state final_state;
		int counter;
		for(counter=1;counter<=nof_subproblems;counter++)
		{
			*initial=get_subproblem_state(subproblems,counter-1);
			*goal=get_subproblem_state(subproblems,counter);
			add_subproblem_level(counter);
			solve_subproblems(final_state);
			remove_subproblem_level();
			if (display_messages)
				cout << "Final state: " << *final_state << endl;
			set_subproblem_state(subproblems,counter,final_state);
		}
		//initial=*final_state;
		//goal=get_subproblem_state(subproblems, counter);
		//if (display_messages)
		//{
		//	cout << endl << "Initial: " << initial << endl;
		//	cout << endl << "Goal: " << goal << endl;
		//}
	}
	else
	{
		linked_subgoals* t_subgoals=subgoals;
		bool more_subgoals_found=false;
		if (xor_routines_flag)
		while (t_subgoals!=NULL )
		{
			if (t_subgoals->subgoalPtr->level==1)
				if (!goal->included(t_subgoals->subgoalPtr->h->f))
				{
					 more_subgoals_found=true;
//					 cout << t_subgoals->subgoalPtr->h->f << endl;
					goal->add_fact(t_subgoals->subgoalPtr->h->f);
				}
			t_subgoals=t_subgoals->next;
		}

		if (more_subgoals_found)
		{
			//xor_routines_flag=false;
			solve_subproblems(final_state);
			//xor_routines_flag=true;
		}
		else
		{
			search_routines(final_state);
		}
	}

}

// This function checks whether an object appears 
// The function works also with variables, i.e. negative object numbers...
bool object_in_fact(int obj, fact* f, int* pos)
{
	if (obj==0)
	{
		cout << "894749402823403832403429" << endl;
		abort();
	}

	int i=0;
	bool found=false;
	while (i<predicates[f->pred].arity && !found)
		if (obj==f->arguments[i])
			found=true;
		else
			i++;
	*pos=i;
	return found;
}

// This function checks whether object 'obj' can potential match with the parameter 'param'
// of operator 'oper_id'.
bool can_match(int obj, int oper_id, int param)
{
	int i=0;
	bool flag=true;
	while (i<Operators[oper_id].sof_lists[prec_list] && flag)
	{
		// if the precondition is a constant fact...
		if (constant_predicates[Operators[oper_id].strips[prec_list][i].pred])
			// if the precondition contains the current parameter...
		{
//			cout << "object: " << objects[obj].name << endl;
//			cout << "fact: " << Operators[oper_id].strips[prec_list][i] << endl;
			int pos;
			if (object_in_fact(-param-1, &Operators[oper_id].strips[prec_list][i], &pos))
			{
				flag=false;
				int j=0;
				// for every static fact of the initial state
				while (j<nof_constants && !flag)
				{
//					cout << "constant: " << constants[j] << endl;
					if (constants[j].instantiable(Operators[oper_id].strips[prec_list][i]))
						if (constants[j].arguments[pos]==obj)
							flag=true;
					j++;
				}
			}
		}
		i++;
	}
	return flag;
}


// This function checks whether operator 'oper_id' has effects irrelevant to the parameter 'param'.
bool foreign_effects(int oper_id, int param)
{
	bool flag=false;
	int i=0;

	// check first the delete effects
	while (i<Operators[oper_id].sof_lists[delete_list] && !flag)
	{
		flag=true;
		int j=0;
		while (j<predicates[Operators[oper_id].strips[delete_list][i].pred].arity && flag)
		{
			if (Operators[oper_id].strips[delete_list][j].arguments[j]==-param-1)
				flag=false;
			j++;
		}
		i++;
	}

	// check then the add effects
	i=0;
	while (i<Operators[oper_id].sof_lists[add_list] && !flag)
	{
		flag=true;
		int j=0;
		while (j<predicates[Operators[oper_id].strips[add_list][i].pred].arity && flag)
		{
			if (Operators[oper_id].strips[add_list][j].arguments[j]==-param-1)
				flag=false;
			j++;
		}
		i++;
	}
	return flag;
}


// This function checks whether operator 'oper_id' has effects irrelevant to the object obj.
bool foreign2_effects(int oper_id, int obj)
{
	bool flag=false;
	int i=0;

//	cout << Operators[oper_id] << endl;

	// check first the delete effects
	while (i<Operators[oper_id].sof_lists[delete_list] && !flag)
	{
//		cout << Operators[oper_id].strips[delete_list][i] << endl;
		flag=true;
		int j=0;
		while (j<predicates[Operators[oper_id].strips[delete_list][i].pred].arity && flag)
		{
			if (Operators[oper_id].strips[delete_list][i].arguments[j]==obj)
				flag=false;
			j++;
		}
		i++;
	}

	// check then the add effects
	i=0;
	while (i<Operators[oper_id].sof_lists[add_list] && !flag)
	{
//		cout << Operators[oper_id].strips[add_list][i] << endl;
		flag=true;
		int j=0;
		while (j<predicates[Operators[oper_id].strips[add_list][i].pred].arity && flag)
		{
			if (Operators[oper_id].strips[add_list][i].arguments[j]==obj)
				flag=false;
			j++;
		}
		i++;
	}
	return flag;
}


// This function checks whether object obj appears grounded in a list 
// of the operator oper_id...
bool grounded_parameter(int obj, int oper_id)
{
	bool found=false;
	int i;
	i=0;
	while (i<Operators[oper_id].sof_lists[prec_list] && !found)
	{
		//cout << Operators[oper_id].strips[prec_list][i] << endl;
		int j=0;
		while (j<predicates[Operators[oper_id].strips[prec_list][i].pred].arity && !found)
		{
			if (Operators[oper_id].strips[prec_list][i].arguments[j]==obj)
				found=true;
			j++;
		}
		i++;
	}

	i=0;
	while (i<Operators[oper_id].sof_lists[delete_list] && !found)
	{
		//cout << Operators[oper_id].strips[delete_list][i] << endl;
		int j=0;
		while (j<predicates[Operators[oper_id].strips[delete_list][i].pred].arity && !found)
		{
			if (Operators[oper_id].strips[delete_list][i].arguments[j]==obj)
				found=true;
			j++;
		}
		i++;
	}

	i=0;
	while (i<Operators[oper_id].sof_lists[add_list] && !found)
	{
		//cout << Operators[oper_id].strips[add_list][i] << endl;
		int j=0;
		while (j<predicates[Operators[oper_id].strips[add_list][i].pred].arity && !found)
		{
			if (Operators[oper_id].strips[add_list][i].arguments[j]==obj)
				found=true;
			j++;
		}
		i++;
	}
	return found;
}


// This function checks whether object 'obj' can potentially be a parameter
// of operator 'oper_id' and if so, the function checks if there are facts irelevant to the object
// that are deleted or added by the operator...
bool parameter_with_foreign_effect(int obj, int oper_id)
{
	Operator* T_Operators;
	T_Operators=Operators;
	Operators=Normal_Operators;
//	cout << Operators[oper_id] << endl;
	
	// check whether the fact can be 
	int param=0;
	bool flag=false;
	// For every parameter...
	while (param<Operators[oper_id].nof_parameters && !flag)
	// if the object can match with the parameter
	{
		if (can_match(obj,oper_id,param))
			// if there are effects irrelevant to the parameter
			if (foreign_effects(oper_id,param))
				flag=true;
		param++;
	}
	
	// Check if the objects appears in some of the lists, prec, delete or add
	if (grounded_parameter(obj, oper_id) && !flag)
	{
		if (foreign2_effects(oper_id, obj))
			flag=true;
	}

	Operators=T_Operators;
	return flag;
}

// This function checks whether an object can be ommitted...
bool idle_object(int obj, state* s)
{
	// First check whether the object appears in the goals and if so, 
	// whether these facts appear identical in the initial state.
	int i=0;
	bool flag=true;
	while (i<goal->size && flag)
	{
		int pos;
		if (object_in_fact(obj, &goal->facts[i], &pos))
			if (!s->included(goal->facts[i]))
				flag=false;
		i++;
	}

	// Then check whether there are actions that can have this object as a parameter,
	// which add or delete facts not containing the object...
	// ATTENTION: THIS IS A WEAK AND NOT-CORRECT CONDITION FOR IDLE OBJECTS...
	// A BETTER CONDITION WOULD BE SEARCHING ONLY FOR XOR-CONSTRAINED OBJECTS THAT 
	// DO NOT APPEAR AS PRECONDITIONS IN OPERATORS CONCERNING OTHER XOR-RELATIONS OR NON-XOR-RELATED FACTS...
	int oper=0;
	while (oper<nof_operators && flag)
	{
		if (parameter_with_foreign_effect(obj, oper))
			flag=false;
		else
			oper++;
	}

	return flag;
}



// The main loop in order to look for idle objects...
void detect_idle_objects()
{
//	display_messages=true;
	if (display_messages)
	{
		cout << endl;
		cout << "DETECTING IDLE OBJECTS" << endl;
		cout << "======================" << endl;
	}
	int obj;
	for (obj=1;obj<=nof_objects;obj++)
	{
		if (idle_object(obj,initial))
		{
			objects[obj].idle->value=true;
			if (display_messages)
			{
				cout << objects[obj].name << "..." << "IDLE"<< endl;
				cout << endl;
			}
		}
		else
			if (display_messages)
				cout << "OK"<< endl;
	}
}


void add_idle_level()
{
	int i;
	for (i=1;i<=nof_objects;i++)
	{
		objects[i].idle=new linked_bool(objects[i].idle);
		objects[i].idle->value=false;
	}
}

void delete_idle_level()
{
	int i;
	for (i=1;i<=nof_objects;i++)
	{
		if (objects[i].idle==NULL)
		{
			cout << "ERROR 38347390273940272302" << endl;
			abort();
		}

		linked_bool* t_bool;
		t_bool=objects[i].idle->next;
		delete objects[i].idle;
		objects[i].idle=t_bool;
	}
}