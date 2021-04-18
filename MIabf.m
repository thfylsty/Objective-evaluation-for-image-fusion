function [h] = MIabf(image_1,image_2,image_F)
% [h] = MI(image_1,image_2,image_F) - 计算图像之间的互信息
% image_1 - 输入图像1(源图像)数据 
% image_2 - 输入图像2(源图像)数据
% image_F - 输入图像F（融合图像）数据
% h - 返回获得的互信息
%%%%%%%%%%%%%%%%%%%调用方式%%%%%%%%%%%%%%%%%%%%%%%%%%
% image_1 = imread('test1.jpg');
% image_2 = imread('test2.jpg');
% image_F = imread('fusion.jpg');
% [h] = MI(image_1,image_2,image_F);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 检查输入的图像数据尺寸是否相等
[row1 col1] = size(image_1);
[row2 col2] = size(image_2);
[rowF colF] = size(image_F);
% if (row1 ~= row2) || (col1 ~= col2)||(rowF ~= row2)||(colF ~= col2)
%     error('图像数据尺寸不相等！！！');
% end;

% 计算输入图像数据的信息熵
e1 = ENTROPY(image_1);
e2 = ENTROPY(image_2);
eF = ENTROPY(image_F);

% 分别计算源图像与融合图像之间的联合信息熵
eF1 = Hab(image_1,image_F);
eF2 = Hab(image_2,image_F);
% 分别计算源图像与融合图像之间的互信息
MIF1 = e1+eF-eF1;
MIF2 = e2+eF-eF2;
% 计算并返回互信息
h = MIF1+MIF2;
sprintf('融合图像的互信息MI的值为 : %.4f ',h);  

function [e] = ENTROPY(image)
% [e] = ENTROPY(image) - 计算输入图像数据的信息熵
[row,col] = size(image);
counter = zeros(256,256);

% 统计直方图
image = image+1;
for i=1:row
    for j=1:col
        index = image(i,j);
        counter(index) = counter(index)+1;
    end
end
% 计算图像信息熵
total= row*col;
index = find(counter~=0);
p = counter./total;

% 获得并返回图像信息熵
e = sum(sum(-p(index).*log2(p(index))));   

function [HabR] = Hab(image_1,image_2)
% [HabR] = Hab(image_1,image_2) - 计算两幅图像的联合信息熵
% image_1 - 输入图像1数据 
% image_2 - 输入图像2数据 

% 获取图像数据的大小及生成计数器
[row,col] = size(image_1);
counter = zeros(256,256);

% 统计直方图
image_1 = image_1+1;
image_2 = image_2+1;
for i=1:row
    for j=1:col
        index_1 = image_1(i,j);
        index_2 = image_2(i,j);
        counter(index_1,index_2) = counter(index_1,index_2)+1;  %联合直方图
    end
end
% counter=counter./(row*col);
% 
% % 计算AB的联合熵
% HabR=0;
% for i=1:256
%     for j=1:256
%         if counter(i,j)~=0;
%             HabR=HabR-counter(i,j)*log2(counter(i,j));
%         end
%     end
% end
% 计算联合信息熵
total= row*col;
index = find(counter~=0);
p = counter./total;

% 获得并返回联合信息熵
HabR = sum(sum(-p(index).*log2(p(index))));   