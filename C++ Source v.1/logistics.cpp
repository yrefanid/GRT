#include <planner.h>

bool is_a_package(int);
bool is_an_airplane(int);
bool is_a_truck(int);
bool included_within_the_goals(int);
bool same_city(int, int );
bool foreign_airport(int, int);

int get_location_city(int);

int get_current_location(state*, int);
int get_goal_location(int);


int state_grade2(state* s)
{
//	cout << "Current state:" << *s << endl;
	int score=0;
	int i;
	for (i=0;i<s->size;i++)
	{
//		cout << "Current fact: " << s->facts[i] << endl;
		if (s->facts[i].pred==pred_at)
		{
			if (is_a_package(s->facts[i].arguments[0]))
			{
				if (included_within_the_goals(s->facts[i].arguments[0]))
				{
					int goal_loc=get_goal_location(s->facts[i].arguments[0]);
					if (s->facts[i].arguments[1]==goal_loc)
						score=score;
					else if (same_city(s->facts[i].arguments[1],goal_loc))
						score=score+3;
					else if (foreign_airport(s->facts[i].arguments[1],goal_loc))
						score=score+6;
					else 
						score=score+9;
				}
			}
		}
		else if (s->facts[i].pred==pred_in)
		{
			if (is_a_package(s->facts[i].arguments[0]))
			{
				if (included_within_the_goals(s->facts[i].arguments[0]))
				{
					if (is_a_truck(s->facts[i].arguments[1]))
					{
						int truck_location=get_current_location(s, s->facts[i].arguments[1]);
						int goal_loc=get_goal_location(s->facts[i].arguments[0]);
						if (truck_location==goal_loc)
							score=score+1;
						else if (same_city(truck_location,goal_loc))
							score=score+2;
						else if (foreign_airport(truck_location,goal_loc))
							score=score+7;
						else 
							score=score+8;
					}
					else if (is_an_airplane(s->facts[i].arguments[1]))
					{
						int plane_location=get_current_location(s, s->facts[i].arguments[1]);
						int goal_loc=get_goal_location(s->facts[i].arguments[0]);
						if (plane_location==goal_loc)
							score=score+1;
						else if (same_city(plane_location,goal_loc))
							score=score+4;
						else 
							score=score+5;
					}
					else
					{
						cout << "ERROR: PACKAGE " << s->facts[i].arguments[0] <<
							" IS WITHIN NEITHER A PLANE NOR A TRUCK " << endl;
						abort();
					}
				}
			}
			else
			{
				cout << "ERROR: SOMETHING THAT IS NOT A PACKAGE IS INCLUDED WITHIN" << 
					" A PLANE OR A TRUCK " << endl;
				abort();
			}
		}
	}
	return score;
}


bool is_a_package(int obj)
{
	bool flag=false;
	int i=0;
	while (i<nof_constants && ! flag)
		if (!strcmp(predicates[constants[i].pred].name,"obj") &&
			constants[i].arguments[0]==obj)
			flag=true;
		else
			i++;
	return flag;
}


bool included_within_the_goals(int package)
{
	bool flag=false;
	int i=0;
	while (i<goal.size && !flag)
		if (!strcmp(predicates[goal.facts[i].pred].name, "at")
			&& goal.facts[i].arguments[0]==package)
			flag=true;
		else
			i++;
	return flag;
}


bool same_city(int current_loc, int goal_loc)
{
	int current_loc_city=get_location_city(current_loc);
	int goal_loc_city=get_location_city(goal_loc);
	if (current_loc_city==goal_loc_city)
		return true;
	else
		return false;
}


int get_location_city(int location)
{
	bool found=false;
	int i=0;
	while (i<nof_constants && !found)
		if (!strcmp(predicates[constants[i].pred].name, "in-city") 
			&& constants[i].arguments[0]==location)
			found=true;
		else
			i++;
	if (found)
		return constants[i].arguments[1];
	else
	{
		cout << "ERROR: CITY OF LOCATION " << objects[location] << "NOT FOUND." << endl ;
		abort();
	}
}


bool is_an_airport(int location)
{
	bool found=false;
	int i=0;
	while (i<nof_constants && !found)
		if (!strcmp(predicates[constants[i].pred].name, "airport")
			&& constants[i].arguments[0]==location)
			found=true;
		else
			i++;
	return found;
}	


bool is_an_airplane(int obj)
{
	bool found=false;
	int i=0;
	while (i<nof_constants && !found)
		if (!strcmp(predicates[constants[i].pred].name, "airplane")
			&& constants[i].arguments[0]==obj)
			found=true;
		else
			i++;
	return found;
}	


bool is_a_truck(int obj)
{
	bool found=false;
	int i=0;
	while (i<nof_constants && !found)
		if (!strcmp(predicates[constants[i].pred].name, "truck")
			&& constants[i].arguments[0]==obj)
			found=true;
		else
			i++;
	return found;
}


bool foreign_airport(int current_loc, int goal_loc)
{
	int current_loc_city=get_location_city(current_loc);
	int goal_loc_city=get_location_city(goal_loc);
	if (current_loc_city!=goal_loc_city && is_an_airport(current_loc))
		return true;
	else
		return false;	
}


int get_current_location(state* s, int obj)
{
	int i=0;
	bool found=false;
	while (i<s->size && !found)
		if (!strcmp(predicates[s->facts[i].pred].name, "at")
			&& s->facts[i].arguments[0]==obj)
			found=true;
		else
			i++;
	if (found)
		return s->facts[i].arguments[1];
	else
	{
		cout << "ERROR: CURRENT LOCATION OF " << objects[obj] << "NOT FOUND." << endl ;
		abort();
	}
}


int get_goal_location(int obj)
{
	int i=0;
	bool found=false;
	while (i<goal.size && !found)
		if (!strcmp(predicates[goal.facts[i].pred].name, "at")
			&& goal.facts[i].arguments[0]==obj)
			found=true;
		else
			i++;
	if (found)
		return goal.facts[i].arguments[1];
	else
	{
		cout << "ERROR: GOAL LOCATION OF " << objects[obj] << "NOT FOUND." << endl ;
		abort();
	}
}












