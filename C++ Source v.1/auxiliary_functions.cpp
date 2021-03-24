#include "planner.h"


// Function same_char() checks if two chars are "case-insensitive" equals
bool same_char(char c1, char c2)
{
	if (c1==c2)
		return true;
	if (c1>='A' && c1<='Z' && c2==c1+32)
		return true;
	if (c2>='A' && c2<='Z' && c1==c2+32)
		return true;
	return false;
}

// Function 'strcomp' compares two strings, 's1' and 's2', which must have maximum size 'length'.
// It returns 'true' if the strings are equal, otherwise it returns 'false'.
bool strcomp(char s1[], char s2[], unsigned int length)
{
	if (strlen(s1)==strlen(s2) && strlen(s1)<=length)
	{
		unsigned int i;
		for(i=0;i<strlen(s1);i++) if (!same_char(s1[i],s2[i])) return false;
		return true;
	}
	else
		return false;
};



// Function strcmp2() checks if two strings are "case-insensitive" equals
bool strcmp2(char s1[], char s2[])
{
	int i=0;
	do
	{
		if (s1[i]==0 && s2[i]==0)
			return true;
		if (!same_char(s1[i], s2[i]))
			return false;
		i++;
	}
	while (i<=255);
	return false;
}

// Function 'O' takes string 'name' for input and returns an integer that indicates the 
// number of the object with the string as name. If there is no object with this name, 
// the function returns 0.

int O(char name[])
{
	if (strlen(name)>sof_object_name)
	{
		cout << "ERROR: Size of object name '" << name << "' exceeds " << sof_object_name << endl;
		return 0;
	}
	else
	{
		int i;
		for(i=1;i<=nof_objects;i++)
			if (strcomp(name, objects[i], sof_object_name))
				return i;
		// cout << "ERROR: There is no object with name '" << name <<"'." << endl; 
		return 0;
	}
};


// Function 'P' takes string 'name' for input and returns an integer that indicates the 
// number of the predicate with the string as name. If there is no predicate with this name, 
// the function returns -1.
int P(char name[])
{
	if (strlen(name)>sof_predicate_name)
	{
		cout << "ERROR: Size of predicate name '" << name << "' exceeds " << sof_predicate_name << endl;
		return -1;
	}
	else
	{
		int i;
		for(i=0;i<=nof_predicates;i++)
			if (strcomp(name, predicates[i].name, sof_predicate_name))
				return i;
		cout << "ERROR: There is no predicate with name '" << name <<"'." << endl; 
		return -1;
	}
};

// this function checks whether 
bool instantiable_with_list(fact f, int sof_list, fact list_of_facts[])
{
	int i;
	for(i=0;i<sof_list;i++)
		if (list_of_facts[i].instantiable(f))
			return true;
	return false;
}

bool output_file_provided=false;

bool process_command_line(int argc, char* argv[])
{
	if (argc==0)
	{
		cout << "Command line syntax:" << endl;
		cout << "Program -d domain_file -p problem_file" << endl;
		return false;
	}
/*
	if (argc==2*int(argc/2))
	{
		cout << "ERROR: Bad number of arguments." << endl;
		cout << "Arguments must be an even number." << endl;
		return false;
	}
*/


	bool domain_file_provided=false;
	bool problem_file_provided=false;
	
	int i;	
	i=1;
	while (i<argc)
	{
		if (strcmp2(argv[i],"echo"))
		{
			display_messages=true;
			cout << "Echo on" << endl;
			i++;
		}
		else if (strcmp2(argv[i],"-r"))
		{
			reduced_enriched=true;
			i++;
		}

		else if (strcmp2(argv[i],"-d"))
		{
			if (i==argc-1)
			{
				cout << "Missing domain file name." << endl;
				return false;
			}
			strcpy(domain_file, argv[i+1]);
			domain_file_provided=true;
			i=i+2;
		}
		else if (strcmp2(argv[i],"-p"))
		{
			if (i==argc-1)
			{
				cout << "Missing problem file name." << endl;
				return false;
			}
			strcpy(problem_file, argv[i+1]);
			problem_file_provided=true;
			i=i+2;
		}
		else if (strcmp2(argv[i],"-o"))
		{
			if (i==argc-1)
			{
				cout << "Missing output file name." << endl;
				return false;
			}
			strcpy(output_file, argv[i+1]);
			output_file_provided=true;
			i=i+2;
		}
		else
		{
			cout << "ERROR - Bad argument: " << argv[i] << endl;
			return false;
		}

	}

	if (!domain_file_provided)
	{
		cout << "Syntax: grt -d domain_file -p probem_file [-o output_file]" << endl;
		return false;
	}

	if (!problem_file_provided)
	{
		cout << "Syntax: grt -d domain_file -p probem_file [-o output_file[" << endl;
		return false;
	}


	if (display_messages)
	{
		for(i=1;i<argc;i++)
			cout<< argv[i]<< endl;
	}

	return true;
}

void check_time()
{
	clock_t t;
	long double ft;
	t=clock();
	ft=(long double) t/CLOCKS_PER_SEC;
	if (ft>MAX_TIME*60)
	{
		cout << "Time limit: " << MAX_TIME << " minutes." << endl;
		cout << "Elapsed time: " << ft << " secs." << endl;
		cout << "Execution aborted." << endl;
		abort();
	}
}