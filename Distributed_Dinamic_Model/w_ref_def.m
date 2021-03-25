function vec = w_ref_def(G,actpos)

    radius = 1000;
    
    close = nearest(G,actpos,radius);
    
    v1 = find(~isnan(G.Nodes.WasteP(close,1)));
    mean1 = mean(G.Nodes.WasteP(close(v1),1));
    
    v2 = find(~isnan(G.Nodes.WasteP(close,2)));
    mean2 = mean(G.Nodes.WasteP(close(v2),2));
    
    v3 = find(~isnan(G.Nodes.WasteP(close,3)));
    mean3 = mean(G.Nodes.WasteP(close(v3),3));
    
    v4 = find(~isnan(G.Nodes.WasteP(close,4)));
    mean4 = mean(G.Nodes.WasteP(close(v4),4));
    
    v5 = find(~isnan(G.Nodes.WasteP(close,5)));
    mean5 = mean(G.Nodes.WasteP(close(v5),5));
    
    vec = [mean1 mean2 mean3 mean4 mean5];


end