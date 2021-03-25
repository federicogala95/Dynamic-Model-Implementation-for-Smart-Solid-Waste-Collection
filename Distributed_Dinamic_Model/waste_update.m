%% WASTE UPDATE:
%{
This script permits to implement the level of garbage in the graph at every
iteration. It generates a random value between 0:0.2 in order to have the
increase of solid waste in the nodes while the trucks keep moving inside
the model. 
It might be interesting to consider that all the bin are not characterised
by the same updating frequency since some of them are generally filled
faster while other are less used. This could be done by adding another
parameter, speficied at the very beginning of the simulation, which
represents the updating frequency as an integer number: 1(slow), 2(medium), 3(fast).
Then when the waste_update script is launched it defines the new level of
waste taking into account of that value: new_waste(i) =
prev_waste*rand(0:0.1)*freq_index(i), where freq_index(i) is the updating
frequency characterising that bin.

%}

%% 1) Without taking care of different update frequency:
if waste_level==1
    for i=1:length(n_bins)
        pos = find(~isnan(G.Nodes.WasteP(:,i)));
        mean_consume = 0.5*(dailywaste_min(i)+dailywaste_mean(i))*n_cits*(1/(24*12*n_bins(i))); 
        sigma_consume  = 1/3*(mean_consume-dailywaste_min(i)*n_cits*(1/(24*12*n_bins(i))));
        kg_waste = abs(normrnd(mean_consume,sigma_consume,length(pos),1)); 
        G.Nodes.WasteP(pos,i) = G.Nodes.WasteP(pos,i)+(kg_waste/rho_waste(i))/(v_bins(i));
    end
    G.Nodes.WasteP(start_points,:)   = 0;    % change for loss function!
    for j=1:length(n_bins)
        overwaste_counter(j) = sum(G.Nodes.WasteP(:,j)>1);
    end
    overwaste(t,:) = overwaste_counter;
    
elseif waste_level==2
    for i=1:length(n_bins)
        pos = find(~isnan(G.Nodes.WasteP(:,i)));
        mean_consume = dailywaste_mean(i)*n_cits*(1/(24*12*n_bins(i))); 
        sigma_consume  = 1/6*(mean_consume-dailywaste_min(i)*n_cits*(1/(24*12*n_bins(i))));
        kg_waste = abs(normrnd(mean_consume,sigma_consume,length(pos),1)); 
        G.Nodes.WasteP(pos,i) = G.Nodes.WasteP(pos,i)+(kg_waste/rho_waste(i))/(v_bins(i));
    end
    G.Nodes.WasteP(start_points,:)   = 0;    % change for loss function!
    for j=1:length(n_bins)
        overwaste_counter(j) = sum(G.Nodes.WasteP(:,j)>1);
    end
    overwaste(t,:) = overwaste_counter;
    
    
    
    
elseif waste_level==3
    for i=1:length(n_bins)
        pos = find(~isnan(G.Nodes.WasteP(:,i)));
        mean_consume = 0.5*(dailywaste_max(i)+dailywaste_mean(i))*n_cits*(1/(24*12*n_bins(i)));
        delta_consume  = 1/3*(dailywaste_max(i)*n_cits*(1/(24*12*n_bins(i)))-mean_consume);
        kg_waste = abs(normrnd(mean_consume,sigma_consume,length(pos),1));
        G.Nodes.WasteP(pos,i) = G.Nodes.WasteP(pos,i)+(kg_waste/rho_waste(i))/(v_bins(i));
    end
    G.Nodes.WasteP(start_points,:)   = 0;    % change for loss function!
    for j=1:length(n_bins)
        overwaste_counter(j) = sum(G.Nodes.WasteP(:,j)>1);
    end
    overwaste(t,:) = overwaste_counter;
    
    
    
end
