%% TRUCKS MOVEMENTS CHOICE:

%{
In this script/funtion we define how the trucks establish the best choice
of the path. Starting from the actual position it evaluates the best
possible choice between the adjacent connected nodes and change its position to it.
The evaluation of the best position is based on the minimization of the
weight associate to each alternative nodes.
The weight for node j is defined in the following way:
WEIGHT(NODE(j)) = (DISTANCE(EDGE(j))/VEL_REF +
T_TRAFF(EDGE(j))*(1+W_REF/WASTE_PERCENTAGE(NODE(j))^(ALPHA))
where:
1)DISTANCE = const : length of the road
2)VEL_REF = const  : mean velocity of the trucks (approx.) which
permits to make DISTANCE and T_TRAFFIC of the same magnitude (500 m /min = 30 Km/h)
3)WASTE_PERCENTAGE = updates with the simulation : percentage of garbage in
node j


%}

%%
time_move = zeros(1,length(Trucks_var));
c_waste = zeros(1,length(Trucks_var));
dist = zeros(1,length(Trucks_var));
if mod(t,6)==0
    waste_ref = param_impl(G,Trucks_sub_id,trucks_kind);
end
% list = visited_nodes(Trucks_var,start_points,trucks_kind);
for k = 1:length(Trucks_var)        
           
    idx = find(ismember(trucks_kind,Trucks_var(k).Kind)==1);  
    base = find(ismember(start_points,Trucks_var(k).base));
    node_i = Trucks_var(k).actpos(id(k));
    weight = [];
    node_next = [];
    l = check_bin_closest(G_subs{1,base}, Trucks_var(k),trucks_kind);
    l(l==Trucks_var(k).prevpos(id(k)))=[];
    v = find(ismember(l,Trucks_var(k).actpos(id))==1);
    l(v) = []; 
    v = find(ismember(l,start_points)==1);
    l(v) = [];
%     v = find(ismember(l,list{base,idx}));
%     l(v) = [];
    if ~isempty(l)    
        weight = lf_long(G, node_i, l, idx, waste_ref(base,idx), alpha);
        node_next1 = l(weight == min(weight));
        path = shortestpath(G,node_i,node_next1(1));
        node_next = path(end);
        Trucks_var(k).actpos(id(k)) = node_next;    
        Trucks_var(k).picked(end+1) = node_next;
        
        %Implementation of the truck parameters:

        a = shortestpath(G,node_i,node_next);
        a1 = a(1:end-1);
        a2 = a(2:end);
        sum_street = sum(G.Edges.StreetL(findedge(G,a1,a2)));
        sum_traffic = sum(G.Edges.Traffic(findedge(G,a1,a2)));
        time_move(k) = sum_street/500 + sum_traffic + randi([2 3]);
        Trucks_var(k).dist = Trucks_var(k).dist + sum_street;
        Trucks_var(k).cwaste = Trucks_var(k).cwaste + G.Nodes.WasteP(node_next,idx)*rho_waste(idx)*v_bins(idx);
        Trucks_var(k).prevpos(id(k)) = node_i;               
        c_waste(k) = G.Nodes.WasteP(node_next,idx)*rho_waste(idx)*v_bins(idx);
        G_subs{1,base}.Nodes.WasteP(find(G_subs{1,base}.Nodes.Index==node_next),idx) = 0;
        G.Nodes.WasteP(node_next,idx) = 0;
        dist(k)       = sum_street;
        for w = 1:length(Trucks_var)
            Trucks_var(w).actpos(id(k))  = Trucks_var(k).actpos(id(k));
            Trucks_var(w).prevpos(id(k)) = Trucks_var(k).prevpos(id(k));  
        end

        
    else
         node_next = node_i;
         
               
    end
       
   
       
end

% Data storage of the picked up positions and vehicles displacements:
WasteP_cell{1,DAY}{1,t}  =   G.Nodes.WasteP;
Traffic_cell{1,DAY}{1,t} =   G.Edges.Traffic;
TrucksPos_cell{1,DAY}{1,t} = Trucks_var(k).actpos(id);
ID_cell_cell{1,DAY}{1,t}   = id;

collected_waste = [collected_waste; c_waste];
travelled_dist  = [travelled_dist; dist];
time_spent = [time_spent; time_move];

        
        
