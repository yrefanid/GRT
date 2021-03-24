#include "planner.h"

bool not_repeated_state(state*, node*);
int state_grade(state* s);

// pointers to agenda hash table
agenda* agenda_head[agenda_hash_size+2];
agenda* agenda_tail[agenda_hash_size+2];

int	best_agenda;

int bfs_solve()
{
	// initialize agenda's hash table
	int i;
	for (i=0;i<agenda_hash_size+2;i++)
	{
		agenda_head[i]=NULL;
		agenda_tail[i]=NULL;
	}
	best_agenda=agenda_hash_size+2;

	// create initial nodes and add the corresponging pointers to the agenda
	agenda* agenda_ptr;
	node* node_ptr;

	action* appl_actions=initial.applicable2();
	while (appl_actions!=NULL)
	{
		//cout << counter++ << endl;
		state* nextstate=initial.next_state(*appl_actions);
		node_ptr=new_node(node(nextstate, *appl_actions, NULL));
		int score=state_grade(nextstate);
		agenda_ptr=new agenda(node_ptr, score);
		if (score>=0 && score<=agenda_hash_size)
		{
			if (agenda_head[score]==NULL)
			{
				agenda_head[score]=agenda_ptr;
				agenda_tail[score]=agenda_ptr;
			}
			else
			{
				agenda_tail[score]->next=agenda_ptr;
				agenda_tail[score]=agenda_ptr;
			}
			if (score<best_agenda)
				best_agenda=score;
		}	// if score>=0 && ...
		action* tmp_action;
		tmp_action=appl_actions;
		appl_actions=appl_actions->next;
		delete_action(tmp_action);
	}	// 	while (appl_actions!=NULL)
	
	clock_t t1;
	clock_t t2;
	clock_t t3;
	t1=clock();
	while (best_agenda<=agenda_hash_size)
	{
		check_time();
		if (display_messages)
		cout << best_agenda << endl;
		node* best_node=agenda_head[best_agenda]->nd;
		
		agenda* new_head_agenda=agenda_head[best_agenda]->next;
		delete agenda_head[best_agenda];
		agenda_head[best_agenda]=new_head_agenda;
		if (new_head_agenda==NULL)
		{
			agenda_tail[best_agenda]=NULL;
			bool flag=true;
			best_agenda++;
			while (flag && best_agenda<=agenda_hash_size)
				if (agenda_head[best_agenda]!=NULL)
					flag=false;
				else
					best_agenda++;
		}
		
		if (not_repeated_state(best_node->s, best_node->previous))
		{
		//	cout << ++counter << ":" << head_agenda->nd->step <<endl;
			if (goal<=best_node->s)
			{
				ftime3=clock();
				dt2=(double)(ftime3-ftime2)/CLOCKS_PER_SEC;
				dt=(double) (ftime3)/CLOCKS_PER_SEC;
				finish = clock();
				duration=(double)(finish - start);
				
				action* plan=best_node->get_plan();

				int steps=0;
				action* t_plan=plan;
				if(display_messages)
					cout << "Plan:" << endl;
				while (t_plan!=NULL)
				{
					if(display_messages)
						cout << *t_plan << endl;
					steps++;
					t_plan=t_plan->next;
				}
				if (display_messages)
				{
					cout << "Total steps: " << steps << endl;
					cout << "Enriched goal state    : " << dt3 << endl;
					cout << "Graph creation time    : " << dt1 << endl;
					cout << "Search time    : " << dt2 << endl;
					cout << "Total  time : " << dt << endl;
					cout << "Pure time: " << duration << endl;
					cout << "GOAL FOUND" << endl << endl;
				}
				cout << problem_name << " " ;
				cout << dt << " ";
				cout << steps ;
				t_plan=plan;
				while (t_plan!=NULL)
				{
					cout << " " << *t_plan ;
					t_plan=t_plan->next;
				}
				cout << endl;
					
				if (output_file_provided)
				{
					ofstream outfile;
					outfile.open(output_file,ios::app);
					outfile << problem_name << " " ;
					outfile << dt << " ";
					outfile << steps ;
					t_plan=plan;
					while (t_plan!=NULL)
					{
						outfile << " " << *t_plan ;
						t_plan=t_plan->next;
					}
					outfile << endl;
					outfile.close();
				}

				while (plan!=NULL)
				{
					t_plan=plan->next;
					delete plan;
					plan=t_plan; 
				}
				return 0;
			}
			
			t3=clock();
			appl_actions=best_node->s->applicable2();
			#if MESS1
			cout << "State: " << *(best_node->s) << endl;
			print_linked_actions(appl_actions);
			#endif
	//		cout << "Applicable: " << clock()-t3 << endl;
			while (appl_actions!=NULL)
			{
				state* nextstate=best_node->s->next_state(*appl_actions);
				node_ptr=new_node(node(nextstate, *appl_actions, best_node));
				int score=state_grade(nextstate);
				agenda_ptr=new agenda(node_ptr, score);
				if (score>=0 && score<=agenda_hash_size)
				{
					if (agenda_head[score]==NULL)
					{
						agenda_head[score]=agenda_ptr;
						agenda_tail[score]=agenda_ptr;
					}
					else
					{
						agenda_tail[score]->next=agenda_ptr;
						agenda_tail[score]=agenda_ptr;
					}
					if (score<best_agenda)
						best_agenda=score;
				}	// if score>=0 && ...
				action* tmp_action;
				tmp_action=appl_actions->next;
				delete_action(appl_actions);
				appl_actions=tmp_action;
			}	// 	while (appl_actions!=NULL)
		}	// if not_repeated_state...
		t2=clock();
//		cout << "Cycle time: " << t2-t1 << endl;
		t1=t2;
	}
	return 0;
}


bool not_repeated_state(state* nextstate, node* nd)
{
	while (nd!=NULL)
	if (*nextstate==nd->s)
			return false;
		else
			nd=nd->previous;
	return true;
}

int state_grade(state* s)
{
	linked_hash_entry* linked_facts;
	linked_facts=NULL;
	hash_entry* fact_pointer;
	 int i;
	for(i=0;i<s->size;i++)
	{
		fact_pointer=get_fact_pointer(&(s->facts[i]));
		linked_facts=new_linked_hash_entry(linked_hash_entry(fact_pointer, linked_facts));
	}
	int score=find_grade(linked_facts); // find_grade() deletes the list 'linked_facts'...
	return score;
}

