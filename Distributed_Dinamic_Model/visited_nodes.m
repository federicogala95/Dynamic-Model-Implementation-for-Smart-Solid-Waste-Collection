function list = visited_nodes(Trucks,start_points,trucks_kind)
list = cell(length(start_points),length(trucks_kind));
    for i=1:length(Trucks)
        idx = find(ismember(trucks_kind, Trucks(i).Kind));
        base = find(ismember(start_points, Trucks(i).base));
        vec = list{base,idx};
        list{base,idx} = [vec Trucks(i).picked];

    end
end

