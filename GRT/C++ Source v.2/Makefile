all: prog

prog: parser.o xor.o New_complete_states.o auxiliary_functions.o test_routines.o BFS-GRT.o Grt.o planner.o
	g++ -O3 auxiliary_functions.o test_routines.o parser.o xor.o New_complete_states.o BFS-GRT.o Grt.o planner.o -lpthread -o p_best

parser.o: parser.cpp
	g++ -O3 -c parser.cpp 

auxiliary_functions.o: auxiliary_functions.cpp
	g++ -O3 -c auxiliary_functions.cpp 

test_routines.o: test_routines.cpp
	g++ -O3 -c test_routines.cpp
 
xor.o: xor.cpp
	g++ -O3 -c xor.cpp

New_complete_states.o: New_complete_states.cpp
	g++ -O3 -c New_complete_states.cpp

memory_manager.o: memory_manager.cpp
	g++ -O3 -c memory_manager.cpp

BFS-GRT.o: BFS-GRT.cpp
	g++ -O3 -c BFS-GRT.cpp

Grt.o: Grt.cpp
	g++ -O3 -c Grt.cpp

planner.o: planner.cpp
	g++ -O3 -c planner.cpp

clean:
	rm *.o
