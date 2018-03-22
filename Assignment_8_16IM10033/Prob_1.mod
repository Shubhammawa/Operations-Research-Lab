/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Shubham Mawa
 * Creation Date: Mar 22, 2018 at 4:57:45 PM
 *********************************************/
 int nkit = 6;
 int nstudent = 10;
 
 range kit = 1..nkit;
 range student=1..nstudent;
 
 int rate[student][kit] = [[3,6,6,6,4,3],[12,18,7,9,3,9],[14,12,6,10,1,3],[5,13,6,13,2,4],[6,14,9,15,1,9]
 ,[14,9,2,12,3,9],[12,17,11,5,2,1],[4,16,2,14,7,6],[4,14,9,6,1,3],[8,17,4,14,4,3]];
 
 dvar int+ xij[student][kit];
 
 minimize 
 sum(i in student, j in kit)xij[i][j]*(60/rate[i][j]);
 
 subject to{
   ct1:
     forall(j in kit)
       sum(i in student)xij[i][j] == 1;
   ct2:
     forall(i in student)
       sum(j in kit)xij[i][j] <= 1;    

 }   
 /* From obtained solution
 	Susan - Children's
 	Jeff - Emergency Food packet
 	Naomi - Food support
 	Brenden - Household
 	Carlos - Personal care
 	LaQuita - Layette
 */