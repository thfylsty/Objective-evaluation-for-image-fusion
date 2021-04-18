function f=MyEntroy(h)
%H return entropy of the image          求图像的熵
%input must be a imagehandle            输入图像句柄
%image fusion evaluate parameter        图像融合评价参数
%    example
%      i=imread('imagename.bmp');
%      f=H(i); 
% 熵值的大小表示图像所包含的平均信息量的多少，反映了图像中具有不同灰度值像素的概率分布
% 熵越大说明图像的融合效果越好。
s=size(size(h));
if s(2)==3
    h1=rgb2gray(h);
else
    h1=h;
end    
h1=double(h1);
[m,n]=size(h1);
X=zeros(1,256);
result=0;
%统计原图各灰度级像素
for i=1:m
    for j=1:n
        X(h1(i,j)+1)=X(h1(i,j)+1)+1;
    end
end
%计算各灰度级象素出现的概率
for k=1:256
    P(k)=X(k)/(m*n);
    if (P(k)~=0)
        result=P(k)*log2(P(k))+result;
    end
end
result=-result;
f=result;
end
