#include "planner.h"

int OSystem=1;

/*
-r0 -time 15 -strategy HILL -d "AIPS-2000\Logistics\Track1\Untyped\domain.pddl"  -p "AIPS-2000\Logistics\Track1\Untyped\probLOGISTICS-15-1.pddl"
-display_short_messages -time 15 -strategy HILL -d "AIPS-2000\freecell\Untyped\domain.pddl"  -p "AIPS-2000\Freecell\Untyped\probfreecell-5-1.pddl"
-r2 -display_short_messages -time 15 -strategy BEST -d "AIPS-2000\mic10\Untyped\domain.pddl"  -p "AIPS-2000\mic10\Untyped\s30-0.pddl"
-display_short_messages -STRATEGY best -time 5 -d "AIPS-2000\Freecell\CompleteGoals\domain.pddl"  -p "AIPS-2000\Freecell\CompleteGoals\probfreecell-12-1.pddl" 
*/

char domain_file[max_file_name];
char problem_file[max_file_name];
char output_file[max_file_name];

char next_char();
bool next_word(char[max_sof_words+1]);
bool white_char(char ch);
bool legal_char(char ch);

bool load_requirements();
bool load_types();
bool load_operator();
bool load_predicates();
bool load_predicate();
bool load_constants();
bool ignore_list();
bool load_xors();

state* initial2;
 
void detect_constant_predicates();

ifstream infile;

char domain_name[max_sof_words+1];
char problem_name[max_sof_words+1];

bool get_domain_header();

bool load_domain()
{
	if (OSystem==1)
		infile.open(domain_file, ios::binary);
	else
		infile.open(domain_file, ios::in);
	char ch;
	char wrd[max_sof_words+1];
	if (!get_domain_header())
	{
			infile.close();
			return false;
	}
	else
	{
		ch=next_char();
		bool pred_loaded=false;
		bool action_loaded=false;
		while (ch=='(' )
		{
			ch=next_char();
			if (ch!=':')
			{
				cout << "Unexpected character: '" << ch << "'. Double dot (:) expected." << endl;
				infile.close();
				return false;
			}
			if (!next_word(wrd))
			{
				cout << "Unexpected characters. Some keyword expected." << endl ;
				infile.close();
				return false;
			}
			if (strcmp2(wrd,"predicates"))
			{
				if (pred_loaded)
				{
					cout << "ERROR: Predicates already loaded" << endl;
					if (!ignore_list())
					{
						infile.close();
						return false;
					}
					else
						cout << "Second predicate list ignored." << endl;
				}
				else
				{
					if (!load_predicates())
					{
						infile.close();
						return false;
					}
					pred_loaded=true;
				}
			}
			else if (strcmp2(wrd,"types"))
			{
				if (!load_types())
				{
					infile.close();
					return false;
				}
			}
			else if (strcmp2(wrd,"action"))
			{
				if (!pred_loaded)
				{
					cout << "Unable to load actions, without having loaded predicate definitions." << endl;
					infile.close();
					return false;
				}
				else
				{
					if (!load_operator())
					{
						infile.close();
						return false;
					}
					action_loaded=true;
				}
			}
			else if (strcmp2(wrd,"requirements"))
			{
				if (!load_requirements())
				{
					infile.close();
					return false;
				}
			}
			else if (strcmp2(wrd,"constants"))
			{
				if (!load_constants())
				{
					infile.close();
					return false;
				}
			}
			else if (strcmp2(wrd,"xors"))
			{
				if (!load_xors())
				{
					infile.close();
					return false;
				}
				xor_enabled=true;
			}
			else
			{
				cout << endl << "Unknown keyword: '" << wrd << "'." << endl;
				if (!ignore_list())
				{
					infile.close();
					return false;
				}
			}
		ch=next_char();
		}
		if (ch!=')')
		{
			cout << "Unexpected character: '" << ch << "'. Left or right parenthesis expected" << endl;
			infile.close();
			return false;
		}
	}
	if (display_messages)
		cout << "Domain loaded successfully." << endl << endl;
	infile.close();
	return true;
}


bool get_domain_header()
{
	char ch;
	char wrd[max_sof_words+1];
	ch=next_char();
	if ( ch != '(' )
	{
		cout << "Domain file begins inproperly with character: " << int(ch) << endl;
		cout << "First non-white character must be a left parenthesis" << endl;
		return false;
	}
	if (!next_word(wrd))
	{
		cout << "Bad characters. Keyword 'define' expected" << endl;
		return false;
	}
	if (!strcmp2(wrd, "define"))
	{
		cout << "Unexpected keyword: " << wrd << endl;
		cout << "Keyword 'define' expected" << endl;
		return false;
	}
	if(display_messages)
		cout << "Define new domain" << endl;
	ch=next_char();
	if (ch!='(')
	{
		cout << "Bad file structure. Left parenthesis expected." << endl;
		return false;
	}
	if (!next_word(wrd))
	{
		cout << "Unexpected characters. Keyword 'domain' expected." << endl;
		return false;
	}
	if (!strcmp2(wrd, "domain"))
	{
		cout << "Unexpected keyword: " << wrd << endl;
		cout << "Keyword 'domain' expected." << endl;
		return false;
	}
	if (next_word(wrd))
	{
		if(display_messages)
			cout << "Domain name: " << wrd << endl;
		strcpy(domain_name, wrd);
		ch=next_char();
		if (ch==')')
		{
			if(display_messages)
				cout << "Domain header loaded" << endl;
			return true;
		}
		else
		{
			cout << "Unexpected character: right parenthesis expected" << endl;
			return false;
		}
	}
	else
	{
		cout << "Unexpected error: Domain name expected." << endl;
		return false;
	}
}


// Function skip_line() reads and throws out the rest of the current line
void skip_line()
{
	char ch=';';
	while (infile && ch!='\n') infile.get(ch);
}


// Function next_char() finds and returns the first next non-white character.
// If the function detects a semicolon (;), it ignores the rest of the line.
char next_char()
{
	char ch;
	ch=' ';
	while (infile && white_char(ch))
	{
		infile.get(ch);
		if (ch==';') 
		{
			skip_line();
			ch=' ';
		}
	}
	if (!infile)
	{
		cout << endl << "Unexpected end of file" << endl;
		return 0;
	}
	else
		return ch;
}

// This function checks if a char is a white char (space, line feed or return)
bool white_char(char ch)
{
	if (ch==32 || ch==13 || ch==10  || ch==9 )
		return true;
	else
		return false;
}

// This function checks if a character is a valid PDDL name char
bool legal_char(char ch)
{
	if ((ch>='0' && ch<='9') || 
		(ch>='A' && ch<='Z') ||
		(ch>='a' && ch<='z') ||
		ch=='-' || ch=='_' || ch=='?')
		return true;
	else
		return false;
}

// Function next_word() finds and stores the next word. If there is any problem,
// the function returns false, otherwise it returns true.
bool next_word(char wrd[max_sof_words+1])
{
	char ch=' ';
	while (infile && white_char(ch))
	{
		infile.get(ch);
		if (ch==';')
		{
			skip_line();
			ch=' ';
		}
	}
	if (!infile)
	{
		cout << endl << "Unexpected end of file" << endl;
		wrd[0]=0;
		return false;
	}
	else if (!legal_char(ch))
	{
		infile.seekg(-1,ios::cur);
		return false;
	}
	else
	{

		int i=0;
		while (infile && legal_char(ch))
		{
			if (i<max_sof_words) wrd[i++]=ch;
			infile.get(ch);
			if (ch==';')
			{
				skip_line();
				ch=' ';
			}
		}
		wrd[i]=0;
		if (!legal_char(ch) && !white_char(ch)) infile.seekg(-1, ios::cur);
	}
	return true;
}

// Function next_number() finds and stores the next number. If there is any problem,
// the function returns false, otherwise it returns true.
bool next_number(int* Amount)
{
	char ch=' ';
	int prosimo=1;
	*Amount =0;
	
	// search for the first non-white char
	while (infile && white_char(ch))
	{
		infile.get(ch);
		if (ch==';')
		{
			skip_line();
			ch=' ';
		}
	}

	if (!infile)
	{
		cout << endl << "UNexpected end of file" << endl;
		return false;
	}

	if (ch=='-') 
		prosimo=-1;
	else if (ch<'0' || ch>'9') 
		return false;

	// if the first char was '+' or '-' then
	// read also the second char.
	if (ch=='+' || ch=='-')
	{
		if (infile)
			ch=next_char();
		else
			return false;

		if (ch<'0' || ch>'9')
			return false;
	}

	while (infile && ch>='0' && ch<='9') 
	{
		*Amount =10* (*Amount) + (ch-'0');
		infile.get(ch);
		if (ch==';')
			skip_line();
	}

	*Amount=prosimo*(*Amount);
	
	if (!infile || white_char(ch) || ch==';' )
		return true;

	infile.seekg(-1, ios::cur);

	if (ch==')' || ch=='(')
		return true;

	*Amount=0;
	return false;
}




bool load_requirements()
{
	if(display_messages)
		cout << "Requirements loaded" << endl; 
	bool flag=ignore_list();
	return flag;
}



class linked_strings
{
public:
	char name[max_sof_words+1];
	linked_strings* next;

	linked_strings(char wrd[max_sof_words+1])
	{
		strcpy(name, wrd);
		next=NULL;
	}
};

bool load_xors()
{
	char ch;
	char wrd[max_sof_words+1];

	int counter=0;

	ch=next_char();
	if (ch==')')
	{
		cout << "No XOR relations found." << endl;
		return true;
	}
	
	if (ch!='(')
	{
		cout << "Unexpected character: '" << ch << "' while loading XOR relations." << endl;
		cout << "Left parenthesis expected." << endl;
		return false;
	}

	linked_strings* vars_head=NULL;
	linked_strings* vars_tail=NULL;
	linked_strings* vars_temp;



	while (ch=='(')		// For each XOR relation
	{
		counter++;
		if (display_messages)
			cout << "XOR relation " << counter << ":  ";

		int nof_parameters=0;	// the number of the named variables
								// referenced within the relation...
		

		ch=next_char();	// this is the left parenthesis that groups the XOR-constrained atoms
					// with the constants.
		if (ch!='(')
		{
			cout << "Unexpected character while loading XOR constraints." << endl;
			cout << "Left parenthesis expected." << endl;
			return false;
		}
		
		xors=new constraints(xors);

		if (!next_word(wrd))
		{
			cout << "Unexpected characters. Keyword 'xor ' expected." << endl;
			return false;
		}

		if (!strcmp2(wrd, "xor"))
		{
			cout << "Unexpected keyword: " << wrd << endl;
			cout << "Keyword 'xor ' expected." << endl;
			return false;
		}

		ch=next_char();
		while (ch=='(')	// for each XOR atom or group of atoms (AND structure)...
		{
			if (!next_word(wrd))
			{
				cout << "Unexpected characters. Predicate name expected." << endl;
				return false;
			}
			
			fact f;
			if ((f.pred=P(wrd))==-1)
			{
				cout << "Unexpected word: " << wrd << endl;
				cout << "Predicate name expected." << endl;
				return false;
			}
/*
			if (constant_predicates[f.pred])
			{
				cout << "ERROR: Constant predicate within a XOR relation." << endl;
				return false;
			}
*/				
			int i;
			for(i=0;i<predicates[f.pred].arity;i++)
			{
				if (!next_word(wrd))
				{
					cout << "Unexpected characters: " << wrd << ". Object variable or name expected." << endl;
					return false;
				}
				if (O(wrd)>0)
					f.arguments[i]=O(wrd);
				else if (strcmp2(wrd,"?"))
					f.arguments[i]=0;
				else if (wrd[0]!='?')
				{
					if (display_messages)
						cout << "New object created: " << wrd << "." << endl;
					strcpy(objects[++nof_objects].name, wrd);
					f.arguments[i]=nof_objects;
				}
				else
				{
					bool found=false;
					vars_temp=vars_head;
					int j=1;
					while (vars_temp!=NULL && !found)
					{
						if (strcmp2(vars_temp->name,wrd))
							found=true;
						else
						{
							j=j+1;
							vars_temp=vars_temp->next;
						}
					}	//	while (temp!=NULL && !found)

					if (!found)
					{
						nof_parameters++;
						if (vars_head==NULL)
						{
							vars_head=new linked_strings(wrd);
							vars_tail=vars_head;
						}
						else	// if (vars_head==NULL)
						{
							vars_temp=new linked_strings(wrd);
							vars_tail->next=vars_temp;
							vars_tail=vars_temp;
						}	// if (vars_head==NULL)
					}	// if (!found) 
					f.arguments[i]=-j;
				}
			}
			
			xors->xor=new constraint(xors->xor);
			xors->xor->ands=new linked_fact(f);
			
			ch=next_char();
			if (ch!=')')
			{
				cout << "Unexpected character: '" << ch << "'. Right parenthseis expected." << endl;
				return false;
			}

			if (display_messages)
				cout << f << ",  ";
			ch=next_char();
		}	// while (ch=='(')	// for each XOR atom or group of atoms (AND structure)...
		
		if (ch!=')')
		{
			cout << "Unexpected character while loading XOR-relations. Right parenthesis expected."<< endl;
			return false;
		}
		
		ch=next_char();
		if (ch=='(')
		{
			if (!next_word(wrd))
			{
				cout << "Unexpected characters. Keyword 'constants' expected." << endl;
				return false;
			}

			if (!strcmp2(wrd, "constants"))
			{
				cout << "Unexpected keyword: " << wrd << endl;
				cout << "Keyword 'constants' expected." << endl;
				return false;
			}

			if (display_messages)
				cout << "  Constants: ";
			ch=next_char();
			while (ch=='(')	// loading the XOR-relation constants...
			{
		
				if (!next_word(wrd))
				{
					cout << "Unexpected characters. Predicate name expected." << endl;
					return false;
				}
			
				fact f;
			
				if ((f.pred=P(wrd))==-1)
				{
					cout << "Unexpected word: " << wrd << endl;
					cout << "Predicate name expected." << endl;
					return false;
				}

/*
				if (!constant_predicates[f.pred])
				{
					cout << "ERROR: Not constant predicate within the constants of a XOR relation." << endl;
					return false;
				}
*/				
				int i;
				for(i=0;i<predicates[f.pred].arity;i++)
				{
					if (!next_word(wrd))
					{
						cout << "Unexpected characters: " << wrd << ". Object variable or name expected." << endl;
						return false;
					}
					if (O(wrd)>0)
						f.arguments[i]=O(wrd);
					else if (strcmp2(wrd,"?"))
						f.arguments[i]=0;
					else if (wrd[0]!='?')
					{
						if (display_messages)
							cout << "New object created: " << wrd << "." << endl;
						strcpy(objects[++nof_objects].name, wrd);
						f.arguments[i]=nof_objects;
					}
					else
					{
						bool found=false;
						vars_temp=vars_head;
						int j=1;
						while (vars_temp!=NULL && !found)
						{
							if (strcmp2(vars_temp->name,wrd))
								found=true;
							else
							{
								j=j+1;
								vars_temp=vars_temp->next;
							}
						}	//	while (temp!=NULL && !found)
	
						if (!found)
						{
							nof_parameters++;
							if (vars_head==NULL)
							{
								vars_head=new linked_strings(wrd);
								vars_tail=vars_head;
							}
							else	// if (vars_head==NULL)
							{
								vars_temp=new linked_strings(wrd);
								vars_tail->next=vars_temp;
								vars_tail=vars_temp;
							}	// if (vars_head==NULL)
						}	// if (!found) 
						f.arguments[i]=-j;
					}
				}
			
				xors->constants=new linked_fact(f, xors->constants);
	
				ch=next_char();
				if (ch!=')')
				{
					cout << "Unexpected character: '" << ch << "'. Right parenthseis expected." << endl;
					return false;
				}
				if (display_messages)
					cout << f << ",  ";
				ch=next_char();
			}	// while (ch=='(')	 loading the XOR-relation constants...
		}	// if (ch=='(')

		if (ch!=')')
		{
			cout << "Unexpected character while loading XOR constraints." << endl;
			cout << "Right or Left parenthesis expected." << endl;
			return false;
		}

		xors->nof_parameters=nof_parameters;			

		while (vars_head!=NULL)
		{
			vars_temp=vars_head;
			vars_head=vars_head->next;
			delete vars_temp;
		}

		ch=next_char();
		if (ch!=')')
		{
			cout << "Unexpected character while loading XOR constraints." << endl;
			cout << "Right or Left parenthesis expected." << endl;
			return false;
		}

		if (display_messages)
			cout << endl;
		ch=next_char();

	}	// while (ch=='(')		// For each XOR relation

if (display_messages)
	cout << "XOR relations loaded successfully." << endl;
//	display_xor_relations();
	return true;
}


bool load_types()
{
	if(display_messages)
		cout << "Types loaded" << endl;
	bool flag=ignore_list();
	return flag;
}


// the following table keeps the name of the operator's parameters
// the first item of this table is not used
char	ops_parameters[max_nof_parameters][sof_object_name+1];
int		ops_nof_parameters;

bool load_preconditions();
bool load_effects();
bool load_consumption();

bool	load_operator()
{
	char ch;
	char wrd[max_sof_words+1];
	if (!next_word(wrd))
	{
		cout << "Unexpected characters. Action name expected." << endl;
		return false;
	}

	strcpy(Operators[nof_operators].name, wrd);
	ch=next_char();
	if (ch!=':')
	{
		cout << "Unexpected character. Double dot (:) expected." << endl;
		return false;
	}

	if (!next_word(wrd))
	{
		cout << "Unexpected characters. Keyword 'parameters' expected." << endl;
		return false;
	}

	if (!strcmp2(wrd, "parameters"))
	{
		cout << "Unexpected keyword: " << wrd << endl;
		cout << "Keyword 'parameters' expected." << endl;
		return false;
	}

	ch=next_char();
	if (ch!='(')
	{
		cout << "Unexpected character: '" << ch << "'. Left parenthseis expected." << endl;
		return false;
	}

	ops_nof_parameters=0;		// load parameters' names
	while (next_word(wrd))
	{
		if (wrd[0]!='?')
		{
			cout << "Invalid parameter name: '" << wrd <<"' while loading operator " << Operators[nof_operators].name << endl;
			cout << "Parameter names must begin with a question mark ('?')." << endl;
			return false;
		}
		strcpy(ops_parameters[++ops_nof_parameters], wrd);
	}
	Operators[nof_operators].nof_parameters=ops_nof_parameters;

	ch=next_char();
	if (ch!=')')
	{
		cout << "Unexpected character: '" << ch << "'. Right parenthseis expected." << endl;
		return false;
	}
	 
	ch=next_char();
	bool flag=true;
	while (ch==':' && flag)
	{
		if (!next_word(wrd)) 
		{
			cout << "Unexpected characters. Operator keyword (i.e. 'preconditions', 'effects', e.t.c.) expected." << endl;
			return false;
		}
		if (strcmp2(wrd, "precondition"))
		{
			flag=load_preconditions();
			if (!flag)
				return false;
		}
		else if (strcmp2(wrd,"effect"))
		{
			flag=load_effects();
			if (!flag)
				return false;
		}
		else if (strcmp2(wrd,"resources"))
		{
			if (!load_consumption())
				return false;
		}

		else
		{
			cout << endl << "Unknown keyword: '" << wrd << "' while loading operator " << Operators[nof_operators].name << "." << endl;
			ch=next_char();
			if (ch!='(')
				return false;
			else if (!ignore_list())
				return false;
		}
		ch=next_char(); 
	}

	if (ch==')')
	{
		if (display_messages)
			cout << "Operator " << Operators[nof_operators].name << " loaded successfully." << endl;
		//cout << Operators[nof_operators] << endl;
		nof_operators++;
		return true;
	}
	else
	{
		cout << "Unexpected character: '" << ch << "'. Double dot (:) or right parenthesis expected" << endl;
		return false;
	}
}



bool load_preconditions()
{
	char ch;
	char wrd[max_sof_words+1];

	ch=next_char();
	if (ch!='(')
	{
		cout << "Unexpected character: '" << ch << "'. Left parenthesis expected." << endl;
		return false;
	}
	
	if (!next_word(wrd))
	{
		ch=next_char();
		if (ch==')')
			return true;
		cout << "Unexpected characters while loading operator's " << Operators[nof_operators].name << " preconditions." << endl;
		cout << "Keyword 'and' expected." << endl;
		return false;
	}

	if (strcmp2(wrd, "and"))
	{
		int nof_precs=0;
		ch=next_char();
		while (ch=='(')
		{
			if (!next_word(wrd))  // loading precondions' predicate name
			{
				cout << "Unexpected characters while loading operator's " << Operators[nof_operators].name << " preconditions' predicate name." << endl;
				return false;
			}

			int pred_id=P(wrd);
			if (pred_id<0)
			{
				cout << "Unknown predicate name '" << wrd << "', while loading operator's " << Operators[nof_operators].name << " preconditions." << endl;
				return false;
			}

			Operators[nof_operators].strips[prec_list][nof_precs].pred=pred_id;

			int nof_args=0;
			while (next_word(wrd))  // loading preconditions' facts' arguments
			{
				bool flag=false;
				if (wrd[0]=='?')
				{
					int i=1;
					while (i<=ops_nof_parameters && !flag)
						if (strcmp2(wrd, ops_parameters[i]))
							flag=true;
						else
							i++;
					if (!flag)
					{
						cout << "Unknown parameter name, '" << wrd << "', " << endl << "while loading operator's " << Operators[nof_operators].name << " preconditions." << endl;
						return false;
					}
					Operators[nof_operators].strips[prec_list][nof_precs].arguments[nof_args]=-i;
				}
				else
				{
					int i=1;
					while (i<=nof_objects && !flag)
						if (strcmp2(wrd, objects[i].name))
							flag=true;
						else
							i++;
					if (flag)
						Operators[nof_operators].strips[prec_list][nof_precs].arguments[nof_args]=i;
					else 
					{
						strcpy(objects[++nof_objects].name, wrd);
						if (display_messages)
							cout << "Object '" << wrd << "' created."<< endl;
						Operators[nof_operators].strips[prec_list][nof_precs].arguments[nof_args]=nof_objects;
					}
				}
				nof_args++;
			}
			ch=next_char();
			if (ch!=')')
			{
				cout << "Unexpected character: '" << ch << "', while loading operator's " << Operators[nof_operators].name << " preconditions' parameters." << endl;
				cout << "Right parenthesis or parameter name expected." << endl;
				return false;
			}

			if (nof_args!=predicates[pred_id].arity)
			{
				cout << "ERROR: Invalid number of arguments for predicate '" << predicates[pred_id].name << "'," << endl;
				cout << "while loading operator's " << Operators[nof_operators].name << " preconditions." << endl;
				return false;
			}
			ch=next_char();
			nof_precs++;
		}
	
		if (ch!=')')
		{
			cout << "Unexpected character: " << ch << " while loading operator's " << Operators[nof_operators].name << " preconditions." << endl;
			cout << "Left of right parenthesis expected." << endl;
			return false;
		}	
		Operators[nof_operators].sof_lists[prec_list]=nof_precs;
	}	// if (strcmp2(wrd, "and"))
	else
	{
		int pred_id=P(wrd);
		if (pred_id<0)
		{
			cout << "Unknown predicate name '" << wrd << "', while loading operator's " << Operators[nof_operators].name << " preconditions." << endl;
			return false;
		}

		Operators[nof_operators].strips[prec_list][0].pred=pred_id;

		int nof_args=0;
		while (next_word(wrd))  // loading preconditions' facts' arguments
		{
			bool flag=false;
			if (wrd[0]=='?')
			{
				int i=1;
				while (i<=ops_nof_parameters && !flag)
					if (strcmp2(wrd, ops_parameters[i]))
						flag=true;
					else
						i++;
				if (!flag)
				{
					cout << "Unknown parameter name, '" << wrd << "', " << endl << "while loading operator's " << Operators[nof_operators].name << " preconditions." << endl;
					return false;
				}
				Operators[nof_operators].strips[prec_list][0].arguments[nof_args]=-i;
			}
			else
			{
				int i=1;
				while (i<=nof_objects && !flag)
					if (strcmp2(wrd, objects[i].name))
						flag=true;
					else
						i++;
				if (flag)
					Operators[nof_operators].strips[prec_list][0].arguments[nof_args]=i;
				else 
				{
					strcpy(objects[++nof_objects].name, wrd);
					if(display_messages)
						cout << "Object '" << wrd << "' created."<< endl;
					Operators[nof_operators].strips[prec_list][0].arguments[nof_args]=nof_objects;
				}
			}
			nof_args++;
		}
		ch=next_char();
		if (ch!=')')
		{
			cout << "Unexpected character: '" << ch << "', while loading operator's " << Operators[nof_operators].name << " preconditions' parameters." << endl;
			cout << "Right parenthesis or parameter name expected." << endl;
			return false;
		}

		if (nof_args!=predicates[pred_id].arity)
		{
			cout << "ERROR: Invalid number of arguments for predicate '" << predicates[pred_id].name << "'," << endl;
			cout << "while loading operator's " << Operators[nof_operators].name << " preconditions." << endl;
			return false;
		}
			Operators[nof_operators].sof_lists[prec_list]=1;
	}	// if (strcmp2(wrd, "and"))


	// Re-Order preconditions

	for(int i1=0;i1<Operators[nof_operators].sof_lists[prec_list]-2;i1++)
		for(int i2=Operators[nof_operators].sof_lists[prec_list]-2;i2>=i1;i2--)
			if (predicates[Operators[nof_operators].strips[prec_list][i2].pred].arity<
				predicates[Operators[nof_operators].strips[prec_list][i2+1].pred].arity)
			{
				fact f;
				f=Operators[nof_operators].strips[prec_list][i2];
				Operators[nof_operators].strips[prec_list][i2]=Operators[nof_operators].strips[prec_list][i2+1];
				Operators[nof_operators].strips[prec_list][i2+1]=f;
			}


	// cout << "Preconditions loaded successfully." << endl;


	return true;
}



bool load_effects()
{
	char ch;
	char wrd[max_sof_words+1];

	ch=next_char();
	if (ch!='(')
	{
		cout << "Unexpected character: '" << ch << "'. Left parenthesis expected." << endl;
		return false;
	}
	
	if (!next_word(wrd))
	{
		ch=next_char();
		if (ch==')')
			return true;
		cout << "Unexpected characters while loading operator's " << Operators[nof_operators].name << " effects." << endl;
		cout << "Keyword 'and' expected." << endl;
		return false;
	}
	if (strcmp2(wrd, "and"))
	{
		int nof_adds=0;
		int nof_dels=0;
		ch=next_char();
		while (ch=='(')
		{
			if (!next_word(wrd))  // loading precondions' predicate name
			{
				cout << "Unexpected characters while loading operator's " << Operators[nof_operators].name << " effects' predicate name." << endl;
				return false;
			}

			if (!strcmp2(wrd, "not"))
			{
				int pred_id=P(wrd);
				if (pred_id<0)
				{
					cout << "Unknown predicate name '" << wrd << "', while loading operator's " << Operators[nof_operators].name << " effects." << endl;
					return false;
				}
				Operators[nof_operators].strips[add_list][nof_adds].pred=pred_id;

				int nof_args=0;
				while (next_word(wrd))  // loading add list's facts' arguments
				{
					bool flag=false;
					if (wrd[0]=='?')
					{
						int i=1;
						while (i<=ops_nof_parameters && !flag)
							if (strcmp2(wrd, ops_parameters[i]))
								flag=true;
							else
								i++;
						if (flag)
							Operators[nof_operators].strips[add_list][nof_adds].arguments[nof_args]=-i;
						else
						{
							cout << "Unknown parameter name while loading operator's " << Operators[nof_operators].name << " effects." << endl;
							return false;
						}
					}
					else
					{
						int i=1;
						while (i<=nof_objects && !flag)
							if (strcmp2(wrd, objects[i].name))
								flag=true;
							else
								i++;
						if (flag)
							Operators[nof_operators].strips[add_list][nof_adds].arguments[nof_args]=i;
						else
						{
							strcpy(objects[++nof_objects].name, wrd);
							if(display_messages)
								cout << "Object '" << wrd << "' created." << endl;
							Operators[nof_operators].strips[add_list][nof_adds].arguments[nof_args]=nof_objects;
						}
					}
					nof_args++;
				}
				nof_adds++;
			
				ch=next_char();
				if (ch!=')')
				{
					cout << "Unexpected character: '" << ch << "', while loading operator's " << Operators[nof_operators].name << " effects' parameters." << endl;
					cout << "Right parenthesis or parameter name expected." << endl;
					return false;
				}
				if (nof_args!=predicates[pred_id].arity)
				{
					cout << "ERROR: Invalid number of arguments for predicate '" << predicates[pred_id].name << "'," << endl;
					cout << "while loading operator's " << Operators[nof_operators].name << " effects." << endl;
					return false;
				}
			}
			else //(!strcmp2(wrd, "not"))
			{
				ch=next_char();
				if (ch!='(')
				{
					cout << "Unexpected character: '" << ch << "' while loading operator's " << Operators[nof_operators].name << " effects." << endl;
					cout <<	"Left parenthesis expected." << endl;
					return false;
				}
				if (!next_word(wrd))
				{
					cout << "Unexpected characters while loading operator's " << Operators[nof_operators].name << " effects. Predicate name expected." << endl;
					return false;
				}
				int pred_id=P(wrd);
				if (pred_id<0)
				{
					cout << "Unknown predicate name '" << wrd << "', while loading operator's " << Operators[nof_operators].name << " effects." << endl;
					return false;
				}
				Operators[nof_operators].strips[delete_list][nof_dels].pred=pred_id;

				int nof_args=0;
				while (next_word(wrd))  // loading add list's facts' arguments
				{
					bool flag=false;
					if (wrd[0]=='?')
					{ 
						int i=1;
						while (i<=ops_nof_parameters && !flag)
							if (strcmp2(wrd, ops_parameters[i]))
								flag=true;
							else
								i++;
						if (flag)
							Operators[nof_operators].strips[delete_list][nof_dels].arguments[nof_args]=-i;
						else
						{
							cout << "Unknown parameter name while loading operator's " << Operators[nof_operators].name << " effects." << endl;
							return false;
						}
					}
					else
					{
						int i=1;
						while (i<=nof_objects && !flag)
							if (strcmp2(wrd, objects[i].name))
								flag=true;
							else
								i++;
						if (flag)
							Operators[nof_operators].strips[delete_list][nof_dels].arguments[nof_args]=i;
						else
						{
							strcpy(objects[++nof_objects].name, wrd);
							if(display_messages)
								cout << "Object '" << wrd << "' created." << endl;
							Operators[nof_operators].strips[delete_list][nof_dels].arguments[nof_args]=nof_objects;					
						}
				}
					nof_args++;
				}
				nof_dels++;
			
				ch=next_char();
				if (ch!=')')
				{
					cout << "Unexpected character: '" << ch << "', while loading operator's " << Operators[nof_operators].name << " effects' parameters." << endl;
					cout << "Right parenthesis or parameter name expected." << endl;
					return false;
				}
				if (nof_args!=predicates[pred_id].arity)
				{
					cout << "ERROR: Invalid number of arguments for predicate '" << predicates[pred_id].name << "'," << endl;
					cout << "while loading operator's " << Operators[nof_operators].name << " effects." << endl;
					return false;
				}
				ch=next_char();
				if (ch!=')')
				{
					cout << "Unexpected character: '" << ch << "', while loading operator's " << Operators[nof_operators].name << " effects' parameters." << endl;
					cout << "Right parenthesis expected." << endl;
					return false;
				}
			}
			ch=next_char();
		}

		if (ch!=')')
		{
			cout << "Unexpected character: " << ch << " while loading operator's " << Operators[nof_operators].name << " effects." << endl;
			cout << "Left of right parenthesis expected." << endl;
			return false;
		}	
	
		Operators[nof_operators].sof_lists[add_list]=nof_adds;
		Operators[nof_operators].sof_lists[delete_list]=nof_dels;
	
	}	// 	if (strcmp2(wrd, "and"))
	
	else
	
	{
		if (!strcmp2(wrd, "not"))
		{
			int pred_id=P(wrd);
			if (pred_id<0)
			{
				cout << "Unknown predicate name '" << wrd << "', while loading operator's " << Operators[nof_operators].name << " effects." << endl;
				return false;
			}
			Operators[nof_operators].strips[add_list][0].pred=pred_id;

			int nof_args=0;
			while (next_word(wrd))  // loading add list's facts' arguments
			{
				bool flag=false;
				if (wrd[0]=='?')
				{
					int i=1;
					while (i<=ops_nof_parameters && !flag)
						if (strcmp2(wrd, ops_parameters[i]))
							flag=true;
						else
							i++;
					if (flag)
						Operators[nof_operators].strips[add_list][0].arguments[nof_args]=-i;
					else
					{
						cout << "Unknown parameter name while loading operator's " << Operators[nof_operators].name << " effects." << endl;
						return false;
					}
				}
				else
				{
					int i=1;
					while (i<=nof_objects && !flag)
						if (strcmp2(wrd, objects[i].name))
							flag=true;
						else
							i++;
					if (flag)
						Operators[nof_operators].strips[add_list][0].arguments[nof_args]=i;
					else
					{
						strcpy(objects[++nof_objects].name, wrd);
						if(display_messages)
							cout << "Object '" << wrd << "' created." << endl;
						Operators[nof_operators].strips[add_list][0].arguments[nof_args]=nof_objects;
					}
				}
				nof_args++;
			}
					
			ch=next_char();
			if (ch!=')')
			{
				cout << "Unexpected character: '" << ch << "', while loading operator's " << Operators[nof_operators].name << " effects' parameters." << endl;
				cout << "Right parenthesis or parameter name expected." << endl;
				return false;
			}
			
			if (nof_args!=predicates[pred_id].arity)
			{
				cout << "ERROR: Invalid number of arguments for predicate '" << predicates[pred_id].name << "'," << endl;
				cout << "while loading operator's " << Operators[nof_operators].name << " effects." << endl;
				return false;
			}
			Operators[nof_operators].sof_lists[add_list]=1;
			Operators[nof_operators].sof_lists[delete_list]=0;

		}
		else //(!strcmp2(wrd, "not"))
		{
			ch=next_char();
			if (ch!='(')
			{
				cout << "Unexpected character: '" << ch << "' while loading operator's " << Operators[nof_operators].name << " effects." << endl;
				cout <<	"Left parenthesis expected." << endl;
				return false;
			}
			if (!next_word(wrd))
			{
				cout << "Unexpected characters while loading operator's " << Operators[nof_operators].name << " effects. Predicate name expected." << endl;
				return false;
			}
			int pred_id=P(wrd);
			if (pred_id<0)
			{
				cout << "Unknown predicate name '" << wrd << "', while loading operator's " << Operators[nof_operators].name << " effects." << endl;
				return false;
			}
			Operators[nof_operators].strips[delete_list][0].pred=pred_id;

			int nof_args=0;
			while (next_word(wrd))  // loading add list's facts' arguments
			{
				bool flag=false;
				if (wrd[0]=='?')
				{ 
					int i=1;
					while (i<=ops_nof_parameters && !flag)
						if (strcmp2(wrd, ops_parameters[i]))
							flag=true;
						else
							i++;
					if (flag)
						Operators[nof_operators].strips[delete_list][0].arguments[nof_args]=-i;
					else
					{
						cout << "Unknown parameter name while loading operator's " << Operators[nof_operators].name << " effects." << endl;
						return false;
					}
				}
				else
				{
					int i=1;
					while (i<=nof_objects && !flag)
						if (strcmp2(wrd, objects[i].name))
							flag=true;
						else
							i++;
					if (flag)
						Operators[nof_operators].strips[delete_list][0].arguments[nof_args]=i;
					else
					{
						strcpy(objects[++nof_objects].name, wrd);
						if(display_messages)
							cout << "Object '" << wrd << "' created." << endl;
						Operators[nof_operators].strips[delete_list][0].arguments[nof_args]=nof_objects;					
					}
			}
				nof_args++;
			}
					
			ch=next_char();
			if (ch!=')')
			{
				cout << "Unexpected character: '" << ch << "', while loading operator's " << Operators[nof_operators].name << " effects' parameters." << endl;
				cout << "Right parenthesis or parameter name expected." << endl;
				return false;
			}
			if (nof_args!=predicates[pred_id].arity)
			{
				cout << "ERROR: Invalid number of arguments for predicate '" << predicates[pred_id].name << "'," << endl;
				cout << "while loading operator's " << Operators[nof_operators].name << " effects." << endl;
				return false;
			}
			ch=next_char();
			if (ch!=')')
			{
				cout << "Unexpected character: '" << ch << "', while loading operator's " << Operators[nof_operators].name << " effects' parameters." << endl;
				cout << "Right parenthesis expected." << endl;
				return false;
			}
			Operators[nof_operators].sof_lists[add_list]=0;
			Operators[nof_operators].sof_lists[delete_list]=1;

		}

		if (ch!=')')
		{
			cout << "Unexpected character: " << ch << " while loading operator's " << Operators[nof_operators].name << " effects." << endl;
			cout << "Left of right parenthesis expected." << endl;
			return false;
		}	
	
	}

	// cout << "Effects loaded successfully." << endl;
	return true;
}



bool load_consumption()
{
	resource_consumption* Resources=NULL;

	char ch;
	char wrd[max_sof_words+1];
	ch=next_char();
	while (ch=='(')
	{
		int Object_ID=0;
		int Amount=0;

		// reading keyword 'amount'
		if (!next_word(wrd))
		{
			cout << "Unexpected characters or end of file while loading operator's " << Operators[nof_operators].name << " resources." << endl;
			cout << "Keyword 'amount' expected." << endl;
			return false;
		}	
		if (!strcmp2(wrd,"amount"))
		{
			cout << "Unexpected word: '" << wrd << "' while loading operator's " << Operators[nof_operators].name << " resources." << endl;
			cout << "Keyword 'amount' expected." << endl;
			return false;
		}	
		
		// reading resource name
		if (!next_word(wrd))
		{
			cout << "Unexpected characters or end of file while loading operator's " << Operators[nof_operators].name << " resources." << endl;
			cout << "Resource name or variable expected." << endl;
			return false;
		}

		bool flag=false;
		if (wrd[0]=='?')
		{ 
			int i=1;
			while (i<=ops_nof_parameters && !flag)
				if (strcmp2(wrd, ops_parameters[i]))
					flag=true;
				else
					i++;
					
			if (flag)
				Object_ID=-i;
			else
			{
				cout << "Unknown parameter name while loading operator's " << Operators[nof_operators].name << " effects." << endl;
				return false;
			}
		}	// if (wrd[0]=='?')
		else
		{
			int i=1;
			while (i<=nof_objects && !flag)
				if (strcmp2(wrd, objects[i].name))
					flag=true;
				else
					i++;
			
			if (flag)
				Object_ID=i;
			else
			{
				strcpy(objects[++nof_objects].name, wrd);
				if(display_messages)
					cout << "Object '" << wrd << "' created." << endl;
				Object_ID=nof_objects;					
			}
	
			i=0;
			bool found=false;
			while (i<nof_resources && !found)
				if (resources[i].object_ID==Object_ID)
					found=true;
				else	
					i++;

			if (!found)
			{
				resources[nof_resources++].object_ID=Object_ID;
				if (display_messages)
					cout << "Object " << objects[Object_ID].name << " has been characterized as a resource." << endl;
			}
		}


		if (!next_number(&Amount))
		{
			cout << "Unexpected characters or end of file while loading operator's " << Operators[nof_operators].name << " resources." << endl;
			cout << "Integer expected." << endl;
			return false;
		}	

		if (Resources==NULL)
		{
			Operators[nof_operators].resources=new resource_consumption(Object_ID,Amount);
			Resources=Operators[nof_operators].resources;
		}
		else
		{
			Resources->next=new resource_consumption(Object_ID,Amount);
			Resources=Resources->next;
		}

		ch=next_char();
		if (ch!=')')
		{
			cout << "Unexpected character: '" << ch << "' while loading operator's " << Operators[nof_operators].name << " resources." << endl;
			cout << "Left bracket expected." << endl;
			return false;
		}
		ch=next_char();
	}

	infile.seekg(-1, ios::cur);
	return true;
}


bool	load_predicates()
{
	char ch;
	ch=next_char();
	if (ch!='(')
	{
		cout << "Unexpected character while loading predicates. Left parenthesis expected" << endl;
		return false;
	}
	else 
	{
		bool flag=true;
		while (ch=='(' && flag)
		{
			flag=load_predicate();
			if (!flag)
				return false;
			ch=next_char();
		}
		if (ch!=')')
		{
			cout << "Unexpected character: '" << ch << "'. Left or right parenthesis expected" << endl;
			return false;
		}
	}
	return true;
}

	

bool load_predicate()
{
	int arity=0;
	char ch;
	char wrd[max_sof_words+1];
	char wrd2[max_sof_words+1];
	if (!next_word(wrd))
	{
		cout << "Unexpected characters. Predicate name expected." << endl;
		return false;
	}
	else
	{
		int i;
		for(i=0;i<nof_predicates;i++)
			if (strcmp2(wrd, predicates[i].name))
			{
				cout << "ERROR: Predicate '" << wrd << "' is already loaded" << endl;
				return false;
			}
		while (next_word(wrd2))
			arity++;
		ch=next_char();
		if (ch!=')')
		{
			cout << "Unexpected char: '" << ch << "'. Right parenthesis or predicate argument expected." << endl;
			return false;
		}
		else
		{
		strcpy(predicates[nof_predicates].name, wrd);
		predicates[nof_predicates].arity=arity;
		nof_predicates++;
		if (display_messages)
			cout << "Predicate " << wrd << "/" << arity << " loaded successfully." << endl;
		return true;
		}
	}
}



bool load_constants()
{
	char ch;
	char wrd[max_sof_words+1];
	while (next_word(wrd))
	{
		bool object_exists=false;
		int i=1;
		while (i<=nof_objects && !object_exists)
		{
			if (strcmp2(wrd, objects[i].name))
			{
				object_exists=true;
				if(display_messages)
					cout << "Object " << wrd << " already existed." << endl;
			}
			i++;
		}
		if (!object_exists)
		{
			strcpy(objects[++nof_objects].name, wrd);
			if(display_messages)
				cout << "Object " << wrd << " created." << endl;
		}
	}
	ch=next_char();
	if (ch!=')')
	{
		cout << "ERROR: Unexpected character while loading objects' names." << endl;
		cout << "Object name or right parenthesis expected." << endl;
		return false;
	}
	if (display_messages)
		cout << "Constants loaded successfully." << endl;
	return true;
}



bool 	ignore_list()
{
	char ch;
	int i=1;
	while (infile && i>0)
	{
		infile.get(ch);
		if (ch==';')
			skip_line();
		if (ch== ')' ) i--;
		if (ch== '(' ) i++;
	}
	if (infile || i==0)
		return true;
	else
		return false;
}



bool get_problem_header();
bool load_objects();
bool load_resources();
bool load_initial();
bool load_goal();


bool load_problem()
{
	if (OSystem==1)
		infile.open(problem_file, ios::binary);
	else
		infile.open(problem_file, ios::in);
	char ch;
	char wrd[max_sof_words+1];
	if (!get_problem_header())
	{
		infile.close();
		return false;
	}
	else
	{
		ch=next_char();
		while (ch=='(')
		{
			ch=next_char();
			if (ch!=':')
			{
				cout << "Unexpected character: '" << ch << "'. Double dot (:) expected." << endl;
				infile.close();
				return false;
			}
			if (!next_word(wrd))
			{
				cout << "Unexpected characters. Some keyword expected." << endl ;
				infile.close();
				return false;
			}
			if (strcmp2(wrd,"objects"))
			{
				if (!load_objects())
				{
					infile.close();
					return false;
				}
			}
			else if (strcmp2(wrd,"resources"))
			{
				if (!load_resources())
				{
					infile.close();
					return false;
				}
			}
			else if (strcmp2(wrd,"init"))
			{
				if (!load_initial())
				{
					infile.close();
					return false;
				}
			}
			else if (strcmp2(wrd,"goal"))
			{
				if(!load_goal())
				{
					infile.close();
					return false;
				}
			}
//			else if (strcmp2(wrd,"goal1"))
//			{
//				if(!load_goal(&goal1))
//				{
//					infile.close();
//					return false;
//				}
//			}
			else
			{
				cout << endl << "Unknown keyword: '" << wrd << "'." << endl;
				if (!ignore_list())
				{
					infile.close();
					return false;
				}
			}
		ch=next_char();
		}
		if (ch!=')')
		{
			cout << "Unexpected character: '" << ch << "'. Left or right parenthesis expected" << endl;
			infile.close();
			return false;
		}
	}
	if (display_messages)
		cout << "Problem loaded successfully." << endl << endl;
	infile.close();
	return true;
}



bool get_problem_header()
{
	char ch;
	char wrd[max_sof_words+1];
	ch=next_char();
	if ( ch != '(' )
	{
		cout << "Problem file begins inproperly with character: " << ch << endl;
		cout << "First non-white character must be a left parenthesis" << endl;
		return false;
	}
	if (!next_word(wrd))
	{
		cout << "Unexpected characters. Keyword 'define' expected" << endl;
		return false;
	}
	if (!strcmp2(wrd, "define"))
	{
		cout << "Unexpected keyword: " << wrd << endl;
		cout << "Keyword 'define' expected" << endl;
		return false;
	}
	if(display_messages)
		cout << "Define new problem instance" << endl;
	ch=next_char();
	if (ch!='(')
	{
		cout << "Bad file structure. Left parenthesis expected." << endl;
		return false;
	}
	if (!next_word(wrd))
	{
		cout << "Unexpected characters. Keyword 'problem' expected." << endl;
		return false;
	}
	if (!strcmp2(wrd, "problem"))
	{
		cout << "Unexpected keyword: " << wrd << endl;
		cout << "Keyword 'problem' expected." << endl;
		return false;
	}
	if (!next_word(wrd))
	{
		cout << "Unexpected keyword: " << wrd << endl;
		cout << "Problem name expected." << endl;
		return false;
	}
	if (display_messages)
		cout << "Problem name: " << wrd << endl;
	strcpy(problem_name, wrd);
	
	ch=next_char();
	if (ch!=')')
	{
		cout << "Unexpected character: " << ch << ". Right parenthesis expected." << endl;
		return false;
	}

	ch=next_char();
	if (ch!='(')
	{
		cout << "Unexpected character: " << ch << ". Left parenthesis expected." << endl;
		return false;
	}

	ch=next_char();
	if (ch!=':')
	{
		cout << "Unexpected character: " << ch << ". Double dot (:) expected." << endl;
		return false;
	}

	if (!next_word(wrd))
	{
		cout << "Unexpected characters. Keyword 'define' expected" << endl;
		return false;
	}

	if (!strcmp2(wrd, "domain"))
	{
		cout << "Une xpected keyword: " << wrd << endl;
		cout << "Keyword 'domain' expected" << endl;
		return false;
	}

	if (!next_word(wrd))
	{
		cout << "Unexpected characters. Domain name expected" << endl;
		return false;
	}

	if(display_messages)
		 cout << "Problem's domain name: " << wrd << endl;
	if (!strcmp2(wrd, domain_name))
		cout << "WARNING: Problem's domain name is different from domain name" << endl;

	ch=next_char();
	if (ch!=')')
	{
		cout << "Unexpected character: " << ch << ". Right parenthesis expected." << endl;
		return false;
	}
	return true;
}


bool load_objects()
{
	char ch;
	char wrd[max_sof_words+1];
	while (next_word(wrd))
	{
		bool object_exists=false;
		int i=1;
		while (i<=nof_objects && !object_exists)
		{
			if (strcmp2(wrd, objects[i].name))
			{
				object_exists=true;
				if(display_messages)
					cout << "Object " << wrd << " already existed." << endl;
			}
			i++;
		}
		if (!object_exists)
		{
			strcpy(objects[++nof_objects].name, wrd);
			if(display_messages)
				cout << "Object " << wrd << " created." << endl;
		}
	}
	ch=next_char();
	if (ch!=')')
	{
		cout << "ERROR: Unexpected character while loading objects' names." << endl;
		cout << "Object name or right parenthesis expected." << endl;
		return false;
	}
	return true;
}

bool existing_resource(int Resource);

bool load_resources()
{
	char ch;
	char wrd[max_sof_words+1];
	while (next_word(wrd))
	{
		bool object_exists=false;
		int i=1;
		while (i<=nof_objects && !object_exists)
		{
			if (strcmp2(wrd, objects[i].name))
			{
				object_exists=true;
				if(display_messages)
					cout << "Object " << wrd << " already existed." << endl;
				if (!existing_resource(i))
				{
					resources[nof_resources++].object_ID=i;
				}
			}
			i++;
		}
		if (!object_exists)
		{
			strcpy(objects[++nof_objects].name, wrd);
			resources[nof_resources++].object_ID=nof_objects;
			if(display_messages)
				cout << "Resource object " << wrd << " created." << endl;
		}
	}
	ch=next_char();
	if (ch!=')')
	{
		cout << "ERROR: Unexpected character while loading resource objects' names." << endl;
		cout << "Resource name or right bracket expected." << endl;
		return false;
	}

	int i;
	for (i=0;i<nof_resources;i++)
		objects[resources[i].object_ID].resource=i;

	return true;
}


bool load_initial()
{
	char ch;
	char wrd[max_sof_words+1];
	initial2=new state();
	initial2->nullify();
	ch=next_char();
	while (ch=='(')
	{
		fact f;
		f=fact();
		if (!next_word(wrd))
		{
			cout << "ERROR: Unexpected characters while loading initial state." << endl;
			cout << "Predicata name expected." << endl;
			initial2->nullify();
			return false;
		}


		if (strcmp2(wrd,"amount"))
		{
			if (!next_word(wrd))
			{
				cout << "ERROR: Unexpected characters while loading initial state." << endl;
				cout << "Resource name expected." << endl;
				initial2->nullify();
				return false;
			}

			int r;
			r=R(wrd);
			if (r<0)
			{
				cout << "Wrong resource name: '"<< wrd << "', while loading initial state."<< endl;
				initial2->nullify();
				return false;
			}
			
			int amount;
			if (!next_number(&amount))
			{
				cout << "Cannot read resource amount, while loading initial state."<< endl;
				initial2->nullify();
				return false;
			}
			initial2->resource_vector[r]=amount;

			ch=next_char();
			if (ch!=')')
			{
				cout << "Unexpected character '" << ch << "', while loading initial state." << endl;
				cout << "Right brucket expected." << endl;
				initial2->nullify();
				return false;
			}
		}
		else	//	if (strcmp2(wrd,"amount")
		{
			f.pred=P(wrd);
			if (f.pred<0)
			{
				cout << "ERROR: Unknown predicate name, '" << wrd << "', while loading initial state." << endl;
				initial2->nullify();
				return false;
			}
		
			int nof_args=0;
			while (next_word(wrd))
			{
				f.arguments[nof_args]=O(wrd);
				if (f.arguments[nof_args]==0)
				{
					cout << "ERROR: Unknown object name, '" << wrd << "', while loading initial state." << endl;
					initial2->nullify();
					return false;
				}
				nof_args++;
			}
			ch=next_char();
			if (ch!=')')
			{
				cout << "ERROR: Unexpected character: '" << ch << "', while loading initial state." << endl;
				cout << "Predicate's argument or right parenthesis expected." << endl;
				initial2->nullify();
				return false;
			}

			if (nof_args!=predicates[f.pred].arity)
			{
				cout << "ERROR: Invalid number of arguments for predicate " << predicates[f.pred].name << "/";
				cout << predicates[f.pred].arity << ", while loading initial state." << endl;
				initial2->nullify();
				return false;
			}
			initial2->add_fact(f);
		}
		ch=next_char();
	}

	if (ch!=')')
	{
		cout << "ERROR: Unexpected character while loading initial state." << endl;
		cout << "Left or right parenthesis expected." << endl;
		initial2->nullify();
		return false;
	}  
	detect_constant_predicates();
	initial=new state();
	initial->nullify();
	nof_constants=0;

	int i;
	for(i=0;i<initial2->size;i++)
		if (constant_predicates[initial2->facts[i].pred])
			constants[nof_constants++]=initial2->facts[i];
		else
			initial->add_fact(initial2->facts[i]);
	
	for(i=0;i<nof_resources;i++)
		if (initial2->resource_vector[i]<0)
		{
			cout << "Initial state does not provide information for the initial amount of resource '" << objects[resources[i].object_ID].name << "'." << endl;
			initial2->nullify();
			initial->nullify();
			return false;
		}
		else
			initial->resource_vector[i]=initial2->resource_vector[i];

	if(display_messages)
	{
		cout << "Initial state: " << *initial2 << endl;
		cout << "Reduced Initial state: " << *initial << endl;
		cout << "Initial state loaded successfully." << endl;
	}
	return true;
}


bool load_goal()
{
	char ch;
	char wrd[max_sof_words+1];
	goal=new state();
	goal->nullify();


	ch=next_char();
	if (ch!='(')
	{
		cout << "ERROR: Unexpected character: '" << ch << "'. Left parenthesis expected." << endl;
		goal->nullify();
		return false;
	}


	if (!next_word(wrd))
	{
		cout << "ERROR: Unexpected characters while loading goals. Keyword 'and' expected." << endl;
		goal->nullify();
		return false;
	}

	if (!strcmp2(wrd, "and"))
	{
		fact f;
		f=fact();
		f.pred=P(wrd);
		if (f.pred<0)
		{
			cout << "ERROR: Unknown predicate name, '" << wrd << "', while loading goals." << endl;
			goal->nullify();
			return false;
		}
	
		int nof_args=0;
		while (next_word(wrd))
		{
			f.arguments[nof_args]=O(wrd);
			if (f.arguments[nof_args]==0)
			{
				cout << "ERROR: Unknown object name, '" << wrd << "', while loading goals." << endl;
				goal->nullify();
				return false;
			}
			nof_args++;
		}
		ch=next_char();
		if (ch!=')')
		{
			cout << "ERROR: Unexpected character: '" << ch << "', while loading goals." << endl;
			cout << "Predicate's argument or right parenthesis expected." << endl;
			goal->nullify();
			return false;
		}
			if (nof_args!=predicates[f.pred].arity)
		{
			cout << "ERROR: Invalid number of arguments for predicate " << predicates[f.pred].name << "/";
			cout << predicates[f.pred].arity << ", while loading goals." << endl;
			goal->nullify();
			return false;
		}
		goal->add_fact(f);
	}
	else	// if (!strcmp2(wrd, "and"))
	{
		ch=next_char();
		while (ch=='(')
		{
			fact f;
			f=fact();
			if (!next_word(wrd))
			{
				cout << "ERROR: Unexpected characters while loading goals." << endl;
				cout << "Predicata name expected." << endl;
				goal->nullify();
				return false;
			}
			f.pred=P(wrd);
			if (f.pred<0)
			{
				cout << "ERROR: Unknown predicate name, '" << wrd << "', while loading goals." << endl;
				goal->nullify();
				return false;
			}
		
			int nof_args=0;
			while (next_word(wrd))
			{
				f.arguments[nof_args]=O(wrd);
				if (f.arguments[nof_args]==0)
				{
					cout << "ERROR: Unknown object name, '" << wrd << "', while loading goals." << endl;
					goal->nullify();
					return false;
				}
				nof_args++;
			}
			ch=next_char();
			if (ch!=')')
			{
				cout << "ERROR: Unexpected character: '" << ch << "', while loading goals." << endl;
				cout << "Predicate's argument or right parenthesis expected." << endl;
				goal->nullify();
				return false;
			}

			if (nof_args!=predicates[f.pred].arity)
			{
				cout << "ERROR: Invalid number of arguments for predicate " << predicates[f.pred].name << "/";
				cout << predicates[f.pred].arity << ", while loading goals." << endl;
				goal->nullify();
				return false;
			}
			goal->add_fact(f);
			ch=next_char();
		}	// while ...

		if (ch!=')')
		{
			cout << "ERROR: Unexpected character while loading goals." << endl;
			cout << "Left or right parenthesis expected." << endl;
			goal->nullify();
			return false;
		}
	}	// if (!strcmp2(wrd, "and"))
	
	
	
	ch=next_char();
	if (ch!=')')
	{
		cout << "ERROR: Unexpected character while loading goals." << endl;
		cout << "Left parenthesis expected." << endl;
		goal->nullify();
		return false;
	}
	if(display_messages)
	{
		cout << "Goals: " << *goal << endl;
		cout << "Goals loaded successfully." << endl;
	}
	return true;
}

void	detect_constant_predicates()
{
	int i;
	for(i=0;i<max_nof_predicates;i++)
		constant_predicates[i]=true;
	for(i=0;i<nof_operators;i++)
	{
		int j;
		for(j=0;j<Operators[i].sof_lists[delete_list];j++)
			constant_predicates[Operators[i].strips[delete_list][j].pred]=false;
		for(j=0;j<Operators[i].sof_lists[add_list];j++)
			constant_predicates[Operators[i].strips[add_list][j].pred]=false;
	}
}


bool existing_resource(int Resource)
{
	int i;
	for(i=1;i<=nof_resources;i++)
		if (resources[i].object_ID=Resource)
			return true;
	return false;
}
