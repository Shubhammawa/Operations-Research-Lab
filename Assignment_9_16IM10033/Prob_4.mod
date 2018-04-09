/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Shubham Mawa
 * Creation Date: Apr 9, 2018 at 7:29:33 PM
 *********************************************/
 //using CP;
 int nf = 4;
 int nd = 5;
 
 range f=1..nf;
 range d=1..nd;
 range f_new=1..5;
 
 int cord_fx[f] = [0,0,2,4];
 int cord_fy[f] = [0,4,2,1];
 
 int cord_dx[d] = [0,1,2,4,4];
 int cord_dy[d] = [3,1,3,0,5];
 
 int food[f] = [500,1000,1500,100];
 int demand[d] = [500,2000,500,1500,500];
 
 int food_new = 1000;
 
 dvar int+ x;
 dvar int+ y;
 
 dvar float+ f_d[f_new][d];			// Quantity of food supplied by factory f to demand point d
 
 
 minimize
 sum(i in f, j in d)10*f_d[i][j]*sqrt(pow((cord_fx[i]-cord_dx[j]),2)+pow((cord_fy[i]-cord_dy[j]),2)) + 
 sum(j in d)10*f_d[nf+1][j]*sqrt(pow(x - cord_dx[j],2)+pow(y - cord_dy[j],2));
 
 subject to {
 ct1:
 		forall(i in f)
 		  sum(j in d)f_d[i][j] <= food[i];
 ct2:
 		forall(j in d)
 		  sum(i in f_new)f_d[i][j] >= demand[j];
 }
 