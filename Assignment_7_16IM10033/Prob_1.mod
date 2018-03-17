/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Krish
 * Creation Date: 15-Mar-2018 at 10:47:52 am
 *********************************************/
int nplant = 3;
int nwarehouse = 3;
int ndemandpoints = 4;

range plant =1..nplant;
range warehouse = 1..nwarehouse;
range demandpoints = 1..ndemandpoints; 

int tcostpw [plant][warehouse] = [[5000,3000,6500],[6000,3200,2500],[5500,2300,6200]];
int tcostwd [warehouse][demandpoints] = [[6000,4500,5000,4000],[5500,3200,2500,4700],[5500,2300,6200,8000]];
int demand [demandpoints] =[50,130,75,90];

dvar int+ Qpw [plant][warehouse];
dvar int+ Qwd [warehouse][demandpoints];

minimize 
  sum (i in plant, j in warehouse) Qpw[i][j]*tcostpw[i][j] +
  sum (j in warehouse, k in demandpoints) Qwd[j][k]*tcostwd[j][k];
  
  subject to {
  ct1:  
      forall (j in warehouse)
      sum (i in plant) Qpw[i][j] == sum (k in demandpoints)Qwd[j][k];
      
  ct2:
      forall (k in demandpoints)
        sum (j in warehouse) Qwd[j][k] == demand[k];
  }