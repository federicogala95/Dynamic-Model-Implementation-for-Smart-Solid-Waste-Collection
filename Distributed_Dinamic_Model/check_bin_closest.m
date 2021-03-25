
function best = check_bin_closest(G, Truck, trucks_kind)
    idx  = find(ismember(trucks_kind, Truck.Kind)==1);
    pos  = find(~isnan(G.Nodes.WasteP(:,idx)));
    radius = 700; % try for 500,1000,2000
    best = nearest(G,find(G.Nodes.Index==Truck.actpos(Truck.ID)), radius); 
    best = best(ismember(best,pos)==1);

  best = G.Nodes.Index(best);
  end























% 