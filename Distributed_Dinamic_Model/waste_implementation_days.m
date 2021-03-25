
% WASTE INITIALIZATION:
%{
The script defines the quantity of waste at the beginning of the
week. First of all we need to initialise the kind of wastes per bin location 
since different kind requires a different number of bins. Then we define an
approximated quantity of waste based on the actual consumptions and
reference values per kind and bin volume. 
%}
%% BINS:
% Range of waste produced by citizen per day and per class
% ORDER: Organic, Plastic, Paper, Glass, Residual Waste

if waste_level==1
    for i=1:length(n_bins)

        pos = find(~isnan(G.Nodes.WasteP(:,i)));
        mean_consume = 0.5*(dailywaste_min(i)+dailywaste_mean(i))*n_cits*(1/(n_bins(i)))*n_day_without_collection; 
        sigma_consume  = 1/3*(mean_consume-dailywaste_min(i)*n_day_without_collection*n_cits*(1/(n_bins(i))));
        kg_waste = normrnd(mean_consume,sigma_consume,length(pos),1);
        G.Nodes.WasteP(pos,i) = G.Nodes.WasteP(pos,i)+(kg_waste/rho_waste(i))/(v_bins(i));

    end
    G.Nodes.WasteP(start_points,:)   = 0;    % change for loss function!

elseif waste_level == 2
    
    for i=1:length(n_bins)

        pos = find(~isnan(G.Nodes.WasteP(:,i)));
        mean_consume = dailywaste_mean(i)*n_cits*(1/(n_bins(i)))*n_day_without_collection; 
        sigma_consume  = 1/6*(mean_consume-dailywaste_min(i)*n_day_without_collection*n_cits*(1/(n_bins(i))));
        kg_waste = normrnd(mean_consume,sigma_consume,length(pos),1);
        G.Nodes.WasteP(pos,i) = G.Nodes.WasteP(pos,i)+(kg_waste/rho_waste(i))/(v_bins(i));

    end
    
    G.Nodes.WasteP(start_points,:)   = 0;    % change for loss function!

elseif waste_level == 3
    
    for i=1:length(n_bins)

        pos = find(~isnan(G.Nodes.WasteP(:,i)));
        mean_consume = 0.5*(dailywaste_max(i)+dailywaste_mean(i))*n_cits*(1/(n_bins(i)))*n_day_without_collection; 
        sigma_consume  = 1/3*(dailywaste_max(i)*n_day_without_collection*n_cits*(1/(n_bins(i)))-mean_consume);
        kg_waste = normrnd(mean_consume,sigma_consume,length(pos),1);
        G.Nodes.WasteP(pos,i) = G.Nodes.WasteP(pos,i)+(kg_waste/rho_waste(i))/(v_bins(i));

    end
    G.Nodes.WasteP(start_points,:)   = 0;    % change for loss function!

end





%%