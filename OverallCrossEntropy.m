function [MCE] = OverallCrossEntropy(imga,imgb,imgf)
%% Over All Cross Entropy-总体交叉熵
% OCE有两种计算方法，即平均交叉熵和均方根交叉熵，值越小说明融合图像从源图像中提取的信息越多，融合效果越好。
G1=double(imga);
G2=double(imgb);
G=double(imgf);
[m1,n1,p1]=size(G1);
[m2,n2,p2]=size(G2);
[m,n]=size(G);
m2=m1;
n2=n1;
X1=zeros(1,256);
X2=zeros(1,256);
X=zeros(1,256);

CEAF=0;
%统计两图各灰度级像素
for i=1:m1
    for j=1:n1
        X1(G1(i,j)+1)=X1(G1(i,j)+1)+1;
        X2(G2(i,j)+1)=X2(G2(i,j)+1)+1;
        X(G(i,j)+1)=X(G(i,j)+1)+1;
    end
end
%计算两图各灰度级象素出现的概率
for k=1:256
    P1(k)=X1(k)/(m1*n1);
    P(k)=X(k)/(m*n);
    if((P1(k)~=0)&(P(k)~=0))
        CEAF=CEAF+P1(k)*log2(P1(k)/P(k));
    end
end
% sprintf('源图像A 与 融合图像 F 之间的交叉熵为 : %.4f ',CEAF)

CEBF=0;
for k=1:256
    P2(k)=X2(k)/(m2*n2);
    P(k)=X(k)/(m*n);
    if((P2(k)~=0)&(P(k)~=0))
        CEBF=CEBF+P2(k)*log2(P2(k)/P(k));
    end
end
% sprintf('源图像B 与 融合图像 F 之间的交叉熵为 : %.4f ',CEBF)

MCE=(CEAF+CEBF)/2;
% sprintf('源图像与融合图像之间的平均交叉熵为 : %.4f ',MCE)

% RCE=sqrt((CEAF+CEBF)/2);
% sprintf('源图像与融合图像之间的均方根交叉熵为 : %.4f ',RCE)

% [COUNTSA,X]=imhist(imga);
% % PA=COUNTSA/(M*N);  %modified histogram,计算概率分布-calculation of the probability distributation
% for i=1:length(X)
%     PA(i)=COUNTSA(i)/prod(size(imga));  
% end  %该方法同上,都是计算P(i)表示灰度值为i的像素数目Ni 与 图像总像素数 N 之比，可看作图像的归一化直方图
% 
% [COUNTSB,Y]=imhist(imgb);
% for i=1:length(Y)
%     PB(i)=COUNTSB(i)/prod(size(imgb));  
% end 
% 
% [COUNTSF,F]=imhist(imgf);
% for i=1:length(F)
%     PF(i)=COUNTSF(i)/prod(size(imgf));  
% end 
% 
% CEAF=0;
% for j=1:length(X)
%     if((PA(j)~=0)&(PF(j)~=0))
%         CEAF=CEAF+PA(j)*(log2(PA/PF));
%     end
% end
% sprintf('源图像A 与 融合图像 F 之间的交叉熵为 : %.4f ',CEAF)
% 
% CEBF=0;
% for j=1:length(Y)
%     if((PB(j)~=0)&(PF(j)~=0))
%         CEBF=CEBF+PB(j)*(log2(PB/PF));
%     end
% end
% sprintf('源图像B 与 融合图像 F 之间的交叉熵为 : %.4f ',CEBF);
% 
% MCE=(CEAF+CEBF)/2;
% sprintf('源图像与融合图像之间的平均交叉熵为 : %.4f ',MCE)