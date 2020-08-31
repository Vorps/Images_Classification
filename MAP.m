function [thresh, matrix] = MAP(X1, X2)
    [N1,edges1] = histcounts(X1,10000);
    [N2,edges2] = histcounts(X2,10000);
    thresh = edges1(1);
    dt = (max(edges2)-min(edges1))/10000;
    edges1(end) = [];
    edges2(end) = [];
    for i= 1:10000
        if(sum(N1(edges1 > thresh)) < sum(N2(edges2 < thresh)))
            matrix = [sum(N1(edges1 < thresh)), sum(N2(edges2 > thresh)); sum(N1(edges1 > thresh)), sum(N2(edges2 < thresh))];
            break;
        end
        thresh = thresh + dt;
    end
end