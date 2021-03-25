function w = param_impl(G,Trucks_sub_id,truck_kind)
    w = zeros(length(Trucks_sub_id),length(truck_kind));
    for i=1:length(Trucks_sub_id)
        mat = [];
        for j = 1:length(Trucks_sub_id{1,i})
            vec = w_ref_def(G,Trucks_sub_id{1,i}(j));
            mat = [mat; vec];
            
        end
        w(i,:) = mean(mat);   
    end





end