%% Highlight in graph plots:
%{
This script permits to represent the graph at different condition of
traffic based on the selected time step t of the simulation.
%}

traf_level = [1 3 5 10];

for i=1:length(colors(:,1))
    for j=1:length(Traffic_vec)
       if  floor(Traffic_vec(j)) == traf_level(i)
           trafcol(j,:) = colors(i,:);
       end
    end
end
h = plot(G,'EdgeColor',trafcol,'LineWidth',3);
h.XData = xl;
h.YData = yl;

labelnode(h,start_points,{'START1' 'START2' 'START3' 'START4'});
highlight(h,start_points,'NodeColor','c','Marker','h','MarkerSize',10);