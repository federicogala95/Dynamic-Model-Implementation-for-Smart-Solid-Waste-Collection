function truckkind = trucksclass(trucks,string)
    truckkind=[];
    for i=1:length(trucks)
        if trucks(i).Kind==string
         truckkind=[truckkind; trucks(i)];           
        end
    end
   
end