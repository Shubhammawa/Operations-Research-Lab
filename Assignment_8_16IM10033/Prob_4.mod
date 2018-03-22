/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Shubham Mawa
 * Creation Date: Mar 22, 2018 at 5:14:55 PM
 *********************************************/
 int ncomp = 3;
 int nschool = 9;
 
 range comp=1..ncomp;
 range school=1..nschool;
 
 int bid[comp][school] = [[11000,999999,6200,999999,8200,9850,7000,9250,4900],
 [11150,8700,999999,12950,8800,999999,6600,8400,4900],
 [999999,8300,6250,12600,8150,9750,6500,999999,4300]];
 
 dvar int+ xij[comp][school];
 
 minimize
 sum(i in comp, j in school)xij[i][j]*bid[i][j];
 subject to{
   ct1:
     forall(j in school)
       sum(i in comp)xij[i][j] == 1;
   ct2:
     forall(i in comp)
       sum(j in school)xij[i][j] <=3;
}

 