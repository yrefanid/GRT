#include "planner.h"

#define max_sof_words 80 

//#define domain_file "Domains\\blocks-strips.pddl"
//#define problem_file "Domains\\bw-large-a.pddl"
//#define problem_file "Domains\\blocks4.pddl"

#define domain_file "Domains\\AIPS-98\\Logistics\\logistics-strips.pddl"
#define problem_file "Domains\\AIPS-98\\Logistics\\prob23.pddl"
//#define problem_file "Domains\\log-c.pddl"

//#define domain_file "Domains\\rocket-strips.pddl"
//#define problem_file "Domains\\rocket-b.pddl"


//#define domain_file "Domains\\AIPS-98\\Movie\\movie-strips-n.pddl"
//#define problem_file "Domains\\AIPS-98\\Movie\\prob20.pddl"

//#define domain_file "Domains\\AIPS-98\\Gripper\\gripper-strips.pddl"
//#define problem_file "Domains\\AIPS-98\\Gripper\\prob05.pddl"

//#define domain_file "Domains\\Kautz\\domain.pddl"
//#define problem_file "Domains\\Kautz\\prob028.pddl"


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

state initial2;

void detect_constant_predicates();

ifstream infile;

char domain_name[max_sof_words+1];
char problem_name[max_sof_words+1];

bool get_domain_header();

bool load_domain()
{
	infile.open(domain_file, ios::binary);
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
		cout << "Domain file begins inproperly with character: " << ch << endl;
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
		cout << "Domain name: " << wrd << endl;
		strcpy(domain_name, wrd);
		ch=next_char();
		if (ch==')')
		{
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



bool load_requirements()
{
	cout << "Requirements loaded" << endl; 
	bool flag=ignore_list();
	return flag;
}



bool load_types()
{
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

bool	load_operator()
{
	char ch;
	char wrd[max_sof_words+1];
	if (!next_word(wrd))
	{
		cout << "Unexpected characters. Action name expected." << endl;
		return false;
	}

	strcpy(Operators0[nof_operators0].name, wrd);
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
			cout << "Invalid parameter name: '" << wrd <<"' while loading operator " << Operators0[nof_operators0].name << endl;
			cout << "Parameter names must begin with a question mark ('?')." << endl;
			return false;
		}
		strcpy(ops_parameters[++ops_nof_parameters], wrd);
	}
	Operators0[nof_operators0].nof_parameters=ops_nof_parameters;

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
		else
		{
			cout << endl << "Unknown keyword: '" << wrd << "' while loading operator " << Operators0[nof_operators0].name << "." << endl;
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
		cout << "Operator " << Operators0[nof_operators0++].name << " loaded successfully." << endl;
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
		cout << "Unexpected characters while loading operator's " << Operators0[nof_operators0].name << " preconditions." << endl;
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
				cout << "Unexpected characters while loading operator's " << Operators0[nof_operators0].name << " preconditions' predicate name." << endl;
				return false;
			}

			int pred_id=P(wrd);
			if (pred_id<0)
			{
				cout << "Unknown predicate name '" << wrd << "', while loading operator's " << Operators0[nof_operators0].name << " preconditions." << endl;
				return false;
			}

			Operators0[nof_operators0].strips[prec_list][nof_precs].pred=pred_id;

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
						cout << "Unknown parameter name, '" << wrd << "', " << endl << "while loading operator's " << Operators0[nof_operators0].name << " preconditions." << endl;
						return false;
					}
					Operators0[nof_operators0].strips[prec_list][nof_precs].arguments[nof_args]=-i;
				}
				else
				{
					int i=1;
					while (i<=nof_objects && !flag)
						if (strcmp2(wrd, objects[i]))
							flag=true;
						else
							i++;
					if (flag)
						Operators0[nof_operators0].strips[prec_list][nof_precs].arguments[nof_args]=i;
					else 
					{
						strcpy(objects[++nof_objects], wrd);
						cout << "Object '" << wrd << "' created."<< endl;
						Operators0[nof_operators0].strips[prec_list][nof_precs].arguments[nof_args]=nof_objects;
					}
				}
				nof_args++;
			}
			ch=next_char();
			if (ch!=')')
			{
				cout << "Unexpected character: '" << ch << "', while loading operator's " << Operators0[nof_operators0].name << " preconditions' parameters." << endl;
				cout << "Right parenthesis or parameter name expected." << endl;
				return false;
			}

			if (nof_args!=predicates[pred_id].arity)
			{
				cout << "ERROR: Invalid number of arguments for predicate '" << predicates[pred_id].name << "'," << endl;
				cout << "while loading operator's " << Operators0[nof_operators0].name << " preconditions." << endl;
				return false;
			}
			ch=next_char();
			nof_precs++;
		}
	
		if (ch!=')')
		{
			cout << "Unexpected character: " << ch << " while loading operator's " << Operators0[nof_operators0].name << " preconditions." << endl;
			cout << "Left of right parenthesis expected." << endl;
			return false;
		}	
		Operators0[nof_operators0].sof_lists[prec_list]=nof_precs;
	}	// if (strcmp2(wrd, "and"))
	else
	{
		int pred_id=P(wrd);
		if (pred_id<0)
		{
			cout << "Unknown predicate name '" << wrd << "', while loading operator's " << Operators0[nof_operators0].name << " preconditions." << endl;
			return false;
		}

		Operators0[nof_operators0].strips[prec_list][0].pred=pred_id;

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
					cout << "Unknown parameter name, '" << wrd << "', " << endl << "while loading operator's " << Operators0[nof_operators0].name << " preconditions." << endl;
					return false;
				}
				Operators0[nof_operators0].strips[prec_list][0].arguments[nof_args]=-i;
			}
			else
			{
				int i=1;
				while (i<=nof_objects && !flag)
					if (strcmp2(wrd, objects[i]))
						flag=true;
					else
						i++;
				if (flag)
					Operators0[nof_operators0].strips[prec_list][0].arguments[nof_args]=i;
				else 
				{
					strcpy(objects[++nof_objects], wrd);
					cout << "Object '" << wrd << "' created."<< endl;
					Operators0[nof_operators0].strips[prec_list][0].arguments[nof_args]=nof_objects;
				}
			}
			nof_args++;
		}
		ch=next_char();
		if (ch!=')')
		{
			cout << "Unexpected character: '" << ch << "', while loading operator's " << Operators0[nof_operators0].name << " preconditions' parameters." << endl;
			cout << "Right parenthesis or parameter name expected." << endl;
			return false;
		}

		if (nof_args!=predicates[pred_id].arity)
		{
			cout << "ERROR: Invalid number of arguments for predicate '" << predicates[pred_id].name << "'," << endl;
			cout << "while loading operator's " << Operators0[nof_operators0].name << " preconditions." << endl;
			return false;
		}
			Operators0[nof_operators0].sof_lists[prec_list]=1;
	}	// if (strcmp2(wrd, "and"))


	// Re-Order preconditions

	for(int i1=0;i1<Operators0[nof_operators0].sof_lists[prec_list]-2;i1++)
		for(int i2=Operators0[nof_operators0].sof_lists[prec_list]-2;i2>=i1;i2--)
			if (predicates[Operators0[nof_operators0].strips[prec_list][i2].pred].arity<
				predicates[Operators0[nof_operators0].strips[prec_list][i2+1].pred].arity)
			{
				fact f;
				f=Operators0[nof_operators0].strips[prec_list][i2];
				Operators0[nof_operators0].strips[prec_list][i2]=Operators0[nof_operators0].strips[prec_list][i2+1];
				Operators0[nof_operators0].strips[prec_list][i2+1]=f;
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
		cout << "Unexpected characters while loading operator's " << Operators0[nof_operators0].name << " effects." << endl;
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
				cout << "Unexpected characters while loading operator's " << Operators0[nof_operators0].name << " effects' predicate name." << endl;
				return false;
			}

			if (!strcmp2(wrd, "not"))
			{
				int pred_id=P(wrd);
				if (pred_id<0)
				{
					cout << "Unknown predicate name '" << wrd << "', while loading operator's " << Operators0[nof_operators0].name << " effects." << endl;
					return false;
				}
				Operators0[nof_operators0].strips[add_list][nof_adds].pred=pred_id;

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
							Operators0[nof_operators0].strips[add_list][nof_adds].arguments[nof_args]=-i;
						else
						{
							cout << "Unknown parameter name while loading operator's " << Operators0[nof_operators0].name << " effects." << endl;
							return false;
						}
					}
					else
					{
						int i=1;
						while (i<=nof_objects && !flag)
							if (strcmp2(wrd, objects[i]))
								flag=true;
							else
								i++;
						if (flag)
							Operators0[nof_operators0].strips[add_list][nof_adds].arguments[nof_args]=i;
						else
						{
							strcpy(objects[++nof_objects], wrd);
							cout << "Object '" << wrd << "' created." << endl;
							Operators0[nof_operators0].strips[add_list][nof_adds].arguments[nof_args]=nof_objects;
						}
					}
					nof_args++;
				}
				nof_adds++;
			
				ch=next_char();
				if (ch!=')')
				{
					cout << "Unexpected character: '" << ch << "', while loading operator's " << Operators0[nof_operators0].name << " effects' parameters." << endl;
					cout << "Right parenthesis or parameter name expected." << endl;
					return false;
				}
				if (nof_args!=predicates[pred_id].arity)
				{
					cout << "ERROR: Invalid number of arguments for predicate '" << predicates[pred_id].name << "'," << endl;
					cout << "while loading operator's " << Operators0[nof_operators0].name << " effects." << endl;
					return false;
				}
			}
			else //(!strcmp2(wrd, "not"))
			{
				ch=next_char();
				if (ch!='(')
				{
					cout << "Unexpected character: '" << ch << "' while loading operator's " << Operators0[nof_operators0].name << " effects." << endl;
					cout <<	"Left parenthesis expected." << endl;
					return false;
				}
				if (!next_word(wrd))
				{
					cout << "Unexpected characters while loading operator's " << Operators0[nof_operators0].name << " effects. Predicate name expected." << endl;
					return false;
				}
				int pred_id=P(wrd);
				if (pred_id<0)
				{
					cout << "Unknown predicate name '" << wrd << "', while loading operator's " << Operators0[nof_operators0].name << " effects." << endl;
					return false;
				}
				Operators0[nof_operators0].strips[delete_list][nof_dels].pred=pred_id;

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
							Operators0[nof_operators0].strips[delete_list][nof_dels].arguments[nof_args]=-i;
						else
						{
							cout << "Unknown parameter name while loading operator's " << Operators0[nof_operators0].name << " effects." << endl;
							return false;
						}
					}
					else
					{
						int i=1;
						while (i<=nof_objects && !flag)
							if (strcmp2(wrd, objects[i]))
								flag=true;
							else
								i++;
						if (flag)
							Operators0[nof_operators0].strips[delete_list][nof_dels].arguments[nof_args]=i;
						else
						{
							strcpy(objects[++nof_objects], wrd);
							cout << "Object '" << wrd << "' created." << endl;
							Operators0[nof_operators0].strips[delete_list][nof_dels].arguments[nof_args]=nof_objects;					
						}
				}
					nof_args++;
				}
				nof_dels++;
			
				ch=next_char();
				if (ch!=')')
				{
					cout << "Unexpected character: '" << ch << "', while loading operator's " << Operators0[nof_operators0].name << " effects' parameters." << endl;
					cout << "Right parenthesis or parameter name expected." << endl;
					return false;
				}
				if (nof_args!=predicates[pred_id].arity)
				{
					cout << "ERROR: Invalid number of arguments for predicate '" << predicates[pred_id].name << "'," << endl;
					cout << "while loading operator's " << Operators0[nof_operators0].name << " effects." << endl;
					return false;
				}
				ch=next_char();
				if (ch!=')')
				{
					cout << "Unexpected character: '" << ch << "', while loading operator's " << Operators0[nof_operators0].name << " effects' parameters." << endl;
					cout << "Right parenthesis expected." << endl;
					return false;
				}
			}
			ch=next_char();
		}

		if (ch!=')')
		{
			cout << "Unexpected character: " << ch << " while loading operator's " << Operators0[nof_operators0].name << " effects." << endl;
			cout << "Left of right parenthesis expected." << endl;
			return false;
		}	
	
		Operators0[nof_operators0].sof_lists[add_list]=nof_adds;
		Operators0[nof_operators0].sof_lists[delete_list]=nof_dels;
	
	}	// 	if (strcmp2(wrd, "and"))
	
	else
	
	{
		if (!strcmp2(wrd, "not"))
		{
			int pred_id=P(wrd);
			if (pred_id<0)
			{
				cout << "Unknown predicate name '" << wrd << "', while loading operator's " << Operators0[nof_operators0].name << " effects." << endl;
				return false;
			}
			Operators0[nof_operators0].strips[add_list][0].pred=pred_id;

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
						Operators0[nof_operators0].strips[add_list][0].arguments[nof_args]=-i;
					else
					{
						cout << "Unknown parameter name while loading operator's " << Operators0[nof_operators0].name << " effects." << endl;
						return false;
					}
				}
				else
				{
					int i=1;
					while (i<=nof_objects && !flag)
						if (strcmp2(wrd, objects[i]))
							flag=true;
						else
							i++;
					if (flag)
						Operators0[nof_operators0].strips[add_list][0].arguments[nof_args]=i;
					else
					{
						strcpy(objects[++nof_objects], wrd);
						cout << "Object '" << wrd << "' created." << endl;
						Operators0[nof_operators0].strips[add_list][0].arguments[nof_args]=nof_objects;
					}
				}
				nof_args++;
			}
					
			ch=next_char();
			if (ch!=')')
			{
				cout << "Unexpected character: '" << ch << "', while loading operator's " << Operators0[nof_operators0].name << " effects' parameters." << endl;
				cout << "Right parenthesis or parameter name expected." << endl;
				return false;
			}
			
			if (nof_args!=predicates[pred_id].arity)
			{
				cout << "ERROR: Invalid number of arguments for predicate '" << predicates[pred_id].name << "'," << endl;
				cout << "while loading operator's " << Operators0[nof_operators0].name << " effects." << endl;
				return false;
			}
			Operators0[nof_operators0].sof_lists[add_list]=1;
			Operators0[nof_operators0].sof_lists[delete_list]=0;

		}
		else //(!strcmp2(wrd, "not"))
		{
			ch=next_char();
			if (ch!='(')
			{
				cout << "Unexpected character: '" << ch << "' while loading operator's " << Operators0[nof_operators0].name << " effects." << endl;
				cout <<	"Left parenthesis expected." << endl;
				return false;
			}
			if (!next_word(wrd))
			{
				cout << "Unexpected characters while loading operator's " << Operators0[nof_operators0].name << " effects. Predicate name expected." << endl;
				return false;
			}
			int pred_id=P(wrd);
			if (pred_id<0)
			{
				cout << "Unknown predicate name '" << wrd << "', while loading operator's " << Operators0[nof_operators0].name << " effects." << endl;
				return false;
			}
			Operators0[nof_operators0].strips[delete_list][0].pred=pred_id;

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
						Operators0[nof_operators0].strips[delete_list][0].arguments[nof_args]=-i;
					else
					{
						cout << "Unknown parameter name while loading operator's " << Operators0[nof_operators0].name << " effects." << endl;
						return false;
					}
				}
				else
				{
					int i=1;
					while (i<=nof_objects && !flag)
						if (strcmp2(wrd, objects[i]))
							flag=true;
						else
							i++;
					if (flag)
						Operators0[nof_operators0].strips[delete_list][0].arguments[nof_args]=i;
					else
					{
						strcpy(objects[++nof_objects], wrd);
						cout << "Object '" << wrd << "' created." << endl;
						Operators0[nof_operators0].strips[delete_list][0].arguments[nof_args]=nof_objects;					
					}
			}
				nof_args++;
			}
					
			ch=next_char();
			if (ch!=')')
			{
				cout << "Unexpected character: '" << ch << "', while loading operator's " << Operators0[nof_operators0].name << " effects' parameters." << endl;
				cout << "Right parenthesis or parameter name expected." << endl;
				return false;
			}
			if (nof_args!=predicates[pred_id].arity)
			{
				cout << "ERROR: Invalid number of arguments for predicate '" << predicates[pred_id].name << "'," << endl;
				cout << "while loading operator's " << Operators0[nof_operators0].name << " effects." << endl;
				return false;
			}
			ch=next_char();
			if (ch!=')')
			{
				cout << "Unexpected character: '" << ch << "', while loading operator's " << Operators0[nof_operators0].name << " effects' parameters." << endl;
				cout << "Right parenthesis expected." << endl;
				return false;
			}
			Operators0[nof_operators0].sof_lists[add_list]=0;
			Operators0[nof_operators0].sof_lists[delete_list]=1;

		}

		if (ch!=')')
		{
			cout << "Unexpected character: " << ch << " while loading operator's " << Operators0[nof_operators0].name << " effects." << endl;
			cout << "Left of right parenthesis expected." << endl;
			return false;
		}	
	
	}

	// cout << "Effects loaded successfully." << endl;
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
		cout << "Predicate " << wrd << "/" << arity << " loaded successfully." << endl;
		return true;
		}
	}
}



bool load_constants()
{
	cout << endl << "Constants loaded" << endl ;
	bool flag=ignore_list();
	return flag;
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
bool load_initial();
bool load_goal(state*);


bool load_problem()
{
	infile.open(problem_file, ios::binary);
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
				if(!load_goal(&goal))
				{
					infile.close();
					return false;
				}
			}
			else if (strcmp2(wrd,"goal1"))
			{
				if(!load_goal(&goal1))
				{
					infile.close();
					return false;
				}
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
			if (strcmp2(wrd, objects[i]))
			{
				object_exists=true;
				cout << "Object " << wrd << " already existed." << endl;
			}
			i++;
		}
		if (!object_exists)
		{
			strcpy(objects[++nof_objects], wrd);
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


bool load_initial()
{
	char ch;
	char wrd[max_sof_words+1];
	
	initial2.nullify();
	ch=next_char();
	while (ch=='(')
	{
		fact f;
		f=fact();
		if (!next_word(wrd))
		{
			cout << "ERROR: Unexpected characters while loading initial state." << endl;
			cout << "Predicata name expected." << endl;
			initial2.nullify();
			return false;
		}
		f.pred=P(wrd);
		if (f.pred<0)
		{
			cout << "ERROR: Unknown predicate name, '" << wrd << "', while loading initial state." << endl;
			initial2.nullify();
			return false;
		}
		
		int nof_args=0;
		while (next_word(wrd))
		{
			f.arguments[nof_args]=O(wrd);
			if (f.arguments[nof_args]==0)
			{
				cout << "ERROR: Unknown object name, '" << wrd << "', while loading initial state." << endl;
				initial2.nullify();
				return false;
			}
			nof_args++;
		}
		ch=next_char();
		if (ch!=')')
		{
			cout << "ERROR: Unexpected character: '" << ch << "', while loading initial state." << endl;
			cout << "Predicate's argument or right parenthesis expected." << endl;
			initial2.nullify();
			return false;
		}

		if (nof_args!=predicates[f.pred].arity)
		{
			cout << "ERROR: Invalid number of arguments for predicate " << predicates[f.pred].name << "/";
			cout << predicates[f.pred].arity << ", while loading initial state." << endl;
			initial2.nullify();
			return false;
		}
		initial2.add_fact(f);
		ch=next_char();
	}

	if (ch!=')')
	{
		cout << "ERROR: Unexpected character while loading initial state." << endl;
		cout << "Left or right parenthesis expected." << endl;
		initial2.nullify();
		return false;
	}  
	detect_constant_predicates();
	initial.nullify();
	nof_constants=0;
	int i;
	for(i=0;i<initial2.size;i++)
		if (constant_predicates[initial2.facts[i].pred])
			constants[nof_constants++]=initial2.facts[i];
		else
			initial.add_fact(initial2.facts[i]);
	cout << "Initial state: " << initial2 << endl;
	cout << "Reduced Initial state: " << initial << endl;
	cout << "Initial state loaded successfully." << endl;
	return true;
}


bool load_goal(state* goal)
{
	char ch;
	char wrd[max_sof_words+1];
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
		cout << "ERROR: Unexpected keyword: '" << wrd << "'. while loading goals. Keyword 'and' expected." << endl;
		goal->nullify();
		return false;
	}

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
	}

	if (ch!=')')
	{
		cout << "ERROR: Unexpected character while loading goals." << endl;
		cout << "Left or right parenthesis expected." << endl;
		goal->nullify();
		return false;
	}
	
	ch=next_char();
	if (ch!=')')
	{
		cout << "ERROR: Unexpected character while loading goals." << endl;
		cout << "Left parenthesis expected." << endl;
		goal->nullify();
		return false;
	}

	cout << "Goals: " << *goal << endl;
	cout << "Goals loaded successfully." << endl;
	return true;
}

void	detect_constant_predicates()
{
	int i;
	for(i=0;i<max_nof_predicates;i++)
		constant_predicates[i]=true;
	for(i=0;i<nof_operators0;i++)
	{
		int j;
		for(j=0;j<Operators0[i].sof_lists[delete_list];j++)
			constant_predicates[Operators0[i].strips[delete_list][j].pred]=false;
		for(j=0;j<Operators0[i].sof_lists[add_list];j++)
			constant_predicates[Operators0[i].strips[add_list][j].pred]=false;
	}
}

bool possible_first_argument(int OP, int OBJ);
void create_first_instantiated_operator(int OP, int OBJ);

void copy_operators()
{
	int i;
	int j;
	for(i=0;i<nof_operators0;i++)
		for(j=1;j<=nof_objects;j++)
			if (possible_first_argument(i,j))
				create_first_instantiated_operator(i,j);
}


bool possible_first_argument(int OP, int OBJ)
{
	int i=0;
	bool ret=true;
	while (i<Operators0[OP].sof_lists[prec_list] && ret)
	{
		if (constant_predicates[Operators0[OP].strips[prec_list][i].pred]
			&& Operators0[OP].strips[prec_list][i].arguments[0]==-1)
		{
			ret=false;
			int j=0;
			while (j<nof_constants && !ret)
			{
				if (constants[j].pred==Operators0[OP].strips[prec_list][i].pred
					&& constants[j].arguments[0]==OBJ)
					ret=true;
				j++;
			}
		}
		i++;
	}
	return ret;
}

void create_first_instantiated_operator(int OP, int OBJ)
{
	Operators[nof_operators]=Operators0[OP];
	strcat(Operators[nof_operators].name, objects[OBJ]);
	int i;
	int j;
	int k;
	for(i=0;i<3;i++)
		for(j=0;j<Operators[nof_operators].sof_lists[i];j++)
			for(k=0;k<predicates[Operators[nof_operators].strips[i][j].pred].arity;k++)
				if (Operators[nof_operators].strips[i][j].arguments[k] == -1)
					Operators[nof_operators].strips[i][j].arguments[k] = OBJ;
				else if (Operators[nof_operators].strips[i][j].arguments[k] <-1)
					Operators[nof_operators].strips[i][j].arguments[k] ++;
	Operators[nof_operators].nof_parameters--;
	nof_operators++;
}
