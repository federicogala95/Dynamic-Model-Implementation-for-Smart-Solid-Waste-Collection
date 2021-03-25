%% TRUCKS DEFINITION:
%{
In this section we implement the trucks we are going to use for the
simultation. In order to do that we are going to define several structure
variables, each one of which would represent a truck moving in the graph
during the simulation.
14/10/2020: 3 ATTRIBUTES: node position, distance travelled, collected
waste. At first we will only consider one type of waste and then it will be 
implemented with 4 classes: glass (green trucks), organic (red trucks), plastic (blue trucks), paper (yellow trucks).
%

%}


% In order to add different colors for the trucks uncomment the following
% section:
%{
for i=1:n_trucks
     for j=1:length(trucks_kind)
      if input_kind(i) == trucks_kind(j)
          trucks_col = [trucks_col; col(j)];
      end       
     end     
end
%}
%% Initialization of the 'Truck' structure and its attribute
Truck.ID = [];
Truck.cwaste = 0;
Truck.dist =   0;
Truck.actpos =   ones(1,n_trucks);
Truck.prevpos =  zeros(1,n_trucks);
Truck.label =    strings(1);
Truck.Kind =     strings(1);
Truck.base =      1;
Truck.picked = [];
Trucks = [];
%% Initialization of the 'Trucks' structure and its n substructures 'Track'
for i=1:n_trucks
   Trucks = [Trucks; Truck];
end
n_trucks_per_pos = n_trucks/length(start_points);
trucks_pos = n_trucks_per_pos*(1:length(start_points));
for i=1:n_trucks
    
    Trucks(i).ID = i;
    Trucks(i).label = "T"+num2str(i+"");
    Trucks(i).Kind = input_kind(i);
    
    %Trucks(i).col  = trucks_col(i); uncomment to add truck colors!
end

for k = 2:length(start_points)
    for i=1:n_trucks
        if Trucks(i).ID <= trucks_pos(k) && Trucks(i).ID > trucks_pos(k-1)
            Trucks(i).base = start_points(k);
            for j=1:n_trucks
               Trucks(j).actpos(i) = start_points(k);
               
            end
        end
    end
end


%% Data  plot:
%{
We need to store the varables necessary to represetn the evolving model
through a plot (graph plot) and the amount of waste disposal changing
in the simulation. Similar to the previous section we are going to define
some empty cell objects which are going to be filled during the simulation
in order to keep track of the evolving system.
1) WasteP : percentage of waste in the model
2) Traffic : 
3) TrucksPos
4) ID
%}
WasteP_cell = cell(1,length(WEEK));
Traffic_cell = cell(1,length(WEEK));
TrucksPos_cell = cell(1,length(WEEK));
ID_cell = cell(1,length(WEEK));
overwaste_cell = cell(1,length(WEEK));
distance_cell = cell(1,length(WEEK));
collected_waste_cell = cell(1,length(WEEK));
move_spent_time_cell = cell(1,length(WEEK));
for DAY = 1:length(WEEK)
    WasteP_cell{1,DAY} = cell(1,0);
    Traffic_cell{1,DAY} = cell(1,0);
    TrucksPos_cell{1,DAY} = cell(1,0);
    ID_cell{1,DAY} = cell(1,0);
end











    