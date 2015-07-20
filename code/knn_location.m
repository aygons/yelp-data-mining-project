% matlab_knn_location_mining_euclidean
clear
clc

% variables
niter = 100;
distance_type = [cellstr('euclidean'); cellstr('mahalanobis'); cellstr('cityblock')];
ldata = xlsread('pitt.csv');
best = [];
a=0;
b=0;
min_error_rate = 9999;

% read in features (coordinates) and class labels (ratings)
coordinates = [ldata(:,1), ldata(:,2)];
ratings = ldata(:,3);


train_coordinates = coordinates;
train_ratings = ratings;

for k = 2:20
    for cut = 4
        totalError = 0;
        train_ratings = ratings;
        
        for j = 1:size(train_coordinates,1)
            if train_ratings(j) < cut
                train_ratings(j) = 0;
            else
                train_ratings(j) = 1;
            end
        end
        
        for i = 1:niter
            P = cvpartition(train_ratings,'Holdout',0.20);

            m1 = fitcknn(train_coordinates(P.training,:),train_ratings(P.training),'Distance','euclidean','NumNeighbors',k);
            m1.Cost=[0 2;1 0];
            pred = predict(m1,train_coordinates(P.test,:));
            errRate = sum(train_ratings(P.test)~= pred)/P.TestSize;
            totalError = totalError + errRate;
        end
    
        a=[a,k];
        b=[b,totalError/niter];
        
        if totalError/niter < min_error_rate
            min_error_rate = totalError/niter;
            best = [cut,k,min_error_rate];
        end
        
    end
end

plot(a(2:end),b(2:end),'LineWidth',1)
% plot(k_value(2:end),store_error_rate(2:end),'LineWidth')
title('Error Rate with Different Selections of k and Distance Type') % title
xlabel('k values') % x-axis label
ylabel('Error Rate') % y-axis label

hold on

% variables
best3 = [];
e=0;
f=0;
min_error_rate = 9999;

train_coordinates = coordinates;
train_ratings = ratings;

for k = 2:20
    for cut = 4
        totalError = 0;
        train_ratings = ratings;
        
        for j = 1:size(train_coordinates,1)
            if train_ratings(j) < cut
                train_ratings(j) = 0;
            else
                train_ratings(j) = 1;
            end
        end
        
        for i = 1:niter
            P = cvpartition(train_ratings,'Holdout',0.20);

            m1 = fitcknn(train_coordinates(P.training,:),train_ratings(P.training),'Distance','cityblock','NumNeighbors',k);
            m1.Cost=[0 2;1 0];
            pred = predict(m1,train_coordinates(P.test,:));
            errRate = sum(train_ratings(P.test)~= pred)/P.TestSize;
            totalError = totalError + errRate;
        end
    
        e=[e,k];
        f=[f,totalError/niter];
        
        if totalError/niter < min_error_rate
            min_error_rate = totalError/niter;
            best3 = [cut,k,min_error_rate];
        end
        
    end
end

plot(e(2:end),f(2:end),'r','LineWidth',1)

legend('Euclidean','City Block','Location','southeast')
