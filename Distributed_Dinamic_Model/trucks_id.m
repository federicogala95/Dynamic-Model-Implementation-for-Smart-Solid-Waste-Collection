function array = trucks_id(Trucks)
    array = zeros(1,length(Trucks));
    for i=1:length(Trucks)
            array(i) = Trucks(i).ID;
    end
end