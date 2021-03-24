# include <iostream.h>
# include <string.h>
# include <time.h>
# include <sys/timeb.h>
# include <fstream.h>
# include <stdlib.h>
# include <malloc.h>
# include <math.h>
//# include <mbstring.h>

#define MESS1 0

#define	max_arity 20
#define sof_predicate_name 40	// Hereafter, sof_... means "size_of..."
#define max_nof_predicates 1000		// Hereafter, max... means max value of some parameter...
#define sof_object_name 60
#define	max_nof_objects 2000
#define	max_nof_criteria 100
#define max_nof_operators 40
#define max_nof_parameters 12
#define prec_list 0
#define delete_list 1
#define add_list 2
#define max_sof_op_lists 30
#define sof_operator_name 50
#define X -1
#define Y -2
#define Z -3
#define max_nof_constants 3000
#define agenda_hash_size 10000
#define max_file_name 500
#define max_sof_words 200
#define CLOSE_LIST_HASH_SIZE 10000


class fact;
class action;
class linked_hash_entry;
class node;
class state;
class vector;

//void mem_init();
//fact* new_fact(fact);
//void delete_fact(fact*);
//linked_hash_entry* new_linked_hash_entry(linked_hash_entry);
//void delete_linked_hash_entry(linked_hash_entry*);
//extern action* new_action(action);
//extern void delete_action(action*);
//extern node* new_node(node);
//extern void delete_node(node*);
//extern state* new_state(state);
//extern void delete_state(state*);
 
extern bool reduced_enriched;
extern bool copy_from_initial;
extern bool enriched_no_used;
extern bool idle_flag;
extern int max_time;
extern int search_strategy;
extern int OSystem;
extern bool NO_RELATED;
extern bool xor_enabled;
extern bool xor_routines_flagl;
extern bool enrich_initial;
extern bool ignore_criteria;
extern bool no_xors;
extern bool no_rdph;

extern int past_weight;			
extern int remaining_weight;	
extern int length_weight;
extern int length_from;
extern int length_to;

extern bool multiply_scale;
extern int multiply_scale_criterion;
extern int multiply_scale_type;
extern int multiply_scale_number;



extern int appl_counter;
extern clock_t ftime1;
extern clock_t ftime2;
extern clock_t ftime3;
extern long double dt1;
extern long double dt2;
extern long double dt3;		// Enriched goal state
extern long double dt;

extern clock_t start;
extern clock_t finish;   
extern double  duration;

extern char domain_file[max_file_name];
extern char problem_file[max_file_name];
extern char output_file[max_file_name];
extern bool output_file_provided;


extern state* initial;
extern state* goal;

extern action* solution;

extern char problem_name[max_sof_words+1];

extern bool display_messages;
extern bool display_short_messages;

class linked_bool
{
public:
	bool value;
	linked_bool* next;

	linked_bool()
	{
		value=false;
		next=NULL;
	}

	linked_bool(linked_bool* n)
	{
		value=false;
		next=n;
	}
};


class object
{
public:
	char name[sof_object_name+1];
	linked_bool* idle;
	int criterion;

	object()
	{
		strcpy(name,"");
		idle=NULL;
		criterion=-1;
	}

	object(char n[sof_object_name+1])
	{
		strcpy(name,n);
		idle=NULL;
		criterion=-1;
	}

	friend ostream& operator << (ostream& stream, object& o)
	{
		stream << o.name;
		return stream;
	}
};

struct	predicate
{
	int arity;
	char name[sof_predicate_name+1];
};

class Criterion;

extern int nof_predicates;
extern predicate predicates[max_nof_predicates];
extern bool	constant_predicates[max_nof_predicates];
extern int nof_objects;
extern object objects[max_nof_objects];
extern int nof_criteria;
extern Criterion criteria[max_nof_criteria];


int Obj(char name[]);
int P(char name[]);
int R(char name[]);
int R_ID(int Object_ID);

extern int	nof_facts;
extern int  nof_actions;
extern int	nof_set_facts;
extern int	nof_applied_inverted_actions;

extern int  nof_enabled_facts;

class fact
{
public:
	int pred;
	int arguments[max_arity];

	fact()
	{
		pred=0;
		int i;
		for(i=0;i<max_arity;i++)
			arguments[i]=0;
	}

	fact(int p, int arg[max_arity])
	{
		if (p<0 || p>nof_predicates)
			cout << "ERROR: Bad predicate number, " << p << ", while constructing new fact" << endl;
		pred=p;
		int i;
		for(i=0; i<predicates[p].arity;i++)
			if (arg[i]>0 && arg[i]<=nof_objects)
				arguments[i]=arg[i];
			else
			{
				arguments[i]=arg[i];
				cout << "ERROR: Bad object number, " << arg[i] << ", while constructing new fact" << endl;
			}

		while (i<max_arity)
			arguments[i++]=0;
	}


	fact(int p, int arg0=0, int arg1=0, int arg2=0, int arg3=0)
	{
		if (p<0 || p>nof_predicates)
			cout << "ERROR: Bad predicate number, " << p << ", while constructing new fact" << endl;
		pred=p;
		arguments[0]=arg0;
		arguments[1]=arg1;
		arguments[2]=arg2;
		arguments[3]=arg3;
	}

	fact(char p[], char arg0[]="", char arg1[]="", char arg2[]="", char arg3[]="")
	{
		int p0=P(p);
		if (p0==-1) 
			cout << "ERROR: Bad predicate name, " << p << ", while constructing new fact" << endl;
		pred=p0;
		if (arg0[0]>0)
			arguments[0]=Obj(arg0);
		else 
			arguments[0]=0;	
		if (arg1[0]>0)
			arguments[1]=Obj(arg1);
		else 
			arguments[1]=0;	
		if (arg2[0]>0)
			arguments[2]=Obj(arg2);
		else 
			arguments[2]=0;	
		if (arg3[0]>0)
			arguments[3]=Obj(arg3);
		else 
			arguments[3]=0;	
	}

	fact instantiate(int parameters[max_nof_parameters])
	{
		fact f;
		f.pred=pred;
		int i;
		for(i=0;i<predicates[pred].arity;i++)
			if (arguments[i]>=0)
				f.arguments[i]=arguments[i];
			else
				f.arguments[i]=parameters[-arguments[i]-1];
		for(i=predicates[pred].arity;i<max_arity;i++)
			f.arguments[i]=0;
		return f;
	}

	bool operator == (fact f2)
	{
		if (pred!=f2.pred)
			return false;
		else
		{
			int arity=predicates[pred].arity;
			int i;
			for(i=0;i<arity;i++)
				if (arguments[i]!=f2.arguments[i])
					return false;
		}
		return true;
	}

	bool instantiable(fact f2)
	{
		if (pred!=f2.pred)
			return false;
		else
		{
			int arity=predicates[pred].arity;
			int i;
			for(i=0;i<arity;i++)
				if (arguments[i]>0 && f2.arguments[i]>0 && arguments[i]!=f2.arguments[i])
					return false;
		}
		return true;
	}
	
	bool operator != (fact f2)
	{
		if (pred!=f2.pred)
			return true;
		else
		{
			int arity=predicates[pred].arity;
			int i;
			for(i=0;i<arity;i++)
				if (arguments[i]!=f2.arguments[i])
					return true;
		}
		return false;
	}
	
	fact operator = (fact f2)
	{
		pred=f2.pred;
		int i;
		for(i=0;i<max_arity;i++)
			arguments[i]=f2.arguments[i];
		return *this;
	}

	bool enabled()
	{
		int i=0;
		bool flag=true;
		while (i<predicates[pred].arity && flag)
		{
			if (objects[arguments[i]].idle->value)
				flag=false;
			else
				i++;
		}
		return flag;
	}

	friend ostream& operator << (ostream& stream, fact& f)
	{
		stream << predicates[f.pred].name;
		if (predicates[f.pred].arity>0)
		{
			stream << '(';
			int i;
			for(i=0;i<predicates[f.pred].arity-1;i++)
				if (f.arguments[i]>0)
					stream << objects[f.arguments[i]].name <<',';
				else
					stream << "V" << -f.arguments[i] <<',';
			if (i<predicates[f.pred].arity)
				if (f.arguments[i]>0)
					stream << objects[f.arguments[i]].name;
				else
					stream << "V" << -f.arguments[i];
			stream << ')';
		}	//	if (predicates[f.pred].arity>0)
		return stream;
	}
};


extern fact	constants[max_nof_constants];
extern int	nof_constants;

class linked_fact
{
public:
	fact f;
	linked_fact* next;

	linked_fact()
	{
		next=NULL;
	}

	linked_fact(fact f1)
	{
		f=f1;
		next=NULL;
	}
	
	linked_fact(fact f1, linked_fact*n)
	{
		f=f1;
		next=n;
	}
};

bool is_a_constant(fact f);	// This function checks if fact f is included in the list of constants


class criterion_consumption
{
public:
	int object_ID;
	int amount;
	criterion_consumption* next;

	criterion_consumption()
	{
		object_ID=0;
		amount=0;
		next=NULL;
	}

	criterion_consumption(int ID, int A)
	{
		object_ID=ID;
		amount=A;
		next=NULL;
	}

	criterion_consumption(int ID, int A, criterion_consumption* N)
	{
		object_ID=ID;
		amount=A;
		next=N;
	}
		
	criterion_consumption(criterion_consumption* N)
	{
		object_ID=0;
		amount=0;
		next=N;
	}
		
	criterion_consumption operator = (criterion_consumption R)
	{
		object_ID=R.object_ID;
		amount=R.amount;
		next=R.next;
		return *this;
	}
};

// This class refers to all the criteria 
// Note that the first element of the table "elements" is the 
// distance from the goal, in the heuristic computation.
class vector
{
public:
	int* elements;
	bool* mins;
	bool* maxs;

	vector()
	{
		elements=new int[nof_criteria+1];
		mins=new bool[nof_criteria+1];
		maxs=new bool[nof_criteria+1];
		int i;
		for(i=0;i<=nof_criteria;i++)
		{
			elements[i]=0;
			mins[i]=true;
			maxs[i]=true;
		}
	}

	vector(int* el)
	{
		elements=new int[nof_criteria+1];
		mins=new bool[nof_criteria+1];
		maxs=new bool[nof_criteria+1];
		int i;
		for(i=0;i<=nof_criteria;i++)
		{
			elements[i]=el[i];
			mins[i]=true;
			maxs[i]=true;
		}
	}

	void nullify()
	{
		int i;
		for(i=0;i<=nof_criteria;i++)
		{
			elements[i]=0;
		}
	}

	vector operator + (vector v)
	{
		vector result;
		int i;
		for(i=0;i<=nof_criteria;i++)
			result.elements[i]=elements[i]+v.elements[i];
		return result;
	}

	vector operator = (vector v)
	{
		int i;
		for(i=0;i<=nof_criteria;i++)
		{
			elements[i]=v.elements[i];
			mins[i]=v.mins[i];
			maxs[i]=v.maxs[i];
		}
		return *this;
	}

	bool operator == (vector* v)
	{
		bool flag;
		flag=true;
		int i=0;
		while (i<=nof_criteria && flag)
		{
			if (elements[i]!=v->elements[i])
				flag=false;
			else
				i++;
		}
		return flag;
	}


	friend ostream& operator << (ostream& stream, vector& v)
	{
		stream << "[";
		int i;
		for (i=0;i<=nof_criteria-1;i++)
			stream << v.elements[i] << "-";
		stream << v.elements[i] << "]";
		return stream;
	}
};

//void max(vector* v1, vector* v2, vector* v);
//void min(vector* v1, vector* v2, vector* v);
void sum(vector* v1, vector* v2, vector* v);
void max_min(vector* v1, vector* v2, vector* v);
void min_max(vector* v1, vector* v2, vector* v);
bool out_of_bounds(vector* v);
bool out_of_remaining_bounds(vector* v, state* s);
bool is_abs_min_equal(vector* v1, vector* v2);
bool totally_better_equal(vector* v1, vector* v2);
bool is_abs_min(vector* v1, vector* v2);
bool is_min_i(vector* v1, vector* v2, int i);
bool is_max_i(vector* v1, vector* v2, int i);

extern long length_times;
extern long length_d_estimated;

class Criterion
{
public:
	int object_ID;		// The ID of the object, in the 'objects' table, 
						// that corresponds to that criterion.
	short int type;		// 0: The criterion does not change.
						// 1: the criterion only increases (i.e. it is monotonic).
						// 2: the criterion only decreases (i.e. it is monotonic).
						// 3: The criterion both increases and decreases (i.e. it is not monotonic).
	int weight;
	int from;
	bool bounded_from;
	int to;
	bool bounded_to;
	bool max_better;
	long d_actual;
	long d_estimated;
	long times;

	Criterion()
	{
		object_ID=0;

		weight=1;
		from=0;
		to=100;
		bounded_from=false;
		bounded_to=false;
		max_better=true;
		d_actual=1;
		d_estimated=1;
		times=0;
	}
};


class Operator
{
public:
	char name[sof_operator_name+1];
	int nof_parameters;					// nof_parameters must be less than max_nof_parameters
	int sof_lists[3];
	fact strips[3][max_sof_op_lists];
	criterion_consumption* criteria;

	Operator()			// default constructor
	{
		name[0]=0;
		nof_parameters=0;
		int i;
		for(i=0;i<3;i++) sof_lists[i]=0;
		criteria=NULL;
	}

	Operator(char nm[sof_operator_name+1],int nof_param,
	int sof_l[3],fact s[3][max_sof_op_lists]) 
	{
		int i=0;		// copy name
		while (nm[i]) 
		{
			name[i]=nm[i];
			i++;
		}
		nof_parameters=nof_param;
		for(i=0;i<3;i++)
		{
			sof_lists[i]=sof_l[i];
			int j;
			for(j=0;j<sof_lists[i];j++)
				strips[i][j]=s[i][j];
		}
		criteria=NULL;
	}


	Operator operator = (Operator OP)
	{
		strcpy(name, OP.name); 
		nof_parameters=OP.nof_parameters;
		int i;
		for(i=0;i<3;i++)
			sof_lists[i]=OP.sof_lists[i];
		int j;
		for(i=0;i<3;i++)
			for(j=0;j<max_sof_op_lists;j++)
				strips[i][j]=OP.strips[i][j];

		criterion_consumption* R=OP.criteria;
		criterion_consumption* R_last=NULL;
		while (R!=NULL)
		{
			if (R_last==NULL)
			{
				criteria=new criterion_consumption(R->object_ID,R->amount, criteria);
				R_last=criteria;
			}
			else
			{
				R_last->next=new criterion_consumption(R->object_ID,R->amount, criteria);
				R_last=R_last->next;
			}
			R=R->next;
		}
		return *this;
	}



	friend ostream& operator << (ostream& stream, Operator& op)
	{
		stream << op.name << "(";			// Display name
		int i;
		for(i=1;i<op.nof_parameters;i++)
			cout << "V" << i << ", ";				// Display parameters
		stream << "V" << op.nof_parameters <<")" << endl;
		stream << "Preconditions list: ";			// Display preconditions list
		for(i=0;i<op.sof_lists[prec_list]-1;i++)
			stream << op.strips[prec_list][i] <<", ";
		if (i==op.sof_lists[prec_list]-1)
			stream << op.strips[prec_list][i];
		cout << endl;
		stream << "delete list: ";			// Display delete list
		for(i=0;i<op.sof_lists[delete_list]-1;i++)
			stream << op.strips[delete_list][i] <<", ";
		if (i==op.sof_lists[delete_list]-1)
			stream << op.strips[delete_list][i];
		cout << endl;
		stream << "Add list: ";			// Display add list
		for(i=0;i<op.sof_lists[add_list]-1;i++)
			stream << op.strips[add_list][i] <<", ";
		if (i==op.sof_lists[add_list]-1)
			stream << op.strips[add_list][i];
		cout << endl;

		stream << "Criteria: ";
		criterion_consumption* R;
		R=op.criteria;
		while (R!=NULL)
		{
			cout << "amount(";
			if (R->object_ID<0)
				cout << "V" << -R->object_ID << ", ";
			else if (R->object_ID>0)
				cout << objects[R->object_ID].name << ", ";
			else
				cout << "NULL_OBJECT, ";
			cout << R->amount;
			if (R->next!=NULL)
				cout << "), ";
			else
				cout << ")";
			R=R->next;
		}	
		cout << endl;
		return stream;
	}
};

extern Operator* Operators;
extern Operator* Inv_Operators;
extern Operator* Normal_Operators;
extern int nof_operators;

class action
{
public:
	int operator_id;
	int parameters[max_nof_parameters];
	action* next;

	action()			// default constructor
	{
		operator_id=0;
		int i;
		for(i=0;i<max_nof_parameters;i++)
			parameters[i]=0;
		next=NULL;
	}

	action(int id, int param[max_nof_parameters], action* n=NULL)		// basic constructor
	{
		operator_id=id;
		int i;
		for(i=0;i<Operators[operator_id].nof_parameters;i++)
			parameters[i]=param[i];
		for(i=Operators[operator_id].nof_parameters;i<max_nof_parameters;i++)
			parameters[i]=0;
		next=n;
	}

	action operator = (action* act)
	{
		operator_id=act->operator_id;
		int i;
		for(i=0;i<max_nof_parameters;i++)
			parameters[i]=act->parameters[i];
		next=act->next;
		return *this;
	}

	bool operator == (action* act2)
	{
		if (operator_id!=act2->operator_id)
			return false;
		else
		{
			int nof_param=Operators[operator_id].nof_parameters;
			int i;
			for(i=0;i<nof_param;i++)
				if (parameters[i]!=act2->parameters[i])
					return false;
		}
		return true;
	}
	
	friend ostream& operator << (ostream& stream, action& step)
	{
		stream << "(" << Operators[step.operator_id].name ;			// Display name
		int i;
		for(i=0;i<Operators[step.operator_id].nof_parameters;i++)
			stream << " " << objects[step.parameters[i]].name;				// Display parameters
		stream << ")";
		return stream;
	}
};


class linked_action
{
public:
	action* step;
	linked_action* next;

	linked_action()
	{
		step=NULL;
		next=NULL;
	}
};

extern action* all_actions;

void delete_linked_hash_entry_list(linked_hash_entry*);

class linked_linked_distances;
class inverted_action;


// These are the distances of an inverted action...

class inverted_distance
{
public:
	vector* v_distance;
	bool should_be_deleted;		// this flag indicates that this distance is worse
								// than another distance of this inverted action,
								// so it should be deleted. If this distance has not been applied yet,
								// it can be deleted, otherwise not...
	bool best_vector;			// This field indicates whether this vector is the
								// best vector of a fact. In order for a vector
								// to be marked as 'should_be_deleted', 
								// it must have bust_vector=false.
	bool has_been_applied;		// this flag indicates that this distance has been applied in a previous
								// application of the operator, so there is no reason to 
								// re-apply it...
	linked_hash_entry* keep;

	linked_linked_distances* prec_distances;// In this field is kept a linked list
											// of the supporting cost vectors for
											// this action's cost. This is used by
											// the XOR routines, to construct the
											// fact chains...
											// This field is currently not used...
	inverted_action* inv_action;			// This field points to the inverted_action,
											// where this inverted_distance belongs. Also 
											// this field is used by the XOR routines,
											// but only for presentation purposes (actually
								// it is not necessary to know by which action has been achieved a fact,
								// since we know the preconditions of this action.
								// Currently this field is not used...
	inverted_distance* next;

	inverted_distance()
	{
		v_distance=NULL;
		should_be_deleted=false;
		best_vector=false;
		has_been_applied=false;
		keep=NULL;
		prec_distances=NULL;
		inv_action=NULL;
		next=NULL;
	}

	inverted_distance(inverted_distance* n)
	{
		v_distance=NULL;
		should_be_deleted=false;
		best_vector=false;
		has_been_applied=false;
		keep=NULL;
		prec_distances=NULL;
		inv_action=NULL;
		next=n;
	}
};

  

// ATTENTION: IF WE WOULD LIKE TO COMPUTE NOT ALL THE DISTANCES AT ONCE, 
// BUT COMPUTE ONLY THE NECESSARY DISTANCES AT THE PREPROCESSING PHASE AND THE OTHER DISTANCES
// ON DEMAND, THEN INVERTED ACTIONS SHOULD HAVE LINKED FIELDS FOR 'DISTANCE', 'KEEP' 
// AND 'IN_AGENDA'.
// IT IS EASY TO BE DONE...

class inverted_action
{
public:
	action* step;
	linked_hash_entry* precs; // A linked list to the preconditions of the action.
	bool in_agenda;
	inverted_distance* distances;
	inverted_distance* best_distance;
	long best_value;
	vector* inverted_action_cost;
	inverted_action* next;	// all the inverted action construct a list, so it is possible
							// to delete them...

	bool applied;
	inverted_action(action* act)
	{
		step=act;
		precs=NULL;
		in_agenda=false;
		distances=NULL;
		best_distance=NULL;
		best_value=2*agenda_hash_size;
		inverted_action_cost=NULL;
		applied=false;
		next=NULL;
	}

	/*
	~inverted_action()
	{
		delete_linked_hash_entry_list(precs);
		delete_linked_hash_entry_list(keep);
	}
	*/

};



class	linked_inverted_action
{
public:
	inverted_action* inverted_step;
	linked_inverted_action* next;

	linked_inverted_action()
	{
		inverted_step=NULL;
		next=NULL;
	}

	linked_inverted_action(inverted_action* a)
	{
		inverted_step=a;
		next=NULL;
	}

	linked_inverted_action(linked_inverted_action* n)
	{
		inverted_step=NULL;
		next=n;
	}
};



bool instantiable_with_list(fact f, int sof_list, fact list_of_facts[]);


class node;
class agenda;


class hash_entry;
hash_entry* get_fact_pointer(fact*);

class state
{
public:
	int size;
	fact* facts;
	//int* criterion_vector;
	vector* state_vector;
	vector* goal_distance_estimate;

	state()
	{
		size=0;
		facts=NULL;
		if (nof_criteria>0)
			state_vector=new vector();
		else
			state_vector=NULL;
		goal_distance_estimate=NULL;
	}

	state( int sz, fact* f)
	{
		size=sz;
		facts=f;
		if (nof_criteria>0)
			state_vector=new vector();
		else
			state_vector=NULL;
		goal_distance_estimate=NULL;
	}


	void nullify()
	{
		if (size>0)
			delete facts;
		facts=NULL;
		size=0;
		if (nof_criteria>0)
		{
			int i;
			for(i=0;i<=nof_criteria;i++)
				state_vector->elements[i]=0;
		}
		goal_distance_estimate=NULL;
	}

	void add_fact(fact f)
	{
		fact* facts2;
		facts2=new fact[size+1];
		 int i;
		for(i=0;i<size;i++)
			facts2[i]=facts[i];
		facts2[size++]=f;
		delete facts;
		facts=facts2;
	}
	
	void set_criterion(int Criterion, int Amount)
	{
		if (Criterion<0 || Criterion>=nof_criteria)
		{
			cout << "ERROR: Illegal criterion ID, while calling state.set_criterion." << endl;
			abort();
		}
		state_vector->elements[Criterion]=Amount;
	}


	state operator = (state s2)
	{
		if (size>0)
			delete facts;
		size=s2.size;
		facts=new fact[s2.size];
		 int i;
		for(i=0;i<size;i++)
			facts[i]=s2.facts[i];
		if (nof_criteria>0)
		{
			for(i=0;i<=nof_criteria;i++)
			{
				state_vector->elements[i]=s2.state_vector->elements[i];
			}
		}
		goal_distance_estimate=s2.goal_distance_estimate;
		return *this;
	}

	bool operator == (state *s2)		// This operator checks if two states are equal
	{
		if (size!=s2->size)
			return false;
		else
		{
			int i=0;
			bool flag1=true;
			while (i<size && flag1)
			{
				 int j=0;
				bool flag2=false;
				while (j<size && !flag2)
				{
					if (*(facts+i)==*(s2->facts+j))
						flag2=true;
					j++;
				}
				flag1=flag2;
				i++;
			}

// We say that two states are equal, even if they do not have the same criterion vectors...
//			i=0;
//			while (i<nof_criteria && flag1)
//			{
//				if (criterion_vector[i]!=s2->criterion_vector[i])
//					flag1=false;
//				i++;
//			}

			return flag1;
		}
	}


	bool operator <= (state* s2)		// This operator checks if twe first state 
	{								// is included (sub-set) in the second state
		if (size>s2->size)
			return false;
		else
		{
			 int i=0;
			bool flag1=true;
			while (i<size && flag1)
			{
				 int j=0;
				bool flag2=false;
				while (j<s2->size && !flag2)
				{
					if (*(facts+i)==*(s2->facts+j))
						flag2=true;
					j++;
				}
				flag1=flag2;
				i++;
			}
			return flag1;
		}
	}

	bool included(fact f)		// This function checks if fact f is included in the state
	{								
		 int i;
		for(i=0;i<size;i++)
			if (facts[i]==f) return true;
		return false;
	}

	friend ostream& operator << (ostream& stream, state& s)
	{
		stream << "[";
		 int i;
		for(i=0;i<s.size;i++)
			stream << * (s.facts + i) << ", ";
		cout << "Length:" << s.state_vector->elements[0] << ", ";
		for(i=1;i<=nof_criteria;i++)
		{
			stream << objects[criteria[i-1].object_ID].name << ":" << s.state_vector->elements[i];
			if (i<nof_criteria)
				stream << ", ";
		}
		stream << "]";
		return stream;
	}

	// this function checks if an action (==ground operator) is applicable to the current state
	// WARNING: This function does not check the constants of the operator. It checks only 
	// if the preconditions are included in the state
	// WARNING2: THIS FUNCTION DOES NOT CHECK THE RESOURCES OF THE ACTION!!!
	bool applicable(action* step)
	{
		fact prec[max_sof_op_lists];
		int nof_prec=Operators[step->operator_id].sof_lists[prec_list];
		int i;
		for(i=0;i<nof_prec;i++)
		{
			fact f=Operators[step->operator_id].strips[prec_list][i].instantiate(step->parameters);
			if (!included(f))
				if (!is_a_constant(f))
					return false;
		}
		return true;
	}


void space(int j)
{
	while (j>0)
	{
		cout << "     ";
		j--;
	}
}

bool instantiate_prec(int oper_id, int j, int vars[max_nof_parameters], 
	int back_points[max_sof_op_lists], int instantiated_by[max_sof_op_lists],
	int* max_instantiated)
	{
		
		int max_inst;

		fact cur_prec=Operators[oper_id].strips[prec_list][j];	// for shortness

		int i;
//		int nof_preconditions=Operators[oper_id].sof_lists[prec_list];
		//	deallocate variables
		if (back_points[j]>-1)
		{
#if MESS1
			space(j);cout << "Backtracking: " << Operators[oper_id].strips[prec_list][j] << endl;
#endif
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

		// Reorder the two tables, so that 'order_ind' be in increasing order...

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
		fact* sfacts;
		int	nof_sfacts;
		if (constant_predicates[cur_prec.pred])
		{
			sfacts=constants;
			nof_sfacts=nof_constants;
		}
		else
		{
			sfacts=facts;
			nof_sfacts=size;
		}

		bool instantiable=false;
		
		while (i<nof_sfacts && !instantiable)
		{
			if (cur_prec.pred==sfacts[i].pred)
			{
				int k;
				bool possible=true;
				for(k=0;k<arity;k++)
				{
					if (max_inst<order_ind[k] && order_ind[k]<j) max_inst=order_ind[k];
					
					if (objects[sfacts[i].arguments[order_to_check[k]]].idle->value)
						possible=false;
					else
					{
						// if the argument is a constant
						if (cur_prec.arguments[order_to_check[k]]>0 )
						{
							if (cur_prec.arguments[order_to_check[k]] != sfacts[i].arguments[order_to_check[k]])
								possible=false;
						}
						else
						{	
							// if the argument is a variable that is already instantiated
							if (vars[-cur_prec.arguments[order_to_check[k]]-1]>0)
							{
								if (vars[-cur_prec.arguments[order_to_check[k]]-1] != sfacts[i].arguments[order_to_check[k]])
									possible=false;
							}
						}
					}
				}

				if (possible)
				{
					for(k=0;k<arity;k++)
						if(cur_prec.arguments[k]<0 && vars[-cur_prec.arguments[k]-1]==0)
						{
							vars[-cur_prec.arguments[k]-1]=sfacts[i].arguments[k];
							instantiated_by[-cur_prec.arguments[k]-1]=j;
						}

/*					bool other_instantiable=true;
					int jj=j+1;
					int nof_precs=Operators[oper_id].sof_lists[prec_list];
					while (jj<nof_precs && other_instantiable)
					{
						if (constant_predicates[Operators[oper_id].strips[prec_list][jj].pred])
							other_instantiable=instantiable_with_list(Operators[oper_id].strips[prec_list][jj].instantiate(vars),
									nof_constants, constants);
						else
							other_instantiable=instantiable_with_list(Operators[oper_id].strips[prec_list][jj].instantiate(vars),
									size, facts);
						jj++;
					}

					if (other_instantiable)
					{
*/
						instantiable=true;
						max_inst=j;
						back_points[j]=i;
/*					}
					else
					{
						possible=false;
						for(k=0;k<arity;k++)
							if(instantiated_by[k]=j)
							{
								instantiated_by[k]=-1;
								vars[k]=0;
							}
						i++;
					}
*/				}	//	if (possible)
				else
					i++;
			}	
			else	//	if (cur_prec.pred==sfacts[i].pred)
			{
				i++;
			}	//	if (cur_prec.pred==sfacts[i].pred)
		}	//	while (i<nof_sfacts && !instantiable)
		if (!instantiable)
			back_points[j]=nof_sfacts;
		*max_instantiated=max_inst;
		return instantiable;
	}

	

	action* applicable()
	{
		appl_counter++;
		action* first_action=NULL;
		action* act1_ptr=NULL;
		action* act2_ptr=NULL;
		int vars[max_nof_parameters];	// the values that take the parameters of the operator
		int back_points[max_sof_op_lists];
		int instantiated_by[max_sof_op_lists];

		int oper_id;
		for (oper_id=0;oper_id<nof_operators;oper_id++)
		{
			int j;
			//cout << Operators[oper_id] << endl;
			// initialization steps
			for (j=0;j<max_nof_parameters;j++) vars[j]=0;
			if (Operators[oper_id].nof_parameters>0)
			{
			
				for (j=0;j<max_sof_op_lists;j++) 
				{
					back_points[j]=-1;
					instantiated_by[j]=-1;
				}

				j=0;
				int max_instantiated=0;
				int nof_precs=Operators[oper_id].sof_lists[prec_list];
				int prec_0_limit;
				if (constant_predicates[Operators[oper_id].strips[prec_list][0].pred])
					prec_0_limit=nof_constants;
				else
					prec_0_limit=size;
				while (back_points[0]<prec_0_limit && max_instantiated>=0)
				{
					if (instantiate_prec(oper_id, j, vars, back_points, instantiated_by, &max_instantiated))
					{
						#if MESS1
						space(j);cout << Operators[oper_id].strips[prec_list][j] << " = ";
						cout << Operators[oper_id].strips[prec_list][j].instantiate(vars) << endl;
						#endif
						if (j<nof_precs-1)
							j++;
						else
						{
						// In this point all variables (array 'vars') must have been grounded.
						// A test could take place... (but... delay)
						bool all_dif=true;
						int nof_param=Operators[oper_id].nof_parameters;
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

						// In case where there are parameters that are identical,
						// we check if the add and the delete effects are equivalent.
						// If they are not, then the action is kept, otherwise it is rejected.
						if (!all_dif)
						{
							bool beto=false;
							int i=0;
							while (i<Operators[oper_id].sof_lists[add_list] && !beto)
							{
								fact f=Operators[oper_id].strips[add_list][i].instantiate(vars);
								hash_entry* h=get_fact_pointer(&f);
								if (h==NULL)
									beto=true;
								else
									i++;
							}

							if (!beto)
							{
								int add_id=Operators[oper_id].sof_lists[add_list]-1;
								int del_id=Operators[oper_id].sof_lists[delete_list]-1;
								if (del_id!=add_id) all_dif=true;
							
								while (add_id>=0 && !all_dif)
								{
									del_id=Operators[oper_id].sof_lists[delete_list]-1;
									fact add_fact=Operators[oper_id].strips[add_list][add_id].instantiate(vars);
									bool found=false;
									while (del_id>=0 && !found)
									{
										fact del_fact=Operators[oper_id].strips[delete_list][del_id].instantiate(vars);
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
						}
				

						// HERE A CHECK FOR ENOUGH RESOURCES IS PERFORMED.
						// THE PLACE IS THE EASIEST (FOR THE PROGRAMMER) 
						// BUT THE WORSE (FOR EFFICIENCY) TO PERFORM THIS TEST.
						// THE BEST PLACE IS TO PERFORM THE TEST CONCURRENTLY
						// WITH THE INSTANTIATION OF THE OPERATOR'S VARIABLES...
						bool criteria_enough=true;
						criterion_consumption* r;
						r=Operators[oper_id].criteria;
						while (r!=NULL && criteria_enough)
						{
							int current_criterion;
							// find current criterion...
							if (r->object_ID>0)
								current_criterion=R_ID(r->object_ID);
							else
								current_criterion=R_ID(vars[-r->object_ID-1]);

							if (r->amount>0)
							{
								if (criteria[current_criterion].bounded_to)
								{
									if (state_vector->elements[current_criterion+1]+r->amount>criteria[current_criterion].to)
										criteria_enough=false;
								}
							}
							else	// if (r->amount>0)
							{
								if (criteria[current_criterion].bounded_from)
								{
									// check for enough resources
									if (state_vector->elements[current_criterion+1]+r->amount<criteria[current_criterion].from)
										criteria_enough=false;
								}
							}
							r=r->next;
						}

						if (all_dif && criteria_enough)
						{
							#if MESS1
							cout << "Success" << endl;
							#endif
							act1_ptr=act2_ptr;
							act2_ptr=new action(oper_id, vars);
							#if MESS1
							cout << *act2_ptr<< endl;
							#endif
							if (act1_ptr==NULL)
								first_action=act2_ptr;
							else
								act1_ptr->next=act2_ptr;
						}
						}
					}
					else
					{
						#if MESS1
						cout << "Fail:" << Operators[oper_id].strips[prec_list][j].instantiate(vars) << endl;
						#endif
						if (max_instantiated>=0)
						{
							if (j>0)
								back_points[j]=-1;
							int i1;
							for(i1=j-1;i1>max_instantiated;i1--)
							{
								back_points[i1]=-1;
								#if MESS1
								cout << "Deallocate: " << Operators[oper_id].strips[prec_list][i1] << endl;							
								#endif
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
				}	//	while (back_points[0]<max_inst[0] && max_instantiated>=0)
			}	
			else	//	if (Operators[oper_id].nof_parameters>0)
			{
				bool satisfied=true;
				int prec_no=0;
				while (satisfied && prec_no<Operators[oper_id].sof_lists[prec_list])
				{	
					int counter;
					satisfied=false;
					counter=0;
					while (!satisfied && counter<size)
					{
						if (Operators[oper_id].strips[prec_list][prec_no]==facts[counter])
							satisfied=true;
						else
							counter++;
					}
					prec_no++;
				}


				bool criteria_enough=true;
				criterion_consumption* r;
				r=Operators[oper_id].criteria;
				while (r!=NULL && criteria_enough)
				{
					if (r->amount>0)
					{
						if (r->object_ID>0)
						{
							if (state_vector->elements[R_ID(r->object_ID)+1]<r->amount)
								criteria_enough=false;
						}	
						else 
						{
							cout << "ERROR 38474384024820420" << endl;
							abort();
						}
					}		
					r=r->next;
				}
				
				if (satisfied & criteria_enough)
				{
					act1_ptr=act2_ptr;
					act2_ptr=new action(oper_id, vars);
					if (act1_ptr==NULL)
						first_action=act2_ptr;
					else
						act1_ptr->next=act2_ptr;
				}	// if satisfied
			}	// (Operators[oper_id].nof_parameters>0)
		}	//	for (oper_id=0;oper_id<nof_operators;oper_id++)
		return first_action;
	}

	state* next_state(action* step)
	{
		int new_size=size
				- Operators[step->operator_id].sof_lists[delete_list]
				+ Operators[step->operator_id].sof_lists[add_list];
		
		fact* new_facts=new fact[new_size];
		int k=0;
		 int i;
 		for(i=0;i<size;i++)
		{
			bool flag=true;
			int j=0;
			while (j<Operators[step->operator_id].sof_lists[delete_list]
					&& flag)
				if (facts[i]==Operators[step->operator_id].strips[delete_list][j].instantiate(step->parameters))
					flag=false;
				else
					j++;
			if (flag)
			{
				new_facts[k++]=facts[i];
//				cout << new_facts[k-1] << endl;
			}
			else
			{
//				cout << "Fact Removed: " << facts[i] << endl;
//				cout << endl;
			}
		}
		int j;
		for(j=0;j<Operators[step->operator_id].sof_lists[add_list];j++)
		{
			new_facts[k++]=Operators[step->operator_id].strips[add_list][j].instantiate(step->parameters);
//			cout << new_facts[k-1] << endl;
		}
		state* new_s=new state(k, new_facts);

		for(i=0;i<=nof_criteria;i++)
			new_s->state_vector->elements[i]=state_vector->elements[i];

		new_s->state_vector->elements[0]+=1;
		criterion_consumption* r;
		r=Operators[step->operator_id].criteria;
		while (r!=NULL)
		{
			if (r->object_ID>0)
				new_s->state_vector->elements[R_ID(r->object_ID)+1] += r->amount;
			else
				new_s->state_vector->elements[R_ID(step->parameters[-r->object_ID-1])+1] +=r->amount;
			r=r->next;
		}
		new_s->goal_distance_estimate=NULL;
		return new_s;
	}
};


class node
{
public:
	state* s;
	action step;
	long score;
	linked_linked_distances* end_facts;
	node* previous;


	node()
	{
		s=NULL;
		score=agenda_hash_size+1;
		previous=NULL;
	}

	node(state* s1, action st, node* prev)
	{
		s=s1;
		step=st;
		score=agenda_hash_size+1;
		previous=prev;
	};

	node operator = (node n)
	{
		s=n.s;
		step=n.step;
		score=agenda_hash_size+1;
		previous=n.previous;
		return *this;
	}
	
	void display_plan()
	{
		int steps=0;
		node* nd=previous;
		cout << "Plan:" << endl;
		cout << step << endl;
		steps++;
		while (nd!=NULL)
		{
			cout << nd->step << endl;
			steps++;
			nd=nd->previous;
		}
		cout << "Total steps: " << steps << endl;
	}

	action* get_plan()
	{
		action* plan;		
		plan=new action(step.operator_id, step.parameters, NULL);
		node* nd=previous;
		while (nd->previous!=NULL)
		{
			plan=new action(nd->step.operator_id, nd->step.parameters, plan);
			nd=nd->previous;
		}
		return plan;
	}

	int length()
	{
		int steps=0;
		node* nd=previous;
		steps++;
		while (nd!=NULL)
		{
			steps++;
			nd=nd->previous;
		}
		return steps;
	}
};

class agenda
{
public:
	node* nd;
	long score;
	int depth;
	agenda* next;

	agenda()
	{
		nd=NULL;
		score=NULL;
		depth=0;
		next=NULL;
	}

	agenda(node* n1, long v)
	{
		nd=n1;
		score=v;
		depth=0;
		next=NULL;
	}
};


class state_hash_entry
{
public:
	node* state_node;
	state_hash_entry* next;

	state_hash_entry()
	{
		state_node=NULL;
		next=NULL;
	}

	state_hash_entry(node* nd, state_hash_entry* n)
	{
		state_node=nd;
		next=n;
	}
};



class pointer
{
public:
	void* forward;
	void* back;
	int depth;
	int width;

	pointer() // default constructor
	{
		depth=0;
		width=0;
		forward=NULL;
		back=NULL;
	}

	pointer(void* p)
	{
		depth=0;
		width=0;
		forward=p;
		back=NULL;
	}

	friend ostream& operator << (ostream& stream, pointer& p)
	{
		fact f;
		int i;
		pointer* tp=&p;
		while (tp->back!=NULL)
		{
			f.arguments[tp->depth]=tp->width;
			tp=(pointer*)tp->back;
		}

		f.pred=tp->width;
		i=p.depth+1;
		while(i<predicates[f.pred].arity)
		{
			f.arguments[i]=-i-1;
			i++;
		}
		while (i<max_arity)
		{
			f.arguments[i]=0;
			i++;
		}
		stream << f;
		return stream;
	}


};


class complete_state_action;
class linked_complete_state_action;

extern pointer* hash_table;


// This class corresponds to all the distances, related facts and achieving actions
// of a fact for a specific sub-problem.
class linked_distances
{
public:
	vector* v_distance;
	bool best_vector;				// This field indicates whether this vector is the
									// best vector of a fact. In order for a vector
									// to be marked as 'should_be_deleted', 
									// it must have bust_vector=false.
	bool should_be_deleted;
	linked_hash_entry* related;		// The lists of related facts for this distance...
	inverted_action* achieved_by;	// The inverted action that achieved the fact with this distance...
	inverted_distance* achieved_by_distance;	// This field points to the exactly cost vector
								// of the action that achieved that fact. In the pointed object
								// there are pointers to the preconditions' cost vectors 
								// that produced this specific distance...
								// This field is currently not used...
	hash_entry* h;				// This field points to the hash_entry, where this distance belongs.
								// This field will be used to transform chains of cost vectors to 
								// chains of facts, while applying XOR routines...
								// Currently this field is not used...
	linked_distances* next;

	linked_distances()
	{
		v_distance=NULL;
		best_vector=false;
		should_be_deleted=false;
		related=NULL;
		h=NULL;
		next=NULL;
	}

	linked_distances(linked_distances* n)
	{
		v_distance=NULL;
		best_vector=false;
		should_be_deleted=false;
		related=NULL;
		h=NULL;
		next=n;
	}
	// ATTENTION: A destructor is needed here, in order to delete the linked lists 
	// of other objects that are pointed by this object.
};

// This class corresponds to the sets of distances, related facts and achieving actions
// of the several sub-problems
// This class is also used to link several cost vectors from different facts,
// in the Grt.cpp routines...
class linked_linked_distances
{
public:
	
	linked_distances* distances;		// This is a linked-list of the distances of 
										// a specific fact for a specific sub-problem.
	linked_distances* best_distance;	// This is the best of the distances of 
										// a specific fact for a specific sub-problem.
	long best_value;					// This is the evaluation value of the best distance.
	linked_linked_distances* next;

	linked_linked_distances()
	{
		distances=NULL;
		best_distance=NULL;
		best_value=2*agenda_hash_size;
		next=NULL;
	}

	linked_linked_distances(linked_linked_distances* n)
	{
		distances=NULL;
		best_distance=NULL;
		best_value=2*agenda_hash_size;
		next=n;
	}

	linked_linked_distances(linked_distances* d)
	{
		distances=d;
		best_distance=NULL;
		best_value=2*agenda_hash_size;
		next=NULL;
	}

	linked_linked_distances(linked_distances* d, linked_linked_distances* n)
	{
		distances=d;
		best_distance=NULL;
		best_value=2*agenda_hash_size;
		next=n;
	}
};


class linked_linked_hash_entry
{
public:
	linked_hash_entry* related;
	linked_linked_hash_entry* next;

	linked_linked_hash_entry()
	{
		related=NULL;
		next=NULL;
	}

	linked_linked_hash_entry(linked_linked_hash_entry* n)
	{
		related=NULL;
		next=n;
	}
};


class hash_entry
{
public:
	fact f;							// The fact.
	linked_linked_distances* subproblem_distances;		// The distances, related facts and the actios that achieved
										// that fact, for the various sub-problems...
	
	linked_inverted_action* inv_op_prec;	// The inverted actions that have this fact as precondition...
	
	complete_state_action* forward_achieved_by;
	
	bool achieved;	// used by the 'Complete_state' module, in order
					// to indicate whether a fact has been achieved or not
	vector* init_vector;	// This field keeps the criteria needed for achieving the fact from
							// the initial state. The criteria are computed in an admissible manner,
							// i.e. we use "max" function to compute the cost for applying an normal action
							// and "min" function for the criterion vectors of the several ways of 
							// achieving the fact...
	linked_hash_entry* mutexes;
	linked_complete_state_action* normal_actions;	// pointers to the normal actions that have
													// this fact as a precondition.
	linked_complete_state_action* normal_actions_add; // pointers to the normal actions that
						// have thisfact as an add effect...
	
	// !!! IT WOULD NOT BE IMPORTANT (AT LEAST INITIALLY) TO KEEP THE INFORMATION 
	// OF ENRICHED AND USED FACTS FOR ALL THE SUBPROBLEMS. THIS IS BECAUSE THIS INFORMATION
	// IS USED AT THE MAIN PROBLEM, BEFORE TRYING TO SOLVE ANY SUBPROBLEM, 
	// SO IT WOULD BE ENOUGH SIMPLY FALS-0FY THESE TWO FIELDS BEFORE COPING WITH
	// THE SUBPROBLEM.
	// HOWEVER, IN THE FUTURE AND IF GRT DOES NOT COMPUTE INITIALLY ALL THE DISTANCES
	// BUT ONLY THOSE THAT ARE NEEDED, THIS INFORMATION MAY COULD BE IMPORTANT TO RETAIN...
	linked_bool* linked_enriched;		// Indicates whether the fact is part of the enriched goal state.
	linked_bool* linked_used;			// Indicates whether the fact of the enriched goal state has been used.

	bool enriched_init;			// The fact is member of the enriched initial state (AIPS-2000...)
	bool enriched_init_used;	// The fact of the enriched initial state has been used... (for what? see 'New_comple_states.cpp')
	bool new_fact;

	bool goal_fact_used;	// this field indicates whether a goal fact has already
							// supported the usage of an enriched goal fact...

	bool dynamic;	// Indicates whether fact's predicate is static or dynamic...
	pointer* back;

	hash_entry(fact* f1)
	{
		f=*f1;
		subproblem_distances=NULL;
		//linked_achieved_by=NULL;
		inv_op_prec=NULL;
		normal_actions=NULL;
		normal_actions_add=NULL;
		//linked_related=NULL;
		achieved=false;
		init_vector=NULL;
		mutexes=NULL;
		linked_enriched=NULL;
		linked_used=NULL;
		enriched_init=false;
		enriched_init_used=false;
		new_fact=false;
		goal_fact_used=false;
		forward_achieved_by=NULL;
		dynamic=true;
		back=NULL;
	}
};


class	linked_hash_entry
{
public:
	hash_entry* entry;
	linked_hash_entry* next;

	linked_hash_entry()
	{
		entry=NULL;
		next=NULL;
	}

	linked_hash_entry(hash_entry* h)
	{
		entry=h;
		next=NULL;
	}

	linked_hash_entry(hash_entry* h, linked_hash_entry* n)
	{
		entry=h;
		next=n;
	}

};


//class hash_entry;
//class linked_hash_entry;
hash_entry* get_fact_pointer(fact*);


class complete_state_action
{
public:
	action* step;		// the action
	linked_hash_entry* precs;	// a linked list of pointers to the precondition facts in the hash table
	linked_hash_entry* del;		// a linked list of pointers to the delete list facts in the hash table
	linked_hash_entry* add;		// a linked list of pointers to the add list facts in the hash table
	linked_hash_entry* non_deleted_precs;	// a linked list of pointers to the non_deleted preconditions in the hash table
//	int unsatisfied_precs;
//	int remaining_mutexes;
	bool satisfied_prec;	// flag that indicates whether the preconditions have all been achieved or not
	bool no_mutex;			// flag that indicates whether the already achieved preconditions are not mutex to each other
	bool already_in_agenda;	// flag that indicates whether the action is already in agenda or not
	complete_state_action* next; // pointer to the next action
	bool first_application;		// indicates whether it is about the first application of the action or not.
	vector* action_cost;			// The cost for applying the action (without the preconditions' cost...
	vector* total_cost;
	bool has_dynamic_precs;
	
	complete_state_action(action* act)
	{
		int oper_id=act->operator_id;
		int* vars=act->parameters;
		step=act;
		satisfied_prec=false;
		no_mutex=false;
		next=NULL;

		action_cost=NULL;
		total_cost=NULL;
//		unsatisfied_precs=0;
//		remaining_mutexes=-1;
		precs=NULL;
		del=NULL;
		add=NULL;
		non_deleted_precs=NULL;
		first_application=true;
		already_in_agenda=false;
		has_dynamic_precs=false;

		int i;
		// creating the 'del' list
		for(i=0;i<Operators[oper_id].sof_lists[delete_list];i++)
		{
			if (!constant_predicates[Operators[oper_id].strips[delete_list][i].pred])
			{
				hash_entry* ptr;
				ptr=get_fact_pointer(&Operators[oper_id].strips[delete_list][i].instantiate(vars));
				del=new linked_hash_entry(ptr, del);
			}
		}
		// creating the 'add' list
		for(i=0;i<Operators[oper_id].sof_lists[add_list];i++)
		{
			if (!constant_predicates[Operators[oper_id].strips[add_list][i].pred])
			{
				hash_entry* ptr;
				ptr=get_fact_pointer(&Operators[oper_id].strips[add_list][i].instantiate(vars));
				add=new linked_hash_entry(ptr, add);
			}
		}
		// creating the 'prec' and the 'non_deleted_precs' lists
		for(i=0;i<Operators[oper_id].sof_lists[prec_list];i++)
		{
			if (!constant_predicates[Operators[oper_id].strips[prec_list][i].pred])
			{
				has_dynamic_precs=true;
//				unsatisfied_precs++;
				hash_entry* ptr;
				ptr=get_fact_pointer(&Operators[oper_id].strips[prec_list][i].instantiate(vars));
				precs=new linked_hash_entry(ptr, precs);
				
				bool flag=true;
				linked_hash_entry* temp_del=del;
				while (flag && temp_del!=NULL)
				{
					if (temp_del->entry->f==ptr->f)
						flag=false;
					else
						temp_del=temp_del->next;
				}
				if (flag)
					non_deleted_precs=new linked_hash_entry(ptr, non_deleted_precs);
			}
		}
		
	}
};

  

class linked_complete_state_action
{
public:
	complete_state_action* step;
	linked_complete_state_action* next;

	linked_complete_state_action()
	{
		step=NULL;
		next=NULL;
	}

	linked_complete_state_action(complete_state_action* a)
	{
		step=a;
		next=NULL;
	}

	linked_complete_state_action(complete_state_action* a, linked_complete_state_action* n)
	{
		step=a;
		next=n;
	}
};


extern complete_state_action* normal_actions_head;
extern complete_state_action* normal_actions_tail;
extern linked_complete_state_action* c_agenda_head;
extern linked_complete_state_action* c_agenda_tail;

// Class constraint groups a set of facts (general definitions), 
// that hold simoultaneously in a given state. 
// However. usually this structure contains a single fact.
class constraint
{
public:
	linked_fact* ands;
	constraint* next;

	constraint()
	{
		ands=NULL;
		next=NULL;
	}

	constraint(constraint* n)
	{
		ands=NULL;
		next=n;
	}
/*
	constraint(fact f)
	{
		ands=new linked_fact(f);
		next=NULL;
	}
*/
};


// This class contains general definitions of sets of facts (of the class 'constraint'),
// where only the facts of one set can hold in a given state.
class constraints
{
public:
	constraint* xor;
	linked_fact* constants;
	int nof_parameters;
	constraints* next;

	constraints()
	{
		xor=NULL;
		constants=NULL;
		nof_parameters=0;
		next=NULL;
	}
	
	constraints(constraints* n)
	{
		xor=NULL;
		constants=NULL;
		nof_parameters=0;
		next=n;
	}

	friend ostream& operator << (ostream& stream, constraints& t_xors)
	{
		stream << "XOR Relation - Facts: ";
		constraint* t_xor=t_xors.xor;
		while (t_xor!=NULL)
		{
			stream << t_xor->ands->f << ", ";
			t_xor=t_xor->next;
		}	// while (t_xor!=NULL)
		stream << "   Constants: ";
		
		linked_fact* xor_constants=t_xors.constants;
		while (xor_constants!=NULL)
		{
			stream << xor_constants->f << ", ";
			xor_constants=xor_constants->next;
		}	// while (xor_constants!=NULL)
		return stream;
	}
};


// This class is the instantiation of a 'constraints' object,
// having given values to the variables of the 'constraints' object.
class ground_constraint
{
public:
	constraints* xors;
	int parameters[max_nof_parameters];

	ground_constraint()
	{
		xors=NULL;
		int i;
		for(i=0;i<max_nof_parameters;i++)
			parameters[i]=0;
	}

	ground_constraint(constraints* x)
	{
		xors=x;
		int i;
		for(i=0;i<max_nof_parameters;i++)
			parameters[i]=0;
	}

	ground_constraint operator = (ground_constraint xors2)
	{
		xors=xors2.xors;
		int i;
		for (i=0;i<max_nof_parameters;i++)
			parameters[i]=xors2.parameters[i];
		return *this;
	}

	bool operator == (ground_constraint xors2)
	{
		if (xors==NULL || xors2.xors==NULL)
			return false;
		if (xors!=xors2.xors)
			return false;
		else
		{
			int i;
			for(i=0;i<xors->nof_parameters;i++)
				if (parameters[i]!=xors2.parameters[i])
					return false;
		}
		return true;
	}

	bool operator != (ground_constraint xors2)
	{
		if (xors==NULL || xors2.xors==NULL) 
			return true;
		if (xors!=xors2.xors)
			return true;
		else
		{
			int i;
			for(i=0;i<xors->nof_parameters;i++)
				if (parameters[i]!=xors2.parameters[i])
					return true;
		}
		return false;
	}

	friend ostream& operator << (ostream& stream, ground_constraint& ground_xors)
	{
		stream << "Ground XOR Relation - Facts: ";
		constraint* t_xor=ground_xors.xors->xor;
		fact f;
		while (t_xor!=NULL)
		{
			f=t_xor->ands->f.instantiate(ground_xors.parameters) ;
			stream << f << ", ";
			t_xor=t_xor->next;
		}	// while (t_xor!=NULL)
		stream << "   Constants: ";
		
		linked_fact* xor_constants=ground_xors.xors->constants;
		while (xor_constants!=NULL)
		{
			f=xor_constants->f.instantiate(ground_xors.parameters);
			stream <<  f << ", ";
			xor_constants=xor_constants->next;
		}	// while (xor_constants!=NULL)
		return stream;
	}
};

// This class can hold all the ground constraints of a specific problem instance.
class linked_ground_constraints
{
public:
	ground_constraint* ground_xor;
	linked_ground_constraints* next;

	linked_ground_constraints(ground_constraint* g_xor)
	{
		ground_xor=g_xor;
		next=NULL;
	}

	linked_ground_constraints(ground_constraint* g_xor, linked_ground_constraints* n)
	{
		ground_xor=g_xor;
		next=n;
	}
};

// This structure is used to keep the pairs of facts, one from the 
// initial state and one from the goals, that are XOR-constrained.
class pairs_of_facts
{
public:
	ground_constraint ground_xor;
	hash_entry* initial;
	hash_entry* goal;
	linked_hash_entry* sequence;
	pairs_of_facts* next;

	pairs_of_facts()
	{
		initial=NULL;
		goal=NULL;
		sequence=NULL;
		next=NULL;

	}

	pairs_of_facts(pairs_of_facts* pairs)
	{
		initial=NULL;
		goal=NULL;
		sequence=NULL;
		next=pairs;
	}
};


// This class keeps the facts that are subgoals,
// i.e. the facts that will be used to construct the intermediate states, 
// together with all relative and needed information for each fact.
class subgoal
{
public:
	hash_entry* h;						// The fact that is a subgoal
	ground_constraint xor_relation;		// The ground XOR-relation, by which the fact 
										// has been marked as a subgoal;
	int position;						// The position of the action that inserted the fact.
	int subgoal_type;					// If subgoal_type==0 then the fact is in the initial state.
										// If subgoal_type==1 then the fact is a precondition of an action 
										//		of another XOR-sequence. 
										// If subgoal_type==2 then the fact is an add_effect of an action
										//		of the same XOR-sequence.
										// If subgoal_type==3 then the fact is a goal fact of its own XOR-sequence.
	ground_constraint foreign_xor_relation;	// This field is used only by the subgoals of type 1.
	int level;	// The level (i.e. the substate) at which the subgoal is located...
				// Level 0 is the initial state.
										

	subgoal()
	{
		h=NULL;
		xor_relation.xors=NULL;
		position=-1;
		subgoal_type=-1;
		foreign_xor_relation.xors=NULL;
		level=-1;
	}

	subgoal(hash_entry* hf)
	{
		h=hf;
		xor_relation.xors=NULL;
		position=-1;
		subgoal_type=-1;
		foreign_xor_relation.xors=NULL;
		level=-1;
	}
};

// This class is used to keep in a linked list all the subgoals of a problem...
class linked_subgoals
{
public:
	subgoal* subgoalPtr;
	linked_subgoals* next;

	linked_subgoals()
	{
		subgoalPtr=NULL;
		next=NULL;
	}

	linked_subgoals(hash_entry* h)
	{
		subgoalPtr=new subgoal(h);
		next=NULL;
	}

	linked_subgoals(subgoal* sub)
	{
		subgoalPtr=sub;
		next=NULL;
	}
};

// This structure is used to keep the goal states of the subproblems
// that have to be solved (after the problem decomposition based on
// the XOR relations).
class linked_states
{
public:
	state* s;
	int id;
	linked_states* next;

	linked_states()
	{
		s=NULL;
		id=-1;
		next=NULL;
	}
};


extern constraints* xors;
void xor_routines(state*);

class level
{
public:
	int l;
	level* next;

	level()
	{
		l=-1;
		next=NULL;
	}

	level(level* n)
	{
		l=-1;
		next=n;
	}

	level(int l1, level* n)
	{
		l=l1;
		next=n;
	}
};

extern level* subproblem_level;


// FUNCTION PROTOTYPES: test_routines.cpp
void display_objects();	
void display_criteria();
void display_predicates();
void display_operators();
void display_constants();
void display_constant_predicates();
void display_agenda(agenda*);
void display_hash_table();
void print_linked_actions(action* act);
void display_xor_relations();
void display_pairs(pairs_of_facts*);
void display_sequences(pairs_of_facts*);
void display_subgoals(linked_subgoals*);
void print_leveled_subgoals(int, linked_subgoals*);
void print_subproblems(linked_states* subproblems);
void display_fact_distances(hash_entry* h);
void display_entry(hash_entry* h);
void display_normal_actions();
void display_entry_related(hash_entry* h);
void display_calibration_values();
	
// FUNCTION PROTOTYPES: parser.cpp
bool load_domain();
bool load_problem();
void copy_operators();

// FUNCTION PROTOTYPES: auxiliary_functions.cpp
bool strcmp2(char s1[], char s2[]);
bool process_command_line(int argc, char* argv[]);
void check_time();
void for_every_hash_entry(void f(hash_entry*));
long vector_grade(vector* v, int flag, int excluded_criterion, state* s, bool single_fact);


// FUNCTION PROTOTYPES: GRT.CPP
void create_inverted_operators();
void create_inverted_actions();
void find_all_distances(linked_hash_entry*);
void add_goals(state*);
void display_inverted_satisfied();
vector* find_grade(linked_linked_distances* linked_facts, linked_linked_distances** original_reduced_end_facts);
hash_entry* get_fact_pointer(fact* f);
bool included_in_fact_list(fact f, linked_fact* linked_list);
void delete_linked_hash_entry_list(linked_hash_entry*);
void assign_inverted_actions_costs();

// FUNCTION PROTOTYPES: XOR.CPP
void add_GRG_level(hash_entry*);
void delete_GRG_level(hash_entry*);
void detect_idle_objects();
void add_idle_level();
void delete_idle_level();
void display_current_subproblem_level();
bool idle_object(int obj, state* s);

// FUNCTION PROTOTYPES: COMPLETE_STATES.CPP
void compute_mutexes();
void complete_goals(linked_hash_entry**);

// FUNCTION PROTOTYPES: PLANNER.CPP
void solve_subproblems(state*);

// FUNCTION PROTOTYPES: CREATE_ACTIONS
void insert_fact_to_hash_table(fact* f);

int get_time();

void search_routines(state*);

void test_movie1();

