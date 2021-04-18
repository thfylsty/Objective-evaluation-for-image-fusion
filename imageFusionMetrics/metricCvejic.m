function res=metricCvejic(im1,im2,fim,sw)

% function res=metricCvejic(im1,im2,fim,sw)
%
% This function implements Chen's algorithm for fusion metric.
% im1, im2 -- input images;
% fim      -- fused image;
% res      -- metric value;
% sw       -- 1: metric 1; 2: metric 2. Cvejic has two different metics.
%
% IMPORTANT: The size of the images need to be 2X. 
%
% Z. Liu [July 2009]
%

% Ref: Metric for multimodal image sensor fusion, Electronics Letters, 43 (2) 2007 
% by N. Cvejic et al.
%
% Ref: A Similarity Metric for Assessment of Image Fusion Algorithms, International Journal of Information and Communication Engineering 2 (3) 2006, pp.178-182.
% by N. Cvejic et al.
%


%% pre-processing
im1=double(im1);
im2=double(im2);
fim=double(fim);

switch sw
    
    % metric No.1
    case 1 
        disp('The 1st metric of Cvejic.');
        %% Step 1: extract edge information

        flt1=[-1 0 1 ; -2 0 2 ; -1 0 1];
        flt2=[-1 -2 -1; 0 0 0; 1 2 1];

        % 1) get the map

        fuseX=filter2(flt1,fim,'same');
        fuseY=filter2(flt2,fim,'same');
        fuseG=sqrt(fuseX.*fuseX+fuseY.*fuseY);

        buffer=(fuseX==0);
        buffer=buffer*0.00001;
        fuseX=fuseX+buffer;
        fuseA=atan(fuseY./fuseX);


        img1X=filter2(flt1,im1,'same');
        img1Y=filter2(flt2,im1,'same');
        im1G=sqrt(img1X.*img1X+img1Y.*img1Y);

        buffer=(img1X==0);
        buffer=buffer*0.00001;
        img1X=img1X+buffer;
        im1A=atan(img1Y./img1X);

        img2X=filter2(flt1,im2,'same');
        img2Y=filter2(flt2,im2,'same');
        im2G=sqrt(img2X.*img2X+img2Y.*img2Y);

        buffer=(img2X==0);
        buffer=buffer*0.00001;
        img2X=img2X+buffer;
        im2A=atan(img2Y./img2X);
        
        % to be finished ************************
        res=0;
        
        
    case 2;
         disp('The 2nd metric of Cvejic.');
%        [mssim1, ssim_map1, sigma_XY] = ssim_yang(im1, im2);
        [mssim2, ssim_map2, sigma_XF] = ssim_yang(im1, fim);
        [mssim3, ssim_map3, sigma_YF] = ssim_yang(im2, fim);
        
        simXYF=sigma_XF./(sigma_XF+sigma_YF);
        sim=simXYF.*ssim_map2+(1-simXYF).*ssim_map3;
        
        index=find(simXYF<0);
        sim(index)=0;
        
        index=find(simXYF>1);
        sim(index)=1;
        res=mean2(sim);
        
    otherwise
        disp('Please choose 1 or 2.');
end

return;

%%
function [mssim, ssim_map, sigma12] = ssim_yang(img1, img2)

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

