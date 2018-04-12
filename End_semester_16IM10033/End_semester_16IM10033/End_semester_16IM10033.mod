/*********************************************
 * OPL 12.5 Model
 * Author: user_2
 * Creation Date: Apr 12, 2018 at 2:30:56 PM
 *********************************************/
int ncomp = 3;
int ngas = 2;

range comp=1..ncomp;
range gas=1..ngas;

int cost[comp] = [250,260,284];
int gallons[comp] = [5000,10000,10000];
int sp[gas] = [290,300];

dvar float+ Ri[comp];
dvar float+ Pi[comp];

maximize
  sp[1]*(sum(i in comp)Ri[i]) + sp[2]*(sum(j in comp)Pi[j]) - sum(k in comp)cost[k]*(Pi[k] + Ri[k]);
  
  subject to{
    ct1:
      forall(i in comp)
        Ri[i] + Pi[i] <= gallons[i];
    ct2:
      sum(i in comp)Ri[i] >= 10000;
    ct3:
      Ri[1] <= 0.3*(sum(i in comp)Ri[i]);
      Ri[2] >= 0.4*(sum(i in comp)Ri[i]);
      Ri[3] <= 0.3*(sum(i in comp)Ri[i]);
	  
	  Pi[1] >= 0.25*(sum(i in comp)Pi[i]);      
      Pi[2] <= 0.4*(sum(i in comp)Pi[i]);
      Pi[3] >= 0.3*(sum(i in comp)Pi[i]);
 
     }        