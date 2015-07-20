function ParzenPlot2D(n, h1)
%train = mvnrnd([0 0],[1 0;0 1],n);
train = rand(n,2);

x = -3:0.1:3;
y = -3:0.1:3;
for i=1:length(x)
for j=1:length(y)
f(i,j) = Parzen2D(train, [x(i) y(j)], h1);
end
end
surf(x, y, f);
end


function density = Parzen2D(train_patterns, x, h1)
n = length(train_patterns);
hn = h1/sqrt(sqrt(n));
Vn = hn^2;
S = 0;

for i = 1:n,
S = S + mvnpdf((x-train_patterns(i,:))./hn);
end
density = S/n/Vn;
%End Parzen

end