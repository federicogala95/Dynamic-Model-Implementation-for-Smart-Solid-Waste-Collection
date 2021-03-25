% NODE DISTANCE: takes as input a graph model (which needs to have both x and y coordinates property)
% and a source node. It gives back a vector containing all the computed
% distances between the considered nodes.

function distance = node_distance(G,s)
distance = zeros(numnodes(G)-1,1);
G2 = G;
G2 = rmnode(G2,s);
x1=G.Nodes.x(s);
y1=G.Nodes.y(s);
   for i=1:numnodes(G2)
       x2=G2.Nodes.x(i);
       y2=G2.Nodes.y(i);
       StreetL(i)=sqrt((x2-x1)^2+(y2-y1)^2);     
   end

end