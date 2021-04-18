function SF = space_frequency(X)
X = double(X);
[n0,m0] = size(X);
RF = 0;
CF = 0;
%% 计算行频率
for fi = 1:n0
    for fj = 2:m0
        RF = RF+(X(fi,fj)-X(fi,fj-1)).^2;
    end
end
RF = RF/(n0*m0);
%% 计算列频率
for fi = 2:m0
    for fj = 1:n0
        CF = CF+(X(fi,fj)-X(fi-1,fj)).^2;
    end
end
CF = CF/(n0*m0);
%% 计算空间频率
SF = sqrt(RF+CF);
end