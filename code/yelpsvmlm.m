M = xlsread('pitt.csv');

headers = {'longtitude','latitude','stars'};


long = M(:,1);
lat = M(:,2);
stars = M(:,3);

X = M(:,1:2);



threshold = 4;
region = [min(M(:,1)),max(M(:,1)),min(M(:,2)),max(M(:,2)),200];

P = cvpartition(stars,'Holdout',0.20);

train = X(P.training,:);



x1 = linspace(region(1),region(2),region(5));
y1 =  linspace(region(3),region(4),region(5));

%%NN = 0.1:0.1:2;
NN = 0.9;
[X1,Y1] = meshgrid(x1,y1);
figure()

iteration = 1;
errorRateAvgArray = zeros(length(NN),1);


for kk = 1:length(NN)
    errorRateAvg = 0;
 for ii = 1:iteration   

    
    stars_lbl  = stars > threshold;
    
    stars_lbl_train = stars_lbl(P.training,:);
    
    svmStruct = svmtrain(train,stars_lbl_train,'showplot',1,'kernel_function','rbf','rbf_sigma',NN(kk));
    C = svmclassify(svmStruct,X(P.test,:),'showplot',1);
    
    axis(region(1:4))
    errRate = sum(stars_lbl(P.test)~= C)/length(C);
    conMat = confusionmat(stars_lbl(P.test),C);
    
    
    

    
%     subplot(1,length(n),kk)
%     hold on
% %     for i = 1:region(5)
% %         for j = 1:region(5)
% %             
% %             if D(i,j) == 0
% %                 plot(x1(i),y1(j),'ko','MarkerSize',5, 'MarkerFaceColor','k');
% %             else 
% %                  plot(x1(i),y1(j),'bo','MarkerSize',5, 'MarkerFaceColor','b');
% %             end
% %             
% %         end
% %     end
%     
%     for i = 1:length(train)
%         if stars(i) <= 4
%         plot(train(i,1),train(i,2),'r.')
%         else
%             plot(train(i,1),train(i,2),'g.')
%         end
%     end
%     
%     contour(X1',Y1',D,[1,1],'k')
%     
%     hold off
%     
%     axis(region(1:4))
%     
%     test = X(P.test,:);
%     stars_lbl_test = stars_lbl(P.test,:);
% 
%        
%     error = 0;
% %     
% %     for i = 1:length(test)
% %         
% %         tmp = test(i,:);
% %         
% %         [~,a] = min(abs(tmp(1)-x1));
% %         [~,b] = min(abs(tmp(2)-y1));
% %         
% %         if nominal( D(a,b)) ~= nominal(stars_lbl_test(i)) 
% %             error = error + 1;
% %         end
% %         
% %         
% %     end
%     
%     errorRate = error/size(test,1);
%     
   errorRateAvg = errorRateAvg + errRate;
% 
 end
% 
     errorRateAvgArray(kk) = errorRateAvg/iteration;

end
% 
 
% 
%plot(NN,errorRateAvgArray)

