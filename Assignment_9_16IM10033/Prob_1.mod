/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Shubham Mawa
 * Creation Date: Apr 9, 2018 at 6:07:56 PM
 *********************************************/
int ncrew = 9;
int nskill = 3;

range crew=1..ncrew;
range skill=1..nskill;

int skills[crew][skill] = [[2,5,4],[1,1,2],[1,4,3],[5,2,2],[4,1,1],[3,2,5],[1,3,4],[3,1,3],[4,2,4]];
int salary[crew] = [1000,1100,800,1300,1300,1400,1400,1000,700];

dvar int+ x[crew];

minimize
  sum(i in crew)x[i]*salary[i];
  subject to{
   ct1:
     forall(j in skill)
       sum(i in crew)x[i]*skills[i][j] >= 15;
   ct2:
     forall(i in crew)
       x[i] <= 1; 
  }
// x = [1 0 1 1 0 1 0 0 1];
// solution (optimal) with objective 5200