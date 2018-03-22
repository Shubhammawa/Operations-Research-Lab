/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Shubham Mawa
 * Creation Date: Mar 22, 2018 at 4:58:51 PM
 *********************************************/
 int nemp = 7;
 int ndept = 5;
 
 range emp=1..nemp;
 range dept=1..ndept;
 
 int sales[emp][dept] = [[1555,525,370,275,560],[1250,450,285,250,540],[850,500,320,330,550],[1675,490,375,350,580]
 ,[1125,510,365,345,190],[950,500,195,335,350],[1050,300,345,200,545]];
 
 dvar int+ xij[emp][dept];
 
 maximize
 sum(i in emp, j in dept)xij[i][j]*sales[i][j];
 
 subject to{
   ct1:
     forall(j in dept)
       sum(i in emp)xij[i][j] == 1;
   ct2:
     forall(i in emp)
       sum(j in dept)xij[i][j] <=1;
}
/* From obtained solution :
	Joshua - Flooring   : Best in category
	Ha - Lighting		: Not best
	Tyson - Appliances	: Best in category
	Valley - Plumbing	: Not best
	Lacole - Doors		: Not best
	
	Optimal solution did not pick individual best because the objective was to maximize the average
	An individual may have good sales in all dept but some other may have very high in one but little less
	than the previous individual in some category but it will still be picked if it has very less sales in other
	depts so as to keep the average high by selecting the first individual for that dept
		*/

