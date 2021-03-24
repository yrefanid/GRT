#include "planner.h"

int nof_actions=0;
int nof_facts=0;
int total_nof_facts=0;

extern pointer* hash_table;

action* all_actions=NULL;
linked_action* agenda_head=NULL;
linked_action* agenda_tail=NULL;

void find_new_applicable_actions(fact* h);

// This function adds the new fact in the hash table and checks for actions
// having this facts as precondition.
// If the fact is already in the agenda, nothing happens.
void insert_fact_to_hash_table(fact* f)
{
	void* hash_ptr;
//	cout << *f<< endl;
	hash_ptr=&(hash_table[f->pred]);

	((pointer*) hash_ptr)->depth=-1;
	((pointer*) hash_ptr)->width=f->pred;
//	cout << *((pointer*) hash_ptr) <<endl;

	int i;
	for(i=0;i<predicates[f->pred].arity;i++)
	{
		if (((pointer*)hash_ptr)->forward==NULL)
		{
			pointer* temp_ptr=new pointer[nof_objects];
			int i1;
			for(i1=0;i1<nof_objects;i1++)
			{
				temp_ptr[i1].back=hash_ptr;
				temp_ptr[i1].depth=i;
				temp_ptr[i1].width=i1+1;
			}
			((pointer*) hash_ptr)->forward=temp_ptr;
			hash_ptr=&temp_ptr[f->arguments[i]-1];  // obj1 is in position 0, obj2 is in position 1, etc...
//			cout << *((pointer*) hash_ptr) <<endl;
		}
		else	// if hash_ptr==NULL
		{
			hash_ptr=&(((pointer*) ((pointer*) hash_ptr)->forward)[f->arguments[i]-1]); // obj1 is in position 0, obj2 is in position 1, etc...
//			cout << *((pointer*) hash_ptr) <<endl;
		}  // if hash_ptr==NULL
	}	// for(i=0;i<predicates[f.pred].arity;i++)
	
	hash_entry* hash_item;
	
	if (((pointer*)hash_ptr)->forward == NULL)
	{
		// It is about a new fact...
		total_nof_facts++;
		// ATTENTION: First check for new actions (for that fact)...
//		cout << endl << "NEW FACT = " << *f << endl;
		find_new_applicable_actions(f);
		// and then adding the fact in the hash table.
		hash_item=new hash_entry(f);
		hash_item->back=((pointer*) hash_ptr);
		((pointer*)hash_ptr)->forward=hash_item;
		if (constant_predicates[f->pred])
			hash_item->dynamic=false;
		else
		{
			hash_item->dynamic=true;
			nof_facts++;
		}
	}
	else
	{
		// The fact already exists...
		hash_item= (hash_entry*) (((pointer*)hash_ptr)->forward);
	}
}


void create_actions()
{
	hash_table=new pointer[max_nof_predicates];

	int i;
	for(i=0;i<nof_constants;i++)
		insert_fact_to_hash_table(&constants[i]);
	for(i=0;i<initial->size;i++)
		insert_fact_to_hash_table(&initial->facts[i]);
//	cout << initial->facts[0] << endl;
//	find_new_applicable_actions(&initial->facts[0]);

	int counter=0;
	while (agenda_head!=NULL)
	{
//		cout << ++counter << " : " << *agenda_head->step->step << endl;
		int i=0;
		for(i=0;i<Operators[agenda_head->step->operator_id].sof_lists[add_list];i++)
		{
			insert_fact_to_hash_table(&Operators[agenda_head->step->operator_id].strips[add_list][i].instantiate(agenda_head->step->parameters));
		}
		linked_action* t_action=agenda_head;
		agenda_head=agenda_head->next;
		delete t_action;
	}

//	complete_state_action* t_action=all_actions;
//	while (t_action!=NULL)
//	{
//		cout << *t_action->step << endl;
//		t_action=t_action->next;
//	}
//	cout << "TOTAL NOF FACTS=" << total_nof_facts << endl;
//	cout << "DYNAMIC FACTS=" << nof_facts << endl;
//	cout << "ACTIONS=" << nof_actions << endl;
}


bool instantiate_prec(fact* precs, int nof_param, int j, int vars[max_nof_parameters], 
		hash_entry* back_points[max_sof_op_lists], int instantiated_by[max_sof_op_lists],
		int* max_instantiated);

void find_all_instantiations(int oper_id, int nof_param, int vars[max_nof_parameters]);

// This function finds actions having fact h as precondition and
// adds them in the agenda.
void find_new_applicable_actions(fact* f)
{
	int vars[max_nof_parameters];
	hash_entry* back_points[max_sof_op_lists-1];	// array of pointers to hash_entry items, for every precondition
	int instantiated_by[max_nof_parameters];		// array of 'pointers' to the preconditions, for every parameter
	int oper_id;
	// for every operator...
	for (oper_id=0;oper_id<nof_operators;oper_id++)
	{
//		cout <<Operators[oper_id] << endl;
		int nof_param=Operators[oper_id].nof_parameters;
		int prec_no;
		// for every operator's precondition...
		for (prec_no=0;prec_no<Operators[oper_id].sof_lists[prec_list];prec_no++)
		if (f->instantiable(Operators[oper_id].strips[prec_list][prec_no]))
		{
			fact* current_prec=&Operators[oper_id].strips[prec_list][prec_no];	// for shortness and acceleration
//			cout << *current_prec << endl;
			int j;
			// Set initially all the parameters to 0
			for (j=0;j<max_nof_parameters;j++)
			{
				vars[j]=0;
				instantiated_by[j]=-1;
			}
			// Set the parameters affected by the current fact (h->f) to the appropriate values...
			for (j=0;j<predicates[f->pred].arity;j++)
				if (current_prec->arguments[j]<0)
					vars[-current_prec->arguments[j]-1]=f->arguments[j];

			// create reduced precs array, i.e. the original precs minus the new prec...
			int nof_precs=Operators[oper_id].sof_lists[prec_list]-1;

			fact* precs;
			if (nof_precs>0)
			{
				precs=new fact[nof_precs];
				int j1=0;
				for(j=0;j<=nof_precs;j++)
					if (j!=prec_no)
					{
						precs[j1]=Operators[oper_id].strips[prec_list][j];
						j1++;
					}
			}
			else
				precs=NULL;

			// Now we have the original parameter list (i.e. vars[]), with some parameters instantiated,
			// and the new precondition list, with the new precondition fact removed.
			
				
			if (Operators[oper_id].sof_lists[prec_list]>1)	
			{													
				// initialization steps
				for (j=0;j<max_sof_op_lists-1;j++) 
					back_points[j]=NULL;

				j=0;
				int max_instantiated=0;

				bool finished=false;
				while (!finished) 
				{
//					cout << precs[j] << endl;
					if (instantiate_prec(precs, nof_param, j, vars, back_points, instantiated_by, &max_instantiated))
					{
//						cout << j << " : " << back_points[j]->f << endl;
						//cout << Operators[oper_id].strips[prec_list][j] << " = ";
						//cout << Operators[oper_id].strips[prec_list][j].instantiate(vars) << endl;
						j++;
						if (j==nof_precs)
						{	
							j--;
							
							find_all_instantiations(oper_id, nof_param, vars);
							while (j>max_instantiated)
							{
								back_points[j]=NULL;
								j--;
								// Deallocation of the variables is performed in the instantiate_prec(...)
							}
							if (j<0)
								finished=true;
						}	// if (==nof_precs)
					}	
					else	// if (instantiate_prec(precs, oper_id, j, vars, back_points, instantiated_by, &max_instantiated))
					{
						//cout << "Fail:" << Operators[oper_id].strips[prec_list][j].instantiate(vars) << endl;
						if (j==0 || max_instantiated<0)
							finished=true;
						else
						{
							while (j>max_instantiated)
							{
								back_points[j]=NULL;
								j--;
							}
							if (j<0)
								finished=true;
						}

/*
						if (max_instantiated>=0)
						{
							if (j>0)
								back_points[j]=NULL;
							int i1;
							for(i1=j-1;i1>max_instantiated;i1--)
							{
								//cout << "Deallocate: " << Operators[oper_id].strips[prec_list][i1] << endl;							
								int i2;
								for (i2=0;i2<max_nof_parameters;i2++)
								if (instantiated_by[i2]==i1)
								{
									instantiated_by[i2]=-1;
									vars[i2]=0;
								}
								back_points[i1]=NULL;
							}
							j=max_instantiated;
						}	
*/
					}
				}
			}	
			else	//	if (Operators[oper_id].sof_lists[prec_list]>1)	
			{
				find_all_instantiations(oper_id, nof_param, vars);

				/*
				if (mode==1 && nof_resources>0)
					create_inverted_action(oper_id, vars);
				else if (mode==1 && nof_resources==0)
				{
					create_inverted_action(oper_id, vars);
					create_normal_action(oper_id,vars);
				}	
				else if (mode==2 && nof_resources>0)
					create_normal_action(oper_id,vars);
					*/
			}	// 	if (Operators[oper_id].sof_lists[prec_list]>1)	
			
	
		}	
	
	}
}


void find_all_instantiations(int oper_id, int nof_param, int vars[max_nof_parameters])
{
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
				// check if all the parameters have different values
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

		if (!all_dif)
		{
			action* tact=new action(oper_id, vars);
//			cout << *tact << endl;;
			int add_id=Operators[oper_id].sof_lists[add_list]-1;
			int del_id=Operators[oper_id].sof_lists[delete_list]-1;
			if (del_id!=add_id) all_dif=true;

/*			int iii;
			cout << "ADD LIST = ";
			for (iii=0;iii<Operators[oper_id].sof_lists[add_list];iii++)
				cout << Operators[oper_id].strips[add_list][iii].instantiate(vars) << ", ";
			cout << endl;

			cout << "DELETE LIST = ";
			for (iii=0;iii<Operators[oper_id].sof_lists[delete_list];iii++)
				cout << Operators[oper_id].strips[delete_list][iii].instantiate(vars) << ", ";
			cout << endl;
*/

			while (add_id>=0 && !all_dif)
			{
				fact add_fact=Operators[oper_id].strips[add_list][add_id].instantiate(vars);
//				cout << "ADD = " << add_fact << endl;
				
				del_id=Operators[oper_id].sof_lists[delete_list]-1;
				bool found=false;
				while (del_id>=0 && !found)
				{
					fact del_fact=Operators[oper_id].strips[delete_list][del_id].instantiate(vars);
//					cout << "     DEL FACT = " << del_fact << endl;
					if (add_fact==del_fact)
						found=true;
					else
						del_id--;
				}
				if (!found)
					all_dif=true;
				else
					add_id--;
			}
		}

//		if (all_dif)
//			cout << "OK" << endl;
//		else
//			cout << "REJECTED" << endl;

		if (all_dif)
		{
			action* new_action=new action(oper_id, vars);
			new_action->next=all_actions;
			all_actions=new_action;
			if (agenda_head==NULL)
			{
				agenda_head=new linked_action();
				agenda_head->step=new_action;
				agenda_tail=agenda_head;
			}
			else
			{
				agenda_tail->next=new linked_action();
				agenda_tail=agenda_tail->next;
				agenda_tail->step=new_action;
			}
			
//			cout << *all_actions->step << endl;
			nof_actions++;
				/*
			if (mode==1 && nof_resources>0)
				create_inverted_action(oper_id, vars);
			else if (mode==1 && nof_resources==0)
			{
				create_inverted_action(oper_id, vars);
				create_normal_action(oper_id,vars);
			}
			else if (mode==2 && nof_resources>0)
				create_normal_action(oper_id,vars);
				*/
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
	}		//	while (more_instantiations)
	int iii;
	for(iii=0;iii<nof_param;iii++)
		if (not_instantiated[iii])
			vars[iii]=0;
}



hash_entry* find_next_fact(hash_entry* back_point, fact* prec);


// This function tries to instantiate the jth precondition of the array precs.
// If the jth precondition is already instantiated, the fact by which it has been instantiated
// is pointed by backpoints[j], otherwise backpoints[j]=NULL.
// The current parameters' allocation is in vars[].
// The facts by which the previous (to j) preconditions have been instantiated are pointed
// by back_points[].
// The precs id number by which the various parameters of the preconditions have been instantiated
// are indicated by instantiated_by[].
// Finally, the max_instantiated output variable indicates the max precondition that 
// caused instantiation of a variable.
// 'nof_param' is the number of parameters of the current operator.
// If the instantiation of precs[j] is unable, the function returns FALSE, otherwise it returns TRUE.
bool instantiate_prec(fact* precs, int nof_param, int j, int vars[max_nof_parameters], 
		hash_entry* back_points[max_sof_op_lists], int instantiated_by[max_sof_op_lists],
		int* max_instantiated)
{
	if (precs==NULL)
	{
		*max_instantiated=-1;
		return true;
	}
	
	int max_inst;

	fact cur_prec=precs[j];	// for shortness
//	cout << cur_prec << endl;
	int i;

		//	deallocate variables
	if (back_points[j]!=NULL)
	{
		for (i=0;i<nof_param;i++)
			if (instantiated_by[i]==j)
			{
				instantiated_by[i]=-1;
				vars[i]=0;
			}
	}

	max_inst=-1;
	int i1;
	for(i1=0;i1<nof_param;i1++)
		if (instantiated_by[i1]>max_inst)
			max_inst=instantiated_by[i1];
	
	// create a fact template, according to the current variables allocations,
	// in order to match it with the hash_table facts...
	fact f;
	f.pred=precs[j].pred;
	for(i1=0;i1<predicates[precs[j].pred].arity;i1++)
		if (precs[j].arguments[i1]>0)
			f.arguments[i1]=precs[j].arguments[i1];
		else
		{
			if (vars[-precs[j].arguments[i1]-1]>0)
				f.arguments[i1]=vars[-precs[j].arguments[i1]-1];
			else
				f.arguments[i1]=precs[j].arguments[i1];
		}
	
	
//	cout << f << endl;
	back_points[j]=find_next_fact(back_points[j], &f);
	
	if (back_points[j]!=NULL)
	{
//		cout << back_points[j]->f << endl;
		int k;
		for(k=0;k<predicates[cur_prec.pred].arity;k++)
			if(cur_prec.arguments[k]<0 && vars[-cur_prec.arguments[k]-1]==0)
			{
				vars[-cur_prec.arguments[k]-1]=back_points[j]->f.arguments[k];
				instantiated_by[-cur_prec.arguments[k]-1]=j;
				max_inst=j;
			}
	}	//	while (i<nof_constants && !instantiable)

	*max_instantiated=max_inst;
	if (back_points[j]!=NULL)
		return true;
	else
		return false;
}

// This function looks for the next fact in the hash_table (next relative to 
// back_point fact) that can be matched with the fact f.
hash_entry* find_next_fact(hash_entry* back_point, fact* prec)
{
	// ATTENTION: This vars[] array is different from the vars[] of the calling functions. This vars[]
	// concerns only the non-instantiated variables of fact f. The already instantiated variables are already grounded within f.
	int vars[max_arity];
	bool grounded[max_arity];
	int arity=predicates[prec->pred].arity;

	int i;	
	if (back_point!=NULL)
	{
		for(i=0;i<arity;i++)
		{
			vars[i]=back_point->f.arguments[i];	
			if (prec->arguments[i]>0)
				grounded[i]=true;
			else
				grounded[i]=false;
		}
	}
	else
	{
		for(i=0;i<arity;i++)
		{
			if (prec->arguments[i]>0)
			{
				grounded[i]=true;
				vars[i]=prec->arguments[i];	
			}
			else
			{
				grounded[i]=false;
				vars[i]=0;
			}
		}
	}


	if (arity==0)
	{
		if (back_point!=NULL)
			return NULL;
		else
		{
			pointer* ptr;
			ptr=&hash_table[prec->pred];
			if (ptr->forward==NULL)
				return NULL;
			else
				return (hash_entry*) ptr->forward;
		}
	}
	
	pointer* ptr;
	int cur_arg;
	if (back_point!=NULL)
	{
		cur_arg=arity-1;
		ptr=((pointer*)back_point->back->back);
		while (grounded[cur_arg] && cur_arg>=0)
		{
			cur_arg--;
			ptr=((pointer*) ptr->back);
		}
		if (cur_arg<0)
			return NULL;
	}
	else
	{
		cur_arg=0;
		ptr=&hash_table[prec->pred];
		if (ptr->forward==NULL)
			return NULL;
	}
//	cout << *ptr << endl;
	while (cur_arg>=0)		// Alternatively we could use: while (ptr!=NULL)
	{
		if (grounded[cur_arg])
		{
			if (ptr->forward!=NULL)
			{
				pointer* ptr2;
				ptr2=&((pointer*) ptr->forward)[vars[cur_arg]-1];
//				cout << *ptr2 << endl;
				if (ptr2!=NULL)
				{
					ptr=ptr2;
					cur_arg++;
					if (cur_arg==arity)
					{
						if ((hash_entry*) ptr->forward !=NULL)
							if (((hash_entry*) ptr->forward)!=back_point)
								return ((hash_entry*) ptr->forward);
						cur_arg--;
						cur_arg--;
						ptr=(pointer*)ptr->back;
						ptr=(pointer*)ptr->back;
						while (grounded[cur_arg] && cur_arg>=0)
						{
							cur_arg--;
							ptr=((pointer*) ptr->back);
						}
					}
				}
				else
				{
					cur_arg--;
					ptr=((pointer*) ptr->back);
					while (grounded[cur_arg] && cur_arg>=0)
					{
						cur_arg--;
						ptr=((pointer*) ptr->back);
					}
				}
			}	//	if (ptr->forward!=NULL)
			else
			{
				cur_arg--;
				ptr=((pointer*) ptr->back);
				while (grounded[cur_arg] && cur_arg>=0)
				{
					cur_arg--;
					ptr=((pointer*) ptr->back);
				}
			}
		}
		else	// if (grounded[cur_arg])
		{
			bool found=false;
			if (ptr->forward!=NULL)
			{
				int i=vars[cur_arg]+1;
				while (i<=nof_objects && !found)
				{
					if (((pointer*)ptr->forward)[i-1].forward!=NULL)
					{
						found=true;
						ptr=&((pointer*) ptr->forward)[i-1];
//						cout << *ptr << endl;
						vars[cur_arg]=i;
						cur_arg++;
						if (cur_arg==arity)
						{
							return (hash_entry*) ptr->forward;
						}
					}
					else
						i++;
				}
			}
			if (!found)
			{
				ptr=(pointer*) ptr->back;
				vars[cur_arg]=0;
				cur_arg--;
				while (grounded[cur_arg] && cur_arg>=0)
				{
					cur_arg--;
					ptr=((pointer*) ptr->back);
				}
			}
		}	// if (grounded[cur_arg])
	}
	return NULL;

}