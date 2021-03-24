#include "planner.h"

long state_grade(state* s, state* old_state, linked_linked_distances** end_facts, int past_length);

// pointers to agenda hash table
agenda* BFS_AgendaHead[10*agenda_hash_size+2];
agenda* BFS_AgendaTail[10*agenda_hash_size+2];

int	best_agenda;

long length_times=0;
long length_d_estimated=0;

int hash_value(state* s);
bool remember_state(int value, node* nd, state_hash_entry** states_hash_table);
bool state_exists(int value, state* s, state_hash_entry** states_hash_table);
void unconditional_remember_state(int value, node* nd, state_hash_entry** states_hash_table);

// This function appends the new sub-plan to the end of the global plan.
void append_plan(action** solution, action* plan)
{
	action* solution_tail;
	solution_tail=*solution;
	if (solution_tail!=NULL)
		while (solution_tail->next!=NULL)
			solution_tail=solution_tail->next;

	while (plan!=NULL) 
	{
		if (solution_tail==NULL)
		{
			solution_tail=new action(plan->operator_id, plan->parameters);
			*solution=solution_tail;
		}
		else
		{
			solution_tail->next=new action(plan->operator_id, plan->parameters);
			solution_tail=solution_tail->next;
		}
		plan=plan->next;
	}
}

// This function checks whether the initial state violates or not the hard constraints posed
// by the criteria scales.
bool check_initial()
{
	int i;
	for(i=0;i<nof_criteria;i++)
	{
		if (criteria[i].bounded_from==true)
			if (initial->state_vector->elements[i+1]<criteria[i].from)
			{
				cout << "The initial state violates the criteria hard constraints," << endl;
				cout << "with respect to criterion " << objects[criteria[i].object_ID].name << "." << endl;
				return false;
			}
		if (criteria[i].bounded_to==true)
			if (initial->state_vector->elements[i+1]>criteria[i].to)
			{
				cout << "The initial state violates the criteria hard constraints," << endl;
				cout << "with respect to criterion " << objects[criteria[i].object_ID].name << "." << endl;
				return false;
			}
	}
	return true;
}

void calibrate_criteria(node* best_node);

int bfs_solve(state* final_state)
{
	
	// initialize agenda's hash table
	if (*goal<=initial)
	{
		cout << "GOAL STATE IS A SUBSET OF THE INITIAL STATE" << endl;
		*final_state=*initial;
		return 0;
	}

	if (!check_initial())
		return 0;

	state_hash_entry** states_hash_table=new state_hash_entry*[CLOSE_LIST_HASH_SIZE];
	int i;
	for(i=0;i<CLOSE_LIST_HASH_SIZE;i++)
		states_hash_table[i]=NULL;

	for (i=0;i<10*agenda_hash_size+2;i++)
	{
		BFS_AgendaHead[i]=NULL;
		BFS_AgendaTail[i]=NULL;
	}
	best_agenda=10*agenda_hash_size+2;
	
	// create initial nodes and add the corresponging pointers to the agenda
	agenda* agenda_ptr;
	node* node_ptr;

	linked_linked_distances* dummy=NULL;
	node_ptr=new node();
	node_ptr->s=new state();
	node_ptr->s=initial;
	node_ptr->previous=NULL;
	long score=agenda_hash_size+state_grade(initial, NULL, &dummy, 0);

	if (score<0) {
		cout << "State score is less than zero!" << endl;
		cout << "You have to justify the agenda hash size." << endl;
		cout << "The program will be terminated." << endl;
		abort();
	}

	if (score>10*agenda_hash_size)
		score=10*agenda_hash_size;

	int value;
	if (score<=10*agenda_hash_size)
	{
		value=hash_value(initial);
		remember_state(value, node_ptr, states_hash_table);
		agenda_ptr=new agenda(node_ptr, score);
		if (score>=0 && score<=10*agenda_hash_size)
		{
			if (BFS_AgendaHead[score]==NULL)
			{
				BFS_AgendaHead[score]=agenda_ptr;
				BFS_AgendaTail[score]=agenda_ptr;
			}
			else
			{
				BFS_AgendaTail[score]->next=agenda_ptr;
				BFS_AgendaTail[score]=agenda_ptr;
			}
			if (score<best_agenda)
				best_agenda=score;
		}	// if score>=0 && ...
	}
	
	action* appl_actions;
	clock_t t1;
	clock_t t2;
	t1=clock();
	while (best_agenda<=10*agenda_hash_size)
	{
		check_time();
		node* best_node=BFS_AgendaHead[best_agenda]->nd;
		
//		calibrate_criteria(best_node);
		
/*
		cout << "STATE: " << *best_node->s ;
		if (best_node->previous!=NULL)
			cout << "    achieved by " << best_node->step << endl;
		else
			cout << endl;
*/
		if (display_messages || display_short_messages)
		{
			int value=hash_value(best_node->s);
			cout << best_agenda << " : " << value << endl;
		}
		agenda* new_head_agenda=BFS_AgendaHead[best_agenda]->next;
		delete BFS_AgendaHead[best_agenda];
		BFS_AgendaHead[best_agenda]=new_head_agenda;
		if (new_head_agenda==NULL)
		{
			BFS_AgendaTail[best_agenda]=NULL;
			bool flag=true;
			best_agenda++;
			while (flag && best_agenda<=10*agenda_hash_size)
				if (BFS_AgendaHead[best_agenda]!=NULL)
					flag=false;
				else
					best_agenda++;
		}
		
		int value=hash_value(best_node->s);
		//	cout << ++counter << ":" << head_agenda->nd->step <<endl;
		if (*goal<=best_node->s)
		{
			finish = clock();
			duration=(double)(finish - start);
			
			action* plan=best_node->get_plan();
			append_plan(&solution, plan);

			int steps=0;
			action* t_plan=plan;
			while (t_plan!=NULL)
			{
				steps++;
				t_plan=t_plan->next;
			}

			if (subproblem_level!=NULL && display_short_messages)
			{
				cout << "PARTIAL SOLUTION ";
				display_current_subproblem_level();
				cout << endl;
				cout << "=======================" << endl;
				cout << problem_name << "," ;
				cout << dt << ",";
				cout << steps ;
				t_plan=plan;
				while (t_plan!=NULL)
				{
					cout << "," << *t_plan ;
					t_plan=t_plan->next;
				}
				cout << endl << endl;
			}
					

			while (plan!=NULL)
			{
				t_plan=plan->next;
				delete plan;
				plan=t_plan; 
			}
			*final_state=*best_node->s;
			return 0;
		}
		
		appl_actions=best_node->s->applicable();

//		cout << *best_node->s << endl;
/*		action* t_action=appl_actions;
		while (t_action!=NULL)
		{
			cout << *t_action << endl;
			t_action=t_action->next;
		}
*/
		while (appl_actions!=NULL)
		{
//			cout << *appl_actions << endl;
			state* nextstate=best_node->s->next_state(appl_actions);
			node_ptr=new node(nextstate, *appl_actions, best_node);
			value=hash_value(nextstate);
			if (remember_state(value, node_ptr, states_hash_table))
			{
				long score=agenda_hash_size+state_grade(nextstate, best_node->s, &dummy, node_ptr->length());
//				cout << "Action: " << *appl_actions << " ==> " << score->elements[0] << endl;

				if (score<0)
				{
					cout << "State evaluated less than zero." << endl;
					abort();
				}

				if (score>10*agenda_hash_size)
					score=10*agenda_hash_size;

				if (score<=10*agenda_hash_size)
				{
					agenda_ptr=new agenda(node_ptr, score);
					if (score>=0 && score<=10*agenda_hash_size)
					{
						if (BFS_AgendaHead[score]==NULL)
						{
							BFS_AgendaHead[score]=agenda_ptr;
							BFS_AgendaTail[score]=agenda_ptr;
						}
						else
						{
							BFS_AgendaTail[score]->next=agenda_ptr;
							BFS_AgendaTail[score]=agenda_ptr;
						}
						if (score<best_agenda)
							best_agenda=score;
					}	// if score>=0 && ...
				}
			}
			action* tmp_action;
			tmp_action=appl_actions->next;
			delete appl_actions;
			appl_actions=tmp_action;
		}	// 	while (appl_actions!=NULL)

		t2=clock();
//		cout << "Cycle time: " << t2-t1 << endl;
		t1=t2;
	}
	return 0;
}


void check_new_node(node* best_node)
{
	// check the facts achieved last,
	// if some of them is idle...
//	cout << best_node->step << endl;
	int i1;
	// for every fact in the add_list of the applied action...
	for (i1=0;i1<Operators[best_node->step.operator_id].sof_lists[add_list];i1++)
	{
		// if the fact is included in the goals...
		if (goal->included(Operators[best_node->step.operator_id].strips[add_list][i1].instantiate(best_node->step.parameters)))
		{
//			cout <<  Operators[best_node->step.operator_id].strips[add_list][i1].instantiate(best_node->step.parameters) << endl;
			int i2;
			// for every parameter of the achieved fact...
			for (i2=0;i2<predicates[Operators[best_node->step.operator_id].strips[add_list][i1].pred].arity;i2++)
			{
				int var=Operators[best_node->step.operator_id].strips[add_list][i1].arguments[i2];

				int obj;
				if (var<0)
					obj=best_node->step.parameters[-var-1];
				else
					obj=var;
//				cout << objects[obj].name << endl;
				// The object may have been idle by a previous
				// fact achieved by the current action.
				if (!objects[obj].idle->value)
				{
					if (idle_object(obj,best_node->s))
					{
						objects[obj].idle->value=true;
//						cout << "New idle object: " << objects[obj].name << endl;
//						cout << endl;
					}
				}
			}
		}
	}
}


bool breadth_first(node** best_node, agenda* BFS_AgendaHead, agenda* BFS_AgendaTail, int depth)
{
	state_hash_entry** states_hash_table=new state_hash_entry*[CLOSE_LIST_HASH_SIZE];
	int i;
	for(i=0;i<CLOSE_LIST_HASH_SIZE;i++)
		states_hash_table[i]=NULL;
	int value;
	
	linked_linked_distances* new_end_facts;
	while (BFS_AgendaHead!=NULL)
	{
		if (BFS_AgendaHead->depth > depth)
			return false;
		check_time();

			action* appl_actions=BFS_AgendaHead->nd->s->applicable();
			while (appl_actions!=NULL)
			{
				state* nextstate=BFS_AgendaHead->nd->s->next_state(appl_actions);
	
				value=hash_value(nextstate);
				if (!state_exists(value,nextstate, states_hash_table))
				{
					long score=state_grade(nextstate, BFS_AgendaHead->nd->s, &new_end_facts, BFS_AgendaHead->nd->length()+1);
					if (score<=10*agenda_hash_size)
					{
						agenda* t_agenda=BFS_AgendaTail;
						BFS_AgendaTail=new agenda();
						t_agenda->next=BFS_AgendaTail;

						BFS_AgendaTail->nd=new node();
						BFS_AgendaTail->nd->s=nextstate;
						BFS_AgendaTail->nd->step=*appl_actions;
						BFS_AgendaTail->nd->previous=BFS_AgendaHead->nd;
						BFS_AgendaTail->nd->score=score;
						BFS_AgendaTail->nd->end_facts=new_end_facts;
						BFS_AgendaTail->next=NULL;
						BFS_AgendaTail->score=score;
						BFS_AgendaTail->depth=BFS_AgendaHead->depth+1;
						unconditional_remember_state(value, BFS_AgendaTail->nd, states_hash_table);
				
						if (score<(*best_node)->score)
						{
							node* t_node=BFS_AgendaTail->nd;
							while (t_node!=(*best_node))
							{
								check_new_node(t_node);
								t_node=t_node->previous;
							}
							*best_node=BFS_AgendaTail->nd;
							delete states_hash_table;
							return true;
						}
					}
				}
				appl_actions=appl_actions->next;
			}
		
		agenda* t_agenda=BFS_AgendaHead;
		BFS_AgendaHead=BFS_AgendaHead->next;
		delete t_agenda;
	}
	delete states_hash_table;
	return false;
}

void reorder_end_facts(node* best_node);

bool breadth_limited(node** best_node, agenda* BFS_AgendaHead, agenda* BFS_AgendaTail, int depth)
{

	state_hash_entry** states_hash_table=new state_hash_entry*[CLOSE_LIST_HASH_SIZE];
	int i;
	for(i=0;i<CLOSE_LIST_HASH_SIZE;i++)
		states_hash_table[i]=NULL;
	int value;

	linked_linked_distances* end_facts;
	linked_linked_distances* new_end_facts;
	if (display_messages || display_short_messages)
		cout << "       " ;
	int current_depth=0;
	while (BFS_AgendaHead!=NULL)
	{
		if (BFS_AgendaHead->depth > depth)
		{
			cout << endl;
			return false;
		}
		check_time();
		if (BFS_AgendaHead->depth>current_depth)
		{
			current_depth=BFS_AgendaHead->depth;
			if (display_messages || display_short_messages)
				cout << "[" << current_depth << "]" ;
		}

//			reorder_end_facts(BFS_AgendaHead->nd);
			end_facts=BFS_AgendaHead->nd->end_facts;
			while (end_facts!=NULL)
			{
				if (end_facts->distances->h->f.enabled() && !goal->included(end_facts->distances->h->f))
				{
					action* act;
					if (end_facts->distances->achieved_by!=NULL)
					{
						act=new action();
						//cout << h->f << endl;
						act->operator_id=end_facts->distances->achieved_by->step->operator_id;
						int j;
						for(j=0;j<max_nof_parameters;j++)
							act->parameters[j]=end_facts->distances->achieved_by->step->parameters[j];
						// cout << *act << endl;
						if (BFS_AgendaHead->nd->s->applicable(act))
						{

							state* nextstate=BFS_AgendaHead->nd->s->next_state(act);

							value=hash_value(nextstate);
							if (!state_exists(value,nextstate, states_hash_table))
							{
								long score=state_grade(nextstate, BFS_AgendaHead->nd->s, &new_end_facts, BFS_AgendaHead->nd->length()+1);

								if (score<=10*agenda_hash_size)
								{
									agenda* t_agenda=BFS_AgendaTail;
									BFS_AgendaTail=new agenda();
									t_agenda->next=BFS_AgendaTail;
									BFS_AgendaTail->nd=new node();
									BFS_AgendaTail->nd->s=nextstate;
									BFS_AgendaTail->nd->step=*act;
									BFS_AgendaTail->nd->previous=BFS_AgendaHead->nd;
									BFS_AgendaTail->nd->score=score;
									BFS_AgendaTail->nd->end_facts=new_end_facts;
									BFS_AgendaTail->next=NULL;
									BFS_AgendaTail->score=score;
									BFS_AgendaTail->depth=BFS_AgendaHead->depth+1;
									unconditional_remember_state(value, BFS_AgendaTail->nd, states_hash_table);
									
									if (score<(*best_node)->score)
									{
										node* t_node=BFS_AgendaTail->nd;
										while (t_node!=(*best_node))
										{
											check_new_node(t_node);
											t_node=t_node->previous;
										}
										*best_node=BFS_AgendaTail->nd;
										delete states_hash_table;
										if (display_messages || display_short_messages)
											cout << endl;
										return true;
									}
								}
							}
						}
					}
				}
				end_facts=end_facts->next;
			}

		
		agenda* t_agenda=BFS_AgendaHead;
		BFS_AgendaHead=BFS_AgendaHead->next;
		delete t_agenda;
	}
	
	//cout << "Cannot find better state while breadth-first search." << endl;
	delete states_hash_table;
	cout << endl;
	return false;
}


void reorder_end_facts(node* best_node)
{
/*
	// print end facts before ordering
	linked_linked_distances* tt=best_node->end_facts;
	while (tt!=NULL)
	{
		cout << tt->distances->h->f << "=" <<tt->distances->v_distance->elements[0] << ", ";
		tt=tt->next;
	}
	cout << endl;
*/

	linked_linked_distances* new_end_facts;
	// reorder end facts...
	int nof_end_facts=0;
	new_end_facts=best_node->end_facts;
	while (new_end_facts!=NULL)
	{
		nof_end_facts++;
		new_end_facts=new_end_facts->next;
	}

	int i1;
	for(i1=1;i1<nof_end_facts;i1++)
	{
		linked_linked_distances *p0, *p1, *p2, *pt;
		p0=NULL;
		p1=best_node->end_facts;
		p2=p1->next;

		int i2;
		for(i2=1;i2<=nof_end_facts-i1;i2++)
		{
			if (p2->distances->v_distance->elements[0]>p1->distances->v_distance->elements[0])
			{
				// swap the pointers
				if (p0==NULL)
				{
					p1->next=p2->next;
					p2->next=p1;
					best_node->end_facts=p2;
				}
				else  // if (p0==NULL)
				{
					p1->next=p2->next;
					p2->next=p1;
					p0->next=p2;
				}  // if (p0==NULL)
				pt=p2;
				p2=p1;
				p1=pt;
			}
			p0=p1;
			p1=p2;
			p2=p2->next;
		}
	}
		/*
	tt=best_node->end_facts;
	while (tt!=NULL)
	{
		cout << tt->distances->h->f << "=" <<tt->distances->v_distance->elements[0] << ", ";
		tt=tt->next;
	}
	cout << endl;
	*/
}


void reorder_appl_actions(action** appl_actions);

int hill_climbing(state* final_state)
{

	// initialize agenda's hash table
	if (*goal<=initial)
	{
		cout << "GOAL STATE IS A SUBSET OF THE INITIAL STATE" << endl;
		*final_state=*initial;
		return 0;
	}

	if (!check_initial())
		return 0;


	linked_linked_distances* end_facts;
	linked_linked_distances* new_end_facts;

	node* best_node=NULL;

	best_node=new node();
	best_node->s=new state();
	*best_node->s=*initial;
	long score=state_grade(best_node->s, NULL, &new_end_facts, 0);
	best_node->score=score;
	best_node->end_facts=new_end_facts;
	best_node->previous=NULL;

	clock_t t1;
	clock_t t2;
	t1=clock();
	while (true)
	{
		
		check_time();
		if (display_messages || display_short_messages)
			cout << best_node->score<< endl;

		// It is not needed to check for repeated states, because due to
		// the hill climnbing search algorithm there is no case to have
		// repeated states...

		if (*goal<=best_node->s)
		{
			finish = clock();
			duration=(double)(finish - start);
			
			action* plan=best_node->get_plan();
			append_plan(&solution, plan);
			int steps=0;
			action* t_plan=plan;
			while (t_plan!=NULL)
			{
				steps++;
				t_plan=t_plan->next;
			}
			if (subproblem_level!=NULL)
			{
				cout << "PARTIAL SOLUTION ";
				display_current_subproblem_level();
				cout << endl;
				cout << "=======================" << endl;
				cout << problem_name << "," ;
				cout << dt << ",";
				cout << steps ;
				t_plan=plan;
				while (t_plan!=NULL)
				{
					cout << "," << *t_plan ;
					t_plan=t_plan->next;
				}
				cout << endl << endl;
			}
					
			while (plan!=NULL)
			{
				t_plan=plan->next;
				delete plan;
				plan=t_plan; 
			}
			*final_state=*best_node->s;
			return 0;
		}
	
		
		//	Try to find if any of the actions that achieved state's facts is applicable
		//	and leads to better state...

		bool found_better=false;
		end_facts=best_node->end_facts;


//		reorder_end_facts(best_node);

		while (end_facts!=NULL && !found_better)
		{
			if (end_facts->distances->h->f.enabled() && !goal->included(end_facts->distances->h->f))
			{
				action* act;
				if (end_facts->distances->achieved_by!=NULL)
				{
					act=new action();
					//cout << h->f << endl;
					act->operator_id=end_facts->distances->achieved_by->step->operator_id;
					int j;
					for(j=0;j<max_nof_parameters;j++)
						act->parameters[j]=end_facts->distances->achieved_by->step->parameters[j];
					// cout << *act << endl;
					if (best_node->s->applicable(act))
					{
						state* nextstate=best_node->s->next_state(act);
						long score=state_grade(nextstate, best_node->s, &new_end_facts, best_node->length()+1);
						if (score<=10*agenda_hash_size)
						{
							if (score<best_node->score)
							{
								found_better=true;
								node* old_best_node=best_node;
								best_node=new node();
								best_node->s=nextstate;
								best_node->step=*act;
								best_node->score=score;
								best_node->end_facts=new_end_facts;
								best_node->previous=old_best_node;
							}
						}
					}	
				}
			}
			end_facts=end_facts->next;
		}


		agenda* BFS_AgendaHead=NULL;
		agenda* BFS_AgendaTail=NULL;

		action* appl_actions;

		if (!found_better)
		{
			appl_actions=best_node->s->applicable();
		}

//		reorder_appl_actions(&appl_actions);

		while (appl_actions!=NULL && !found_better)
		{
			state* nextstate=best_node->s->next_state(appl_actions);
			long score=state_grade(nextstate, best_node->s, &new_end_facts, best_node->length()+1);
			if (score<=10*agenda_hash_size) 
			{
				if (score<best_node->score)
				{
					found_better=true;
					node* old_best_node=best_node;
					best_node=new node();
					best_node->s=nextstate;
					best_node->step=*appl_actions;
					best_node->score=score;
					best_node->end_facts=new_end_facts;
					best_node->previous=old_best_node;
				}
				else
				{
					if (BFS_AgendaHead==NULL)
					{
						BFS_AgendaHead=new agenda();
						BFS_AgendaTail=BFS_AgendaHead;
					}
					else
					{
						agenda* t_agenda=BFS_AgendaTail;
						BFS_AgendaTail=new agenda();
						t_agenda->next=BFS_AgendaTail;
					}

					BFS_AgendaTail->nd=new node();
					BFS_AgendaTail->nd->s=nextstate;
					BFS_AgendaTail->nd->step=*appl_actions;
					BFS_AgendaTail->nd->previous=best_node;
					BFS_AgendaTail->nd->score=score;
					BFS_AgendaTail->nd->end_facts=new_end_facts;
					BFS_AgendaTail->next=NULL;
					BFS_AgendaTail->score=score;
					BFS_AgendaTail->depth=1;
				}
			}

			action* tmp_action;
			tmp_action=appl_actions->next;
			delete appl_actions;
			appl_actions=tmp_action;
		}	// 	while (appl_actions!=NULL)


		if (!found_better)
		{
			// search with limited breadth_first
			bool flag=breadth_limited(&best_node, BFS_AgendaHead, BFS_AgendaTail, 6);
			if (!flag)
			{
				BFS_AgendaHead=new agenda();
				BFS_AgendaHead->nd=best_node;
				BFS_AgendaHead->score=best_node->score;
				BFS_AgendaHead->next=NULL;
				BFS_AgendaTail=BFS_AgendaHead;
				BFS_AgendaHead->depth=0;
				flag=breadth_first(&best_node, BFS_AgendaHead, BFS_AgendaTail, 3);
				if (!flag)
				{
					cout << "Cannot solve the problem with hill-climbing. Returning to complete BestFS." << endl;
					bfs_solve(final_state);
					return 0;
				}
			}
		}
		else
		{
			check_new_node(best_node);
		}

		t2=clock();
//		cout << "Cycle time: " << t2-t1 << endl;
		t1=t2;
	}	// while true...
	return 0;
}





void test_mins();

	// ATTENTION: IT IS POSSIBLE TO HAVE ALL THE FACTS OF THE ENRICHED
	// GOAL STATE USED, BUT TO HAVE REMAINING FACTS IN THE HASH TABLE,
	// FOR WHICH NO DISTANCES HAVE BEEN COMPUTED. THESE ARE FACTS THAT
	// ARE MUTEXED WITH A GOAL FACT, AND FOR WHICH THERE IS NO ACTION
	// THAT CAN ACHIEVE THEM. 
	// FOR EXAMPLE, SUPPOSE THAT YOU CAN PAINT A DOOR ONLY ONCE AND 
	// YOU HAVE TWO COLORS, BLUE AND GREEN. BOTH OF THE FACTS CAN 
	// BE ACHIEVED FROM THE INITIAL STATE (=NOT PAINTED). SUPPOSE THAT
	// THE GOAL STATE DETERMINES THAT THE DOOR IS BLUE. THEN THERE IS
	// NO WAY TO ACHIEVE THE FACT DOOR=GREEN FROM THE GOALS. OFCOURSE
	// THE TWO FACTS ARE MUTEXED. OFCOURSE, THE FACT DOOR=GREEN SHOULD HAVE 
	// AN INFINITE DISTANCE...



// This functionr returns the best value-vector from the value-vectors
// of fact h, with respect to the criteria hierarchy.
linked_distances* get_best_distance(hash_entry* h, state* s)
{
	linked_distances* min_distance;
	if (h->subproblem_distances==NULL)
	{
		cout << h->f << endl;
		cout << "ERROR 384673494301248340" << endl;
		abort();
	}

	if (h->subproblem_distances->distances==NULL)
	{ 
		return NULL;
	}

	min_distance=NULL;
	long best_distance=10*agenda_hash_size;

	min_distance=h->subproblem_distances->best_distance;
	
/*	linked_distances* distances=h->subproblem_distances->distances;
	while (distances!=NULL)
	{
		if (!distances->should_be_deleted)
		{
			//int d=evaluate_remaining_vector(distances->v_distance);
			long d=vector_grade(distances->v_distance,1,-1,initial,true);
			if (d<best_distance)
			{
				min_distance=distances;
				best_distance=d;
			}
		}
		distances=distances->next;
	}
	
	if (min0_distance!=min_distance)
	{
		cout << h->f << endl;
		cout << "***bingo9485***" << endl;
	}
*/
	return min_distance;
}

/*
// This function returns the position in a criterion vector, where the first vector
// maximum exceeds the second vector...
int find_max_difference_position(vector* total_score, state* s, double* difference)
{
	double current_max_hard=0;
	int current_max_hard_pos=-1;
	double current_max_soft=0;
	int current_max_soft_pos=-1;

	double current_dif;

	current_dif=((double) total_score->elements[0]+s->state_vector->elements[0] - length_to)/((float) length_to-length_from);
	if (current_dif>0)
	{
		current_max_soft=current_dif;
		current_max_soft_pos=0;
	}

	int i;
	for(i=1;i<=nof_criteria;i++) {
		if (criteria[i-1].type==1 || criteria[i-1].type==3)		{
			
			current_dif=((double) total_score->elements[i]+s->state_vector->elements[i] - criteria[i-1].to)/((float) criteria[i-1].to - criteria[i-1].from);

			if (criteria[i-1].bounded_to) {
				if ( current_dif > fabs(current_max_hard))
				{
					current_max_hard=current_dif;
					current_max_hard_pos=i;
				}
			}
			else {
				if ( current_dif > fabs(current_max_soft) && !criteria[i-1].max_better)
				{
					current_max_soft=current_dif;
					current_max_soft_pos=i;
				}
			}
		}

		if (criteria[i-1].type==2 || criteria[i-1].type==3) {
			current_dif=((double) total_score->elements[i] - s->state_vector->elements[i] - criteria[i-1].from)/((float) criteria[i-1].to - criteria[i-1].from);
			if (criteria[i-1].bounded_from) {
				if ( (-current_dif) > fabs(current_max_hard))
				{
					current_max_hard=current_dif;
					current_max_hard_pos=i;
				}
			}
			else {
				if ( (-current_dif) > fabs(current_max_soft) && criteria[i-1].max_better)
				{
					current_max_soft=current_dif;
					current_max_soft_pos=i;
				}
			}
		}
	}

	if (current_max_hard_pos>=0)
	{
		*difference=current_max_hard;
		return current_max_hard_pos;
	}
	else
	{
		*difference=current_max_soft;
		return current_max_soft_pos;
	}
}
*/

// This function measures the relative combined overflow in all criteria...
long measure_overflow(vector* total_score, state* s)
{
	double overflow=0;
	double current_dif=0;
	
	current_dif=((double) total_score->elements[0]+s->state_vector->elements[0] - length_to)/((float) length_to-length_from);
	if (current_dif>0) overflow+=current_dif;

	int i;
	for(i=1;i<=nof_criteria;i++) {
		if (criteria[i-1].type==1 || criteria[i-1].type==3)		{
			
			current_dif=((double) total_score->elements[i]+s->state_vector->elements[i] - criteria[i-1].to)/((float) criteria[i-1].to - criteria[i-1].from);

			if (criteria[i-1].bounded_to) {
				if ( current_dif >0)
				{
					overflow+=3*current_dif;
				}
			}
			else {
				if ( current_dif > 0 && !criteria[i-1].max_better)
				{
					overflow+=current_dif;
				}
			}
		}

		if (criteria[i-1].type==2 || criteria[i-1].type==3) {
			current_dif=((double) total_score->elements[i] - s->state_vector->elements[i] - criteria[i-1].from)/((float) criteria[i-1].to - criteria[i-1].from);
			if (criteria[i-1].bounded_from) {
				if ( (-current_dif) > 0)
				{
					overflow+=3*(-current_dif);
				}
			}
			else {
				if ( (-current_dif) > 0 && criteria[i-1].max_better)
				{
					overflow+=(-current_dif);
				}
			}
		}
	}

	return long (overflow*agenda_hash_size);
}


/*
// This function returns from the linked list of vectors distances 
// the vector with the 'absolute' minimum value in dimension criterion_pos.
// HERE THERE IS AN INCONSISTENCY WITH THE PAPER: IN CASE OF IMRPOVING CRITERION AND WITH SOFT BOUND TOWARDS
// THE IMPROVING DIRECTION, THE COST VECTOR WITH THE LOWEST VALUE IN THE CRITERION IS CONSIDERED, INSTEAD OF 
// THE COST-VECTOR WITH THE BEST COMBINED VALUE IN THE REST OF THE CRITERIA.
linked_distances* get_abs_min_criterion(linked_distances* distances, int criterion_pos, double difference)
{
	int min_amount;

	if (criterion_pos==0) {
		min_amount=30000;
	}
	else if (criteria[criterion_pos-1].type==1 || ( criteria[criterion_pos-1].type==3 && difference>0 )) 
		min_amount=30000;
	else
		min_amount=-30000;
	
	linked_distances* min_criterion=NULL;

	while (distances!=NULL)
	{
		if (!distances->should_be_deleted)
		{
			if (criterion_pos==0 )
			{
				if (distances->v_distance->elements[criterion_pos]<min_amount)
				{
					min_criterion=distances;
					min_amount=distances->v_distance->elements[criterion_pos];
				}
			}
			else if (criteria[criterion_pos-1].type==1 || ( criteria[criterion_pos-1].type==3 && difference>0 )) {
				if (distances->v_distance->elements[criterion_pos]<min_amount)
				{
					min_criterion=distances;
					min_amount=distances->v_distance->elements[criterion_pos];
				}
			}
			else
			{
				if (distances->v_distance->elements[criterion_pos]>min_amount)
				{
					min_criterion=distances;
					min_amount=distances->v_distance->elements[criterion_pos];
				}
			}
		}
		distances=distances->next;
	}


	if (!min_criterion->v_distance->mins[criterion_pos] && !no_rdph)
	{
		cout << "ERROR 393749430427202472402" << endl;
		abort();
	}

	return min_criterion;
}
*/


/*
// This function changes the distance of fact number 'fact_pos' in the linked_list 'state_facts'
// with another distance of the same fact with the minimum value 
// in criterion number 'criterion_pos'
void change_state_fact(linked_linked_distances* state_facts, int fact_pos, int criterion_pos, double difference)
{
	int i=0;
	while (i<fact_pos)
	{
		state_facts=state_facts->next;
		i++;
	}
	//cout << state_facts->distances->h->f << endl;
	linked_distances* new_distance=get_abs_min_criterion(state_facts->distances->h->subproblem_distances->distances,criterion_pos, difference);
	state_facts->distances=new_distance;
}
*/ 


void calibrate_criteria(node* best_node) {
	if (best_node->previous!=NULL) {
		length_times++;
		length_d_estimated+=-best_node->s->goal_distance_estimate->elements[0]+best_node->previous->s->goal_distance_estimate->elements[0];
		int i;
		for(i=1;i<=nof_criteria;i++)
		{
			criteria[i-1].times++;
			criteria[i-1].d_actual+=best_node->s->state_vector->elements[i]-best_node->previous->s->state_vector->elements[i];
			criteria[i-1].d_estimated+=-best_node->s->goal_distance_estimate->elements[i]+best_node->previous->s->goal_distance_estimate->elements[i];
		}
	}
}



long state_grade(state* s, state* previous_state, linked_linked_distances** end_facts, int past_length)
{
	hash_entry* h;
	vector* score;
	linked_linked_distances* state_facts=NULL;
	int i;
	state_facts=NULL;

	for(i=0;i<s->size;i++)
	{
//		cout << s->facts[i] << endl;
		h=get_fact_pointer(&(s->facts[i]));
		linked_distances* best_distance=get_best_distance(h,s);
		if (best_distance==NULL)
		{
			cout << h->f << endl;
			return agenda_hash_size+1;
		}
		state_facts=new linked_linked_distances(best_distance, state_facts);

	}
	score=find_grade(state_facts, end_facts); // find_grade() deletes the list 'linked_facts'...
//	vector* total_score=new vector();

//	sum(total_score, state_vector, score);

//	double difference=0;
//	int max_dif=find_max_difference_position(score,s, &difference);
	long overflow=measure_overflow(score,s);

	long counter1;
	long counter2;
		
	if (overflow==0)
	{
		s->goal_distance_estimate=score;
//		delete total_score;
		return int((past_weight*vector_grade(s->state_vector,0,0,s,false)+remaining_weight*vector_grade(score, 1, -1,s,false))/((float) past_weight+remaining_weight));
	}
	else
	{
		counter1=0;
		counter2=0;
		bool has_been_improved;
		do {
			has_been_improved=false;
			linked_linked_distances* state_facts_head=state_facts;
			while (state_facts_head!=NULL)
			{
				linked_distances* current_distance=state_facts_head->distances;
				linked_distances* other_distances=current_distance->h->subproblem_distances->distances;
				while (other_distances!=NULL) {
					if (!other_distances->should_be_deleted) {
						counter1++;
						state_facts_head->distances=other_distances;
						linked_linked_distances* new_end_facts=NULL;
						vector* new_score=find_grade(state_facts, &new_end_facts);
						long new_overflow=measure_overflow(new_score,s);
						if (new_overflow<overflow) {
							has_been_improved=true;
							counter2++;
							overflow=new_overflow;
							score=new_score;
							*end_facts=new_end_facts;
							current_distance=other_distances;
						}
						else {
							state_facts_head->distances=current_distance;
						}
					}
					other_distances=other_distances->next;
				}
			state_facts_head=state_facts_head->next;
			}
		} while (has_been_improved && no_rdph);	// In case of the relaxed dominance pruning heuristic
													// a single attempt is performed...

/*		
		i=0;
		do 
		{
			change_state_fact(state_facts, i, max_dif, difference);
			delete score;
			score=find_grade(state_facts, end_facts);
//			sum(total_score, state_vector, score);
			max_dif=find_max_difference_position(score,s, &difference);
	//		if (max_dif<0)
	//			cout << "bingo" << endl;
			i++;
		} while (i<s->size && max_dif>=0);
*/

//		delete total_score;
		s->goal_distance_estimate=score;
		return int(( (float) past_weight*vector_grade(s->state_vector,0,0,s,false)+remaining_weight*vector_grade(score, 1, -1,s,false))/( (float) past_weight+remaining_weight));
	}
}

void search_routines(state* final_state)
{
	clock_t t;
	extern long double bfs_solve_time;
	t=clock();
	if (search_strategy==1)
		bfs_solve(final_state);
	else
		hill_climbing(final_state);
	t=clock() -t;
	bfs_solve_time=bfs_solve_time+t;
}


int power(int a, int b)
{
	if (b==0)
		return 1;
	else
	{
		int i;
		int ret=1;
		for (i=1;i<=b;i++)
			ret=ret*a;
		return ret;
	}
}

int pos_int(double D)
{
	int LI=int(D);
	if (LI<0)
		LI=-LI;
	return LI;
}


int hash_value(state* s)
{
	int hash=0;
	int i;
	for(i=0;i<s->size;i++)
	{
		double hash1=sin((30*s->facts[i].pred+3)*(s->facts[i].pred+1));
		int j;
		for(j=0;j<predicates[s->facts[i].pred].arity;j++)
		{
			hash1=hash1*sin(hash1*(s->facts[i].arguments[j]+j));
		}
		hash=(hash + pos_int(hash1*CLOSE_LIST_HASH_SIZE )) % CLOSE_LIST_HASH_SIZE;
	}
	return hash;
}


bool state_abs_better_equal(state* s1, state* s2)
{
	if (s1->state_vector->elements[0]>s2->state_vector->elements[0])
		return false;
	
	int i=1;
	while (i<=nof_criteria)
	{
		if (criteria[i-1].max_better)
		{
			if (s1->state_vector->elements[i]<s2->state_vector->elements[i])
				return false;
		}
		else
		{
			if (s1->state_vector->elements[i]>s2->state_vector->elements[i])
				return false;
		}
		i++;
	}
	return true;
}


// This function checks if a state already exists in the closed list of visited states.
// It the state exists, it is not appended again, and a false value is returned,
// otherwise the state is added and a true value is appended.
// Note that in case of multiple criteria, a check is also performed in the values of the criteria.
// If the state is revisited but not in a dominated way. it is added again with its
// new criterion vector and a true value is returned.
bool remember_state(int value, node* nd, state_hash_entry** states_hash_table)
{
	state_hash_entry* entry=states_hash_table[value];
	bool found=false;
	while (entry!=NULL && !found)
	{
//		cout << "bingo1" << endl;
		if (*entry->state_node->s==nd->s)
		{
			if (state_abs_better_equal(entry->state_node->s, nd->s))
//			cout << "BINGO2" << endl;
				found=true;
			else
				entry=entry->next;
		}
		else
			entry=entry->next;
	}
	if (!found )
	{
		states_hash_table[value]=new state_hash_entry(nd, states_hash_table[value]);
	}
	return !found;
}

void unconditional_remember_state(int value, node* nd, state_hash_entry** states_hash_table)
{
	states_hash_table[value]=new state_hash_entry(nd, states_hash_table[value]);
}

bool state_exists(int value, state* s, state_hash_entry** states_hash_table)
{
	state_hash_entry* entry=states_hash_table[value];
	bool found=false;
	while (entry!=NULL && !found)
	{
//		cout << "bingo1" << endl;
		if (*entry->state_node->s==s)
		{
//			cout << "BINGO2" << endl;
			found=true;
		}
		else
			entry=entry->next;
	}
	return found;
}


int action_cost(action* act)
{
	int i;
	int sum=0;
	for(i=0;i<Operators[act->operator_id].sof_lists[delete_list];i++)
	{
		hash_entry* h=get_fact_pointer(&Operators[act->operator_id].strips[delete_list][i].instantiate(act->parameters));
		sum=sum+h->subproblem_distances->distances->v_distance->elements[0];
	}
	return sum;
}

void reorder_appl_actions(action** appl_actions)
{

	action* t_action=*appl_actions;

/*	while (t_action!=NULL)
	{
		cout << *t_action << "=" << action_cost(t_action) << ", ";
		t_action=t_action->next;
	}
	cout << endl << endl;
*/
	t_action=*appl_actions;
	// reorder end facts...
	int nof_actions=0;
	while (t_action!=NULL)
	{
		nof_actions++;
		t_action=t_action->next;
	}

	int i1;
	for(i1=1;i1<nof_actions;i1++)
	{
		action *p0, *p1, *p2, *pt;
		p0=NULL;
		p1=*appl_actions;
		p2=p1->next;

		int i2;
		for(i2=1;i2<=nof_actions-i1;i2++)
		{
			if (action_cost(p2)>action_cost(p1))
			{
				// swap the pointers
				if (p0==NULL)
				{
					p1->next=p2->next;
					p2->next=p1;
					*appl_actions=p2;
				}
				else  // if (p0==NULL)
				{
					p1->next=p2->next;
					p2->next=p1;
					p0->next=p2;
				}  // if (p0==NULL)
				pt=p2;
				p2=p1;
				p1=pt;
			}
			p0=p1;
			p1=p2;
			p2=p2->next;
		}
	}
/*
	t_action=*appl_actions;
	while (t_action!=NULL)
	{
		cout << *t_action << "=" << action_cost(t_action) << ", ";
		t_action=t_action->next;
	}
	cout << endl << endl;
*/
}