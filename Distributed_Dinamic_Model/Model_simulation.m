%% VIDEO OF THE SIMULATION:
%{
Here we extract the data collected during the simulation in order to make a
video of the system evolution during the week schedule. Two videos are
produced:
-'Truck_simu'---> represents the moving trucks during the week
-'Waste_simu'---> represents the level of garbage during the week

This has been done separately mainly to reduce the computational time of
the simulation, which otherwise would have taken much more time due to the
need of further iterative cycle inside the "truck_m.m" script.
%}

WasteP_cell{1,DAY}{1,t}  =   G.Nodes.WasteP;
Traffic_cell{1,DAY}{1,t} =   G.Edges.Traffic;
TrucksPos_cell{1,DAY}{1,t} = Trucks_var(k).actpos(id);
ID_cell_cell{1,DAY}{1,t}   = id;
movieVector1 = [];
movieVector2 = [];
disp('--------------------')
disp('VIDEO MAKING OF THE SIMULATION: (Moving Trucks + Bin Waste Percentage)')
disp('')
for DAY = 1:length(WEEK)
    clear mV1;
    clear mV2;
    fprintf('Creation of the frames vector related to %s...\n',WEEK(DAY))
    for t = 1:length(WasteP_cell{1,DAY})
        if     t == round(0.25*length(WasteP_cell{1,DAY}))
            disp('       AT .........25 %')
        elseif t == round(0.5*length(WasteP_cell{1,DAY}))
            disp('       AT .........50 %')
        elseif t == round(0.75*length(WasteP_cell{1,DAY}))
            disp('       AT .........75 %')
        elseif t == length(WasteP_cell{1,DAY})
            disp(' FINISHED! ')
        end
        Waste_mat      = WasteP_cell{1,DAY}{1,t};
        Traffic_vec    = Traffic_cell{1,DAY}{1,t};
        Trucks_pos_vec = TrucksPos_cell{1,DAY}{1,t};
        ID_vec         = ID_cell_cell{1,DAY}{1,t};
        
        f1 = figure();
        title(" Moving Trucks " + "[" + WEEK(DAY) + "]")
        set(f1, 'Visible', 'off')
        plot_highlight;
        labelg = strings(1,length(Trucks_pos_vec));
        
            for i=1:length(Trucks_pos_vec)
                labelg(i) = Trucks(ID_vec(i)).label + Trucks(ID_vec(i)).Kind;
            end
            
        labelnode(h,Trucks_pos_vec,labelg);
        highlight(h,Trucks_pos_vec,'NodeColor','b','Marker','s','MarkerSize',10);
        
        f2 = figure();
        set(f2, 'Visible', 'off')
        plot3(xl,yl,Waste_mat(:,1),'*',xl,yl,Waste_mat(:,2),'*',xl,yl,Waste_mat(:,3),'*',xl,yl,Waste_mat(:,4),'*',xl,yl,Waste_mat(:,5),'*')
        legend(trucks_kind);
        xlabel('Nodes')
        zlabel('Waste [Percentage]')
        title("Collected Waste at time:" + num2str(t) + "[" + WEEK(DAY) + "]");
        
        mV1(t) = getframe(f1);
        mV2(t) = getframe(f2);
   
    end
    movieVector1 = [movieVector1 mV1];
    movieVector2 = [movieVector2 mV2];  
end

disp('--------------------')
name = 'Trucks_Simu';
disp('REALIZATION OF THE MOVING TRUCK VIDEO:')
myWriter1 = VideoWriter(name);
myWriter1.FrameRate = 1;
open(myWriter1);
writeVideo(myWriter1, movieVector1);
close(myWriter1);
sprintf('Video making finished! \n Saved in Current Folder as "%s" ', string(name))

disp('--------------------')
name = 'Waste_Simu';
disp('REALIZATION OF THE BIN WASTE PERCENATGE VIDEO:')
myWriter2 = VideoWriter(name);
myWriter2.FrameRate = 1;
open(myWriter2);
writeVideo(myWriter2, movieVector2);
close(myWriter2);
sprintf('Video making finished! \n Saved in Current Folder as "%s" ', string(name))