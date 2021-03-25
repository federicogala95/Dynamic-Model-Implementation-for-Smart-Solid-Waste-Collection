function G_subs = subarea_def_kind(G,start_points,input_kind,kind)
    n_areas = 4;
    G_subs = cell(1,n_areas);
    idx=find(input_kind==kind);
    G_kind=subgraph(G,G.Nodes.Index(~isnan(G.Nodes.WasteP(:,idx))));

   nodes_list = G_kind.Nodes.Index(G_kind.Nodes.x<2400 & G_kind.Nodes.x>=0); %& G.Nodes.y>=0);
   if sum(ismember(start_points,nodes_list))>=1
      a = start_points(ismember(start_points,nodes_list));
      b=nodes_list(1);
      nodes_list(nodes_list==a)=b;
      nodes_list(1)=a;
   end
   for i=1:length(nodes_list)
       nodes_list(i) = find(G_kind.Nodes.Index==nodes_list(i));
   end
   G_subs{1,1} = subgraph(G_kind,nodes_list);
   
   nodes_list = G_kind.Nodes.Index(G_kind.Nodes.x<3600 & G_kind.Nodes.x>=2400 & G_kind.Nodes.y<=0);
   if sum(ismember(start_points,nodes_list))>=1
      a = start_points(ismember(start_points,nodes_list));
      b=nodes_list(1);
      nodes_list(nodes_list==a)=b;
      nodes_list(1)=a;
   end
   for i=1:length(nodes_list)
       nodes_list(i) = find(G_kind.Nodes.Index==nodes_list(i));
   end
   G_subs{1,2} = subgraph(G_kind,nodes_list);      %find(ismember(G_kind.Nodes.Index,nodes_list)));

   nodes_list = G_kind.Nodes.Index(G_kind.Nodes.x<3600 & G_kind.Nodes.x>=2400 & G_kind.Nodes.y>=0);
   if sum(ismember(start_points,nodes_list))>=1
      a = start_points(ismember(start_points,nodes_list));
      b=nodes_list(1);
      nodes_list(nodes_list==a)=b;
      nodes_list(1)=a;
   end
   for i=1:length(nodes_list)
       nodes_list(i) = find(G_kind.Nodes.Index==nodes_list(i));
   end
   G_subs{1,3} = subgraph(G_kind,nodes_list);
      nodes_list = G_kind.Nodes.Index(G_kind.Nodes.x<=5800 & G_kind.Nodes.x>=3600); %& G.Nodes.y>=0);
   if sum(ismember(start_points,nodes_list))>=1
      a = start_points(ismember(start_points,nodes_list));
      b=nodes_list(1);
      nodes_list(nodes_list==a)=b;
      nodes_list(1)=a;
   end
   for i=1:length(nodes_list)
       nodes_list(i) = find(G_kind.Nodes.Index==nodes_list(i));
   end
   G_subs{1,4} = subgraph(G_kind,nodes_list);
   
   