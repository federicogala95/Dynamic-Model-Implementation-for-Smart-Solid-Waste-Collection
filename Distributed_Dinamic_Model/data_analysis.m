for j=1:length(WEEK)
    figure(j)
    title(WEEK(j))
    for i=1:length(trucks_kind)
        plot(overwaste_cell{1,j}(:,i), 'o'); 
        title("BINS OVER LIMIT :"+WEEK(j))
        hold on;
        legend(trucks_kind);
        xlabel('Collection steps')
        ylabel(' Number of Bins Above Limit')
    end
end
%%
for j=1:length(WEEK)
    figure(j)
    title(WEEK(j))
    for i=1:length(distance_cell{1,j}(1,:))
        plot(distance_cell{1,j}(:,i)/1000); 
        title("TRAVELLED DISTANCE :"+WEEK(j))
        hold on;
        legend(string(ID_cell{1,j}{1,1}));
        xlabel('Collection steps')
        ylabel('Distance [Km]')
    end
end
%%

for j=1:length(WEEK)
    figure(j)
    title(WEEK(j))
    for i=1:length(move_spent_time_cell{1,j}(1,:))
        plot(move_spent_time_cell{1,j}(:,i)); 
        title("SPENT TIME :"+WEEK(j))
        hold on;
        legend(string(ID_cell_cell{1,j}{1,1}));
        xlabel('Collection steps')
        ylabel('Time [Minute]')
    end
end
%%

for j=1:length(WEEK)
    figure(j)
    title(WEEK(j))
    for i=1:length(collected_waste_cell{1,j}(1,:))
        plot(collected_waste_cell{1,j}(:,i)); 
        title("COLLECTED WASTE :"+WEEK(j)+" ["+Waste_Schedule(1,j)+","+Waste_Schedule(2,j)+"] ")
        hold on;
        legend("T"+string(ID_cell_cell{1,j}{1,1}));
        xlabel('Collection steps')
        ylabel('Waste [Kg]')
    end
end
    
    
    
    
    
    
    