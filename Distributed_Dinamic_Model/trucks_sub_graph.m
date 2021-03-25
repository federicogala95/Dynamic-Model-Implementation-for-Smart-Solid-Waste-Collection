function [G_trucks,Kind_sub] = trucks_sub_graph(G,Trucks,start_points)
    G_trucks = cell(1,length(Trucks));
    Kind_sub = cell(1,length(Trucks));
    for i=1:length(Trucks)
       kind  = Trucks(i).Kind;
       G_subs = subarea_def(G,start_points);
       base  = Trucks(i).base;
       idx   = find(ismember(start_points,base));
       G_trucks{1,i} = G_subs{idx};
       Kind_sub{1,i} = kind; 
    end
        
end
    


















