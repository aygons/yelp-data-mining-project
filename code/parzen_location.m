M = xlsread('pitt.csv');

headers = {'longtitude','latitude','stars'};


long = M(:,1);
lat = M(:,2);
stars = M(:,3);

X = M(:,1:2);



threshold = 2.5:0.5:3;
region = [min(M(:,1)),max(M(:,1)),min(M(:,2)),max(M(:,2)),200];

P = cvpartition(stars,'Holdout',0.20);

train = X(P.training,:);



NN = 0.005;

x1 = linspace(region(1),region(2),region(5));
y1 =  linspace(region(3),region(4),region(5));



[X1,Y1] = meshgrid(x1,y1);

for kk = 1:length(NN)
    figure()
    
for k = 1: length(threshold)
    
    stars_lbl  = stars > threshold(k);
    
    stars_lbl_train = stars_lbl(P.training,:);
    
    D = parzen(train',stars_lbl_train',NN(kk),region);
    
    

    
    subplot(1,5,k)
    hold on
    for i = 1:region(5)
        for j = 1:region(5)
            
            if D(i,j) == 0
                plot(x1(i),y1(j),'ko','MarkerSize',5, 'MarkerFaceColor','k');
            else 
                 plot(x1(i),y1(j),'bo','MarkerSize',5, 'MarkerFaceColor','b');
            end
            
        end
    end
    
    for i = 1:length(train)
        if stars(i) <= threshold(k)
        plot(train(i,1),train(i,2),'r.')
        else
            plot(train(i,1),train(i,2),'g.')
        end
    end
    
    contour(X1',Y1',D,[1,1])
    
    hold off
    
    axis(region(1:4))
    
    test = X(P.test,:);
    stars_lbl_test = stars_lbl(P.test,:);
    
    cost = 0;
    
    train_count0 = length(stars_lbl_train) - sum(stars_lbl_train) ;
    train_count1 = sum(stars_lbl_train);
    
    cost0 = train_count1/length(stars_lbl_train);
    cost1 = train_count0/length(stars_lbl_train);
    
    
    
    
    for i = 1:length(test)
        
        tmp = test(i,:);
        
        [~,a] = min(abs(tmp(1)-x1));
        [~,b] = min(abs(tmp(2)-y1));
        
        if nominal( D(a,b)) ~= nominal(stars_lbl_test(i)) && D(a,b)==0 
            
            
            cost = cost + cost0;
        elseif nominal( D(a,b)) ~= nominal(stars_lbl_test(i)) && D(a,b)==1
             cost = cost + cost1;       
        end
        
        
    end
    
    costAvg = cost/length(test)
    
    
end
end





