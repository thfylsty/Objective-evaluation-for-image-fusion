function res=fusionAssess(im1,im2,fused)

% function res=fusionAssess(im1,im2,fused)
%
% This function is to assess the fused image with different fusion
% assessment metrics.
% 
% im1   ---- input image one;
% im2   ---- input image two;
% fused ---- the fused image(s)
% res   ==== the metric value
%
% Z. Liu @ NRCC [Aug 21, 2009]
%

im1=double(im1);
im2=double(im2);


% check the number of the fused images.
num=prod(size(fused));

% if (num==1)
%     disp('Only one fused image is used.');
% end

% caculate the image fusion metrics:

for i=1:num;
    % normalized mutual informtion $Q_{MI}$
    Q(i,1)=metricMI(im1,im2,fused{i},1);
    
    % Tsallis entropy $Q_{TE}$
    Q(i,2)=metricMI(im1,im2,fused{i},3);

    % Wang - NCIE $Q_{NCIE}$
    Q(i,3)=metricWang(im1,im2,fused{i});
    
    % Xydeas $Q_G$
    Q(i,4)=metricXydeas(im1,im2,fused{i});
    
    % PWW $Q_M$
    Q(i,5)=metricPWW(im1,im2,fused{i});
    
    %Yufeng Zheng (spatial frequency) $Q_{SF}$
    Q(i,6)=metricZheng(im1,im2,fused{i});
    
    % Zhao (phase congrency) $Q_P$
    Q(i,7)=metricZhao(im1,im2,fused{i});
    
    % Piella  (need to select only one) $Q_S$
    % Q(i,8)=index_fusion(im1,im2,fused{i});
    Q(i,8)=metricPeilla(im1,im2,fused{i},1);
    
    % Cvejie $Q_C$
    Q(i,9)=metricCvejic(im1,im2,fused{i},2);
    
    % Yang $Q_Y$
    Q(i,10)=metricYang(im1,im2, fused{i});
    
    % Chen-Varshney $Q_{CV}$
    Q(i,11)=metricChen(im1,im2,fused{i});
      
    % Chen-Blum $Q_{CB}$
    Q(i,12)=metricChenBlum(im1,im2,fused{i});
       
    
end

res=Q;
