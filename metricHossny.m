function res=metricHossny(im1,im2,fim)

% function res=metricHossny(im1,im2,fim)
%
% This function implements Hossny's algorithms for fusion metric.
% im1, im2 -- input images;
% fim      -- fused image;
% res      -- metric value;
%
% IMPORTANT: The size of the images need to be 2X. 
% Wavelet toolbox is needed.
% See also: mutual_info.m, evalu_fusion.m
%
%
% Z. Liu [July 2009]
%

% Ref: Feature-based Image Fusion Quality Metrics
% by Mohammed Hossny et al.
% ICIRA 2008

%% pre-processing
im1=double(im1);
im2=double(im2);
fim=double(fim);

%% caculate the entropy map

% set up the size of local window, a square window
windowSize=7;

E_im1=nlfilter(im1,[windowSize windowSize],'entropy');
E_im2=nlfilter(im2,[windowSize windowSize],'entropy');
E_fim=nlfilter(fim,[windowSize windowSize],'entropy');

% need to remove the edge 
bian=floor((windowSize+1)/2);
[hang,lie]=size(im1);

%[nhang nlie]=[hang lie]-bian*2;
nhang=hang-bian*2;
nlie=lie-bian*2;

E_im1=wkeep(E_im1,[nhang nlie]);
E_im2=wkeep(E_im2,[nhang nlie]);
E_fim=wkeep(E_fim,[nhang nlie]);

% importance map
p1=E_im1./(max(E_im1(:)));
p2=E_im2./(max(E_im2(:)));

[mssim1, ssim_map1, sigma1_sq1,sigma2_sq1] = ssim_hossny(E_im1, E_fim);
[mssim2, ssim_map2, sigma1_sq2,sigma2_sq2] = ssim_hossny(E_im2, E_fim);

[rows,cols]=size(ssim_map1);

nhang=min(nhang,rows);
nlie=min(nlie,cols);

p1=wkeep(p1,[nhang nlie]);
p2=wkeep(p2,[nhang nlie]);

ssim_map1=wkeep(ssim_map1,[nhang nlie]);
ssim_map2=wkeep(ssim_map2,[nhang nlie]);

E1=p1.*ssim_map1;
E2=p2.*ssim_map2;

% !!! here, more processing may be needed; (might be divided by zero)
S_xf=E_m1./E_fim;
S_yf=E_m2./E_fim;

ramda=S_xf./(S_xf+S_yf);
E=ramda.*E1_(1-ramda).*E2;

res=mean2(1-E);


%% sub-function

function [mssim, ssim_map, sigma1_sq,sigma2_sq] = ssim_hossny(img1, img2)

%========================================================================

[M N] = size(img1);
if ((M < 11) | (N < 11))
   ssim_index = -Inf;
   ssim_map = -Inf;
  return
end
window = fspecial('gaussian', 7, 1.5);	%

L = 255;                                  %

C1 = 2e-16;
C2 = 2e-16;

window = window/sum(sum(window));
img1 = double(img1);
img2 = double(img2);
mu1   = filter2(window, img1, 'valid');
mu2   = filter2(window, img2, 'valid');
mu1_sq = mu1.*mu1;
mu2_sq = mu2.*mu2;
mu1_mu2 = mu1.*mu2;
sigma1_sq = filter2(window, img1.*img1, 'valid') - mu1_sq;
sigma2_sq = filter2(window, img2.*img2, 'valid') - mu2_sq;
sigma12 = filter2(window, img1.*img2, 'valid') - mu1_mu2;
if (C1 > 0 & C2 > 0)
   ssim_map = ((2*mu1_mu2 + C1).*(2*sigma12 + C2))./((mu1_sq + mu2_sq + C1).*(sigma1_sq + sigma2_sq + C2));
else
   numerator1 = 2*mu1_mu2 + C1;
   numerator2 = 2*sigma12 + C2;
    denominator1 = mu1_sq + mu2_sq + C1;
   denominator2 = sigma1_sq + sigma2_sq + C2;
   ssim_map = ones(size(mu1));
   
   index = (denominator1.*denominator2 > 0);
   ssim_map(index) = (numerator1(index).*numerator2(index))./(denominator1(index).*denominator2(index));
   index = (denominator1 ~= 0) & (denominator2 == 0);
   ssim_map(index) = numerator1(index)./denominator1(index);
end
mssim = mean2(ssim_map);
return



