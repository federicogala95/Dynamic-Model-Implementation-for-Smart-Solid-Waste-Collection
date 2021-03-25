function [StreetL]=model_distance(G)
StreetL=zeros(numedges(G),1);
   for i=1:numedges(G)
       x1=G.Nodes.x(G.Edges.EndNodes(i,1));
       x2=G.Nodes.x(G.Edges.EndNodes(i,2));
       y1=G.Nodes.y(G.Edges.EndNodes(i,1));
       y2=G.Nodes.y(G.Edges.EndNodes(i,2));
       StreetL(i)=sqrt((x2-x1)^2+(y2-y1)^2);
       
       
   end

end