/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Shubham Mawa
 * Creation Date: Apr 9, 2018 at 6:09:18 PM
 *********************************************/
int nports = 7;
int ncord = 2;

range ports=1..nports;
range cord=1..ncord;

int cords[cord][ports] = [[70,61,100,37,12,96,66],[11,12,30,76,86,72,65]];
dvar int+ x[ports][ports];                  // Xij - Binary port i to port j

minimize 
sum(i in ports, j in ports)x[i][j]*sqrt(pow((cords[1][i]-cords[1][j]),2) + pow((cords[2][i]-cords[2][j]),2));

subject to{
 ct1:
 	forall(j in ports)
    	sum(i in ports)x[i][j] == 1;
 ct2:
 	forall(i in ports)
    	sum(j in ports)x[i][j] == 1;
 ct3:
 	forall(i in ports)
 	  x[i][i] == 0;
 // Introduced after solving upto ct3
 ct4:
    forall(i in ports, j in ports)		// Eliminating subtours of length 2 
      x[i][j] + x[j][i] <= 1; 
// Introduced after solving upto ct4
 ct5:
 	forall(i in ports, j in ports, k in ports)	// Eliminating subtours of length 3
 	  x[i][j] + x[j][k] + x[k][i] <= 2;   
}  
// All subtours eliminated for the given problem. Hence no more constraints needed for this case.
// Subtour - A-C-F-G-D-E-B-A
// solution (optimal) with objective 264.256250396945