function SF = MySF(imgf)
%% SF(空间频率) of the Fusion Image - 计算融合图像的空间频率SF
% image fusion evaluate parameter - 图像融合评价参数
%    Example：
%      I = imread('imagename.jpg/bmp');
%      SF = MySF(I);
s = size(size(imgf));
if s(2) == 3
    imgf = rgb2gray(imgf);
end    

G = double(imgf);
[m,n] = size(G);
c1 = 0;
c2 = 0;

% 计算行频
for i = 1:m
    for j = 2:n
        w1 = G(i,j)-G(i,j-1);
        c1 = c1+w1^2;
    end
end
r = sqrt(c1/(m*n));

% 计算列频
for i = 2:m
    for j = 1:n
        w2 = G(i,j)-G(i-1,j);
        c2 = c2+w2^2;
    end
end
c = sqrt(c2/(m*n));

% 计算图像的空间频率
SF = sqrt(r^2+c^2);

%% 
% rf = 0;cf = 0;
% for i = 1:m
%     for j = 2:n
%         rf = rf+(imgf(i,j)-imgf(i,j-1))^2;
%     end
% end
% rf = rf/(m*n);    %计算行频
% 
% for j = 1:n
%     for i = 2:m
%         cf = cf+(imgf(i,j)-imgf(i-1,j))^2;
%     end
% end
% cf = cf/(m*n);    %计算列频
% 
% SF = sqrt(double(rf+cf))