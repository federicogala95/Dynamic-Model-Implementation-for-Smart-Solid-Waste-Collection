%% DYNAMIC MODEL:
%{
This is the main script to launch the simulation of the "dyanmic" model for
the solid waste collection. The trucks moving inside the model make choices
based on the minimization of a loss function ("lf_long.m") which takes into
account of the distance, the level of traffic and the quantity of waste
contained in the neighborhood bins. 
%}
clear all

%% Model (Bins and Roads)+ Agents (Trucks) creation:
%{
In this section we define the city model (graph) in which the trucks are
going to move during the simulation. The number of nodes represents the
positions at which the solid waste bins are positioned and it is defined
based on the assumption that it is going to satisfy a population of 100000.
The values and hypothesis applied for the model dimension are defined
following the most recent waste consumption of the italian population and 
the suggestions of the APNA disposition for differentiating between the 
different categories of solid wastes.
%}
x_dist = 100;
y_dist = 100;
graph2;  % creates the system  model = GRAPH (Nodes=Bins, Edges = roads)
%% Agents (Trucks) creation:
%{
In this section we define the number of trucks ("trucks.m") to adopt for the 
waste collection based on the number of bins and the length of turn for the 
waste collection (6 HRS). Since we assumed that each step of the simulation
(the waste collection associated with 1 bin) will "approximately" take 5
minutes (time to move + time to pick up-empty-reposition the bin) we
consider an avarage of 72 steps per turn. 
The number of trucks is then slightly modified in order to guarantee that 
at every DEPOSIT NODE there is at least one kind of truck.


%}


% Parameter initialization:
disp('--------------------')
disp('PARAMETERS DEFINITION:')
disp('                      ')
WEEK = ["MON" "TUE" "WED" "THU" "FRI" "SAT" "SUN"];    % week schedule based on six work days (we may add SUNDAY)
Waste_Schedule = ["R" "O" "R" "O" "R" "O" "R"; "G" "PA" "PL" "R" "PA" "G" "PL"];

n_step         = 72;   % 6 HRS per turn
alpha          = 3;
trucks_kind    = ["O" "PL" "PA" "G" "R"]; % ["O"=0rganic "PL"=Plastic "PA"=Paper "G"=Glass "R"=Residual]
n_trucks_class = round(n_bins/n_step);
for i=1:length(n_trucks_class)
    if n_trucks_class(i)<=4
        n_trucks_class(i)=4;
    elseif n_trucks_class(i)>4 && n_trucks_class(i)<=8
        n_trucks_class(i)=8;
    elseif n_trucks_class(i)>8 && n_trucks_class(i)<=12
        n_trucks_class(i)=12;
    else 
        while mod(n_trucks_class(i),4)~=0
            n_trucks_class(i)=1+n_trucks_class(i);
        end
    end
    
end
input_kind = [];

for i=1:length(n_trucks_class)
    input_kind = [input_kind repmat(trucks_kind(i),1,n_trucks_class(i)/4)];
end
input_kind = [input_kind input_kind input_kind input_kind];
n_trucks   = sum(n_trucks_class);
overwaste     = []; 
col = ['m'; 'b'; 'c'; 'k']; % uncomment to add trucks colors!

disp('The model of the city is characterised by:')
fprintf('%d Nodes                         ----> SMART BIN LOCATIONS \n', numnodes(G)-length(n_bins));
fprintf('%d Edges                         ----> ROADS \n', numedges(G));
fprintf('%d Structures for waste disposal ----> TRUCKS \n', n_trucks);
fprintf('%d Different types of wastes and trucks: \n', length(trucks_kind));
disp(' ');
fprintf('%s   %s   %s   %s  %s \n', trucks_kind(1), trucks_kind(2), trucks_kind(3), trucks_kind(4), trucks_kind(5));
waste_level=3
traffic_level=2
n_day_without_collection = 3/4;  % add 3/4
waste_initialization;
if  traffic_level ==1
    traffic_centers = randi([1 numnodes(G)],45,1);
    traff_step = 0.3;  % it is the maximum value that can be reached by the added traffic
elseif traffic_level ==2
    traffic_centers = randi([1 numnodes(G)],70,1);
    traff_step = 0.5; 
elseif traffic_level ==3
    traffic_centers = randi([1 numnodes(G)],90,1);
    traff_step = 0.75;
end
trucks;  % creates the trucks as structures
G_subs = subarea_def(G,start_points);
save('sim_initialization');

%% Instead of creating the graph and trucks every time
% save both of them as a .mat variable and load them from this script
disp('--------------------')
disp('MODEL INITIALIZATION (from saved data):')
disp('                    ')
clear all
load('sim_initialization.mat');
disp('Both trucks and city model have been loaded')

%% Simulation:
%{
The simulation is done considering 7 days a week for the collection and 1
turn per day. In the first part of the turn the trucks moves picking up the
solid waste. Once they reach the end of the turn they start moving back to
their deposit of reference (base property of the truck). The simulation
does not end untill all the Trucks are back to their initial position (see
Back_to_the_base2.m for further information).
At the end of each iteration we save the trucks and model status inside 4
cell objects which are going to be used both for the realization of the
simulation video and the analysis of the model performance.


%}

disp('--------------------')
disp('SIMULATION:')
disp('         ')

for DAY = 1:length(WEEK)
    fprintf("COLLECTION DAY : %s \n",WEEK(DAY));
    collected_waste = [];
    travelled_dist  = [];
    time_spent = [];
    Trucks_var1 = trucksclass(Trucks,Waste_Schedule(1,DAY));
    Trucks_var2 = trucksclass(Trucks,Waste_Schedule(2,DAY));
    Trucks_var = [Trucks_var1; Trucks_var2];
    [Trucks_boss, Trucks_sub_id] = def_boss(Trucks_var,start_points);
    id = trucks_id(Trucks_var);
    waste_ref = param_impl(G,Trucks_sub_id,trucks_kind);

    for t = 1 : round(n_step*0.9)
        if     t == round(0.25*n_step)
            disp('      SIMULATED TURN AT .........25 %')
        elseif t == round(0.5*n_step)
            disp('      SIMULATED TURN AT .........50 %')
        elseif t == round(0.75*n_step)
            disp('      SIMULATED TURN AT .........75 %')
        elseif t == n_step
            disp('      SIMULATED TURN FINISHED! ')
        end
        
        truck_m;
        waste_update;
        traffic_update;
        G_subs = subarea_def(G,start_points);
 
    end
    alpha = 1;
    disp('Trucks moving back to deposit...')
    while ~ all(Trucks_var(1).actpos(id) == start_points(1) | Trucks_var(1).actpos(id) == start_points(2) | Trucks_var(1).actpos(id) == start_points(3) | Trucks_var(1).actpos(id) == start_points(4))
        t = t + 1;
        Back_to_the_base2;
        waste_update;
        traffic_update;
        G_subs = subarea_def(G,start_points);
    end
    
    overwaste_cell{1,DAY} = overwaste;
    distance_cell{1,DAY} = travelled_dist;
    collected_waste_cell{1,DAY} = collected_waste;
    move_spent_time_cell{1,DAY} = time_spent;
    n_day_without_collection = 3/4;  % since each turn is 6 hrs the waste inside the bins keep increasing for 18 hrs 
    waste_implementation_days;
    
end
