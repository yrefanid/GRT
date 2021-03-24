packages( [ p1 , p2 , p3 , p4 , p5 , p6 ] ) .
cities( [ c1, c2, c3, c4, c6, c6] ) .
airports( [ c12, c22, c32, c42, c52, c62] ) .
locations( [ c11, c12, c21, c22, c31, c32, c41, c42, c51, c52, c61, c62 ] ) .
trucks( [ tr1 , tr2 , tr3, tr4, tr5, tr6 ] ) .
airplanes( [ pl1, pl2 ] ) .
 
def( at( Package , Location ) ) :- packages( D1 ) , locations( D2 ) , member( Package , D1 ) , member( Location , D2 ) .  
def( at( Airplane , Airport ) ) :- airplanes( D1 ) , airports( D2 ) , member( Airplane , D1 ) , member( Airport , D2 ) .  
def( out( Package ) ) :- packages( D1 ) , member( Package , D1 ) .
def( in( Package , Truck ) ) :- packages( D1 ) , trucks( D2 ) , member( Package , D1 ) , member( Truck , D2 ) .
def( in( Package , Airplane ) ) :- packages( D1 ) , airplanes( D2 ) , member( Package , D1 ) , member( Airplane , D2 ) .
def( at( Truck , Location ) ) :- trucks( D1 ) , locations( D2 ) , member( Truck , D1 ) , member( Location , D2 ) .
							 	%% This definition locates every truck at every city , 
								%% though we know that each truck is located 
								%% only at one city . But this information is 
								%% contained at the initial state , while the definitions here
								%% are independent from the initial state .
								%% So , some facts will have a distance 'infinite' or -1 from
								%% the goal state .

const( loc_at( c11, c1) ) .
const( loc_at( c12, c1) ) .
const( loc_at( c21, c2) ) .
const( loc_at( c22, c2) ) .
const( loc_at( c31, c3) ) .
const( loc_at( c32, c3) ) .
const( loc_at( c41, c4) ) .
const( loc_at( c42, c4) ) .
const( loc_at( c51, c5) ) .
const( loc_at( c52, c5) ) .
const( loc_at( c61, c6) ) .
const( loc_at( c62, c6) ) .

 
initial( [ at( pl2 , c42 ) , at( pl1 , c42 ) ,
	 at( tr6 , c61 ) , at( tr5 , c51 ) , at( tr4 , c41 ),at( tr3 , c31 ) , at( tr2 , c21 ) , at( tr1 , c11 ),
	at( p6 , c31 ) , at( p5 , c42 ) , at( p4 , c11 ) , at( p3 , c11 ) , at( p2 , c12 ) , at( p1 , c21) ,
	out(p1), out(p2), out(p3), out(p4), out(p5), out(p6)] ) :- ! .

goal( [ at( p6 , c12 ) , at( p5 , c62 ) , at( p4 , c32 ) , at( p3 , c61 ) , at( p2 , c62 ) , at( p1 , c21) ,
	out(p1), out(p2), out(p3), out(p4), out(p5), out(p6)] ):-! .

goal1( [ 	%at(tr1, c11), 
	at(tr1, c12),
	at(tr2, c21), 
	%at(tr2, c22),
	%at(tr3, c31), 
	at(tr3, c32),
	at(tr4, c41), 
	at(tr4, c42),
	%at(tr5, c51), 
	at(tr5, c52),
	at(tr6, c61), 
	%at(tr6, c62),
	at(pl1, c12), at(pl1, c22), at(pl1, c32), at(pl1, c42), at(pl1, c52), at(pl1, c62), 
	at(pl2, c12), at(pl2, c22), at(pl2, c32), at(pl2, c42), at(pl2, c52), 
	at(pl2, c62)] ):-! .


