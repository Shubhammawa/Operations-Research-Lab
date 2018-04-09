/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Shubham Mawa
 * Creation Date: Apr 9, 2018 at 6:09:48 PM
 *********************************************/
int ncircles = 4;

range circle=1..ncircles;

int rad[circle] = [6,9,12,16];

dvar int+ x[circle];
dvar int+ y[circle];
dvar int+ a;
dvar int+ b;

minimize
  2*(a+b);
    
    subject to{
     ct1:
       forall(i in circle, j in circle)
         if(i != j)
         pow(x[i]-x[j],2) + pow(y[i]-y[j],2) >= pow(rad[i] + rad[j],2);
     ct2:
       forall(i in circle)
         x[i] - rad[i] >= 0;
       forall(i in circle)
         x[i] + rad[i] <= a;
       forall(i in circle)
         y[i] - rad[i] >= 0;
       forall(i in circle)
         y[i] + rad[i] >= 0;
    }