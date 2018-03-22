/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Shubham Mawa
 * Creation Date: Mar 22, 2018 at 5:13:02 PM
 *********************************************/
int nrep = 13;
 int nshift = 3;
 
 range rep=1..nrep;
 range shift=1..nshift;
 
 int pref[rep][shift] = [[3,5,1],[2,4,1],[4,1,4],[4,4,4],[3,1,4],[5,5,4],[3,4,3],[5,5,2],[2,1,1],[2,2,4],
 [1,4,1],[5,4,5],[5,1,5]];
 int demand[shift] = [5,5,3];
 dvar int+ xij[rep][shift];
 
 maximize
 sum(i in rep, j in shift)xij[i][j]*pref[i][j];
 
 subject to{
   ct1:
     forall(j in shift)
       sum(i in rep)xij[i][j] == demand[j];
   ct2:
     forall(i in rep)
       sum(j in shift)xij[i][j] == 1;
}