function weight = lf_long(G, node_i, neighboors, idx, w_ref, alpha)
%LF Summary of this function goes here
weight = zeros(1,length(neighboors));   
    for j=1:length(neighboors)   
        a = shortestpath(G,node_i,neighboors(j));
        a1 = a(1:end-1);
        a2 = a(2:end);
        sum_street = sum(G.Edges.StreetL(findedge(G,a1,a2)));
        sum_traffic = sum(G.Edges.Traffic(findedge(G,a1,a2)));
        waste   = G.Nodes.WasteP(neighboors(j),idx);
        weight(j) = (sum_street/500 + sum_traffic)*(1+(w_ref/waste)^(alpha));
    end
end