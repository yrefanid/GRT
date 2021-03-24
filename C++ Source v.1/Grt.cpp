#include "planner.h"
bool reduced_enriched=false;

Operator* Inv_Operators=new Operator[max_nof_operators];

int		nof_facts=0;
int		nof_inverted_actions=0;
int		nof_set_facts=0;
int		nof_applied_inverted_actions=0;

inverted_action* all_inverted_actions=NULL;		// this pointer is useful for the 
												// deletion of the inverted actions...

linked_inverted_action*	inverted_satisfied_head=NULL;
linked_inverted_action*	inverted_satisfied_tail=NULL;

int deleted_keeped_facts=0;
int deleted_inverted_actions=0;
int deleted_linked_inverted_actions=0;

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
	}
}

// Function 'create_inverted_operators' constructs the inverted operators and adds them to 
// the table "Operator* Inv_Operators".
void release_memory()
{
	// delete the definitions of the inverted operators
	delete Inv_Operators;

	// delete the memory allocated to the inverted actions
	while (all_inverted_actions!=NULL)
	{
		linked_hash_entry* keep;
		keep=all_inverted_actions->keep;
		while (keep!=NULL)			// delete the memory allocated to the keeped facts 
		{							// of the inverted action
			linked_hash_entry* keep2;
			keep2=keep->next;
			delete keep;
			keep=keep2;
			deleted_keeped_facts++;
		}
		linked_hash_entry* precs=all_inverted_actions->precs;
		while (precs!=NULL)
		{
			linked_hash_entry* precs2=precs->next;
			delete precs;
			precs=precs2;
		}
		inverted_action* inv_tmp=all_inverted_actions;
		inv_tmp=inv_tmp->next;
		delete all_inverted_actions;
		all_inverted_actions=inv_tmp;
		deleted_inverted_actions++;
	}
//	cout << "deleted inverted actions: " << deleted_inverted_actions << endl;
//	cout << "deleted keeped facts: " << deleted_keeped_facts << endl;


	// delete remaining pointers to inverted satisfied actions
	while (inverted_satisfied_head!=NULL)
	{
		linked_inverted_action* tmp_lnk_inv_act;
		tmp_lnk_inv_act=inverted_satisfied_head->next;
		delete inverted_satisfied_head;
		inverted_satisfied_head=tmp_lnk_inv_act;
	}
	inverted_satisfied_tail=NULL;

	// delete from the hash table the pointers to the inverted actions associated to every fact
	void* ptr;
	int i;
	for(i=0;i<nof_predicates;i++)
		if (hash_table[i].ptr!=NULL)
			if (predicates[i].arity>0)
			{
				int vars[max_arity];
				int j;
				for(j=0;j<max_arity;j++) vars[j]=1;
				while (vars[0]<=nof_objects)
				{
					ptr=hash_table[i].ptr;
					bool flag;
					flag=true;
					j=0;
					while (j<predicates[i].arity && flag)
						if ((((pointer*) ptr)[vars[j]-1]).ptr==NULL)
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
							ptr=(((pointer*) ptr)[vars[j]-1]).ptr;
							j++;
						}
					if (flag)
					{	// deleting the pointers to the inverted actions
						linked_inverted_action* inv_actions;
						inv_actions=((hash_entry*) ptr)->inv_op_prec;
						while (inv_actions!=NULL)
						{
							linked_inverted_action* tmp_inv_act;
							tmp_inv_act=inv_actions->next;
							delete inv_actions;
							deleted_linked_inverted_actions++;
							inv_actions=tmp_inv_act;
						}
						((hash_entry*) ptr)->inv_op_prec=NULL;

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
			}	
			else	// if (predicates[i].arity>0)
			{
				ptr=hash_table[i].ptr;
				linked_inverted_action* inv_actions;
				inv_actions=((hash_entry*) ptr)->inv_op_prec;
				while (inv_actions!=NULL)
				{
					linked_inverted_action* tmp_inv_act;
					tmp_inv_act=inv_actions->next;
					delete inv_actions;
					deleted_linked_inverted_actions++;
					inv_actions=tmp_inv_act;
				}
				((hash_entry*) ptr)->inv_op_prec=NULL;
			}	// if (hash_table[i]->ptr!=NULL)
//	cout << "deleted linked inverted actions: " << deleted_linked_inverted_actions << endl;
}

pointer* hash_table;

void next_value(int j, int vars[max_nof_parameters], int oper_id);
bool all_different(int j, int vars[max_nof_parameters]);
bool check_preconditions(int j, int vars[max_nof_parameters], int oper_id);
void insert_preconditions_to_hash(inverted_action* inv_action);
void insert_add_to_hash(action* inv_action);


bool instantiate_prec(fact* const_precs, int oper_id, int j, int vars[max_nof_parameters], 
		int back_points[max_sof_op_lists], int instantiated_by[max_sof_op_lists],
		int* max_instantiated);


	
// Function 'create_all_facts' creates a hash table which contains all the facts included
// either into a list of preconditions of an inverted action, or into an add list of an 
// inverted action. Simultaneously, it creates instances of all the inverted actions.
void create_all_facts()
{
	Operators=Inv_Operators;
	hash_table=new pointer[max_nof_predicates];
	int vars[max_nof_parameters];	// the values that take the parameters of the operator
	int back_points[max_sof_op_lists];
	//int max_inst[max_sof_op_lists];
	int instantiated_by[max_sof_op_lists];
	
	int oper_id;
	for(oper_id=0;oper_id<nof_operators;oper_id++)	// oper_id: the operator position
	{												// in table Operators
		check_time();
		int j;
		for (j=0;j<max_nof_parameters;j++) vars[j]=0;
		if (Operators[oper_id].nof_parameters>0)	
		{													
			// initialization steps
			for (j=0;j<max_sof_op_lists;j++) 
			{
				back_points[j]=-1;
				instantiated_by[j]=-1;
			}

			// count how many constant predicates are within the preconditions...
			int nof_const_precs=0;
			int i;
			for(i=0;i<Operators[oper_id].sof_lists[prec_list];i++)
				if (constant_predicates[Operators[oper_id].strips[prec_list][i].pred])
					nof_const_precs++;
			fact* const_precs;
			if (nof_const_precs>0)
				const_precs=new fact[nof_const_precs];
			else
				const_precs=NULL;
			// ...and create a new table and put them in.
			nof_const_precs=0;
			for(i=0;i<Operators[oper_id].sof_lists[prec_list];i++)
				if (constant_predicates[Operators[oper_id].strips[prec_list][i].pred])
					const_precs[nof_const_precs++]=Operators[oper_id].strips[prec_list][i];

			j=0;
			int max_instantiated=0;
			while (back_points[0]<nof_constants && max_instantiated>=0)
			{
				if (instantiate_prec(const_precs, oper_id, j, vars, back_points, instantiated_by, &max_instantiated))
				{
					//cout << Operators[oper_id].strips[prec_list][j] << " = ";
					//cout << Operators[oper_id].strips[prec_list][j].instantiate(vars) << endl;
					if (j<nof_const_precs-1)
						j++;
					else
					{	// if (j<nof_const_precs-1)
						// In this point all variables (array 'vars') must have been grounded.
						// A test could take place... (but... delay)

						int nof_param=Operators[oper_id].nof_parameters;

						//  mark which of the parameters have not been instantiated...
						bool not_instantiated[max_nof_parameters];	
						int c1;
						for(c1=0;c1<nof_param;c1++)
							if (vars[c1]==0)
								not_instantiated[c1]=true;
							else
								not_instantiated[c1]=false;
						// bound all the not_instantiated variables
						// to the first object...
						for(c1=0;c1<nof_param;c1++)
							if (vars[c1]==0)
								vars[c1]=1;

						bool more_instantiations=true;
						while (more_instantiations)
						{
					
							bool all_dif=true;

							int i1=0;
							while (i1<nof_param-1 && all_dif)
							{
								int i2;
								i2=i1+1;
								while (i2<nof_param && all_dif)
								{
									if (vars[i1]==vars[i2])
										all_dif=false;
									else	
										i2++;
								}
								i1++;
							}
					
							if (all_dif)
							{
								//cout << "Success" << endl;
								inverted_action* inv_action=new inverted_action(action(oper_id, vars));
								//cout << inv_action->step << endl;
								nof_inverted_actions++;
								inv_action->next=all_inverted_actions;
								all_inverted_actions=inv_action;
								if(Operators[oper_id].sof_lists[prec_list]>0)	
									insert_preconditions_to_hash(inv_action);
								else
									// this case logically will never occurs, since in order to 
									// an inverted action do not have any precondition, 
									// a normal action should not have any effect.
								{
									inv_action->score=0;
									inv_action->keep=NULL;
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
								insert_add_to_hash(&inv_action->step);
							}	//	if (all_dif)
							
							// find next instantiation of the not instantiated variables...
							c1=nof_param-1;
							more_instantiations=false;
							while (c1>=0 && !more_instantiations)
							{
								if (not_instantiated[c1])
									if (vars[c1]<nof_objects)
									{
										vars[c1]=vars[c1]+1;
										more_instantiations=true;
									}
									else
										vars[c1]=1;
								c1--;
							}
						}	//	while (more_instantiations)
					}	// if (j<nof_const_precs-1)
				}
				else	// if (instantiate_prec(const_precs, oper_id, j, vars, back_points, instantiated_by, &max_instantiated))
				{
					//cout << "Fail:" << Operators[oper_id].strips[prec_list][j].instantiate(vars) << endl;
					if (max_instantiated>=0)
					{
						if (j>0)
							back_points[j]=-1;
						int i1;
						for(i1=j-1;i1>max_instantiated;i1--)
						{
							back_points[i1]=-1;
							//cout << "Deallocate: " << Operators[oper_id].strips[prec_list][i1] << endl;							
							int i2;
							for (i2=0;i2<max_nof_parameters;i2++)
							if (instantiated_by[i2]==i1)
							{
								instantiated_by[i2]=-1;
								vars[i2]=0;
							}
						}
						j=max_instantiated;
					}
				}
			}
			if (const_precs!=NULL)
				delete const_precs;
		}	
		else	//	if (Operators[oper_id].nof_parameters>0) , end of 'then' part
		{
			inverted_action* inv_action=new inverted_action(action(oper_id, vars));
			nof_inverted_actions++;
			inv_action->next=all_inverted_actions;
			all_inverted_actions=inv_action;
			if(Operators[oper_id].sof_lists[prec_list]>0)	
				insert_preconditions_to_hash(inv_action);
			else
			// this case logically will never occurs, since in order to 
			// an inverted action do not have any precondition, 
			// a normal action should not have any effect.
			{
				inv_action->score=0;
				inv_action->keep=NULL;
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
			insert_add_to_hash(&inv_action->step);
		}	// //	if (Operators[oper_id].nof_parameters>0) then ....
	}	// for(oper_id=0;oper_id<nof_operators;oper_id++)...
	Operators=Normal_Operators;
	if (display_messages)
	{
		cout << endl << "Number of ivnerted actions: " << nof_inverted_actions << endl;
		cout << "Number of facts in the hash table: " << nof_facts<< endl << endl;
	}
}



bool instantiate_prec(fact* const_precs, int oper_id, int j, int vars[max_nof_parameters], 
		int back_points[max_sof_op_lists], int instantiated_by[max_sof_op_lists],
		int* max_instantiated)
{
	if (const_precs==NULL)
	{
		*max_instantiated=-1;
		return true;
	}
	
	int max_inst;

	fact cur_prec=const_precs[j];	// for shortness

	int i;

		//	deallocate variables
	if (back_points[j]>-1)
	{
		for (i=0;i<max_nof_parameters;i++)
			if (instantiated_by[i]==j)
			{
				instantiated_by[i]=-1;
				vars[i]=0;
			}
		max_inst=-1;
		int i1;
		for(i1=0;i1<Operators[oper_id].nof_parameters;i1++)
			if (instantiated_by[i1]>max_inst)
				max_inst=instantiated_by[i1];
		//max_inst=order_ind[arity-1];	// this is the maximum 'order_ind[?]'
	}
	else
		max_inst=-1;
	
	int order_to_check[max_arity];
	int order_ind[max_arity];
	int arity=predicates[cur_prec.pred].arity;
	int ind=0;
	
	// mark any argument of the 'cur_prec' from which previous fact has been grounded
	// (or if it is a constant, it is considered with the predicate as a whole)
	int i1;
	int i2;
	for(i1=0;i1<arity;i1++)	
	{
		order_to_check[i1]=i1;
		// if the argument is a constant
		if (cur_prec.arguments[i1]>0)
			order_ind[i1]=-1;
		else
		// if the argument is a variable that is already grounded				
			if (vars[-cur_prec.arguments[i1]-1]>0)
				order_ind[i1]=instantiated_by[-cur_prec.arguments[i1]-1];
		// or finally, if the argument is a variable that is not already grounded
			else
				order_ind[i1]=j;
	}
		// Reorder the two tables, so that the second table be in increasing order...
	for(i1=0;i1<arity-1;i1++)
		for(i2=arity-2;i2>=i1;i2--)
			if (order_ind[i2]>order_ind[i2+1])
			{
				int t;
				t=order_ind[i2];
				order_ind[i2]=order_ind[i2+1];
				order_ind[i2+1]=t;
				t=order_to_check[i2];
				order_to_check[i2]=order_to_check[i2+1];
				order_to_check[i2+1]=t;
			}
				
	i=back_points[j]+1;	// points to state's facts 

	bool instantiable=false;
		
	while (i<nof_constants && !instantiable)
	{
		if (cur_prec.pred==constants[i].pred)
		{
			int k;
			bool possible=true;
			for(k=0;k<arity;k++)
			{
				if (max_inst<order_ind[k] && order_ind[k]<j) max_inst=order_ind[k];
				// if the argument is a constant
				if (cur_prec.arguments[order_to_check[k]]>0 )
				{
					if (cur_prec.arguments[order_to_check[k]] != constants[i].arguments[order_to_check[k]])
						possible=false;
				}
				else
				{	
					// if the argument is a variable that is already instantiated
					if (vars[-cur_prec.arguments[order_to_check[k]]-1]>0)
					{
						if (vars[-cur_prec.arguments[order_to_check[k]]-1] != constants[i].arguments[order_to_check[k]])
							possible=false;
					}
					else	// the argument is a variable that is not already instantiated
					{
						
						k++;
					}
				}
			}
			if (possible)
			{
				instantiable=true;
				max_inst=j;
				back_points[j]=i;
				for(k=0;k<arity;k++)
					if(cur_prec.arguments[k]<0 && vars[-cur_prec.arguments[k]-1]==0)
					{
						vars[-cur_prec.arguments[k]-1]=constants[i].arguments[k];
						instantiated_by[-cur_prec.arguments[k]-1]=j;
					}
				}	//	if (possible)
			else
				i++;
		}	
		else	//	if (cur_prec.pred==constants[i].pred)
		{
			i++;
		}	//	if (cur_prec.pred==constants[i].pred)
	}	//	while (i<nof_constants && !instantiable)
	if (!instantiable)
		back_points[j]=nof_constants;
	*max_instantiated=max_inst;
	return instantiable;
}




// Function 'add_fact_to_hash_table' adds a fact to the hash table, and marks the fact that it is 
// included in the precondition list of an inverted action.
hash_entry* add_fact_to_hash_table(fact f, inverted_action* inv_action);	

// Function 'insert_precondtitions_to_hash' adds all the preconditions of an inverted action
// into the hash table.
void insert_preconditions_to_hash(inverted_action* inv2_action)
{
	int i;
	for(i=0;i<Operators[inv2_action->step.operator_id].sof_lists[prec_list];i++)
	{
		fact f=Operators[inv2_action->step.operator_id].strips[prec_list][i].instantiate(inv2_action->step.parameters);
		if (!constant_predicates[f.pred])	// only the non-constant predicates are stored in the hash table
		{
			//inverted_action* inv2_action=new inverted_action(inv_action);
			hash_entry* ptr=add_fact_to_hash_table(f, inv2_action);
			inv2_action->precs=new linked_hash_entry(ptr, inv2_action->precs);
		}
	}	// for(i)
}

// Function 'add_fact_to_hash_table' adds a fact to the hash table, and marks the fact that it is 
// included in the precondition list of an inverted action.
hash_entry* add_fact_to_hash_table(fact f, inverted_action* inv_action)
{
//	cout << f << endl;
	void * hash_ptr;
	hash_ptr=&(hash_table[f.pred]);
	int i;
	for(i=0;i<predicates[f.pred].arity;i++)
	{
		if (((pointer*)hash_ptr)->ptr==NULL)
		{
			pointer* temp_ptr=new pointer[nof_objects];
			((pointer*) hash_ptr)->ptr=temp_ptr;
			hash_ptr=&temp_ptr[f.arguments[i]-1];  // obj1 is in position 0, obj2 is in position 1, etc...
		}
		else	// if hash_ptr==NULL
		{
			hash_ptr=&(((pointer*) ((pointer*) hash_ptr)->ptr)[f.arguments[i]-1]); // obj1 is in position 0, obj2 is in position 1, etc...
		}  // if hash_ptr==NULL
	}	// for(i=0;i<predicates[f.pred].arity;i++)
	
	hash_entry* hash_item;
	
	if (((pointer*)hash_ptr)->ptr == NULL)
	{
		nof_facts++;
		hash_item=new hash_entry(f);
		((pointer*)hash_ptr)->ptr=hash_item;
		if (inv_action!=NULL)
			hash_item->inv_op_prec=new linked_inverted_action(inv_action);
	}
	else
	{
		hash_item= (hash_entry*) (((pointer*)hash_ptr)->ptr);
		if (inv_action!=NULL)
		{
			linked_inverted_action* lnk_act=new linked_inverted_action(inv_action);
			lnk_act->next=hash_item->inv_op_prec;
			hash_item->inv_op_prec=lnk_act;
		}
	}
	return hash_item;
}


// Function 'insert_add_to_hash_table' adds all the facts of the add list of an action
// to the hash table
void insert_add_to_hash(action* inv_action)
{
	int i;
	for(i=0;i<Operators[inv_action->operator_id].sof_lists[add_list];i++)
	{
		fact f=Operators[inv_action->operator_id].strips[add_list][i].instantiate(inv_action->parameters);
		if (!constant_predicates[f.pred])	// only the non-constant predicates are stored in the hash table
			add_fact_to_hash_table(f, NULL);
	}	// for(i)
}

// Function 'set_distance_related' sets the distance and the list of related facts
// of a fact in the hash table.
void set_distance_related(hash_entry* f, int d, linked_hash_entry* related);

// Function 'add_goals' adds all the goals of a problem instance to the hash table,
// with distance=0 and keep=NULL. 
void add_goals(state* goal)
{
	Operators=Inv_Operators;
	 int i;
	for(i=0;i<goal->size;i++)
		set_distance_related(get_fact_pointer(&goal->facts[i]), 0, NULL);
	Operators=Normal_Operators;
}

// Function 'check inverted_actions' finds which of the inverted actions of an achieved fact
// have all of their preconditions satisfied and adds them to the agenda of the satisfied
// inverted actions.
void check_inverted_actions(linked_inverted_action* inv_op_prec);

// Function 'set_distance_related' sets the distance and the list of related facts
// of a fact in the hash table.
void set_distance_related(hash_entry* f, int d, linked_hash_entry* related)
{
	if (f->distance<0)
	{
		nof_set_facts++;
		f->distance=d;
		f->related=related;
		check_inverted_actions(f->inv_op_prec);
	}
}

// Function 'inverted_keep' checks if the preconditions of an inverted action have all been 
// satisfied, and, if so, it returns true, together with (argument keep) the keeped facts 
// of this action (whereas are not included action's preconditions), otherwise it returns false.
bool inverted_keep(inverted_action* step, linked_hash_entry** keep, linked_hash_entry** linked_precs, bool* first_enriched);

// Function 'find_grade' finds the cost for achieving together a set of facts,
// (which are passed to the function as a linked list of 'linked_hash_entry' pointers)
// based on the costs for achieving them separately and on their lists of related facts.
int find_grade(linked_hash_entry* linked_facts);

// Function 'extract_grade' takes as input a linked list of hash entries, and returns
// the sum of their distances.
int extract_grade(linked_hash_entry* reduced_end_facts);

// Function 'check_inverted_actions' finds which of the inverted actions of an achieved fact
// have all of their preconditi	ons satisfied and adds them to the agenda of the satisfied
// inverted actions.
void check_inverted_actions(linked_inverted_action* inv_op_prec)
{
	// This flag is used when a fact has been achieved and we
	// are looking about the applicability if the actions having this fact
	// as precondition. We want that for each fact only one action
	// having an unused fact of the enriched goal state as precondition
	// can be added in the agenda...
	bool first_enriched=true;

	while (inv_op_prec!=NULL)
	{
		if (inv_op_prec->inverted_step->in_agenda==false)	// check only for the inverted_actions
		{													// that are not already in the agenda
			linked_hash_entry* keep=NULL;
			linked_hash_entry* linked_precs;
			linked_precs=NULL;
			if (inverted_keep(inv_op_prec->inverted_step, &keep, &linked_precs, &first_enriched))
			{ 
//				cout << *(inv_op_prec->inverted_step->step);
				inv_op_prec->inverted_step->in_agenda=true;  
				int score=1+find_grade(linked_precs);	// after the execution of 'find_grade'
//				cout << "  Score:" << score	<< endl;									// the memory allocated to the linked
														// list 'linked_precs' is released.
				inv_op_prec->inverted_step->score=score;
				inv_op_prec->inverted_step->keep=keep;

				linked_inverted_action* new_inverted_satisfied_action=new linked_inverted_action(inv_op_prec->inverted_step); 
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
			}	// if (inverted_keep(inv_op_prec->inverted_step, keep, &first_enriched))
		}
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
		
// Function 'inverted_keep' checks if the preconditions of an inverted action have all been 
// satisfied, and, if so, it returns true, together with (argument keep) the keeped facts 
// of this action (whereas are also included action's preconditions), otherwise it returns false.
bool inverted_keep(inverted_action* inv_act, linked_hash_entry** keep, linked_hash_entry** linked_precs, bool* first_enriched)
{
	*keep=NULL;
	*linked_precs=NULL;
	linked_hash_entry* precs=inv_act->precs;
	linked_hash_entry* ptr=NULL;
	bool flag=true;
	while (precs!=NULL && flag)
	{
		if (precs->entry->distance<0 && (!precs->entry->enriched || precs->entry->used==true))
			flag=false;
		else
			precs=precs->next;
	}
	if (!flag)
		return false;
	
	precs=inv_act->precs;
	while (precs!=NULL) // for every fact in the preconditions list
	{																// of the action

		//if (precs->entry->enriched && *first_enriched && precs->entry->distance==0 && !precs->entry->used)
		if (precs->entry->enriched && !precs->entry->used)
		{
			*first_enriched=false;
			precs->entry->used=true;
			if (display_messages)
				cout << "ENRICHED FACT USED: " << precs->entry->f << endl;
			//precs->entry->distance=-1;
			set_distance_related(precs->entry, 0, NULL);
			
			if (reduced_enriched)
			{
				linked_hash_entry* mutex=precs->entry->mutexes;
				while (mutex!=NULL)
				{
					mutex->entry->used=true;
					mutex=mutex->next;
				}
			}
		}

		if (*linked_precs==NULL)	// adds a pointer to the fact's hash entry
		{							// to the linked list 'linked_precs'
			*linked_precs=new_linked_hash_entry(linked_hash_entry(precs->entry));
			ptr=*linked_precs;
		}
		else
		{
			ptr->next=new_linked_hash_entry(linked_hash_entry(precs->entry));
			ptr=ptr->next;
		}

		if (!included_in_delete_list(precs->entry->f, &inv_act->step) &&	// add the fact itself
			!included_in_fact_list(precs->entry, *keep))		// in the 'keep' list
		{
			*keep=new linked_hash_entry(precs->entry, *keep);
		}				
		linked_hash_entry* related=precs->entry->related;	// add the fact's related facts to the 'keep' list
		while (related!=NULL)
		{	// checks whether the fact is not included in the delete list of the operator
			// and is not already inserted in the keep list 
			if (!included_in_delete_list(related->entry->f, &inv_act->step) &&
				!included_in_fact_list(related->entry, *keep))
			{
				*keep=new linked_hash_entry(related->entry, *keep);
			}
			related=related->next;
		}
		precs=precs->next;
	}
	return true;
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
bool included_in_fact_list(hash_entry* f, linked_hash_entry* linked_list)
{
	while (linked_list!=NULL)
		if (f==linked_list->entry)
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
	void* ptr=hash_table[f->pred].ptr;
	bool flag;
	flag=true;
	if (ptr==NULL)	// ptr points to the first (zero) arguments' table of the predicate
	{
		flag=false;
		cout << "ERROR (GET_FACT_POINTER): Fact " << *f << "does not exist in the hash table." << endl;
		abort();
	}
	int i=0;
	while (i<predicates[f->pred].arity && flag)
	{
		ptr=((pointer*) ptr)[f->arguments[i]-1].ptr;	// ptr points to the i+2 (i+1) arguments' table
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
void	find_reduced_end_facts(linked_hash_entry* linked_facts, 
					   linked_hash_entry** end_facts,
					   linked_hash_entry** previous_facts);


// Function 'find_not_last_keeped' takes as input the lists of the 'reduced_end_facts' and the
// 'previous_facts' and returns the list 'not_last_keeped', which is the subset of 'previous_facts'
// that are not included in any of the lists of related atoms of the 'reduced_end_facts'.
void	find_not_last_keeped(linked_hash_entry* previous_facts, 
							 linked_hash_entry* reduced_end_facts, 
							 linked_hash_entry** not_last_keeped);

// Function 'delete_linked_hash_entry_list' takes as input a pointer to the head 
// of a linked hash entry list and deletes (freezes) all the memory allocated
// to that list.
void delete_linked_hash_entry_list(linked_hash_entry* ptr);

// Function 'find_grade' finds the cost for achieving together a set of facts,
// (which are passed to the function as a linked list of 'linked_hash_entry' pointers)
// based on the costs for achieving them separately and on their lists of related facts.
int find_grade(linked_hash_entry* linked_facts)
{
	int score=0;
	linked_hash_entry* reduced_end_facts;
	linked_hash_entry* previous_facts;
	linked_hash_entry* not_last_keeped;
	while (linked_facts!=NULL)
	{
		find_reduced_end_facts(linked_facts, &reduced_end_facts, &previous_facts);
		find_not_last_keeped(previous_facts, reduced_end_facts, &not_last_keeped);
		score=score+extract_grade(reduced_end_facts);
		delete_linked_hash_entry_list(reduced_end_facts);
		delete_linked_hash_entry_list(previous_facts);
		delete_linked_hash_entry_list(linked_facts);
		linked_facts=not_last_keeped;
	}
	return score;
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
		delete_linked_hash_entry(ptr);
		ptr=ptr2;
	}
}

// Function 'keeped' checks if a fact pointed by 'hash_entry' is included in any of 
// the 'related' lists  of the facts included in the list 'linked_facts_head',
// without occurring the inverse. 
bool	keeped(linked_hash_entry* hash_entry, linked_hash_entry* linked_facts_head);

// Function 'equivalent_introduced' checks if the end_fact pointed by 'linked_facts'
// is included in any of the lists of related facts of the already introduced 'end_facts'.
bool	equivalent_introduced(linked_hash_entry* linked_facts, linked_hash_entry* end_facts);

// Function 'find_reduced_end_facts' takes as input a linked list of pointers to facts (in the
// hash entry) and returns two lists, the list of 'end_facts' and the list of 'previous_facts'.
void	find_reduced_end_facts(linked_hash_entry* linked_facts, 
					   linked_hash_entry** end_facts,
					   linked_hash_entry** previous_facts)
{
	*end_facts=NULL;
	*previous_facts=NULL;
	linked_hash_entry* linked_facts_head;
	linked_facts_head=linked_facts;
	while (linked_facts!=NULL)
	{
		if (keeped(linked_facts, linked_facts_head))
		{
			linked_hash_entry* tmp=new_linked_hash_entry(linked_hash_entry(linked_facts->entry));
			tmp->next=(*previous_facts);
			(*previous_facts)=tmp;
		}
		else
		{
			if (!equivalent_introduced(linked_facts, *end_facts))
			{
				linked_hash_entry* tmp=new_linked_hash_entry(linked_hash_entry(linked_facts->entry));
				tmp->next=(*end_facts);
				(*end_facts)=tmp;
			}
		}
		linked_hash_entry* tmp;
		tmp=linked_facts->next;
		linked_facts=tmp;
	}
}

// Function 'keeped' checks if a fact pointed by 'hash_entry' is included in any of 
// the 'related' lists  of the facts included in the list 'linked_facts_head',
// without occurring the inverse. 
bool	keeped(linked_hash_entry* hash_entry, linked_hash_entry* linked_facts_head)
{
	while (linked_facts_head!=NULL)
	{
		linked_hash_entry* related;
		related=linked_facts_head->entry->related;
		while (related!=NULL)
		{
			if (hash_entry->entry==(related->entry))	// if the fact hash_entry is included
			{										// in the list of related facts of the
				bool flag=true	;					// fact pointed by current 'linked_facts_head'
				linked_hash_entry* related2=hash_entry->entry->related;
				while (related2!=NULL && flag)
				{
					if (linked_facts_head->entry==related2->entry)
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
bool	equivalent_introduced(linked_hash_entry* linked_facts, linked_hash_entry* end_facts)
{
	while (end_facts!=NULL)
	{
		linked_hash_entry* related;
		related=end_facts->entry->related;
		while (related!=NULL)
		{
			if (linked_facts->entry==related->entry)
				return true;
			related=related->next;
		}
		end_facts=end_facts->next;
	}
	return false;
}

// Function 'extract_grade' takes as input a linked list of hash entries, and returns
// the sum of their distances.
int extract_grade(linked_hash_entry* reduced_end_facts)
{
	int score=0;
	while (reduced_end_facts!=NULL)
	{
		score=score+reduced_end_facts->entry->distance;
		reduced_end_facts=reduced_end_facts->next;
	}
	return score;
}


// Function 'find_not_last_keeped' takes as input the lists of the 'reduced_end_facts' and the
// 'previous_facts' and returns the list 'not_last_keeped', which is the subset of 'previous_facts'
// that are not included in any of the lists of related atoms of the 'reduced_end_facts'.
void	find_not_last_keeped(linked_hash_entry* previous_facts, 
							 linked_hash_entry* reduced_end_facts, 
							 linked_hash_entry** not_last_keeped)
{
	*not_last_keeped=NULL;
	while (previous_facts!=NULL)		// for every fact in the 'previous_facts'
	{
		linked_hash_entry* ptr;
		ptr=reduced_end_facts;
		bool flag=true;
		while (ptr!=NULL && flag)		// for every fact in the reduced_end_facts
		{
			linked_hash_entry* related=ptr->entry->related;
			while (related!=NULL && flag)	// for every related facts of the fact under
			{					// consideration from the list of the reduced end facts
				if (related->entry==previous_facts->entry)
					flag=false;
				else
					related=related->next;
			}
			ptr=ptr->next;
		}
		if (flag)
		{
			linked_hash_entry* tmp=new_linked_hash_entry(linked_hash_entry(previous_facts->entry));
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
		cout << "Score: " << ptr->inverted_step->score << endl;
		ptr=ptr->next;
	}
}

// Function "check_for_new_goals" checks whether there are unused
// facts of the enriched goal state that can add new inverted actions 
// to the agenda...
bool check_for_more_goals()
{
	linked_hash_entry* enriched=new_goals;
	bool flag=false;
	while (enriched!=NULL && !flag)
	{
		if (!enriched->entry->used)
		{
			if (display_messages)
				cout << "ENRICHED FACT USED: " << enriched->entry->f << endl;
			enriched->entry->used=true;
			//enriched->entry->distance=-1;
			set_distance_related(enriched->entry, 0, NULL);

			if (reduced_enriched)
			{
				linked_hash_entry* mutex=enriched->entry->mutexes;
				while (mutex!=NULL)
				{
					mutex->entry->used=true;
					mutex=mutex->next;
				}
			}

			return true;
		}
		enriched=enriched->next;
	}
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


// Function 'find_all_distances' releatedly reads the head of the inverted satisfied operators 
// linked list and adds the distances and the related facts of their add-list facts 
// to the hash-table.
void find_all_distances()
{
	Operators=Inv_Operators;

	bool more_goals=true;
	if (reduced_enriched)
	{
	more_goals=check_for_more_goals();
	while (inverted_satisfied_head==NULL && more_goals)
		more_goals=check_for_more_goals();
	}

	int counter=0;
	while (inverted_satisfied_head!=NULL && nof_set_facts<nof_facts)
	{
		check_time();
		counter++;
		action* step;
		step=&inverted_satisfied_head->inverted_step->step; // for shortness
		int i;
		for(i=0;i<Operators[step->operator_id].sof_lists[add_list];i++)
		{
			hash_entry* f=get_fact_pointer(&Operators[step->operator_id].strips[add_list][i].instantiate(step->parameters));
			linked_hash_entry* keep1;
			keep1=NULL;
			linked_hash_entry* keep2;
			keep2=inverted_satisfied_head->inverted_step->keep;
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
			set_distance_related(f,inverted_satisfied_head->inverted_step->score,keep1);
		}
		linked_inverted_action* tmp;
		tmp=inverted_satisfied_head->next;
		delete inverted_satisfied_head;
		inverted_satisfied_head=tmp;

		// If the agenda is empty, check for new goals that could 
		// add actions in the agenda...
		if (reduced_enriched)
			while (inverted_satisfied_head==NULL && more_goals)
				more_goals=check_for_more_goals();
	}
	
	Operators=Normal_Operators;

	if(display_messages)
		cout << "COUNTER: " << counter<< endl;
}
 