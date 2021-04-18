function res=metricChenBlum(im1,im2,fim)

% function res=metricChenBlum(im1,im2,fim)
%
% This function implements Yin Chen's algorithm for fusion metric.
% im1, im2 -- input images;
% fim      -- fused image;
% res      -- metric value;
%
% IMPORTANT: The size of the images need to be 2X. 
% See also: evalu_fusion.m
%
% Z. Liu [July 2009]
%

% Ref: A new automated quality assessment algorithm for image fusion, Image and Vision Computing, 27 (2009) 1421-1432 
% By Yin Chen et al.
% 

%% pre-processing
%im1=double(im1);
%im2=double(im2);
%fim=double(fim);

im1 = im2double(im1);
im2 = im2double(im2);
fim = im2double(fim);

im1=normalize1(im1);
im2=normalize1(im2);
fim=normalize1(fim);


%% set up some constant values for experiment

f0=15.3870;
f1=1.3456;
a=0.7622;

% parameters for local constrast computation
k=1;
h=1;
p=3; %2.4;
%p=2.4;
q=2;
Z=0.0001;
sigma=2;
%% caculate the quality Q

[hang,lie]=size(im1);

%DoG filter
%DoG1
%HH=hang/2; LL=lie/2;
HH=hang/30; LL=lie/30;

%DoG2
%HH=hang/4; LL=lie/4;

%DoG3
%HH=hang/8; LL=lie/8;

[u,v]=freqspace([hang,lie],'meshgrid');
u=LL*u; v=HH*v;
r=sqrt(u.^2+v.^2);

Sd=exp(-(r/f0).^2)-a*exp(-(r/f1).^2);

% constrast sensitivity filtering
fim1=ifft2(ifftshift(fftshift(fft2(im1)).*Sd));
fim2=ifft2(ifftshift(fftshift(fft2(im2)).*Sd));
ffim=ifft2(ifftshift(fftshift(fft2(fim)).*Sd));

%--------------------
%fim1=normalize1(fim1);
%fim2=normalize1(fim2);
%ffim=normalize1(ffim);

% local contrast computation
% one level of contrast
G1=gaussian2d(hang,lie,2);
G2=gaussian2d(hang,lie,4);


% filtering in frequency domain
C1=contrast(G1,G2,fim1);
C1=abs(C1); % I add this. (see your notes)
C1P=(k*(C1.^p))./(h*(C1.^q)+Z);

C2=contrast(G1,G2,fim2);
C2=abs(C2); % I add this.
C2P=(k*(C2.^p))./(h*(C2.^q)+Z);

Cf=contrast(G1,G2,ffim);
Cf=abs(Cf); % I add this.
CfP=(k*(Cf.^p))./(h*(Cf.^q)+Z);

% contrast preservation calculation
mask=(C1P<CfP);
mask=double(mask);
Q1F=(C1P./CfP).*mask+(CfP./C1P).*(1-mask);

mask=(C2P<CfP);
mask=double(mask);
Q2F=(C2P./CfP).*mask+(CfP./C2P).*(1-mask);

% Saliency map generation
ramda1=(C1P.*C1P)./(C1P.*C1P+C2P.*C2P);
ramda2=(C2P.*C2P)./(C1P.*C1P+C2P.*C2P);

% global quality map

Q=ramda1.*Q1F+ramda2.*Q2F;

res=mean2(Q);


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% sub-functions 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function res=gaussian2d(n1,n2,sigma)

% creat a 2D Gaussian filter in spatial domain
%

% hang (H)-> y; lie (L) -> x

H=floor((n1-1)/2);
L=floor((n2-1)/2);


[x,y]=meshgrid(-15:15,-15:15);
G=exp(-(x.*x+y.*y)/(2*sigma*sigma))/(2*pi*sigma*sigma);

%This is to normalize
%G=G/sum(G(:));
res=G;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function res=contrast(G1,G2,im)

%[hang,lie]=size(im);

%FG1=fft2(G1,hang,lie);
%FG2=fft2(G2,hang,lie);
%Fim=fft2(im);

%buff=real(ifft2(FG1.*Fim));
%buff1=real(ifft2(FG2.*Fim));

buff=filter2(G1,im,'same');
buff1=filter2(G2,im,'same');

res=buff./buff1-1;



