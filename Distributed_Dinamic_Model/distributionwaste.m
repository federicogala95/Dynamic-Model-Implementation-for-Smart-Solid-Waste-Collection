% Waste Stochastic Distributions representations:
n_cits = 10^5;
n_bins = [268 210 361 166 752];
dailywaste_max =  [0.3300    0.2100    0.3900    0.2300    1.0000];
dailywaste_min =  [0.2500    0.1500    0.3600    0.1500    0.8000];
dailywaste_mean =  [0.2900    0.1800   0.3750    0.1900    0.9000];
trucks_kind
titles = ["ORGANIC" "PLASTIC" "PAPER" "GLASS" "RESIDUAL"];
for i=1:5
    figure(i);
    pos = find(~isnan(G.Nodes.WasteP(:,i)));
    mean_consume = 0.5*(dailywaste_min(i)+dailywaste_mean(i))*n_cits*(1/(24*12*n_bins(i))); 
    sigma_consume  = 1/3*(mean_consume-dailywaste_min(i)*n_cits*(1/(24*12*n_bins(i))));
    x1 = abs(normrnd(mean_consume,sigma_consume,length(pos),1)); 
    y1 = normpdf(sort(x1),mean_consume,sigma_consume);
    
    mean_consume = dailywaste_mean(i)*n_cits*(1/(24*12*n_bins(i))); 
    sigma_consume  = 1/6*(mean_consume-dailywaste_min(i)*n_cits*(1/(24*12*n_bins(i))));
    kg_waste2 = abs(normrnd(mean_consume,sigma_consume,length(pos),1)); 
    x2 = abs(normrnd(mean_consume,sigma_consume,length(pos),1)); 
    y2 = normpdf(sort(x2),mean_consume,sigma_consume);
    
    mean_consume = 0.5*(dailywaste_max(i)+dailywaste_mean(i))*n_cits*(1/(24*12*n_bins(i)));
    delta_consume  = 1/3*(dailywaste_max(i)*n_cits*(1/(24*12*n_bins(i)))-mean_consume);
    kg_waste3 = abs(normrnd(mean_consume,sigma_consume,length(pos),1));
    x3 = abs(normrnd(mean_consume,sigma_consume,length(pos),1)); 
    y3 = normpdf(sort(x3),mean_consume,sigma_consume);
    plot(sort(x1),y1,sort(x2),y2,sort(x3),y3);
    title(titles(i));
    legend('low','medium','high');
    xlabel('Waste Production [Kg/bin*5min]');
    ylabel('Pdf')
end

 

% for i=1:5
%     figure(i);
%     pos = find(~isnan(G.Nodes.WasteP(:,i)));
%     mean_consume = 0.5*(dailywaste_min(i)+dailywaste_mean(i)); 
%     sigma_consume  = 1/3*(mean_consume-dailywaste_min(i));
%     x1 = abs(normrnd(mean_consume,sigma_consume,length(pos),1)); 
%     y1 = normpdf(sort(x1),mean_consume,sigma_consume);
%     
%     mean_consume = dailywaste_mean(i); 
%     sigma_consume  = 1/6*(mean_consume-dailywaste_min(i));
%     kg_waste2 = abs(normrnd(mean_consume,sigma_consume,length(pos),1)); 
%     x2 = abs(normrnd(mean_consume,sigma_consume,length(pos),1)); 
%     y2 = normpdf(sort(x2),mean_consume,sigma_consume);
%     
%     mean_consume = 0.5*(dailywaste_max(i)+dailywaste_mean(i));
%     delta_consume  = 1/3*(dailywaste_max(i)-mean_consume);
%     kg_waste3 = abs(normrnd(mean_consume,sigma_consume,length(pos),1));
%     x3 = abs(normrnd(mean_consume,sigma_consume,length(pos),1)); 
%     y3 = normpdf(sort(x3),mean_consume,sigma_consume);
%     plot(sort(x1),y1,sort(x2),y2,sort(x3),y3,'LineWidth',2);
%     xline(dailywaste_min(i),'k--','LineWidth',2);
%     xline(dailywaste_max(i),'k--','LineWidth',2);
%     title(titles(i)+" WASTE KIND DISTRIBUTION");
%     legend('low rate','medium rate','high rate','limit range values');
%     xlabel('Waste Production [Kg/day*citizen]');
%     ylabel('Pdf')
% end