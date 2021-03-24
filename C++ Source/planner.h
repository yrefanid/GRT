 # include <iostream.h>
# include <string.h>
# include <time.h>
# include <sys/timeb.h>
# include <fstream.h>
# include <stdlib.h>
# include <malloc.h>

#define MESS1 0

#define MAX_TIME 30 // minutes

#define	max_arity 8
#define sof_predicate_name 40	// Hereafter, sof_... means "size_of..."
#define max_nof_predicates 30		// Hereafter, max... means max value of some parameter...
#define sof_object_name 30
#define	max_nof_objects 1000
#define max_nof_operators0 20
#define max_nof_operators 2000
#define max_nof_parameters 8
#define prec_list 0
#define delete_list 1
#define add_list 2
#define max_sof_op_lists 10
#define sof_operator_name 50
#define X -1
#define Y -2
#define Z -3
#define max_nof_constants 2000
#define agenda_hash_size 10000
#define max_file_name 500
#define max_sof_words 200

// FUNCTION PROTOTYPES: memory_manager
class fact;
class action;
class linked_hash_entry;
class node;
class state;

void mem_init();
fact* new_fact(fact);
void delete_fact(fact*);
linked_hash_entry* new_linked_hash_entry(linked_hash_entry);
void delete_linked_hash_entry(linked_hash_entry*);
extern action* new_action(action);
extern void delete_action(action*);
extern node* new_node(node);
extern void delete_node(node*);
extern state* new_state(state);
extern void delete_state(state*);

extern bool reduced_enriched;

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

class state;
extern state initial;
extern state goal;
extern state goal1;

extern char problem_name[max_sof_words+1];

extern bool display_messages;

struct	predicate
{
	int arity;
	char name[sof_predicate_name+1];
};

extern int nof_predicates;
extern predicate predicates[max_nof_predicates];
extern bool	constant_predicates[max_nof_predicates];
extern int nof_objects;
extern char	objects[max_nof_objects][sof_object_name+1];

int O(char name[]);
int P(char name[]);


extern int	nof_facts;
extern int	nof_inverted_actions;
extern int	nof_set_facts;
extern int	nof_applied_inverted_actions;


class	fact
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
			arguments[0]=O(arg0);
		else 
			arguments[0]=0;	
		if (arg1[0]>0)
			arguments[1]=O(arg1);
		else 
			arguments[1]=0;	
		if (arg2[0]>0)
			arguments[2]=O(arg2);
		else 
			arguments[2]=0;	
		if (arg3[0]>0)
			arguments[3]=O(arg3);
		else 
			arguments[3]=0;	
	}

	fact instantiate(int parameters[max_nof_parameters])
	{
		fact f;
		f.pred=pred;
		int i;
		for(i=0;i<predicates[pred].arity;i++)
			if (arguments[i]>0)
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

	friend ostream& operator << (ostream& stream, fact& f)
	{
		stream << predicates[f.pred].name;
		if (predicates[f.pred].arity>0)
		{
			stream << '(';
			int i;
			for(i=0;i<predicates[f.pred].arity-1;i++)
				if (f.arguments[i]>0)
					stream << objects[f.arguments[i]] <<',';
				else
					stream << "V" << -f.arguments[i] <<',';
			if (i<predicates[f.pred].arity)
				if (f.arguments[i]>0)
					stream << objects[f.arguments[i]];
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

class	Operator
{
public:
	char name[sof_operator_name+1];
	int nof_parameters;					// nof_parameters must be less than max_nof_parameters
	int sof_lists[3];
	fact strips[3][max_sof_op_lists];

	Operator()			// default constructor
	{
		name[0]=0;
		nof_parameters=0;
		int i;
		for(i=0;i<3;i++) sof_lists[i]=0;
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
		stream << op.strips[prec_list][i] <<endl;
		stream << "delete list: ";			// Display delete list
		for(i=0;i<op.sof_lists[delete_list]-1;i++)
			stream << op.strips[delete_list][i] <<", ";
		stream << op.strips[delete_list][i] <<endl;
		stream << "Add list: ";			// Display add list
		for(i=0;i<op.sof_lists[add_list]-1;i++)
			stream << op.strips[add_list][i] <<", ";
		stream << op.strips[add_list][i] <<endl;
		return stream;
	}


};

extern Operator* Operators;
extern Operator* Operators0;
extern Operator* Inv_Operators;
extern Operator* Normal_Operators;
extern int nof_operators;
extern int nof_operators0;

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

	action operator = (action act)
	{
		operator_id=act.operator_id;
		int i;
		for(i=0;i<max_nof_parameters;i++)
			parameters[i]=act.parameters[i];
		next=act.next;
		return *this;
	}

	bool operator == (action act2)
	{
		if (operator_id!=act2.operator_id)
			return false;
		else
		{
			int nof_param=Operators[operator_id].nof_parameters;
			int i;
			for(i=0;i<nof_param;i++)
				if (parameters[i]!=act2.parameters[i])
					return false;
		}
		return true;
	}
	
	friend ostream& operator << (ostream& stream, action& step)
	{
		stream << "(" << Operators[step.operator_id].name ;			// Display name
		int i;
		for(i=0;i<Operators[step.operator_id].nof_parameters;i++)
			stream << " " << objects[step.parameters[i]];				// Display parameters
		stream << ")";
		return stream;
	}
};


class	inverted_action
{
public:
	action step;
	linked_hash_entry* precs; // A linked list to the preconditions of the action.
	bool in_agenda;
	int score;
	linked_hash_entry* keep;
	inverted_action* next;	// all the inverted action construct a list, so it is possible
							// to delete them...

	inverted_action(action act)
	{
		step=act;
		precs=NULL;
		in_agenda=false;
		score=-1;
		keep=NULL;
		next=NULL;
	}
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
};



bool instantiable_with_list(fact f, int sof_list, fact list_of_facts[]);


class	node;
class	agenda;

class	state
{
public:
	int size;
	fact* facts;

	state()
	{
		size=0;
		facts=NULL;
	}

	state( int sz, fact* f)
	{
		size=sz;
		facts=f;
	}

	void nullify()
	{
		if (size>0)
			delete facts;
		facts=NULL;
		size=0;
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

	state operator = (state s2)
	{
		if (size>0)
			delete facts;
		size=s2.size;
		facts=new fact[s2.size];
		 int i;
		for(i=0;i<size;i++)
			facts[i]=s2.facts[i];
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
		for(i=0;i<s.size-1;i++)
			stream << * (s.facts + i) << ", ";
		if (i<s.size)
			stream << * (s.facts + i);
		stream << "]";
		return stream;
	}

	// this function checks if an action (==ground operator) is applicable to the current state
	// WARNING: This function does not check the constants of the operator. It checks only 
	// if the preconditions are included in the state
	bool applicable(action step)
	{
		fact prec[max_sof_op_lists];
		int nof_prec=Operators[step.operator_id].sof_lists[prec_list];
		int i;
		for(i=0;i<nof_prec;i++)
		{
			fact f=Operators[step.operator_id].strips[prec_list][i].instantiate(step.parameters);
			if (!included(f))
				if (!is_a_constant(f))
					return false;
		}
		return true;
	}


	// this function checks if all the integers, between vars[0] and vars[j], are distinct
	inline bool all_different(int j, int vars[max_nof_parameters])
	{
		int i;
		for(i=0;i<j;i++)
		{
			int k;
			for(k=i+1;k<=j;k++)
				if (vars[i]==vars[k])
					return false;
		}
		return true;
	}


	inline bool check_preconditions(int j, int vars[max_nof_parameters], int oper_id)
	{
		int i;
		for(i=0;i<Operators[oper_id].sof_lists[prec_list];i++)
		{
			bool relative=false;
			fact prec=Operators[oper_id].strips[prec_list][i];
			int k;
			for(k=0;k<predicates[prec.pred].arity;k++)
			{
				if (prec.arguments[k]==-j-1) relative=true;
				if (prec.arguments[k]<0 && prec.arguments[k]>=-j-1)
					prec.arguments[k]=vars[-prec.arguments[k]-1];
			}
			if (relative && !instantiable_with_list(prec, size, facts)
					&& !instantiable_with_list(prec, nof_constants, constants))
				return false;
		}
		return true;
	}


	inline void next_value(int j, int vars[max_nof_parameters], int oper_id)
	{
		bool found=false;
		while (vars[j]<=nof_objects && !found)
		{
			vars[j]++;
			if (all_different(j, vars))
					if (check_preconditions(j,vars, oper_id))
						found=true;
		}
	}

	action* applicable()
	{
		action* first_action=NULL;
		action* act1_ptr=NULL;
		action* act2_ptr=NULL;
		int vars[max_nof_parameters];	// the values that take the parameters of the operator
		int oper_id;
		for(oper_id=0;oper_id<nof_operators;oper_id++)	// oper_id: the operator position
		{													// in table Operators
			int j;
			for(j=0;j<max_nof_parameters;j++) vars[j]=0;
			if (Operators[oper_id].nof_parameters>0)
			{
				j=0;
				while (j>=0)
				{
					next_value(j, vars, oper_id);
					if (vars[j]<=nof_objects)
					{
						j++;
						if (j==Operators[oper_id].nof_parameters)
						{
							j--;
							act1_ptr=act2_ptr;
							act2_ptr=new_action(action(oper_id, vars));
							if (act1_ptr==NULL)
								first_action=act2_ptr;
							else
								act1_ptr->next=act2_ptr;
						}
					}
					else
					{
						vars[j]=0;
						j--;
					}
				}				// end while j>=0
			}
			else	// if (Operators[oper_id].nof_parameters>0) 
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
				if (satisfied)
				{
					act1_ptr=act2_ptr;
					act2_ptr=new_action(action(oper_id, vars));
					if (act1_ptr==NULL)
						first_action=act2_ptr;
					else
						act1_ptr->next=act2_ptr;
				}	// if satisfied
			}	// (Operators[oper_id].nof_parameters>0)
		}
		return first_action;
	}

	void space(int j)
	{
		for (int i=0;i<j;i++)
			cout << "    ";
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
						else	// the argument is a variable that is not already instantiated
						{
							
							k++;
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

	action* applicable2()
	{
		action* first_action=NULL;
		action* act1_ptr=NULL;
		action* act2_ptr=NULL;
		int vars[max_nof_parameters];	// the values that take the parameters of the operator
		int back_points[max_sof_op_lists];
		//int max_inst[max_sof_op_lists];
		int instantiated_by[max_sof_op_lists];

		int oper_id;
		for (oper_id=0;oper_id<nof_operators;oper_id++)
		{
			int j;
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
				
						if (all_dif)
						{
							#if MESS1
							space(j);cout << "Success" << endl;
							#endif
							act1_ptr=act2_ptr;
							act2_ptr=new_action(action(oper_id, vars));
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
						space(j);cout << "Fail:" << Operators[oper_id].strips[prec_list][j].instantiate(vars) << endl;
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
								space(i1);cout << "Deallocate: " << Operators[oper_id].strips[prec_list][i1] << endl;							
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
				if (satisfied)
				{
					act1_ptr=act2_ptr;
					act2_ptr=new_action(action(oper_id, vars));
					if (act1_ptr==NULL)
						first_action=act2_ptr;
					else
						act1_ptr->next=act2_ptr;
				}	// if satisfied
			}	// (Operators[oper_id].nof_parameters>0)
		}	//	for (oper_id=0;oper_id<nof_operators;oper_id++)
		return first_action;
	}

	state* next_state(action step)
	{
		int new_size=size
				- Operators[step.operator_id].sof_lists[delete_list]
				+ Operators[step.operator_id].sof_lists[add_list];
		
		fact* new_facts=new fact[new_size];
		int k=0;
		 int i;
 		for(i=0;i<size;i++)
		{
			bool flag=true;
			int j=0;
			while (j<Operators[step.operator_id].sof_lists[delete_list]
					&& flag)
				if (facts[i]==Operators[step.operator_id].strips[delete_list][j].instantiate(step.parameters))
					flag=false;
				else
					j++;
			if (flag)
				new_facts[k++]=facts[i];
		}
		int j;
		for(j=0;j<Operators[step.operator_id].sof_lists[add_list];j++)
			new_facts[k++]=Operators[step.operator_id].strips[add_list][j].instantiate(step.parameters);
	state* new_s=new_state(state(new_size, new_facts));
	return new_s;
	}


};


class node
{
public:
	state* s;
	action step;
	node* previous;

	node()
	{
		s=NULL;
		previous=NULL;
	}

	node(state* s1, action st, node* prev)
	{
		s=s1;
		step=st;
		previous=prev;
	};

	node operator = (node n)
	{
		s=n.s;
		step=n.step;
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
		while (nd!=NULL)
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
	int score;
	agenda* next;

	agenda(node* n1, int sc)
	{
		nd=n1;
		score=sc;
		next=NULL;
	}
};




class pointer
{
public:
	void* ptr;

	pointer() // default constructor
	{
		ptr=NULL;
	}

	pointer(void* p)
	{
		ptr=p;
	}
};

class complete_state_action;
class linked_complete_state_action;

extern pointer* hash_table;

class hash_entry
{
public:
	fact f;
	int distance;
	linked_inverted_action* inv_op_prec;
	linked_hash_entry* related;
	//linked_fact* related;
	bool achieved;	// used by the 'Complete_state' module, in order
					// to indicate whether a fact has been achieved or not
	linked_hash_entry* mutexes;
	linked_complete_state_action* normal_actions;	// pointers to the normal actions that have
													// this fact as a precondition.
	linked_complete_state_action* normal_actions_add; // pointers to the normal actions that
						// have thisfact as an add effect...
	bool enriched;
	bool used;			// Indicates if the fact of the enriched goal state
						// has been used 

	hash_entry(fact f1)
	{
		f=f1;
		distance=-1;
		inv_op_prec=NULL;
		normal_actions=NULL;
		normal_actions_add=NULL;
		related=NULL;
		achieved=false;
		mutexes=NULL;
		enriched=false;
		used=false;
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
	action step;		// the action
	linked_hash_entry* precs;	// a linked list of pointers to the precondition facts in the hash table
	linked_hash_entry* del;		// a linked list of pointers to the delete list facts in the hash table
	linked_hash_entry* add;		// a linked list of pointers to the add list facts in the hash table
	linked_hash_entry* non_deleted_precs;	// a linked list of pointers to the non_deleted preconditions in the hash table
	bool satisfied_prec;	// flag that indicates whether the preconditions have all been achieved or not
	bool no_mutex;			// flag that indicates whether the already achieved preconditions are not mutex to each other
	bool already_in_agenda;	// flag that indicates whether the action is already in agenda or not
	complete_state_action* next; // pointer to the next action
	bool first_application;		// indicates whether it is about the first application of the action or not.
	
	complete_state_action(action act)
	{
		step=act;
		satisfied_prec=false;
		no_mutex=false;
		next=NULL;
		
		precs=NULL;
		del=NULL;
		add=NULL;
		non_deleted_precs=NULL;
		first_application=true;
		already_in_agenda=false;

		int i;
		// creating the 'del' list
		for(i=0;i<Operators[step.operator_id].sof_lists[delete_list];i++)
		{
			if (!constant_predicates[Operators[step.operator_id].strips[delete_list][i].pred])
			{
				hash_entry* ptr;
				ptr=get_fact_pointer(&Operators[step.operator_id].strips[delete_list][i].instantiate(step.parameters));
				del=new_linked_hash_entry(linked_hash_entry(ptr, del));
			}
		}
		// creating the 'add' list
		for(i=0;i<Operators[step.operator_id].sof_lists[add_list];i++)
		{
			if (!constant_predicates[Operators[step.operator_id].strips[add_list][i].pred])
			{
				hash_entry* ptr;
				ptr=get_fact_pointer(&Operators[step.operator_id].strips[add_list][i].instantiate(step.parameters));
				add=new_linked_hash_entry(linked_hash_entry(ptr, add));
			}
		}
		// creating the 'prec' and the 'non_deleted_precs' lists
		for(i=0;i<Operators[step.operator_id].sof_lists[prec_list];i++)
		{
			if (!constant_predicates[Operators[step.operator_id].strips[prec_list][i].pred])
			{
				hash_entry* ptr;
				ptr=get_fact_pointer(&Operators[step.operator_id].strips[prec_list][i].instantiate(step.parameters));
				precs=new_linked_hash_entry(linked_hash_entry(ptr, precs));
				
				bool flag=true;
				linked_hash_entry* temp_del=del;
				while (flag && temp_del!=NULL)
				{
					if (temp_del->entry->f==ptr->f)
						flag=false;
					temp_del=temp_del->next;
				}
				if (flag)
					non_deleted_precs=new_linked_hash_entry(linked_hash_entry(ptr, non_deleted_precs));
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


// FUNCTION PROTOTYPES: test_routines.cpp
void display_objects();	
void display_predicates();
void display_operators();
void display_constants();
void display_constant_predicates();
void display_agenda(agenda*);
void display_hash_table();
void print_linked_actions(action* act);
	
// FUNCTION PROTOTYPES: parser.cpp
bool load_domain();
bool load_problem();
void copy_operators();

// FUNCTION PROTOTYPES: auxiliary_functions
bool strcmp2(char s1[], char s2[]);
bool process_command_line(int argc, char* argv[]);
void check_time();

// FUNCTION PROTOTYPES: GRT
void create_inverted_operators();
void release_memory();
void find_all_distances();
void create_all_facts();
void add_goals(state*);
void display_inverted_satisfied();
int find_grade(linked_hash_entry* linked_facts);
hash_entry* get_fact_pointer(fact* f);
bool included_in_fact_list(fact f, linked_fact* linked_list);
void delete_linked_hash_entry_list(linked_hash_entry*);


// FUNCTION PROTOTYPES: COMPLETE_STATES
void complete_goal_state();
extern linked_hash_entry* new_goals;

int get_time();