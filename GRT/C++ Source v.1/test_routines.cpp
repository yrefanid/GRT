#include "planner.h"


void display_predicates()
{
	cout << "Predicates of the domain" << endl;
	cout << "========================" << endl;
	int i;
	for(i=0;i<nof_predicates;i++)
		cout << predicates[i].name << endl;
	cout <<endl << endl;
}

void display_objects()
{
	cout << "Objects of the domain" << endl;
	cout << "=====================" << endl;
	int i;
	for(i=1;i<=nof_objects;i++)
		cout << objects[i] << endl;
	cout <<endl << endl;
}

void display_constants()
{
	cout << "Constants of the domain" << endl;
	cout << "=======================" << endl;
	int i;
	for(i=0;i<nof_constants;i++)
		cout << constants[i] << endl;
	cout <<endl << endl;
}

void display_constant_predicates()
{
	cout << "Constant predicates" << endl;
	cout << "===================" << endl;
	int i;
	for(i=0;i<nof_predicates;i++)
		if(constant_predicates[i])
			cout << predicates[i].name << "/" << predicates[i].arity << endl;
}





void display_operators()
{
	cout << "Operators of the domain" << endl;
	cout << "=======================" << endl;
	int i;
	for(i=0;i<nof_operators;i++)
		cout << Operators[i] << endl;
	cout <<endl << endl;
}

void	display_agenda(agenda* head_agenda)
{
	while (head_agenda!=NULL)
	{
		cout <<"State:   "<< *(head_agenda->nd->s) << endl;
		cout <<"Operator:"<< head_agenda->nd->step << endl<<endl;
		head_agenda=head_agenda->next;
	}
}


void display_hash_table()
{
	cout << endl << "Display hash table contents" << endl;
	cout <<	        "===========================" << endl;
	void* ptr;
	int vars[max_arity];
	int i;
	for(i=0;i<nof_predicates;i++) if (!constant_predicates[i])
	{
		int j;
		for(j=0;j<max_arity;j++) vars[j]=1;
		if (predicates[i].arity>0)
		{
			if (hash_table[i].ptr!=NULL)
			{
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
					{
						if (((hash_entry*) ptr)->distance<0)
						{
							fact f=fact(i, vars);
	
							cout << f ;
							cout << " "<< ((hash_entry*) ptr)->distance;
							cout << "   Enriched: " << ((hash_entry*) ptr)->enriched;
							cout << "   Used: " << ((hash_entry*) ptr)->used << endl;
						}
/*						cout << "Actions" << endl;
						linked_inverted_action* ptr2;
						ptr2=((hash_entry*) ptr)->inv_op_prec;
						while (ptr2!=NULL) 
						{
							cout << *(ptr2->inverted_step -> step) <<endl;
							ptr2=ptr2->next;
						}
						cout << endl;
*/
/*
						cout << " ";
						linked_hash_entry* related;
						related=((hash_entry*) ptr)->related;
						if (related==NULL)
							cout << "NULL";
						else
							while (related!=NULL)
							{
								cout << related->entry->f << ",";
								related=related->next;
							}
						cout << endl;
*/
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
			if (((hash_entry*) ptr)->distance<0)
			{
				fact f=fact(i, vars);
				cout << f ;
				ptr=hash_table[i].ptr;
				cout << " "<< ((hash_entry*) ptr)->distance;
			}
/*			cout << "Actions" << endl;
			linked_inverted_action* ptr2;
			ptr2=((hash_entry*) ptr)->inv_op_prec;
			while (ptr2!=NULL) 
			{
				cout << *(ptr2->inverted_step -> step) <<endl;
				ptr2=ptr2->next;
			}
			cout << endl;
*/
/*			cout << " ";
			linked_hash_entry* related;
			related=((hash_entry*) ptr)->related;
			if (related==NULL)
				cout << "NULL";
			else
				while (related!=NULL)
				{
					cout << related->entry->f << ",";
					related=related->next;
				}
			cout << endl;
*/
		}
	}		
}


void print_linked_actions(action* act)
{
	int counter=0;
	cout << "Actions" << endl;
	cout << "=======" << endl;
	while (act!=NULL)
	{
		counter++;
		cout << counter << ") " << *act << endl;
		act=act->next;
	}
}