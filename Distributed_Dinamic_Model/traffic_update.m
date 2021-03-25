%% TRAFFIC UPDATE:
%{
This script permits to update the level of traffic for the different
streets of the model (graph's edges). It generates a random value between
-1 and 1 which is added to the edge attribute Traffic.
If the traffic become higher than 5 min (5) it automatically reset the
value to the upperbound limit of traffic 5.
%}

%% Traffic update velocity per unit of time:
traff_limit = 10;
%% 1) Without taking care of different update frequency (uniformly increase and decrease):
% if t <= round(n_step/2)
%     G.Edges.Traffic(1:numedges(G)) = G.Edges.Traffic(1:numedges(G)) + randi([0 1],numedges(G),1).*rand(numedges(G), 1)*traff_max;
%     G.Edges.Traffic(G.Edges.Traffic > traff_limit) = traff_limit;
%     G.Edges.Traffic(G.Edges.Traffic < 0) = 0;
% else 
%     G.Edges.Traffic(1:numedges(G)) = G.Edges.Traffic(1:numedges(G)) - randi([0 1],numedges(G),1).*rand(numedges(G), 1)*traff_max;
%     G.Edges.Traffic(G.Edges.Traffic > traff_limit) = traff_limit;
%     G.Edges.Traffic(G.Edges.Traffic < 0) = 0;
% end
% G.Edges.Weight = G.Edges.StreetL/500 + G.Edges.Traffic;
%% 2) Centralized traffic (congestion only in same areas)

nodetraf = cell(1,length(traffic_centers));

    for i=1:length(traffic_centers)
        nodetraf{1,i} = nearest(G,traffic_centers(i),mean(G.Edges.StreetL));
    end
    
    edges = [];
    
    for i=1:length(traffic_centers)
        edges = [edges; findedge(G,traffic_centers(i)*ones(1,length(nodetraf{1,i})),nodetraf{1,i})];
    end
        edges(edges==0)=[];
        edges = unique(edges);
    if t <= round(n_step/2)
        G.Edges.Traffic(edges) = G.Edges.Traffic(edges) + randi([0 1],length(edges),1).*rand(length(edges), 1)*traff_step;
        G.Edges.Traffic(G.Edges.Traffic > traff_limit) = traff_limit;
        G.Edges.Traffic(G.Edges.Traffic < 0) = 0;
    else 
        G.Edges.Traffic(edges) = G.Edges.Traffic(edges) - randi([0 1],length(edges),1).*rand(length(edges), 1)*traff_step;    G.Edges.Traffic(G.Edges.Traffic > traff_limit) = traff_limit;
        G.Edges.Traffic(G.Edges.Traffic > traff_limit) = traff_limit;
        G.Edges.Traffic(G.Edges.Traffic < 0) = 0;
    end
    