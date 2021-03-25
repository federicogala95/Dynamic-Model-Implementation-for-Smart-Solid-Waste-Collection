function [Trucks_boss, Trucks_sub_id] = def_boss(Trucks_var,start_points)
    Trucks_boss = cell(1,length(start_points));
    for i = 1:length(start_points)
        for j= 1:length(Trucks_var)
            if Trucks_var(j).base == start_points(i)
                Trucks_boss{1,i} = Trucks_var(j);
                break
            end
        end
    end
    
    Trucks_sub_id = cell(1,length(start_points));
        
    for i = 1:length(start_points)
        id = [];
        for j= 1:length(Trucks_var)
            if Trucks_var(j).base == start_points(i)
                id = [id Trucks_var(j).ID];
                
            end
        end
        Trucks_sub_id{1,i} = id;
    end






end