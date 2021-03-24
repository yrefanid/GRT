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
	{
		cout << i << ".  " << objects[i].name << "   ";
		if (objects[i].idle!=NULL)
		{
		if (!objects[i].idle->value)
			cout << "enabled";
		else
			cout << "disabled";
		}
		if (objects[i].criterion>=0)
		{
			cout << "  CRITERION  ";
			if (criteria[objects[i].criterion].type<3)
				cout << "  MONOTONIC"; 
			else
				cout << "  NON-MONOTONIC"; 
		}

		cout << endl;
	}
	cout <<endl << endl;
}


void display_criteria()
{
	cout << "Criteria of the domain" << endl;
	cout << "=======================" << endl;
	cout << "00. Length - weight=" << length_weight << "  Scale=[" << length_from << ", " << length_to << ")" << endl;
	int i;
	for(i=0;i<nof_criteria;i++)
	{
		cout << i << ".  " << objects[criteria[i].object_ID].name << " - weight=";
		cout << criteria[i].weight << "  Scale=";
		if (criteria[i].bounded_from)
			cout << "[";
		else
			cout << "(";
		cout << criteria[i].from << ", " << criteria[i].to;
		if (criteria[i].bounded_to)
			cout << "]";
		else
			cout << ")";
		
		if (criteria[i].max_better)
			cout << "  MAX  ";
		else
			cout << "  MIN  ";

		if (criteria[i].type==0)
			cout << "  NOT-CHANGE  ";
		else if (criteria[i].type==1)
			cout << "  INCREASES  ";
		else if (criteria[i].type==2)
			cout << "  DECREASES  ";
		else cout << "  RANDOM  ";

		if (objects[criteria[i].object_ID].idle!=NULL)
		{
			if (!objects[criteria[i].object_ID].idle->value)
				cout << "enabled";
			else
				cout << "disabled";
		}
		cout << endl;
	}
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

void display_xor_relations()
{
	constraints* t_xors=xors;
	cout << endl;
	cout << "GENERAL DEFINITIONS OF XOR RELATIONS" << endl;
	cout << "====================================" << endl;
	while (t_xors!=NULL)
	{
		cout << *t_xors << endl;
		t_xors=t_xors->next;
	}	
}

void display_pairs(pairs_of_facts* pairs)
{
	cout << endl;
	cout << "PAIRS OF FACTS (INITIAL-GOAL FACTS)" << endl;
	cout << "===================================" << endl;
	pairs_of_facts* t_pairs=pairs;
	while (t_pairs!=NULL)
	{
		cout << t_pairs->initial->f << " - " << t_pairs->goal->f << endl;
		cout << t_pairs->ground_xor << endl;
		t_pairs=t_pairs->next;
	}
}

void display_sequences(pairs_of_facts* pairs)
{
	cout << endl << endl;
	cout << "SEQUENCES OF ACTIONS" << endl;
	cout << "====================" << endl;
	pairs_of_facts* t_pairs=pairs;
	while (t_pairs!=NULL)
	{
		cout << "Pair: " << t_pairs->initial->f << " - " << t_pairs->goal->f << endl;
		linked_hash_entry* sequence=t_pairs->sequence;
		while (sequence!=NULL)
		{
			if (sequence->entry->subproblem_distances->distances->achieved_by!=NULL)
				cout << sequence->entry->f << " ==> " << *sequence->entry->subproblem_distances->distances->achieved_by->step << " ==> " ;
				//cout << sequence->entry->achieved_by->step << " (" << sequence->entry->f << "), " << endl;
			else
				//cout << sequence->entry->f << " : Not achieved!!!" << endl;
				cout << sequence->entry->f << endl;
			sequence=sequence->next;
		}
		cout << endl << endl;
		t_pairs=t_pairs->next;
	}
}

void display_subgoals(linked_subgoals* subgoals)
{
	linked_subgoals* t_subgoals;
	t_subgoals=subgoals;
	cout << endl << "SUBGOALS" << endl;
	cout << "========" << endl;
	while (t_subgoals!=NULL)
	{
		cout << t_subgoals->subgoalPtr->h->f << endl;
		cout << "Type = " << t_subgoals->subgoalPtr->subgoal_type << endl;
		cout << "Position = " << t_subgoals->subgoalPtr->position << endl;
		cout << "XOR relation = " << t_subgoals->subgoalPtr->xor_relation << endl;
		if (t_subgoals->subgoalPtr->subgoal_type==1 && t_subgoals->subgoalPtr->foreign_xor_relation==NULL)
		{
			cout << "ERROR 264729462840274920: Subgoal of type 1 has not set its foreign XOR relation." << endl;
			abort();
		}
		if (t_subgoals->subgoalPtr->subgoal_type==1)
			cout << "Foreign XOR relation = " << t_subgoals->subgoalPtr->foreign_xor_relation << endl << endl;
		else
			cout << "Foreign XOR relation = NULL" << endl;
		cout << endl;
		t_subgoals=t_subgoals->next;
	}
}


void print_leveled_subgoals(int nof_subproblems, linked_subgoals* subgoals)
{
	int i=0;
	while (i<=nof_subproblems)
	{
		cout << "LEVEL " << i << endl;
		cout << "=======" << endl;
		linked_subgoals* t_subgoal;
		t_subgoal=subgoals;
		while (t_subgoal!=NULL)
		{
			if (t_subgoal->subgoalPtr->level==i ||
			(t_subgoal->subgoalPtr->level<=i && t_subgoal->subgoalPtr->subgoal_type==3))
				cout << t_subgoal->subgoalPtr->h->f << ", ";
			t_subgoal=t_subgoal->next;
		}
		cout << endl;
		i++;
	}
	cout << endl;
}


void print_subproblems(linked_states* subproblems)
{
	linked_states* t_states;
	t_states=subproblems;
	cout << endl << endl;
	cout << "SUBPROBLEMS (INTERMEDIATE GOAL STATES) TO BE SOLVED" << endl;
	cout << "===================================================" << endl << endl ;
	while (t_states!=NULL)
	{
		cout << "SUBPROBLEM " << t_states->id << endl;
		cout << "============" << endl;
		cout << *t_states->s << endl << endl ;
		t_states=t_states->next;
	}
}

void display_entry(hash_entry* h)
{
	cout << h->f << " ... ";
	if (h->init_vector!=NULL)
		cout << *h->init_vector << "   ";
	if (h->achieved)
		cout << "ACHIEVED" << endl;
	else
		cout << "NOT ACHIEVED" << endl;
	cout ;
}

void display_entry_related(hash_entry* h)
{
	cout << "HASH ENTRY: " << h->f << endl;
	linked_distances* distances=h->subproblem_distances->distances;
	while (distances!=NULL)
	{
		if (!distances->should_be_deleted)
		{
			cout << *distances->v_distance << " <== " ;
			if (distances->achieved_by!=NULL)
				cout << *distances->achieved_by->step << " : " ;
			else
				cout << "NULL" << " : " ;
			linked_hash_entry* related=distances->related;
			while (related!=NULL)
			{
				cout << related->entry->f << ", ";
				related=related->next;
			}
		}
		cout << endl;
		distances=distances->next;
	}
}

void display_fact_distances(hash_entry* h)
{
	cout << "Fact: " << h->f << " : " ;
//	cout << "Distances" << endl;
//	cout << "=========" << endl;
	if (h->achieved)
	{
		if (h->subproblem_distances->best_distance==NULL)
		{
			cout << "NO BEST DISTANCE" << endl;
		}
		else
		{
			cout << "Best distance: " << *h->subproblem_distances->best_distance->v_distance <<
				" (" << h->subproblem_distances->best_value << ")" << endl;
		}
		linked_distances* distances=h->subproblem_distances->distances;
		while (distances!=NULL)
		{
			if (distances->should_be_deleted) cout << "*";
			cout << *distances->v_distance << " (" << 
				vector_grade(distances->v_distance,1,-1,initial,true) << "), ";
			distances=distances->next;
		}
	}
 	cout << endl;
	cout ;
}

extern inverted_action* all_inverted_actions;

void test_movie1()
{
	inverted_action* t_action=all_inverted_actions;
	while (t_action!=NULL)
	{
		cout << t_action->step << endl;
		t_action=t_action->next;
	}
	cout << endl;
}


void display_normal_actions()
{
	complete_state_action* act=normal_actions_head;
	while (act!=NULL)
	{
		cout << act->step << endl;
		act=act->next;
	}
	cout << endl;
	cout << "Actions in agenda" << endl;
	cout << "=================" << endl;
	linked_complete_state_action* act2=c_agenda_head;
	while (act2!=NULL)
	{
		cout << act2->step->step << endl;
		act2=act2->next;
	}
}


void display_calibration_values() {
	cout << "Length: " << length_times << "/" << length_d_estimated << endl;
	int i;
	for(i=1;i<=nof_criteria;i++)
		cout << objects[criteria[i-1].object_ID].name << ": " << criteria[i-1].times <<"/" << criteria[i-1].d_actual << "/" << criteria[i-1].d_estimated << endl;
}

