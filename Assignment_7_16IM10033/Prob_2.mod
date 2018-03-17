/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Shubham Mawa
 * Creation Date: Mar 17, 2018 at 12:00:39 PM
 *********************************************/
 int nplace = 3;
 int ncommodity = 3;
 range place = 1..nplace;
 range commodity = 1..ncommodity;
 
 int weight [place] = [2000,3000,1500];
 int capacity[place] = [100000,135000,30000];
 
 int weightCom [commodity] = [6000,4000,2000];
 int volume_ton [commodity] = [60,50,25];
 int profit [commodity] = [60,80,50];
 
 dvar float+ cip [place][commodity];
 
 maximize
 sum (i in place, j in commodity) cip[i][j]*profit[j];
 
 subject to {
   ct1:
     forall (j in commodity)
       sum (i in place) cip[i][j] <= weightCom[j];
   ct2:
     forall (i in place)
       sum (j in commodity) cip[i][j] <= weight[i];
   ct3:
     forall (i in place)
       sum(j in commodity) cip[i][j]*volume_ton[j] <= capacity[i];
   ct4:
    sum(j in commodity) cip[2][j] == 1.35*sum(j in commodity) cip[1][j];
    sum(j in commodity) cip[3][j] == 4.5*sum(j in commodity) cip[2][j];
   } 