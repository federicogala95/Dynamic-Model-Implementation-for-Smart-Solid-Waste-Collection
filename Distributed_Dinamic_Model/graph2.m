
%% System definition:
%{
First we need to define the model and this going to be done by
dimensioning a system based on the number of citizen of 100000.
we are going to
distinguish between 5 waste classes: 
GLASS, ORGANIC WASTE, PAPER, PLASTIC and RESIDUAL WASTE
The number of bins per class needs to be distinguished based on the
different amount of disposal waste, which is quantified in terms of total volume
which needs to be compared with the volumetric capacity of the applied
bin.
In order to simplify the analysis we are going to consider only a street
urban collection system (not domestic), since the system dimensioning is
generally based on complex statistical analysis and is not this aim on
this research.
%}
n_cits = 100000;                   % number of citizens
av_waste = 500 ;                   % [Kg/(citizen*year)]
W_tot_week = 500 * n_cits / 52;    % [Kg/week = Kg/(citizen*year)*(week/year)*(citizens)]
V_tot_week = zeros(1,5);           % [m^3]

% ORDER: Organic, Plastic, Paper, Glass, Residual Waste
waste_percentage = [0.30 0.15 0.24 0.11 0.20]; % ripartion of wastes percentage per class (ANPA documentation)
rho_waste = [450 230 200 200 80];   % [Kg/m^3] 
n_bins = zeros(1,5);                % number of bins necessary per class
v_bins = [2.4 3 3.2 3.2 3.2];       % [m^3] volume of singol bin per class   (ANPA documentation)
for i=1:length(V_tot_week)
  V_tot_week(i) = W_tot_week*waste_percentage(i)/(rho_waste(i));
  n_bins(i) = ceil(V_tot_week(i)/v_bins(i));
end
n_max = max(n_bins);




%% Graph Definition: (nodes=bins, edges=roads(distance between bins))

clear G;
G = graph();
G = addnode(G,1);
% n = [1 8 ones(1,20)];
% n = [1 2 2 1 1 2 1 1];
n = [1 4 1 2 1 2 1 2 1 1 1 1 2 1 1 ];
%n = [1 50 1 1 1 1 1];
xl = 0;
yl = 0;
n_vec = 1;
for i=2:length(n)
    vec_p = 1:numnodes(G);
    G = addnode(G,prod(n(1:i)));
    vec_n = (1:(numnodes(G)-length(vec_p)))+length(vec_p);
    n_vec = [n_vec length(vec_n)];
    
     for j=1:n_vec(i)/n(i)             %(length(vec_p)/length(prod(n(1:(i-1)))))
        a = ones(1,n(i))*vec_p(end-prod(n(1:i-1))+1)+j-1;
        b = vec_n(1:n(i))+(j-1)*n(i);
        G = addedge(G, a, b);       
    
     end
    
    G = addedge(G, vec_n(1:end-1), vec_n(2:end));
    xl = [xl ones(1,length(vec_n))*x_dist*i];
    y_n = (-length(vec_n)/2:length(vec_n)/2)*y_dist; %*i;    
    y_n(y_n==0) = [];
    
     if length(vec_n)==1
        y_n = 0;
    end
    yl = [yl y_n];
end

%%
l = xl(end);
start2 = vec_n(1);
start3 = vec_n(end);
%%
n = flip(n);
n_vec = flip(n_vec);
for i=1:length(n)-1
    vec_p = 1:numnodes(G);
    G = addnode(G,n_vec(i+1));
    vec_n = (1:(numnodes(G)-length(vec_p)))+length(vec_p);
    
     for j=1:length(vec_n)             %(length(vec_p)/length(prod(n(1:(i-1)))))
         %rev_vec_n = flip(vec_n);
         a = ones(1,n(i))*vec_n(j);
        
        if n(i) == 1
            b = vec_p(end-length(vec_n)+1)+(j-1)*n(i);
        else
            b = flip(vec_p(length(vec_p)-n_vec(i)+1:(length(vec_p)-n_vec(i)+n(i)))+(j-1)*n(i));
        end
                    %b = vec_p((length(vec_p))-n_vec(i):(length(vec_p))-n_vec(i)+n_vec(i)/n(i)-1)+(j-1)*n_vec(i)/n(i);

        G = addedge(G, a, b);
         
      plot(G);  
     end
     
    G = addedge(G, vec_n(1:end-1), vec_n(2:end));
    xl = [xl ones(1,length(vec_n))*x_dist*i+l];

    y_n = (-length(vec_n)/2:length(vec_n)/2)*y_dist; %*(length(n)-i);
    y_n(y_n==0) = [];
    
    if length(vec_n)==1
        y_n = 0;
    end    
    yl = [yl y_n];    
    
end

%% Initializing values for the Solid Waste Collection:
G.Nodes.x=xl';
G.Nodes.y=yl';
start_points = [1 start2 start3 numnodes(G)];
G.Edges.Index = (1:numedges(G))';
G.Edges.StreetL = model_distance(G);
G.Nodes.Index = (1:numnodes(G))';
G.Nodes.WasteP = NaN(numnodes(G),length(waste_percentage));
G.Nodes.BinFreq = randi([1 3],numnodes(G),1);
G.Nodes.BinFreq(start_points) = 0;
G.Edges.Traffic = zeros(1,numedges(G))';
trafcol = [zeros(1,numedges(G)); ones(1,numedges(G)); zeros(1,numedges(G))]';
G.Edges.Weight = G.Edges.StreetL;

colors = [0 1 0 ; 1 1 0 ; 0.9290 0.6940 0.1250; 1 0 0];   % colors for traffic


%% Highlight in graph plots:

h = plot(G,'EdgeColor',trafcol,'LineWidth',3,'XData',xl,'YData',yl);
row = dataTipTextRow('X',G.Nodes.x);
h.DataTipTemplate.DataTipRows(end+1) = row;
row = dataTipTextRow('Y',G.Nodes.y);
h.DataTipTemplate.DataTipRows(end+1) = row;
labelnode(h,[1 start2 start3 numnodes(G)],{'START1' 'START2' 'START3' 'START4'});
highlight(h,[1 start2 start3 numnodes(G)],'NodeColor','b','Marker','h','MarkerSize',10);
h.XData = xl;
h.YData = yl;
