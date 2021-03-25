id = trucks_id(Trucks_var);
time_move = zeros(1,length(Trucks_var));
c_waste = zeros(1,length(Trucks_var));
dist = zeros(1,length(Trucks_var));
if mod(t,5)==0
    waste_ref = param_impl(G,Trucks_sub_id,trucks_kind);
end
    for i = 1:length(Trucks_var)     
    if  Trucks_var(i).actpos(id(i)) == Trucks_var(i).base
        continue    
    else             
        node_i = Trucks_var(i).actpos(id(i));
        base = find(ismember(start_points,Trucks_var(i).base));
        idx  = find(ismember(trucks_kind, Trucks_var(i).Kind)==1);
        weight = [];
        node_next = [];        
        l = check_bin_closest(G_subs{1,base}, Trucks_var(i),trucks_kind) ; 
        l(l==Trucks_var(i).prevpos(id(i)))=[]; 
         if ismember(Trucks_var(i).base,l) || isempty(l)
             node_next = Trucks_var(i).base;
             
         else
                              
            weight = lf_back(G, Trucks_var(i), l, idx, waste_ref(base,idx), alpha);
            node_next1 = l(weight == min(weight));
            node_next = node_next1(1);
         end
         
            Trucks_var(i).actpos(id(i)) = node_next;
            a = shortestpath(G,node_i,node_next);
            a1 = a(1:end-1);
            a2 = a(2:end);
            sum_street = sum(G.Edges.StreetL(findedge(G,a1,a2)));
            sum_traffic = sum(G.Edges.Traffic(findedge(G,a1,a2)));
            time_move(i) = sum_street/500 + sum_traffic + randi([2 3]);
            Trucks_var(i).dist = Trucks_var(i).dist + sum_street;
            Trucks_var(i).cwaste = Trucks_var(i).cwaste + G.Nodes.WasteP(node_next,idx)*rho_waste(idx)*v_bins(idx);
            c_waste(i) = G.Nodes.WasteP(node_next,idx)*rho_waste(idx)*v_bins(idx);
            dist(i)       = sum_street;
            Trucks_var(i).prevpos(id(i)) = node_i;               
            G_subs{1,base}.Nodes.WasteP(find(G_subs{1,base}.Nodes.Index==node_next),idx) = 0;
            G.Nodes.WasteP(node_next,idx) = 0;
          % Send new position of truck -ith to the other trucks:
        vec = 1:length(Trucks_var);
        vec(vec==i) = [];        
        for w = 1:length(vec)
            Trucks_var(vec(w)).actpos(id(i))=Trucks_var(i).actpos(id(i));
            Trucks_var(vec(w)).prevpos(id(i))=Trucks_var(i).prevpos(id(i));  
        end
         
    end
    
    end
WasteP_cell{1,DAY}{1,t}  =   G.Nodes.WasteP;
Traffic_cell{1,DAY}{1,t} =   G.Edges.Traffic;
TrucksPos_cell{1,DAY}{1,t} = Trucks_var(i).actpos(id);
ID_cell_cell{1,DAY}{1,t}   = id;

collected_waste = [collected_waste; c_waste];
travelled_dist  = [travelled_dist; dist];
time_spent = [time_spent; time_move];

 
