#include "planner.h"

#define fact_block_size 10000
#define FACT_NULL -9999

#define action_block_size 10000
#define ACTION_NULL -9999

#define node_block_size 10000
#define NODE_NULL NULL

#define state_block_size 10000
#define STATE_NULL -1

#define linked_hash_entry_block_size 50000
#define LINKED_HASH_ENTRY_NULL (hash_entry*) -1

class	fact_block
{
public:
	fact* block;
	int first_pos;
	fact_block* next;
	fact_block* previous;

	fact_block(fact_block* PREVIOUS)
	{
		previous=PREVIOUS;
		next=NULL;
		first_pos=0;
		block=new fact[fact_block_size];
		if (block==NULL)
		{
			cout << "ERROR while allocating memory for object 'fact_block'." << endl;
			abort();
		}
		int i=0;
		for(i=0;i<fact_block_size;i++)		// mark the facts as empty
			block[i].pred=FACT_NULL;
	}

	fact* new_fact(fact f)
	{
		if (first_pos<fact_block_size)
		{
			block[first_pos]=f;
			fact* ret=&block[first_pos];
			first_pos++;
			while (first_pos<fact_block_size && block[first_pos].pred!=FACT_NULL)
				first_pos++;
			return ret;
		}
		else	//	if (first_pos<fact_block_size)
		{
			if (next!=NULL)
			{
				return next->new_fact(f);
			}
			else
			{
				next=new fact_block(this);
				return next->new_fact(f);
			}
		}
	}

	void	delete_fact(fact* f)
	{
		if (f<&block[fact_block_size])
		{
			f->pred=FACT_NULL;
			int f_pos=f-block;
			if (f_pos<first_pos)
				first_pos=f_pos;

			// check whether it is possible to release the whole block...
			if (f_pos==0 && previous!=NULL)
			{
				bool flag=true;
				int i=0;
				while (flag && i<fact_block_size)
				{
					if (block[i].pred!=FACT_NULL)
						flag=false;
					else
						i++;
				}
				if (flag)
				{
					previous->next=next;
					delete block;		// ATTENTION: this instruction deletes the memory allocated
										// by this object, but DOES NOT DELETE THE OBJECT ITSELF. 
										// The memory released for the object (which is a few bytes only)
										// is not released, but is not referenced by any other object...
				}
			}
		}
		else	// if (f<&block[fact_block_size])
		{
			if (next!=NULL)
				next->delete_fact(f);
			else
			{
				cout << "ERROR while deleting fact. Fact pointer is invalid" << endl;
				abort();
			}
		}
	}
};

fact_block* fact_blocks;

fact* new_fact(fact f)
{
	return fact_blocks->new_fact(f);
}

void delete_fact(fact* f)
{
	fact_blocks->delete_fact(f);
}



class	linked_hash_entry_block
{
public:
	linked_hash_entry* block;
	long int first_pos;
	linked_hash_entry_block* next;
	linked_hash_entry_block* previous;

	linked_hash_entry_block(linked_hash_entry_block* PREVIOUS)
	{
		previous=PREVIOUS;
		next=NULL;
		first_pos=0;
		block=new linked_hash_entry[linked_hash_entry_block_size];
		if (block==NULL)
		{
			cout << "ERROR while allocating memory for object 'linked_hash_entry_block'." << endl;
			abort();
		}
		int i=0;
		for(i=0;i<linked_hash_entry_block_size;i++)		// mark the linked_hash_entrys as empty
			block[i].entry=LINKED_HASH_ENTRY_NULL;
	}

	linked_hash_entry* new_linked_hash_entry(linked_hash_entry lnk)
	{
		if (first_pos<linked_hash_entry_block_size)
		{
			block[first_pos]=lnk;
			linked_hash_entry* ret=&block[first_pos];
			first_pos++;
			while (first_pos<linked_hash_entry_block_size && block[first_pos].entry!=LINKED_HASH_ENTRY_NULL)
				first_pos++;
			return ret;
		}
		else	//	if (first_pos<linked_hash_entry_block_size)
		{
			if (next!=NULL)
			{
				return next->new_linked_hash_entry(lnk);
			}
			else
			{
				next=new linked_hash_entry_block(this);
				return next->new_linked_hash_entry(lnk);
			}
		}
	}

	void	delete_linked_hash_entry(linked_hash_entry* lnk)
	{
		if (lnk<&block[linked_hash_entry_block_size])
		{
			lnk->entry=LINKED_HASH_ENTRY_NULL;
			int lnk_pos=lnk-block;
			if (lnk_pos<first_pos)
				first_pos=lnk_pos;

			// check whether it is possible to release the whole block...
			if (lnk_pos==0 && previous!=NULL)
			{
				bool flag=true;
				int i=0;
				while (flag && i<linked_hash_entry_block_size)
				{
					if (block[i].entry!=LINKED_HASH_ENTRY_NULL)
						flag=false;
					else
						i++;
				}
				if (flag)
				{
					previous->next=next;
					delete block;		// ATTENTION: this instruction deletes the memory allocated
										// by this object, but DOES NOT DELETE THE OBJECT ITSELF. 
										// The memory released for the object (which is a few bytes only)
										// is not released, but is not referenced by any other object...
				}
			}
		}
		else	// if (f<&block[linked_hash_entry_block_size])
		{
			if (next!=NULL)
				next->delete_linked_hash_entry(lnk);
			else
			{
				cout << "ERROR while deleting linked_hash_entry. Linked hash entry pointer is invalid" << endl;
				abort();
			}
		}
	}
};

linked_hash_entry_block* linked_hash_entry_blocks;

linked_hash_entry* new_linked_hash_entry(linked_hash_entry lnk)
{
	return linked_hash_entry_blocks->new_linked_hash_entry(lnk);
}

void delete_linked_hash_entry(linked_hash_entry* lnk)
{
	linked_hash_entry_blocks->delete_linked_hash_entry(lnk);
}



class	action_block
{
public:
	action* block;
	int first_pos;
	action_block* next;
	action_block* previous;

	action_block(action_block* PREVIOUS)
	{
		previous=PREVIOUS;
		next=NULL;
		first_pos=0;
		block=new action[action_block_size];
		if (block==NULL)
		{
			cout << "ERROR while allocating memory for object 'action_block'." << endl;
			abort();
		}
		int i=0;
		for(i=0;i<action_block_size;i++)		// mark the actions as empty
			block[i].operator_id=ACTION_NULL;
	}

	action* new_action(action act)
	{
		if (first_pos<action_block_size)
		{
			block[first_pos]=act;
			action* ret=&block[first_pos];
			first_pos++;
			while (first_pos<action_block_size && block[first_pos].operator_id!=ACTION_NULL)
				first_pos++;
			return ret;
		}
		else	//	if (first_pos<action_block_size)
		{
			if (next!=NULL)
			{
				return next->new_action(act);
			}
			else
			{
				next=new action_block(this);
				return next->new_action(act);
			}
		}
	}

	void	delete_action(action* act)
	{
		if (act<&block[action_block_size])
		{
			act->operator_id=ACTION_NULL;
			int act_pos=act-block;
			if (act_pos<first_pos)
				first_pos=act_pos;

			// check whether it is possible to release the whole block...
			if (act_pos==0 && previous!=NULL)
			{
				bool flag=true;
				int i=0;
				while (flag && i<action_block_size)
				{
					if (block[i].operator_id!=ACTION_NULL)
						flag=false;
					else
						i++;
				}
				if (flag)
				{
					previous->next=next;
					delete block;		// ATTENTION: this instruction deletes the memory allocated
										// by this object, but DOES NOT DELETE THE OBJECT ITSELF. 
										// The memory released for the object (which is a few bytes only)
										// is not released, but is not referenced by any other object...
				}
			}
		}
		else	// if (f<&block[action_block_size])
		{
			if (next!=NULL)
				next->delete_action(act);
			else
			{
				cout << "ERROR while deleting action. Fact pointer is invalid" << endl;
				abort();
			}
		}
	}
};

action_block* action_blocks;

action* new_action(action act)
{
	return action_blocks->new_action(act);
}

void delete_action(action* act)
{
	action_blocks->delete_action(act);
}



class	node_block
{
public:
	node* block;
	int first_pos;
	node_block* next;
	node_block* previous;

	node_block(node_block* PREVIOUS)
	{
		previous=PREVIOUS;
		next=NULL;
		first_pos=0;
		block=new node[node_block_size];
		if (block==NULL)
		{
			cout << "ERROR while allocating memory for object 'node_block'." << endl;
			abort();
		}
		int i=0;
		for(i=0;i<node_block_size;i++)		// mark the nodes as empty
			block[i].s=NODE_NULL;
	}

	node* new_node(node nod)
	{
		if (first_pos<node_block_size)
		{
			block[first_pos]=nod;
			node* ret=&block[first_pos];
			first_pos++;
			while (first_pos<node_block_size && block[first_pos].s!=NODE_NULL)
				first_pos++;
			return ret;
		}
		else	//	if (first_pos<node_block_size)
		{
			if (next!=NULL)
			{
				return next->new_node(nod);
			}
			else
			{
				next=new node_block(this);
				return next->new_node(nod);
			}
		}
	}

	void	delete_node(node* nod)
	{
		if (nod<&block[node_block_size])
		{
			nod->s=NODE_NULL;
			int nod_pos=nod-block;
			if (nod_pos<first_pos)
				first_pos=nod_pos;

			// check whether it is possible to release the whole block...
			if (nod_pos==0 && previous!=NULL)
			{
				bool flag=true;
				int i=0;
				while (flag && i<node_block_size)
				{
					if (block[i].s!=NODE_NULL)
						flag=false;
					else
						i++;
				}
				if (flag)
				{
					previous->next=next;
					delete block;		// ATTENTION: this instruction deletes the memory allocated
										// by this object, but DOES NOT DELETE THE OBJECT ITSELF. 
										// The memory released for the object (which is a few bytes only)
										// is not released, but is not referenced by any other object...
				}
			}
		}
		else	// if (f<&block[node_block_size])
		{
			if (next!=NULL)
				next->delete_node(nod);
			else
			{
				cout << "ERROR while deleting node. Fnod pointer is invalid" << endl;
				abort();
			}
		}
	}
};

node_block* node_blocks;

node* new_node(node nod)
{
	return node_blocks->new_node(nod);
}

void delete_node(node* nod)
{
	node_blocks->delete_node(nod);
}



class	state_block
{
public:
	state* block;
	int first_pos;
	state_block* next;
	state_block* previous;

	state_block(state_block* PREVIOUS)
	{
		previous=PREVIOUS;
		next=NULL;
		first_pos=0;
		block=new state[state_block_size];
		if (block==NULL)
		{
			cout << "ERROR while allocating memory for object 'state_block'." << endl;
			abort();
		}
		int i=0;
		for(i=0;i<state_block_size;i++)		// mark the states as empty
			block[i].size=STATE_NULL;
	}

	state* new_state(state s)
	{
		if (first_pos<state_block_size)
		{
			block[first_pos]=s;
			state* ret=&block[first_pos];
			first_pos++;
			while (first_pos<state_block_size && block[first_pos].size!=STATE_NULL)
				first_pos++;
			return ret;
		}
		else	//	if (first_pos<state_block_size)
		{
			if (next!=NULL)
			{
				return next->new_state(s);
			}
			else
			{
				next=new state_block(this);
				return next->new_state(s);
			}
		}
	}

	void	delete_state(state* s)
	{
		if (s<&block[state_block_size])
		{
			s->size=STATE_NULL;
			int s_pos=s-block;
			if (s_pos<first_pos)
				first_pos=s_pos;

			// check whether it is possible to release the whole block...
			if (s_pos==0 && previous!=NULL)
			{
				bool flag=true;
				int i=0;
				while (flag && i<state_block_size)
				{
					if (block[i].size!=STATE_NULL)
						flag=false;
					else
						i++;
				}
				if (flag)
				{
					previous->next=next;
					delete block;		// ATTENTION: this instruction deletes the memory allocated
										// by this object, but DOES NOT DELETE THE OBJECT ITSELF. 
										// The memory released for the object (which is a few bytes only)
										// is not released, but is not referenced by any other object...
				}
			}
		}
		else	// if (f<&block[state_block_size])
		{
			if (next!=NULL)
				next->delete_state(s);
			else
			{
				cout << "ERROR while deleting state. Fs pointer is invalid" << endl;
				abort();
			}
		}
	}
};

state_block* state_blocks;

state* new_state(state s)
{
	return state_blocks->new_state(s);
}

void delete_state(state* s)
{
	state_blocks->delete_state(s);
}






void mem_init()
{
	fact_blocks=new fact_block(NULL);
	linked_hash_entry_blocks=new linked_hash_entry_block(NULL);
	action_blocks=new action_block(NULL);
	node_blocks=new node_block(NULL);
	state_blocks=new state_block(NULL);
}




void test_facts()
{
	mem_init();
	fact f;
	fact* f_ptr[30000];
	int i;
	for(i=0;i<15000;i++)
		f_ptr[i]=new_fact(f);
		//f_ptr[i]=new fact(f);
	for(i=15000;i<30000;i++)
		f_ptr[i]=new_fact(f);
		//f_ptr[i]=new fact(f);
	for(i=0;i<30000;i++)
		delete_fact(f_ptr[i]);
		//delete f_ptr[i];

}

void test_linked_hash_entries()
{
	mem_init();
	linked_hash_entry f;
	linked_hash_entry* f_ptr[30000];
	int i;
	for(i=0;i<15000;i++)
		f_ptr[i]=new_linked_hash_entry(f);
		//f_ptr[i]=new linked_hash_entry(f);
	for(i=15000;i<30000;i++)
		f_ptr[i]=new_linked_hash_entry(f);
		//f_ptr[i]=new linked_hash_entry(f);
	for(i=0;i<30000;i++)
		delete_linked_hash_entry(f_ptr[i]);
		//delete f_ptr[i];

}


// other objects which the memory manager should cover:

//	2)	agenda

//	4)	linked_facts
//	5)	linked_inverted_actions
//	6)	inverted_actions
//
//	Moreover, it should be faced the problem of the states' facts, for which the memory
//	is allocated once for many facts (and worse, it is released the same way)...
//	Maybe:	new_fact(int number_of_facts)
//			delete_fact(fact* f, int number_of_facts)

