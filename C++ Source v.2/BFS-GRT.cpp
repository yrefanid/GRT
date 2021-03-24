#include "planner.h"

vector* state_grade(state* s, linked_linked_distances** end_facts);

// pointers to agenda hash table
agenda* BFS_AgendaHead[agenda_hash_size+2];
agenda* BFS_AgendaTail[agenda_hash_size+2];

int	best_agenda;

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

int bfs_solve(state* final_state)
{
	
	// initialize agenda's hash table
	if (*goal<=initial)
	{
		cout << "GOAL STATE IS A SUBSET OF THE INITIAL STATE" << endl;
		*final_state=*initial;
		return 0;
	}

	state_hash_entry** states_hash_table=new state_hash_entry*[CLOSE_LIST_HASH_SIZE];
	int i;
	for(i=0;i<CLOSE_LIST_HASH_SIZE;i++)
		states_hash_table[i]=NULL;

	for (i=0;i<agenda_hash_size+2;i++)
	{
		BFS_AgendaHead[i]=NULL;
		BFS_AgendaTail[i]=NULL;
	}
	best_agenda=agenda_hash_size+2;
	
	// create initial nodes and add the corresponging pointers to the agenda
	agenda* agenda_ptr;
	node* node_ptr;

	linked_linked_distances* dummy=NULL;
	node_ptr=new node();
	node_ptr->s=new state();
	*node_ptr->s=*initial;
	node_ptr->previous=NULL;
	vector* score=state_grade(initial, &dummy);

	int value;
	if (score!=NULL)
	{
		value=hash_value(initial);
		remember_state(value, node_ptr, states_hash_table);
		agenda_ptr=new agenda(node_ptr, score);
		if (score->elements[0]>=0 && score->elements[0]<=agenda_hash_size)
		{
			if (BFS_AgendaHead[score->elements[0]]==NULL)
			{
				BFS_AgendaHead[score->elements[0]]=agenda_ptr;
				BFS_AgendaTail[score->elements[0]]=agenda_ptr;
			}
			else
			{
				BFS_AgendaTail[score->elements[0]]->next=agenda_ptr;
				BFS_AgendaTail[score->elements[0]]=agenda_ptr;
			}
			if (score->elements[0]<best_agenda)
				best_agenda=score->elements[0];
		}	// if score>=0 && ...
	}
	
	action* appl_actions;
	clock_t t1;
	clock_t t2;
	t1=clock();
	while (best_agenda<=agenda_hash_size)
	{
		check_time();
		node* best_node=BFS_AgendaHead[best_agenda]->nd;

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
/*
		cout << "Related: ";
		vector* t_score;
		t_score=state_grade(best_node->s, &dummy);
		while (dummy!=NULL)
		{
			cout << dummy->distances->h->f << ", ";
			dummy=dummy->next;
		}
		cout << endl;
*/
		agenda* new_head_agenda=BFS_AgendaHead[best_agenda]->next;
		delete BFS_AgendaHead[best_agenda];
		BFS_AgendaHead[best_agenda]=new_head_agenda;
		if (new_head_agenda==NULL)
		{
			BFS_AgendaTail[best_agenda]=NULL;
			bool flag=true;
			best_agenda++;
			while (flag && best_agenda<=agenda_hash_size)
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

/*		cout << *best_node->s << endl;
		action* t_action=appl_actions;
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
				vector* score=state_grade(nextstate, &dummy);
//				cout << "Action: " << *appl_actions << " ==> " << score->elements[0] << endl;

				if (score!=NULL)
				{
					agenda_ptr=new agenda(node_ptr, score);
					if (score->elements[0]>=0 && score->elements[0]<=agenda_hash_size)
					{
						if (BFS_AgendaHead[score->elements[0]]==NULL)
						{
							BFS_AgendaHead[score->elements[0]]=agenda_ptr;
							BFS_AgendaTail[score->elements[0]]=agenda_ptr;
						}
						else
						{
							BFS_AgendaTail[score->elements[0]]->next=agenda_ptr;
							BFS_AgendaTail[score->elements[0]]=agenda_ptr;
						}
						if (score->elements[0]<best_agenda)
							best_agenda=score->elements[0];
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
					vector* score=state_grade(nextstate, &new_end_facts);
					if (score!=NULL)
					{
						agenda* t_agenda=BFS_AgendaTail;
						BFS_AgendaTail=new agenda();
						t_agenda->next=BFS_AgendaTail;

						BFS_AgendaTail->nd=new node();
						BFS_AgendaTail->nd->s=nextstate;
						BFS_AgendaTail->nd->step=*appl_actions;
						BFS_AgendaTail->nd->previous=BFS_AgendaHead->nd;
						BFS_AgendaTail->nd->v_distance=score;
						BFS_AgendaTail->nd->end_facts=new_end_facts;
						BFS_AgendaTail->next=NULL;
						BFS_AgendaTail->score=score;
						BFS_AgendaTail->depth=BFS_AgendaHead->depth+1;
						unconditional_remember_state(value, BFS_AgendaTail->nd, states_hash_table);
				
						if (score->elements[0]<(*best_node)->v_distance->elements[0])
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
								vector* score=state_grade(nextstate, &new_end_facts);

								if (score!=NULL)
								{
									agenda* t_agenda=BFS_AgendaTail;
									BFS_AgendaTail=new agenda();
									t_agenda->next=BFS_AgendaTail;
									BFS_AgendaTail->nd=new node();
									BFS_AgendaTail->nd->s=nextstate;
									BFS_AgendaTail->nd->step=*act;
									BFS_AgendaTail->nd->previous=BFS_AgendaHead->nd;
									BFS_AgendaTail->nd->v_distance=score;
									BFS_AgendaTail->nd->end_facts=new_end_facts;
									BFS_AgendaTail->next=NULL;
									BFS_AgendaTail->score=score;
									BFS_AgendaTail->depth=BFS_AgendaHead->depth+1;
									unconditional_remember_state(value, BFS_AgendaTail->nd, states_hash_table);
									
									if (score->elements[0]<(*best_node)->v_distance->elements[0])
									{
										node* t_node=BFS_AgendaTail->nd;
										while (t_node!=(*best_node))
										{
											check_new_node(t_node);
											t_node=t_node->previous;
										}
										*best_node=BFS_AgendaTail->nd;
										delete states_hash_table;
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
	
	linked_linked_distances* end_facts;
	linked_linked_distances* new_end_facts;

	node* best_node=NULL;

	best_node=new node();
	best_node->s=new state();
	*best_node->s=*initial;
	vector* score=state_grade(best_node->s, &new_end_facts);
	best_node->v_distance=score;
	best_node->end_facts=new_end_facts;
	best_node->previous=NULL;

	clock_t t1;
	clock_t t2;
	t1=clock();
	while (true)
	{
		
		check_time();
		if (display_messages || display_short_messages)
			cout << best_node->v_distance->elements[0] << endl;

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
						vector* score=state_grade(nextstate, &new_end_facts);
						if (score!=NULL)
						{
							if (score->elements[0]<best_node->v_distance->elements[0])
							{
								found_better=true;
								node* old_best_node=best_node;
								best_node=new node();
								best_node->s=nextstate;
								best_node->step=*act;
								best_node->v_distance=score;
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
			vector* score=state_grade(nextstate, &new_end_facts);
			if (score!=NULL) 
			{
				if (score->elements[0]<best_node->v_distance->elements[0])
				{
					found_better=true;
					node* old_best_node=best_node;
					best_node=new node();
					best_node->s=nextstate;
					best_node->step=*appl_actions;
					best_node->v_distance=score;
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
					BFS_AgendaTail->nd->v_distance=score;
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
				BFS_AgendaHead->score=best_node->v_distance;
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

linked_distances* get_min_distance(hash_entry* h)
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

	//min_distance=h->subproblem_distances->distances;
	
	linked_distances* distances=h->subproblem_distances->distances;
	while (distances!=NULL)
	{
		if (!distances->should_be_deleted)
		{
			if (min_distance==NULL)
			{
				min_distance=distances;
			}
			else
			{
				if (distances->v_distance->elements[0] < min_distance->v_distance->elements[0])
					min_distance=distances;
				else
				{
					if (distances->v_distance->elements[0]==min_distance->v_distance->elements[0])
					{
						int j;
						int sum1=0;
						int sum2=0;
						for (j=1;j<=nof_consumable_resources;j++)
						{
							sum1 += min_distance->v_distance->elements[j];
							sum2 += distances->v_distance->elements[j];
						}
						if (sum2<sum1)
							min_distance=distances;
					}
				}	
			}
		}
		distances=distances->next;
	}
	return min_distance;
}


// This function returns the position in a resource vector, where the first vector
// maximum exceeds the second vector...
int find_max_difference_position(vector* score, vector* state_vector)
{
	int current_max=0;
	int current_pos=0;
	int i;
	for(i=1;i<=nof_consumable_resources;i++)
		if (score->elements[i]-state_vector->elements[i] > current_max)
		{
			current_max=score->elements[i]-state_vector->elements[i];
			current_pos=i;
		}

	//if (current_pos==0)
	//{
	//	cout << "ERROR 393749430437340340" << endl;
	//	abort();
	//}

	return current_pos;
}

linked_distances* get_min_resource(linked_distances* distances, int resource_pos)
{
	int min_amount=10000;
	linked_distances* min_resource=NULL;

	while (distances!=NULL)
	{
		if (!distances->should_be_deleted)
		{
/*			cout << *distances->v_distance << "  MINS = " ;
			int j;
			for (j=0;j<=nof_consumable_resources;j++)
				if (distances->v_distance->mins[j])
					cout << "1";
				else
					cout << "0";
			cout << endl;
*/
			if (distances->v_distance->elements[resource_pos]<=min_amount)
			{
				min_resource=distances;
				min_amount=distances->v_distance->elements[resource_pos];
			}
		}
		distances=distances->next;
	}
	
	if (!min_resource->v_distance->mins[resource_pos])
	{
		cout << "ERROR 393749430427202472402" << endl;
		abort();
	}
	return min_resource;
}

// This function changes the distance of fact number 'fact_pos' in the linked_list 'state_facts'
// with another distance of the same fact with the minimum value 
// in resource number 'resource_pos'
void change_state_fact(linked_linked_distances* state_facts, int fact_pos, int resource_pos)
{
	int i=0;
	while (i<fact_pos)
	{
		state_facts=state_facts->next;
		i++;
	}
	//cout << state_facts->distances->h->f << endl;
	linked_distances* new_distance=get_min_resource(state_facts->distances->h->subproblem_distances->distances,resource_pos);
	state_facts->distances=new_distance;
}
 
vector* state_grade(state* s, linked_linked_distances** end_facts)
{
	hash_entry* h;
	vector* score;
	linked_linked_distances* state_facts=NULL;
	int i;
	state_facts=NULL;

	for(i=0;i<s->size;i++)
	{
		
		h=get_fact_pointer(&(s->facts[i]));
		linked_distances* min_distance=get_min_distance(h);
		if (min_distance==NULL)
		{
			cout << h->f << endl;
			return NULL;
		}
		state_facts=new linked_linked_distances(min_distance, state_facts);

	}
	score=find_grade(state_facts, end_facts); // find_grade() deletes the list 'linked_facts'...
	vector* state_vector=new vector();
	for(i=0;i<nof_resources;i++)
	{
		if (resources[i].type==1)
			state_vector->elements[1+resources[i].consumable_ID]=s->resource_vector[i];
	}
	state_vector->elements[0]=31000;
	if (*score<=state_vector)
		return score;
	else
	{
		i=0;
		bool found=false;
		while (i<s->size && !found)
		{
			int resource_pos=find_max_difference_position(score, state_vector);
			change_state_fact(state_facts, i, resource_pos);
			delete score;
			score=find_grade(state_facts, end_facts);
			found=(*score<=state_vector);
			i++;
		}
		return score;
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


bool remember_state(int value, node* nd, state_hash_entry** states_hash_table)
{
	state_hash_entry* entry=states_hash_table[value];
	bool found=false;
	while (entry!=NULL && !found)
	{
//		cout << "bingo1" << endl;
		if (*entry->state_node->s==nd->s)
		{
//			cout << "BINGO2" << endl;
			found=true;
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