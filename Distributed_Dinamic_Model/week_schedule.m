function G_trucks = trucks_sub_graph(G,Trucks,start_points,trucks_kind)
    path1 = cell(1,0);
    path  = cell(1,length(Trucks));
    sol_in_G_kind = cell(length(trucks_kind),length(start_points));
    sol_in_G = cell(length(trucks_kind),length(start_points));
    G_kind = cell(1,length(trucks_kind));
    ID = [];
    for i=1:length(trucks_kind)
        fprintf('Schedule definition for Waste Kind %s:\n',trucks_kind(i));
        Trucks_var = trucksclass(Trucks,trucks_kind(i));
        G_sub = subarea_def_kind(G,start_points,trucks_kind,trucks_kind(i));
        G_kind{1,i} = G_sub;
        [trucks_start_pos,id]=find_init_pos(Trucks_var,start_points);
        
        for j=1:length(trucks_start_pos)
           fprintf('SUBGRAPH TSP CALC... %2.0f % \n', j/length(trucks_start_pos)*100);
           G_var = G_sub{1,j};
           XY  = [G_var.Nodes.x,G_var.Nodes.y];
           n_a = trucks_start_pos(j);
           if n_a ==1
               sol1 = tsp_ga('XY',XY,'NUMITER',10000,'SHOWPROG',1);
           else
               sol1 = mtspf_ga_minmax('XY',XY,'NSALESMEN',n_a,'SHOWPROG',1,'NUMITER',10000);
           end
           sol_in_G_kind{i,j} = sol1.optSolution;
                        
          if  iscell(sol1.optSolution)==0
               b = sol_in_G_kind{i,j};
               conv = G_var.Nodes.Index(b);
               sol_in_G{i,j} = conv;
               path1{1,end+1}=conv;
          else    
              sol_in_G{i,j} = cell(length(sol1.optSolution),1);
              for n=1:length(sol1.optSolution)
                  
                   b1 = sol_in_G_kind{i,j};
                   b2 = b1{n,1};
                   conv = G_var.Nodes.Index(b2);
                   sol_in_G{i,j}{n,1} = conv;
                   path1{1,end+1}=conv;
              end
          end
           
        end
        
        for k=1:length(id)
            v = id{1,k};
            for m=1:length(v)
                 ID = [ID v(m)];
            end
        end
        
        
    end
    
for s=1:length(Trucks)
    path{1,ID(s)} = path1{1,s};
end
    
end


















