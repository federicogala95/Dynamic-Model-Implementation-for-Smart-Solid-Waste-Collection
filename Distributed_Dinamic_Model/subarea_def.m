function G_subs = subarea_def(G,start_points)
    n_areas = 4;
    G_subs = cell(1,n_areas);
    

   nodes_list = G.Nodes.Index(G.Nodes.x<2400/2 & G.Nodes.x>=0); %& G.Nodes.y>=0);
   if sum(ismember(start_points,nodes_list))>=1
      a = start_points(ismember(start_points,nodes_list));
      b=nodes_list(1);
      nodes_list(nodes_list==a)=b;
      nodes_list(1)=a;
   end
   G_subs{1,1} = subgraph(G,nodes_list);

%    nodes_list = G.Nodes.Index(G.Nodes.x<2600 & G.Nodes.x>=0 & G.Nodes.y<=0);
%    if sum(ismember(start_points,nodes_list))>=1
%       a = start_points(ismember(start_points,nodes_list));
%       b=nodes_list(1);
%       nodes_list(nodes_list==a)=b;
%       nodes_list(1)=a;
%    end
%    G_subs{1,2} = subgraph(G,nodes_list);
   
      nodes_list = G.Nodes.Index(G.Nodes.x<=3600/2 & G.Nodes.x>=2400/2 & G.Nodes.y<=0);
   if sum(ismember(start_points,nodes_list))>=1
      a = start_points(ismember(start_points,nodes_list));
      b=nodes_list(1);
      nodes_list(nodes_list==a)=b;
      nodes_list(1)=a;
   end
   G_subs{1,2} = subgraph(G,nodes_list);

   nodes_list = G.Nodes.Index(G.Nodes.x<=3600/2 & G.Nodes.x>=2400/2 & G.Nodes.y>=0);
   if sum(ismember(start_points,nodes_list))>=1
      a = start_points(ismember(start_points,nodes_list));
      b=nodes_list(1);
      nodes_list(nodes_list==a)=b;
      nodes_list(1)=a;
   end
   G_subs{1,3} = subgraph(G,nodes_list);
      nodes_list = G.Nodes.Index(G.Nodes.x<=5800/2 & G.Nodes.x>3600/2); 
   if sum(ismember(start_points,nodes_list))>=1
      a = start_points(ismember(start_points,nodes_list));
      b=nodes_list(1);
      nodes_list(nodes_list==a)=b;
      nodes_list(1)=a;
   end
   G_subs{1,4} = subgraph(G,nodes_list);






end
