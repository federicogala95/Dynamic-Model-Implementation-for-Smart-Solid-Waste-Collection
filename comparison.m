clear all
load('Dynamic_mod_eval_par')
load('Classic_mod_eval_par')
Levels = {'W1-T1','W1-T2','W1-T3','W2-T1','W2-T2','W2-T3','W3-T1','W3-T2','W3-T3'};


figure(1)
title('Overall collected solid waste')
boxplot(C_waste_tot',Levels,'Colors','r');
hold on
boxplot(C_waste_tot_classic',Levels,'Colors','b');
xlabel('Levels')
ylabel('Collected Waste [Kg]')

figure(2)
title('Overall time spent during the week')
boxplot(T_spent_tot',Levels,'Colors','r');
hold on
boxplot(T_spent_tot_classic',Levels,'Colors','b');
xlabel('Levels')
ylabel('Time [min]')


figure(3)
title('Global evaluation parameter')
boxplot(Phi_tot',Levels,'Colors','r');
hold on
boxplot(Phi_tot_classic',Levels,'Colors','b');
xlabel('Levels')
ylabel('Phi')
