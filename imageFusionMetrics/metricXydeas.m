function res=metricXydeas(img1,img2,fuse)

% function res=metricXydeas(img1,img2,fuse)
%
% This function is used to evaluate the fusion algorithm. 
% im1, im2 -- input images;
% fim      -- fused image;
% res      -- metric value;
%
% Z. Liu @NRCC [3 Oct 2003]
%

% Ref: Objective Pixel-level Image Fusion Performance Measure, Proc. SPIE 4051, 89 (2000)
% by C. Xydeas 
%


flt1=[-1 0 1 ; -2 0 2 ; -1 0 1];
flt2=[-1 -2 -1; 0 0 0; 1 2 1];

% 1) get the map

fuseX=filter2(flt1,fuse,'same');
fuseY=filter2(flt2,fuse,'same');
fuseG=sqrt(fuseX.*fuseX+fuseY.*fuseY);

buffer=(fuseX==0);
buffer=buffer*0.00001;
fuseX=fuseX+buffer;
fuseA=atan(fuseY./fuseX);

img1X=filter2(flt1,img1,'same');
img1Y=filter2(flt2,img1,'same');
img1G=sqrt(img1X.*img1X+img1Y.*img1Y);
buffer=(img1X==0);
buffer=buffer*0.00001;
img1X=img1X+buffer;
img1A=atan(img1Y./img1X);

img2X=filter2(flt1,img2,'same');
img2Y=filter2(flt2,img2,'same');
img2G=sqrt(img2X.*img2X+img2Y.*img2Y);
buffer=(img2X==0);
buffer=buffer*0.00001;
img2X=img2X+buffer;
img2A=atan(img2Y./img2X);

% 2) edge preservation estimation

bimap=img1G>fuseG;

buffer=(img1G==0); buffer=buffer*0.00001; img1G=img1G+buffer;
buffer1=fuseG./img1G;

buffer=(fuseG==0); buffer=buffer*0.00001; fuseG=fuseG+buffer;
buffer2=img1G./fuseG;

Gaf=bimap.*buffer1+(1-bimap).*buffer2;
Aaf=abs(abs(img1A-fuseA)-pi/2)*2/pi;

%------------

bimap=img2G>fuseG;

buffer=(img2G==0); buffer=buffer*0.00001; img2G=img2G+buffer;
buffer1=fuseG./img2G;

buffer=(fuseG==0); buffer=buffer*0.00001; fuseG=fuseG+buffer;
buffer2=img2G./fuseG;

Gbf=bimap.*buffer1+(1-bimap).*buffer2;
Abf=abs(abs(img2A-fuseA)-pi/2)*2/pi;

%some parameter
gama1=1;gama2=1;
k1=-10; k2=-20;
delta1=0.5; delta2=0.75;

Qg_AF=gama1./(1+exp(k1*(Gaf-delta1)));
Qalpha_AF=gama2./(1+exp(k2*(Aaf-delta2)));
Qaf=Qg_AF.*Qalpha_AF;

Qg_BF=gama1./(1+exp(k1*(Gbf-delta1)));
Qalpha_BF=gama2./(1+exp(k2*(Abf-delta2)));
Qbf=Qg_BF.*Qalpha_BF;

% 3) compute the weighting matrix
L=1;

Wa=img1G.^L;
Wb=img2G.^L;

%res=sum(sum(Qaf.*Wa+Qbf.*Wb))/sum(sum(Wa+Wb));
res=mean2((Qaf.*Wa+Qbf.*Wb)./(Wa+Wb));