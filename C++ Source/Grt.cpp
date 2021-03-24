#include "planner.h"

int t_more_goals=0;

int TEST_COUNTER=0;
int TEST_COUNTER2=0;
int TEST_COUNTER3=0;

bool NO_RELATED=false;

bool reduced_enriched=false;
bool copy_from_initial=false;
bool enriched_no_used=false;
bool idle_flag=true;

Operator* Inv_Operators=new Operator[max_nof_operators];

int		nof_enabled_facts=0;
int		nof_set_facts;
int		nof_applied_inverted_actions;

inverted_action* all_inverted_actions=NULL;		// this pointer is useful for the 
												// deletion of the inverted actions...

linked_inverted_action*	inverted_satisfied_head=NULL;
linked_inverted_action*	inverted_satisfied_tail=NULL;

int deleted_keeped_facts=0;
int deleted_inverted_actions=0;
int deleted_linked_inverted_actions=0;

extern int nof2_actions;


// Function 'create_inverted_operators' constructs the inverted operators and adds them to 
// the table "Operator* Inv_Operators".
void create_inverted_operators()
{
	int i;
	for(i=0;i<nof_operators;i++)
	{
		check_time();
		strcpy(Inv_Operators[i].name, Operators[i].name);
		Inv_Operators[i].nof_parameters=Operators[i].nof_parameters;
		Inv_Operators[i].sof_lists[prec_list]=Operators[i].sof_lists[add_list]+
												Operators[i].sof_lists[prec_list]-
												Operators[i].sof_lists[delete_list];
		Inv_Operators[i].sof_lists[delete_list]=Operators[i].sof_lists[add_list];
		Inv_Operators[i].sof_lists[add_list]=Operators[i].sof_lists[delete_list];
		
// construct the delete list of the inverted operator
		int j;
		for(j=0;j<Operators[i].sof_lists[add_list];j++)	
			Inv_Operators[i].strips[delete_list][j]=Operators[i].strips[add_list][j];
		
// construct the add list of the inverted operator
		for(j=0;j<Operators[i].sof_lists[delete_list];j++)
			Inv_Operators[i].strips[add_list][j]=Operators[i].strips[delete_list][j];
		
// construct the precondition list of the inverted operator
		for(j=0;j<Operators[i].sof_lists[add_list];j++)
			Inv_Operators[i].strips[prec_list][j]=Operators[i].strips[add_list][j];
		int k;
		for(k=0;k<Operators[i].sof_lists[prec_list];k++)
		{
			bool flag=true;
			int m=0;
			while(m<Operators[i].sof_lists[delete_list] && flag)
			{
				if (Operators[i].strips[prec_list][k]==Operators[i].strips[delete_list][m])
					flag=false;
				m++;
			}
			if (flag)
				Inv_Operators[i].strips[prec_list][j++]=Operators[i].strips[prec_list][k];
		}

// construct the list with the resources
		resource_consumption* r;
		resource_consumption* r_inv=NULL;
		r=Operators[i].resources;
		while (r!=NULL)
		{
			if (r_inv==NULL)
			{
				Inv_Operators[i].resources=new resource_consumption(r->object_ID,r->amount);
				r_inv=Inv_Operators[i].resources;
			}
			else
			{
				r_inv->next=new resource_consumption(r->object_ID,r->amount);
				r_inv=r_inv->next;
			}
			r=r->next;
		}
	}
}


pointer* hash_table;

void insert_preconditions_to_hash(inverted_action* inv_action);


void create_inverted_action(action* act)
{
	int oper_id=act->operator_id;
	int* vars=act->parameters;
	//cout << "Success" << endl;
	inverted_action* inv_action=new inverted_action(act);
	//cout << inv_action->step << endl;
	inv_action->next=all_inverted_actions;
	all_inverted_actions=inv_action;
	if(Inv_Operators[oper_id].sof_lists[prec_list]>0)	
		insert_preconditions_to_hash(inv_action);
	else
		// this case logically will never occurs, since in order to 
		// an inverted action do not have any precondition, 
		// a normal action should not have any effect.
	{
		inv_action->distances=new inverted_distance();
		inv_action->distances->v_distance=new vector();
		linked_inverted_action* new_inverted_satisfied_action=new linked_inverted_action(inv_action);
		if (inverted_satisfied_head==NULL)
		{
			inverted_satisfied_tail=new_inverted_satisfied_action;
			inverted_satisfied_head=new_inverted_satisfied_action;
		}
		else
		{
			inverted_satisfied_tail->next=new_inverted_satisfied_action;
			inverted_satisfied_tail=new_inverted_satisfied_action;
		}
	}

	// check if there are resources that can be produced...
	// (they should be characterized of type 2)
	if (nof_resources>0)
	{
		resource_consumption* r;
		r=Operators[oper_id].resources;
		while (r!=NULL)
		{
			if (r->amount<0)
			{	
				if (r->object_ID>0)
					resources[objects[r->object_ID].resource].type=2;
				else
					resources[objects[vars[-r->object_ID-1]].resource].type=2;
			}
			r=r->next;
		}
	}
}


void create_inverted_actions()
{
	Operators=Inv_Operators;
	action* t_action=all_actions;
	while (t_action!=NULL)
	{
		create_inverted_action(t_action);
		t_action=t_action->next;
	}
	Operators=Normal_Operators;
}

	
// Function 'insert_precondtitions_to_hash' adds all the preconditions of an inverted action
// into the hash table.
void insert_preconditions_to_hash(inverted_action* inv2_action)
{
//	cout << *inv2_action->step << endl;
	int i;
	for(i=0;i<Operators[inv2_action->step->operator_id].sof_lists[prec_list];i++)
	{
		fact f=Operators[inv2_action->step->operator_id].strips[prec_list][i].instantiate(inv2_action->step->parameters);
		if (!constant_predicates[f.pred])	// only the non-constant predicates are stored in the hash table
		{
			//inverted_action* inv2_action=new inverted_action(inv_action);
			hash_entry* h=get_fact_pointer(&f);
			if (inv2_action!=NULL)
			{
				linked_inverted_action* new_action=new linked_inverted_action(inv2_action);
				new_action->next=h->inv_op_prec;
				h->inv_op_prec=new_action;
			}
			inv2_action->precs=new linked_hash_entry(h, inv2_action->precs);
		}
	}	// for(i)
}


// Function 'set_distance_related' sets the distance and the list of related facts
// of a fact in the hash table.
void set_distance_related(hash_entry* f, vector* v, linked_hash_entry* related, inverted_action* inv_act);

// Function 'add_goals' adds all the goals of a problem instance to the hash table,
// with distance=0 and keep=NULL. 
void add_goals(state* goal)
{
	vector* v;
	v=new vector();;
	Operators=Inv_Operators;
	 int i;
	for(i=0;i<goal->size;i++)
	{
		//cout << "Adding goal fact " << goal->facts[i] << endl;
		set_distance_related(get_fact_pointer(&goal->facts[i]), v, NULL,NULL);
	}
	delete v;
	Operators=Normal_Operators;
}

// Function 'check inverted_actions' finds which of the inverted actions of an achieved fact
// have all of their preconditions satisfied and adds them to the agenda of the satisfied
// inverted actions.
void check_inverted_actions(hash_entry* h);

void test_mins();

// Function 'set_distance_related' sets the distance and the list of related facts
// of a fact in the hash table.
void set_distance_related(hash_entry* h, vector* v, linked_hash_entry* related, inverted_action* inv_act)
{
//	fact f1=fact("idle", "grinder");
//	fact f2=fact("unscheduled", "A0");

//	if (h->f==f1)
//		cout << "bingo1" << endl;
//	if (h->f==f2)
//		cout << "bingo2" << endl;

//  THIS CHECK IS FOR SIMPLIFICATION. ACTUALLY SUCH FACTS SHOULD NOT GET PASSED AS
//  ARGUMENTS TO set_distance_related. TO HAPPEN THIS, FUNCTION check_inverted_actions
//  SHOULD CHECK THE ACTIONS HAVING THE CURRENT FACT AS PRECONDITION, IF THEY HAVE
//	NON_ACHIEVED FACTS IN THE OTHER PRECONDITIONS AND ADD EFFECTS 

	if (!h->achieved)
		return;
	
	//cout << h->f << endl;
	bool found_better=false;
	int i;
	for(i=0;i<=nof_consumable_resources;i++)
		v->mins[i]=false;
	bool found_min=false;
		
	if (h->subproblem_distances==NULL)
	{
		cout << "ERROR 389364920247204278240248" << endl;
		cout << h->f << endl;
		abort();
	}
	linked_distances* old_distances=h->subproblem_distances->distances;
	
	if (old_distances!=NULL && enriched_no_used)
		return;

	if (old_distances==NULL)
	{
		found_min=true;
		for(i=0;i<=nof_consumable_resources;i++)
			v->mins[i]=true;
	}

	while (old_distances!=NULL && !found_better)
	{
		/*
		fact test_f=fact("at", "package2","city2");
		if (test_f==h->f)
		{
			cout << "bingo1" << endl;
			test_mins();
			cout << "NEW VECTOR = " << *v << endl;
		}
		*/
		if (!old_distances->should_be_deleted)
		{
			// if an old vector is equal or better than the new vector...
			if (*old_distances->v_distance <= v)
				found_better=true;
			else
			{
			// if the new vector is better than the old vector
				if (*v < old_distances->v_distance)
				{
					old_distances->should_be_deleted=true;
					found_min=true;
					int	j;
					for (j=0;j<=nof_consumable_resources;j++)
						if (old_distances->v_distance->mins[j])
						{
							old_distances->v_distance->mins[j]=false;
							v->mins[j]=true;
						}	
				}
				else
				{
					for(i=0;i<=nof_consumable_resources;i++)
					{
						if (old_distances->v_distance->mins[i])
							if (old_distances->v_distance->elements[i]>v->elements[i])
							{
								old_distances->v_distance->mins[i]=false;
								v->mins[i]=true;
								found_min=true;
								// check if the old_distance has more mins,
								// otherwise it sould be deleted...
								int j=0;
								bool more_mins=false;
								while (j<=nof_consumable_resources && !more_mins)
								{
									more_mins=old_distances->v_distance->mins[j];
									j++;
								}
								if (!more_mins)
									old_distances->should_be_deleted=true;
							}
					}
				}	
			}
			
		}
		old_distances=old_distances->next;
	}

	if (found_better && found_min)
	{
		cout << "ERROR 384672349238239524375340534" << endl;
		abort();
	}

	if (found_better)
		TEST_COUNTER++;

	if (!found_better && found_min)
	{
		
/*		if (h->subproblem_distances->distances!=NULL)
		{
			cout << h->f << ": ALTERNATIVE DISTANCE ADDED..." << endl;
			old_distances=h->subproblem_distances->distances;
			cout << "OLD DISTANCES" << endl;
			while (old_distances!=NULL)
			{
				cout << *old_distances->v_distance ;
				if (!old_distances->should_be_deleted)
					cout << " : NOT DELETED" << endl;
				else
					cout << " : DELETED" << endl;
				old_distances=old_distances->next;
			}
			cout << "NEW DISTANCE: " << *v << endl;
		} */
		
		int i=0;
		bool enabled=true;
		while (i<predicates[h->f.pred].arity && enabled)
			if (objects[h->f.arguments[i]].idle->value)
			{
	//			cout << f->f << endl;
				enabled=false;
			}
			else
				i++;

		if (enabled && h->subproblem_distances->distances==NULL)
		{
			nof_set_facts++;
//			cout << "Fact achieved " << nof_set_facts << " : " << f->f << endl;
		}

		h->subproblem_distances->distances=new linked_distances(h->subproblem_distances->distances);
		h->subproblem_distances->distances->h=h;
		h->subproblem_distances->distances->v_distance=new vector();
		*h->subproblem_distances->distances->v_distance=*v;
		h->subproblem_distances->distances->related=related;
		h->subproblem_distances->distances->achieved_by=inv_act;
//		cout << h->f << "  =  " << *v << endl;

		/*
		fact test_f=fact("at", "package2","city2");
		if (test_f==h->f)
		{
			cout << "bingo11" << endl;
			test_mins();
		}
		*/

		check_inverted_actions(h);
	}
	/*else
	{
		if (display_messages)
		{
			if (old_distances!=NULL)
			{
				if (old_distances->v_distance->elements[0]>0)
				{
					cout << "ALTERNATIVE DISTANCE REJECTED..." << endl;
					old_distances=h->subproblem_distances->distances;
					cout << "OLD DISTANCES" << endl;
					while (old_distances!=NULL)
					{	
						cout << *old_distances->v_distance << endl;
						old_distances=old_distances->next;
					}
					cout << "NEW DISTANCE: " << *v << endl;
					cout << endl;
				}
			}
		}
	}*/
}

// Function 'inverted_keep' checks if the preconditions of an inverted action have all been 
// satisfied, and, if so, it returns true, together with (argument keep) the keeped facts 
// of this action (whereas are not included action's preconditions), otherwise it returns false.
void inverted_keep(inverted_action* step, hash_entry* h);

// Function 'extract_grade' takes as input a linked list of hash entries, and returns
// the sum of their distances.
vector* extract_grade(linked_linked_distances* reduced_end_facts);

// Function 'check_inverted_actions' finds which of the inverted actions of an achieved fact
// have all of their preconditions satisfied and adds them to the agenda of the satisfied
// inverted actions.
// ATTENTION: THE NEW COST OF THE ACHIEVED FACT IS ITS FIRST COST VECTOR
// (NEW COST VECTORS ARE LOCATED IN THE BEGINNING OF THE DISTANCES LIST)
void check_inverted_actions(hash_entry* h)
{
	// This flag is used when a fact has been achieved and we
	// are looking about the applicability of the actions having this fact
	// as precondition. We want that for each fact only one action
	// having an unused fact of the enriched goal state as precondition
	// can be added in the agenda...
	linked_inverted_action* inv_op_prec=h->inv_op_prec;

	while (inv_op_prec!=NULL)
	{
		//cout << inv_op_prec->inverted_step->step << endl;
		//if (inv_op_prec->inverted_step->in_agenda==false)	// check only for the inverted_actions
		//{													// that are not already in the agenda
			// check if there is a parameter of the ground action 
			// equal to a disabled object...
			bool enabled=true;
			int i=0;
			while (i<Operators[inv_op_prec->inverted_step->step->operator_id].nof_parameters && enabled)
			{
				//cout << inv_op_prec->inverted_step->step << endl;
				if (objects[inv_op_prec->inverted_step->step->parameters[i]].idle->value)
					enabled=false;
				else
					i++;
			}

			if (enabled)
				inverted_keep(inv_op_prec->inverted_step, h);
		// }
		inv_op_prec=inv_op_prec->next;
	}
}

// Function 'get_fact_pointer' takes a fact as a first argument and returns a pointer 
// to the hash entry concerning this fact. If there is no hash entry concerning this fact,
// the pointer is set to NULL.
hash_entry* get_fact_pointer(fact* f);

// Function 'included_in_delete_list' checks whether a fact is included or not in the delete list
// of an action and returns true or false respectively.
bool included_in_delete_list(fact f, action* step);

// Function 'included_in_fact_list' checks whether a fact is included or not in a linked list 
// of facts and returns true or false respectively.
bool included_in_fact_list(hash_entry* f, linked_hash_entry* linked_list);

// Function 'included_in_fact_list' checks whether a fact is included or not in a linked list 
// of facts and returns true or false respectively.
bool included_in_fact_list(hash_entry* f, linked_linked_distances* linked_list);


void compute_actions_distances(inverted_action* inv_act, linked_hash_entry* remaining_precs, hash_entry* h,
		linked_hash_entry* keep, linked_linked_distances* l_distances);
		
// Function 'inverted_keep' checks if the preconditions of an inverted action have all been 
// satisfied, and, if so, it returns true, together with (argument keep) the keeped facts 
// of this action (whereas are also included action's preconditions), otherwise it returns false.
void inverted_keep(inverted_action* inv_act, hash_entry* h)
{
	linked_hash_entry* precs=inv_act->precs;

	bool flag=true;
	while (precs!=NULL && flag)
	{
		if (!precs->entry->achieved)
			return;
		if (precs->entry->subproblem_distances->distances==NULL)
			return;
		precs=precs->next;
	}
	
	precs=inv_act->precs;

	linked_hash_entry* keep=NULL;
	linked_linked_distances* l_distances=NULL;

	compute_actions_distances(inv_act, precs, h, keep, l_distances);
}


// This is a recursive functions which computes the cost for applying an action, 
// based on all the combinations of action's preconditions' cost vectos...
void compute_actions_distances(inverted_action* inv_act, linked_hash_entry* remaining_precs, hash_entry* h,
		linked_hash_entry* keep, linked_linked_distances* l_distances)
{
	if (remaining_precs!=NULL)
	{
		// construct the list of related facts
		// for the inverted action...
	
		linked_distances* fact_distances=remaining_precs->entry->subproblem_distances->distances;
		while (fact_distances!=NULL)
		{
			if (!fact_distances->should_be_deleted)
			{
				l_distances=new linked_linked_distances(fact_distances, l_distances);
			
				if (!included_in_delete_list(remaining_precs->entry->f, inv_act->step) &&	// add the fact itself
					!included_in_fact_list(remaining_precs->entry, keep) )		// in the 'keep' list
				{
					keep=new linked_hash_entry(fact_distances->h, keep);
				}				
			
				linked_hash_entry* related=fact_distances->related;  // add the fact's related facts to the 'keep' list
				while (related!=NULL)
				{	// checks whether the fact is not included in the delete list of the operator
					// and is not already inserted in the keep list 
					if (!included_in_delete_list(related->entry->f, inv_act->step) &&
						!included_in_fact_list(related->entry, keep))
					{
						keep=new linked_hash_entry(related->entry, keep);
					}
					related=related->next;
				}
				compute_actions_distances(inv_act, remaining_precs->next, h, keep, l_distances);
			}
			if (h==remaining_precs->entry)
				fact_distances=NULL;
			else
				fact_distances=fact_distances->next;
		}
		remaining_precs=remaining_precs->next;
	}
	else	// if (remaining_precs!=NULL)
	{
		vector* v;

		linked_linked_distances* dummy=NULL;
		v= find_grade(l_distances, &dummy);	
		*v = (*v) + (*inv_act->inverted_action_cost);

		int i;
		for(i=0;i<=nof_consumable_resources;i++)
			v->mins[i]=false;
		bool found_min=false;
	
		// Check if the new cost is not totally worse than an old cost of the action...
		bool worse=false;
		inverted_distance* old_distances=inv_act->distances;
		inverted_distance* old_distance_prev=NULL;
		
		if (old_distances==NULL)
		{
			for(i=0;i<=nof_consumable_resources;i++)
				v->mins[i]=true;
			found_min=true;
		}

		while (old_distances!=NULL && !worse)
		{
			if (!old_distances->should_be_deleted)
			{
		
				if (*old_distances->v_distance <= v)
					worse=true;
				else
				{
					if (*v < old_distances->v_distance)
					{
						found_min=true;
						for (i=0;i<=nof_consumable_resources;i++)
						{
							if (old_distances->v_distance->mins[i])
							{
								old_distances->v_distance->mins[i]=false;
									v->mins[i]=true;
							}
						}
	
						if (old_distances->has_been_applied)
						{
							old_distances->should_be_deleted=true;
							old_distance_prev=old_distances;
							old_distances=old_distances->next;
						}
						else
						{
							if (old_distance_prev==NULL)
							{
								old_distances=old_distances->next;
								delete inv_act->distances;
								inv_act->distances=old_distances;
							}
							else
							{
								old_distances=old_distances->next;
								delete old_distance_prev->next;
								old_distance_prev->next=old_distances;
							}
						}
					}	// if (*v < old_distances->v_distance)
					else	// check for absolute min...
					{
						bool to_be_deleted=false;
						for (i=0;i<=nof_consumable_resources;i++)
						{
							if (old_distances->v_distance->mins[i])
								if (old_distances->v_distance->elements[i] > v->elements[i])
								{
									old_distances->v_distance->mins[i]=false;
									v->mins[i]=true;
									found_min=true;
									// check if the old_distance has more mins,
									// otherwise it sould be deleted...
									int j=0;
									bool more_mins=false;
									while (j<=nof_consumable_resources && !more_mins)
									{
										more_mins=old_distances->v_distance->mins[j];
										j++;
									}
									if (!more_mins)
										to_be_deleted=false;
								}
						}
						if (to_be_deleted)
						{
							if (old_distances->has_been_applied)
							{
								old_distances->should_be_deleted=true;
								old_distance_prev=old_distances;
								old_distances=old_distances->next;
							}
							else
							{
								if (old_distance_prev==NULL)
								{
									old_distances=old_distances->next;
									delete inv_act->distances;
									inv_act->distances=old_distances;
								}
								else
								{
									old_distances=old_distances->next;
									delete old_distance_prev->next;
									old_distance_prev->next=old_distances;
								}
							}
						}
						else
						{
							old_distance_prev=old_distances;
							old_distances=old_distances->next;
						}
					}
				}
				
			}
			else	// if (!old_distances->should_be_deleted)
			{
				old_distance_prev=old_distances;
				old_distances=old_distances->next;
			}
		}

		if (worse && found_min)
		{
			cout << "ERROR 494759903487459237439340" << endl;
			abort();
		}

		if (!worse && found_min)
		{
			//if (inv_act->distances!=NULL)
			//	cout << "bingo2" << endl;
			inv_act->distances=new inverted_distance(inv_act->distances);
			//inv_act->distances->v_distance=new vector();
			inv_act->distances->v_distance=v;
			inv_act->distances->keep=keep;

			if (!inv_act->in_agenda)
			{
				linked_inverted_action* new_inverted_satisfied_action=new linked_inverted_action(inv_act); 
				if (inverted_satisfied_tail==NULL)
				{
					inverted_satisfied_tail=new_inverted_satisfied_action;
					inverted_satisfied_head=new_inverted_satisfied_action;
				}
				else
				{
					inverted_satisfied_tail->next=new_inverted_satisfied_action;
					inverted_satisfied_tail=new_inverted_satisfied_action;
				}
				inv_act->in_agenda=true;
			}
		}
	}
}

// Function 'included_in_delete_list' checks whether a fact is included or not in the delete list
// of an action and returns true or false respectively.
bool included_in_delete_list(fact f, action* step)
{
	int i;
	for(i=0;i<Operators[step->operator_id].sof_lists[delete_list];i++)
		if (f==Operators[step->operator_id].strips[delete_list][i].instantiate(step->parameters))
			return true;
	return false;
}

// Function 'included_in_fact_list' checks whether a fact is included or not in a linked list 
// of facts and returns true or false respectively.
bool included_in_fact_list(hash_entry* h, linked_hash_entry* linked_list)
{
	while (linked_list!=NULL)
		if (h==linked_list->entry)
			return true;
		else
			linked_list=linked_list->next;
	return false;
}
 

// Function 'included_in_fact_list' checks whether a fact is included or not in a linked list 
// of facts and returns true or false respectively.
bool included_in_fact_list(hash_entry* h, linked_linked_distances* linked_list)
{
	while (linked_list!=NULL)
		if (h==linked_list->distances->h)
			return true;
		else
			linked_list=linked_list->next;
	return false;
}


// Function 'get_fact_pointer' takes a fact as a first argument and returns a pointer 
// to the hash entry concerning this fact. If there is no hash entry concerning this fact,
// the pointer is set to NULL.
hash_entry* get_fact_pointer(fact* f)
{
	void* ptr=hash_table[f->pred].forward;
	bool flag;
	flag=true;
	if (ptr==NULL)	// ptr points to the first (zero) arguments' table of the predicate
	{
		return NULL;
		flag=false;
		cout << "ERROR (GET_FACT_POINTER): Fact " << *f << "does not exist in the hash table." << endl;
		abort();
	}
	int i=0;
	while (i<predicates[f->pred].arity && flag)
	{
		ptr=((pointer*) ptr)[f->arguments[i]-1].forward;	// ptr points to the i+2 (i+1) arguments' table
													// of the predicate
		if (ptr==NULL)
			flag=false;
		i++;
	}
	if (flag)
	{
		return ((hash_entry*) ptr);
	}
	else
		return NULL;
}

// Function 'find_reduced_end_facts' takes as input a linked list of pointers to facts (in the
// hash entry) and returns two lists, the list of 'end_facts' and the list of 'previous_facts'.
// Moreover, the function freezes the memory allocated to the list 'linked_facts'.
void	find_reduced_end_facts(linked_linked_distances* linked_facts, 
					   linked_linked_distances** end_facts,
					   linked_linked_distances** previous_facts);


// Function 'find_not_last_keeped' takes as input the lists of the 'reduced_end_facts' and the
// 'previous_facts' and returns the list 'not_last_keeped', which is the subset of 'previous_facts'
// that are not included in any of the lists of related atoms of the 'reduced_end_facts'.
void	find_not_last_keeped(linked_linked_distances* previous_facts, 
							 linked_linked_distances* reduced_end_facts, 
							 linked_linked_distances** not_last_keeped);

// Function 'delete_linked_hash_entry_list' takes as input a pointer to the head 
// of a linked hash entry list and deletes (freezes) all the memory allocated
// to that list.
void delete_linked_hash_entry_list(linked_hash_entry* ptr);

void delete_l2_distances_list(linked_linked_distances* l_distances)
{
	linked_linked_distances* t;
	while (l_distances!=NULL)
	{
		t=l_distances;
		l_distances=l_distances->next;
		delete t;
	}
}

// Function 'find_grade' finds the cost for achieving together a set of facts,
// (which are passed to the function as a linked list of 'linked_hash_entry' pointers)
// based on the costs for achieving them separately and on their lists of related facts.
vector* find_grade(linked_linked_distances* linked_facts, linked_linked_distances** original_reduced_end_facts)
{
	*original_reduced_end_facts=NULL;
	vector* v;
	v=new vector();
	if (NO_RELATED)
		*v=*extract_grade(linked_facts);
	else
	{
		linked_linked_distances* reduced_end_facts;
		linked_linked_distances* previous_facts;
		linked_linked_distances* not_last_keeped;
		while (linked_facts!=NULL)
		{
			find_reduced_end_facts(linked_facts, &reduced_end_facts, &previous_facts);
			if (*original_reduced_end_facts==NULL)
				*original_reduced_end_facts=reduced_end_facts;
			find_not_last_keeped(previous_facts, reduced_end_facts, &not_last_keeped);
			*v=*v +(*extract_grade(reduced_end_facts));
			//delete_l2_distances_list(reduced_end_facts);
			delete_l2_distances_list(previous_facts);
			//delete_l2_distances_list(linked_facts);
			linked_facts=not_last_keeped;
		}
	}
	return v;
}
	

// Function 'delete_linked_hash_entry_list' takes as input a pointer to the head 
// of a linked hash entry list and deletes (freezes) all the memory allocated
// to that list.
void delete_linked_hash_entry_list(linked_hash_entry* ptr)
{
	linked_hash_entry* ptr2;
	while (ptr!=NULL)
	{
		ptr2=ptr->next;
		delete ptr;
		ptr=ptr2;
	}
}


// Function 'keeped' checks if a fact pointed by 'hash_entry' is included in any of 
// the 'related' lists  of the facts included in the list 'linked_facts_head',
// without occurring the inverse. 
bool keeped(linked_linked_distances* hash_entry, linked_linked_distances* linked_facts_head);

// Function 'equivalent_introduced' checks if the end_fact pointed by 'linked_facts'
// is included in any of the lists of related facts of the already introduced 'end_facts'.
bool	equivalent_introduced(linked_linked_distances* linked_facts, linked_linked_distances* end_facts);

// Function 'find_reduced_end_facts' takes as input a linked list of pointers to facts (in the
// hash entry) and returns two lists, the list of 'end_facts' and the list of 'previous_facts'.
void	find_reduced_end_facts(linked_linked_distances* linked_facts, 
					   linked_linked_distances** end_facts,
					   linked_linked_distances** previous_facts)
{
	*end_facts=NULL;
	*previous_facts=NULL;
	linked_linked_distances* linked_facts_head;
	linked_facts_head=linked_facts;
	while (linked_facts!=NULL)
	{
		if (keeped(linked_facts, linked_facts_head))
		{
			linked_linked_distances* tmp=new linked_linked_distances(linked_facts->distances);
			tmp->next=(*previous_facts);
			(*previous_facts)=tmp;
		}
		else
		{
			if (!equivalent_introduced(linked_facts, *end_facts))
			{
				linked_linked_distances* tmp=new linked_linked_distances(linked_facts->distances);
				tmp->next=(*end_facts);
				(*end_facts)=tmp;
			}
		}
		linked_linked_distances* tmp;
		tmp=linked_facts->next;
		linked_facts=tmp;
	}
}

// Function 'keeped' checks if a fact pointed by 'hash_entry' is included in any of 
// the 'related' lists  of the facts included in the list 'linked_facts_head',
// without occurring the inverse. 
bool	keeped(linked_linked_distances* fact_distance, linked_linked_distances* linked_facts_head)
{
	while (linked_facts_head!=NULL)
	{
		linked_hash_entry* related;
		related=linked_facts_head->distances->related;
		while (related!=NULL)
		{
			if (fact_distance->distances->h==(related->entry))	// if the fact hash_entry is included
			{										// in the list of related facts of the
				bool flag=true	;					// fact pointed by current 'linked_facts_head'
				linked_hash_entry* related2=fact_distance->distances->related;
				while (related2!=NULL && flag)
				{
					if (linked_facts_head->distances->h==related2->entry)
						flag=false;
					else
						related2=related2->next;
				}
				if (flag)
				{
					return true;
				}
			}
			related=related->next;
		}
		linked_facts_head=linked_facts_head->next;
	}
	return false;
}


// Function 'equivalent_introduced' checks if the end_fact pointed by 'linked_facts'
// is included in any of the lists of related facts of the already introduced 'end_facts'.
bool	equivalent_introduced(linked_linked_distances* linked_facts, linked_linked_distances* end_facts)
{
	while (end_facts!=NULL)
	{
		linked_hash_entry* related;
		related=end_facts->distances->related;
		while (related!=NULL)
		{
			if (linked_facts->distances->h==related->entry)
				return true;
			related=related->next;
		}
		end_facts=end_facts->next;
	}
	return false;
}

// Function 'extract_grade' takes as input a linked list of hash entries, and returns
// the sum of their distances.
vector* extract_grade(linked_linked_distances* reduced_end_facts)
{
	vector* v=new vector();
	while (reduced_end_facts!=NULL)
	{
		*v=*v+ (*reduced_end_facts->distances->v_distance);
		reduced_end_facts=reduced_end_facts->next;
	}
	return v;
}


// Function 'find_not_last_keeped' takes as input the lists of the 'reduced_end_facts' and the
// 'previous_facts' and returns the list 'not_last_keeped', which is the subset of 'previous_facts'
// that are not included in any of the lists of related atoms of the 'reduced_end_facts'.
void	find_not_last_keeped(linked_linked_distances* previous_facts, 
							 linked_linked_distances* reduced_end_facts, 
							 linked_linked_distances** not_last_keeped)
{
	*not_last_keeped=NULL;
	while (previous_facts!=NULL)		// for every fact in the 'previous_facts'
	{
		linked_linked_distances* ptr;
		ptr=reduced_end_facts;
		bool flag=true;
		while (ptr!=NULL && flag)		// for every fact in the reduced_end_facts
		{
			linked_hash_entry* related=ptr->distances->related;
			while (related!=NULL && flag)	// for every related facts of the fact under
			{					// consideration from the list of the reduced end facts
				if (related->entry==previous_facts->distances->h)
					flag=false;
				else
					related=related->next;
			}
			ptr=ptr->next;
		}
		if (flag)
		{
			linked_linked_distances* tmp=new linked_linked_distances(previous_facts->distances);
			tmp->next=*not_last_keeped;
			*not_last_keeped=tmp;
		}
		previous_facts=previous_facts->next;
	}
}

void display_inverted_satisfied()
{
	cout << endl;
	cout << "Inverted Satisfied Actions" << endl;
	cout << "==========================" << endl;
	linked_inverted_action* ptr;
	ptr=inverted_satisfied_head;
	while (ptr!=NULL)
	{
		cout << ptr->inverted_step->step << endl;
		cout << "Score: " << ptr->inverted_step->distances->v_distance->elements[0]<< endl;
		ptr=ptr->next;
	}
}


int has_actions_at_level(hash_entry* h)
{
	/*if (strcmp2("at", predicates[h->f.pred].name) &&
		strcmp2("truck3", objects[h->f.arguments[0]].name) &&
		strcmp2("city13", objects[h->f.arguments[1]].name) )
		cout << "bingo" << endl;
	*/
	int min_level=1000;
	linked_inverted_action* actions=h->inv_op_prec;
	while (actions!=NULL) 
	{
//		cout << actions->inverted_step->step << endl;
		
		int counter=1;
		
		int i=0;
		bool enabled=true;
		while (enabled && i<Operators[actions->inverted_step->step->operator_id].nof_parameters)
		{
			if (objects[actions->inverted_step->step->parameters[i]].idle->value)
				enabled=false;
			else
				i++;
		}

		if (enabled)
		{
			linked_hash_entry* precs=actions->inverted_step->precs;
			while (precs!=NULL )
			{
				if (precs->entry->f.enabled() && precs->entry->achieved)
				{
//				cout << precs->entry->f << endl;
				if (precs->entry->subproblem_distances->distances==NULL)
				{
					if (!precs->entry->linked_enriched->value )
						counter += 500;
					if (precs->entry->linked_enriched->value )
						counter += 1;
				}
				else
				{
					if (!precs->entry->linked_enriched->value)
					{
						if (precs->entry->subproblem_distances->distances->v_distance->elements[0]==0)
							if (!precs->entry->goal_fact_used)
							{
								counter -= 1;
								precs->entry->goal_fact_used=true;
							}

						hash_entry* h1=precs->entry;
						if (h1->forward_achieved_by!=NULL)
						{
							if (actions->inverted_step->step->operator_id==h1->forward_achieved_by->step->operator_id)
							{
				//				cout << h1->f ;
				//				cout << "   forward achiecd by: " << *h1->forward_achieved_by->step << endl;
				//				cout << "Now checking: " << actions->inverted_step->step << endl;
								bool same_action=true;
								int j=0;
								while (j<Inv_Operators[actions->inverted_step->step->operator_id].nof_parameters && same_action)
								{
									if (actions->inverted_step->step->parameters[j]!=h1->forward_achieved_by->step->parameters[j])
										same_action=false;
									else
										j++;
								}
								if (same_action)
									counter--;
				//				else
				//				{
				//					cout << "SUCCESS..." << endl;
				//				}
							}
						} 
					}
				}
				}
				else	// if (precs->entry->f.enabled())
					counter=counter+10000;

				precs=precs->next;
			}
			if (min_level>counter)
				min_level=counter;
		}
		actions=actions->next;
	}
	return min_level;
}


void process_enriched_fact(hash_entry* h)
{
	//if (display_messages)
	// cout << "ENRICHED FACT USED: " << h->f << endl;
	//enriched->entry->distance=-1;
	vector* v; 
	v=new vector();
	set_distance_related(h, v, NULL,NULL);
	delete v;
	if (!enriched_no_used)
	{
		h->linked_used->value=true;
		linked_hash_entry* mutex=h->mutexes;
		while (mutex!=NULL)
		{
			mutex->entry->linked_used->value=true;
			mutex=mutex->next;
		}
	}
}

void delete_used_new_goals(linked_hash_entry** new_goals)
{
	linked_hash_entry* t_goals=*new_goals;
	linked_hash_entry* t_goals_prev=NULL;
	while (t_goals!=NULL)
	{
		if (t_goals->entry->enriched_init_used==true)
		{
			if (t_goals_prev==NULL)
			{
				t_goals_prev=t_goals;
				t_goals=t_goals->next;
				delete t_goals_prev;
				t_goals_prev=NULL;
				*new_goals=t_goals;
			}
			else
			{
				t_goals_prev=t_goals->next;
				delete t_goals;
				t_goals=t_goals_prev->next;
			}
		}
		else
		{
			t_goals_prev=t_goals;
			t_goals=t_goals->next;
		}
	}
}

// Function "check_for_new_goals" checks whether there are unused
// facts of the enriched goal state that can add new inverted actions 
// to the agenda...
bool check_for_more_goals(linked_hash_entry* new_goals)
{
	t_more_goals=t_more_goals-clock();
	int cost;
	int min_level=1000;
	hash_entry* min_cost_fact=NULL;
	

	// first trying the fact of the initial state...
	int i=0;
	while (i<initial->size )
	{
		hash_entry* h;
		h=get_fact_pointer(&initial->facts[i]);
		if (h->linked_enriched->value && !h->linked_used->value)
		{
//			cout << "Checkig initial state fact: " << h->f << endl;
			cost=has_actions_at_level(h);
			if (cost<min_level)
			{
				min_level=cost;
				min_cost_fact=h;
				if (min_level<=0)
				{
					process_enriched_fact(min_cost_fact);
					t_more_goals=t_more_goals+clock();
//					delete_used_new_goals(&new_goals);
					return true;
				}
			}
		}
		i++;	
	}

	linked_hash_entry* enriched;
	enriched=new_goals;
	while (enriched!=NULL)
	{
//			cout << "Checking: " << enriched->entry->f << " at level=" << level << endl;
		if (!enriched->entry->linked_used->value && enriched->entry->subproblem_distances->distances==NULL)
		{
			cost=has_actions_at_level(enriched->entry);
			if (cost<min_level)
			{
				min_level=cost;
				min_cost_fact=enriched->entry;
				if (min_level<=0)
				{
					process_enriched_fact(min_cost_fact);
					t_more_goals=t_more_goals+clock();
//					delete_used_new_goals(&new_goals);
					return true;
				}
			}
		}
		enriched=enriched->next;
	}
	
	if (min_cost_fact!=NULL)
	{
		process_enriched_fact(min_cost_fact);
//		delete_used_new_goals(&new_goals);
		t_more_goals=t_more_goals+clock();
		return true;
	}
	else
		t_more_goals=t_more_goals+clock();
		return false;
}

// Function 'not_mutex' returns 'true', if f1 and f2 are not mutual exclusive,
// otherwise it returns 'false'.
bool not_mutex(hash_entry* f1, hash_entry* f2)
{
	linked_hash_entry* mutexes;
	mutexes=f1->mutexes;
	while (mutexes!=NULL)
	{
		if (mutexes->entry==f2)
			return false;
		else
			mutexes=mutexes->next;
	}
	return true;
}


void test_mins();

// Function 'find_all_distances' repeatedly reads the head of the inverted satisfied operators 
// linked list and adds the distances and the related facts of their add-list facts 
// to the hash-table.
void find_all_distances(linked_hash_entry* new_goals)
{
	int t_time=-clock();
	Operators=Inv_Operators;

	bool more_goals=true;
	if (reduced_enriched && inverted_satisfied_head==NULL)
	{
		more_goals=check_for_more_goals(new_goals);
		while (inverted_satisfied_head==NULL && more_goals)
			more_goals=check_for_more_goals(new_goals);
	}

	int counter=0;
	while (inverted_satisfied_head!=NULL ) // && nof_set_facts<nof_enabled_facts)
	{
		TEST_COUNTER2++;
//		cout << TEST_COUNTER2 << " : " << *inverted_satisfied_head->inverted_step->step << endl;
		inverted_satisfied_head->inverted_step->applied=true;

		inverted_distance* action_distances=inverted_satisfied_head->inverted_step->distances;
		if (action_distances==NULL)
		{
			cout << "ERROR 83647334943834628230" << endl;
			abort();
		}
		
		action* step;		
		step=inverted_satisfied_head->inverted_step->step; // for shortness
		while (action_distances!=NULL)
		{
			TEST_COUNTER3++;
			check_time();
			counter++;

			if (!action_distances->has_been_applied && !action_distances->should_be_deleted)
			{
				int i;
				for(i=0;i<Operators[step->operator_id].sof_lists[add_list];i++)
				{
					hash_entry* f=get_fact_pointer(&Operators[step->operator_id].strips[add_list][i].instantiate(step->parameters));
					linked_hash_entry* keep1;
					keep1=NULL;
					if (!NO_RELATED)
					{
						linked_hash_entry* keep2;
						keep2=action_distances->keep;
						while (keep2!=NULL)
						{
							if (not_mutex(f, keep2->entry))
								keep1=new linked_hash_entry(keep2->entry, keep1);
							keep2=keep2->next;
						}
						int j;
						for(j=0;j<Operators[step->operator_id].sof_lists[add_list];j++)
							if (i!=j)
							{
								hash_entry* f1=get_fact_pointer(&Operators[step->operator_id].strips[add_list][j].instantiate(step->parameters));
								if (!included_in_fact_list(f1, keep1))
									if (not_mutex(f, f1))
										keep1=new linked_hash_entry(f1, keep1);
							}
					}	// if (!NO_RELATED)
					//cout << "Adding fact distance " << f->f << endl;
					vector* v=new vector();
					*v = *action_distances->v_distance;
					set_distance_related(f,v,keep1,inverted_satisfied_head->inverted_step);
					delete v;
				}
				action_distances->has_been_applied=true;
			}
			action_distances=action_distances->next;
		}	// while (action_distances!=NULL)

		linked_inverted_action* tmp;
		tmp=inverted_satisfied_head->next;
		inverted_satisfied_head->inverted_step->in_agenda=false;
		delete inverted_satisfied_head;
		inverted_satisfied_head=tmp;
		if (inverted_satisfied_head==NULL)
			inverted_satisfied_tail=NULL;

		// If the agenda is empty, check for new goals that could 
		// add actions in the agenda...
		if (reduced_enriched && inverted_satisfied_head==NULL)
		{
			more_goals=check_for_more_goals(new_goals);
			while (inverted_satisfied_head==NULL && more_goals)
				more_goals=check_for_more_goals(new_goals);
		}
	}
	t_time=t_time+clock();
/*
	cout << "ENABLED FACTS=" << nof_enabled_facts << endl;
	cout << "SET FACTS=" << nof_set_facts << endl;
	cout << "FOUND BETTERS (in facts)=" << TEST_COUNTER << endl;
	cout << "APPLIED ACTIONS=" << TEST_COUNTER2 << endl;
	cout << "APPLIED DISTANCES=" << TEST_COUNTER3 << endl;
	cout << "TIME FOR FINDING DISTANCES=" << t_time* 1000/CLOCKS_PER_SEC << endl;
	cout << "Time for more goals=" << t_more_goals * 1000/CLOCKS_PER_SEC << endl;
*/
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

	if (nof_set_facts<nof_enabled_facts)
	{
		/*
		cout << "Checking new goals" << endl;
		linked_hash_entry* nn=new_goals;
		while (nn!=NULL)
		{
			cout << nn->entry->f ;
			if (nn->entry->linked_used->value)
				cout << "...USED" << endl;
			else
				cout << "...NOT USED" << endl;
			nn=nn->next;
		}
		*/

		cout << "CRITICAL WARNING: The facts for which distances have been computed are less that the total number of facts..." << endl;
/*
		inverted_action* t_action=all_inverted_actions;
		while (t_action!=NULL)
		{
			if (!t_action->applied)
			{

				cout << t_action->step << endl;
				//if (strcmp2(Operators[t_action->step.operator_id].name,"do-lathe"))
				//{
					cout << "Checking preconditions..." << endl;
					int ii;
					for (ii=0;ii<Inv_Operators[t_action->step.operator_id].sof_lists[prec_list];ii++)
					if (!constant_predicates[Inv_Operators[t_action->step.operator_id].strips[prec_list][ii].pred])
					{

						fact ff=Inv_Operators[t_action->step.operator_id].strips[prec_list][ii].instantiate(t_action->step.parameters);
						cout << ff ;
						hash_entry* hh=get_fact_pointer(&ff);
						if (hh->subproblem_distances->distances==NULL)
							cout << "   ...NOT ACHIEVED" << endl;
						else
							cout << "   ...ACHIEVED" << endl;
					}
				cout << endl;
				//}
			}
			t_action=t_action->next;
		}
		*/

	}

	Operators=Normal_Operators;

	//test_mins();

	if(display_messages)
		cout << "COUNTER: " << counter << endl;

	// Clear agenda, mark inverted_actions

	if (xor_enabled)
	{
		while (inverted_satisfied_head!=NULL)
		{
			linked_inverted_action* tl_action=inverted_satisfied_head;
			inverted_satisfied_head=inverted_satisfied_head->next;
			delete tl_action;
		}
		inverted_satisfied_head=NULL;
		inverted_satisfied_tail=NULL;

// ATTENTION: IF WE WOULD LIKE TO COMPUTE NOT ALL THE DISTANCES AT ONCE, 
// BUT COMPUTE ONLY THE NECESSARY DISTANCES AT THE PREPROCESSING PHASE AND THE OTHER DISTANCES
// ON DEMAND, THEN INVERTED ACTIONS SHOULD HAVE LINKED FIELDS FOR 'DISTANCE', 'KEEP' 
// AND 'IN_AGENDA'.
// IT IS EASY TO BE DONE...

	// Initialize inverted_actions
		inverted_action* t_action=all_inverted_actions;
		while (t_action!=NULL)
		{
			t_action->in_agenda=false;
			inverted_distance* t_distance=t_action->distances;
			while (t_distance!=NULL)
			{
				// WE CANNOT DELETE THE KEEP LISTS, BECAUSE THEY ARE INTERLACED...
				//linked_hash_entry* t_keep;
				//t_keep=t_action->distances->keep;
				//while (t_keep!=NULL)
				//{
				//	linked_hash_entry* tt_keep;
				//	tt_keep=t_keep;
				//	t_keep=t_keep->next;
				//	delete tt_keep;
				//}

				if (t_distance->v_distance!=NULL)
					delete t_distance->v_distance;
	
				inverted_distance* tt_distance;
				tt_distance=t_distance;
					t_distance=t_distance->next;
				delete tt_distance;

			}
			t_action->distances=NULL;
			t_action=t_action->next;
		}
	}

	// SET THE DISABLED FACTS OF THE INITIAL STATE TO DISTANCE=0
	int jj;
	for (jj=0;jj<initial->size;jj++)
	{
		bool idle=false;
		int ii;
		ii=0;
		while (ii<predicates[initial->facts[jj].pred].arity && !idle)
			if (objects[initial->facts[jj].arguments[ii]].idle->value)
				idle=true;
			else
				ii++;
		if (idle)
		{
			hash_entry* h;
			h=get_fact_pointer(&initial->facts[jj]);
//			cout << h->f << endl;
			if (h->subproblem_distances->distances==NULL)
			{
				h->subproblem_distances->distances=new linked_distances();
				h->subproblem_distances->distances->h=h;
				h->subproblem_distances->distances->v_distance=new vector();
				h->subproblem_distances->distances->v_distance->elements[0]=0;
				h->subproblem_distances->distances->achieved_by=NULL;
				h->subproblem_distances->distances->achieved_by_distance=NULL;
			}
		}
	}
}

// This functions checks whether an inverted_action has un-achievable preconditions,
// or add effect...
bool inverted_not_achieved_fact(inverted_action* action)
{
	Operator* T_Operators;
	T_Operators=Operators;
	Operators=Inv_Operators;

	bool flag=false;
	// check the preconditions of the inverted action...
	linked_hash_entry* precs=action->precs;
	while (precs!=NULL && !flag) 
		if (!precs->entry->achieved)
			flag=true;
		else
			precs=precs->next;

	if (flag)
		return true;

	// check for the add list of the inverted_action...
	int i=0;
	while (i<Inv_Operators[action->step->operator_id].sof_lists[add_list] && !flag)
	{
		hash_entry* h;
//		fact f;
//		f=Inv_Operators[action->step.operator_id].strips[add_list][i].instantiate(action->step.parameters);
//		cout << f << endl;
		h=get_fact_pointer(&Inv_Operators[action->step->operator_id].strips[add_list][i].instantiate(action->step->parameters));
		flag=!h->achieved;
		i++;
	}

	Operators=T_Operators;
	return flag;
}


// This function counts the number of the inverted actions...
void count_inverted_actions()
{
	inverted_action* act=all_inverted_actions;
	int counter=0;
	while (act!=NULL)
	{
		counter++;
		act=act->next;
	}
	cout << "Number of inverted actions: " << counter << endl;
}



// This function returns the cost vector for applying an inverted action.
vector* get_inverted_action_cost(inverted_action* inv_action)
{
	vector* v=new vector();
	v->elements[0]=1;
	resource_consumption* r=Operators[inv_action->step->operator_id].resources;
	while (r!=NULL)
	{
		// get the object physical number...
		int obj;
		if (r->object_ID>0)
			obj=r->object_ID;
		else
			obj=inv_action->step->parameters[-r->object_ID-1];

		// looking for consumable resources only...
		if (resources[objects[obj].resource].type==1)
			v->elements[objects[obj].consumable_resource+1] += r->amount;
					// it is not necessary to use operator +=, but just for the case...
		r=r->next;
	}
	return v;
}

// This function assigns costs to the inverted actions.
// This job cannot be done while creating the inverted actions, because at that time
// it is not know which resources are consumable. 
// Moreover, this function should update the distances of already applicable inverted actions,
// i.e. inverted actions that have no preconditions, so they have been added to the 
// agenda immediately after their creation.
void assign_inverted_actions_costs()
{
	inverted_action* t_action;
	
	t_action=all_inverted_actions;

	while (t_action!=NULL)
	{
		t_action->inverted_action_cost=get_inverted_action_cost(t_action);
		//cout << t_action->step << "  =  " << *t_action->inverted_action_cost << endl;
		t_action=t_action->next;
	}

	// Actions that are at this time already in agenda have only one distance...
	linked_inverted_action* tt_action;
	tt_action=inverted_satisfied_head;
	while (tt_action!=NULL)
	{
		*tt_action->inverted_step->distances->v_distance=*tt_action->inverted_step->inverted_action_cost;
		tt_action=tt_action->next;
	}
}

void test_mins()
{
	fact f("at", "package2", "city2");
	hash_entry* h=get_fact_pointer(&f);
	linked_distances* distances=h->subproblem_distances->distances;
	while (distances!=NULL)
	{
		cout << *distances->v_distance << "   MINS = ";
		int j;
		for (j=0;j<=nof_consumable_resources;j++)
			if (distances->v_distance->mins[j])
				cout << "1";
			else
				cout << "0";
		if (distances->should_be_deleted)
			cout << "   DELETED";
		cout << endl;
		distances=distances->next;
	}
	cout << endl;
}