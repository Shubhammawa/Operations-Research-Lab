/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Shubham Mawa
 * Creation Date: Mar 17, 2018 at 7:56:37 PM
 *********************************************/

  int ntruck = 2;
 int nproduct = 10;
 
 range truck = 1..ntruck;
 range product = 1..nproduct;
 
 float weight_p[product] = [22.32,29.47,32.63,34.52,19.97,21.39,30.06,29.07,27.19,35.11];
 float volume_p[product] = [.42,.73,.31,.4,.22,.56,.31,.42,.31,.29];
 int profit[truck][product] = [[74,95,65,75,63,89,90,93,58,77],[52,84,78,75,82,71,80,95,72,90]];
 
 int weight_t[truck] = [65,100];
 float volume_t[truck] = [1.5,2];
 int cost[truck] = [10000,27000];
 
 dvar int+ Bin_p[product][truck];
 dvar int+ y[truck];                  //Number of trucks of type truck i.e 1,2
 
 maximize
 sum(j in truck, i in product)Bin_p[i][j]*profit[j][i] - sum(j in truck)cost[j]*y[j];
 
 subject to{
 ct1:
 forall(j in truck)
   sum(i in product)Bin_p[i][j]*weight_p[i] <= weight_t[j]*y[j];   // Truck weight capacity constraint
 ct2:
 forall(j in truck)
   sum(i in product)Bin_p[i][j]*volume_p[i] <= volume_t[j]*y[j];   // Truck volume capacity constraint
 ct3:
 forall(j in truck)
   forall(i in product)
     Bin_p[i][j] <= 1;
 ct4:
 forall(i in product)
   Bin_p[i][1] + Bin_p[i][2] == 1;                            // To ensure every product is picked exactly once
 
    
 }