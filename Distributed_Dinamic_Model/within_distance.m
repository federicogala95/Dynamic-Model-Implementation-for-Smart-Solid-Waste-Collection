% WITHIN DISTANCE: takes as input a Graph model, a source node and a
% distance scalar value. It gives back all the nodes in G that are within
% the specified distance.

function list = within_distance(G,s,d)
    distances = node_distance(G,s);
    nodes = G.Nodes.Index;
    list = [];
    for i=1:length(distances)
        if distances(i) <= d
            list(i) = nodes(i);
        end
    end
end