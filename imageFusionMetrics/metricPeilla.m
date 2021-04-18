function res=metricPeilla(img1,img2,fuse,sw)

% function res=index_fusion(img1,img2,fuse,sw)
%
% This function is to calculate the fusion quality index proposed by
% im1, im2 -- input images;
% fim      -- fused image;
% res      -- metric value;
% sw       -- See the reference paper for three different outputs.
% 
% NOTE: ssim_index.m is needed. 
%
% Z. Liu @NRCC [4 Oct 2003]
%

% Ref: A new quality metric for image fusion, ICIP 2003
% by Piella et al. 
%

[ssim,ssim_map,sigma1_sq,sigma2_sq]=ssim_index(img1,img2);
clear ssim, ssim_map;

buffer=sigma1_sq+sigma2_sq;
test=(buffer==0); test=test*0.5;
sigma1_sq=sigma1_sq+test; sigma2_sq=sigma2_sq+test;

buffer=sigma1_sq+sigma2_sq;
ramda=sigma1_sq./buffer;

[ssim1,ssim_map1]=ssim_index(fuse,img1);
[ssim2,ssim_map2]=ssim_index(fuse,img2);

switch sw
    case 1
        Q=ramda.*ssim_map1+(1-ramda).*ssim_map2;
        %disp('fusion quality index: ');
        %mean2(Q)
%        res(1)=mean2(Q);
        res=mean2(Q);

    case 2
        
        % weighted fusion qualtiy index
        buffer(:,:,1)=sigma1_sq;
        buffer(:,:,2)=sigma2_sq;
        [Cw,U]=max(buffer,[],3);

        cw=Cw/sum(sum(Cw));
        Q=sum(sum(cw.*(ramda.*ssim_map1+(1-ramda).*ssim_map2)));
        %disp('weighted fusion quality index: ');
        %Q
%        res(2)=Q;
        res=Q;
% edge-dependent fusion quality index
    case 3
        flt1=[1 0 -1; 1 0 -1; 1 0 -1];
        flt2=[ 1 1 1; 0 0 0; -1 -1 -1];

        fuseX=filter2(flt1,fuse,'same');
        fuseY=filter2(flt2,fuse,'same');
        fuseF=sqrt(fuseX.*fuseX+fuseY.*fuseY);

        img1X=filter2(flt1,img1,'same');
        img1Y=filter2(flt2,img1,'same');
        img1F=sqrt(img1X.*img1X+img1Y.*img1Y);

        img2X=filter2(flt1,img2,'same');
        img2Y=filter2(flt2,img2,'same');
        img2F=sqrt(img2X.*img2X+img2Y.*img2Y);


        [ssim,ssim_map,sigma1_sq,sigma2_sq]=ssim_index(img1F,img2F);
        clear ssim, ssim_map;

        buffer=sigma1_sq+sigma2_sq;
        test=(buffer==0); test=test*0.5;
        sigma1_sq=sigma1_sq+test; sigma2_sq=sigma2_sq+test;

        buffer=sigma1_sq+sigma2_sq;
        ramda=sigma1_sq./buffer;

        [ssim1,ssim_map1]=ssim_index(fuseF,img1F);
        [ssim2,ssim_map2]=ssim_index(fuseF,img2F);

        buffer(:,:,1)=sigma1_sq;
        buffer(:,:,2)=sigma2_sq;
        [Cw,U]=max(buffer,[],3);

        cw=Cw/sum(sum(Cw));
        Qw=sum(sum(cw.*(ramda.*ssim_map1+(1-ramda).*ssim_map2)));

        alpha=1;
        Qe=Q*Qw^alpha;
        %disp('edge-dependent fusion quality index: ');
        %Qe
%        res(3)=Qe;
        res=Qe;
end

return;