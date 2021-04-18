function res=metricPWW(im1,im2,fim)

% function res=metricPWW(im1,im2,fim)
%
% This function implements Pei-Wei Wang's algorithms for fusion metric.
% im1, im2 -- input images;
% fim      -- fused image;
% res      -- metric value;
%
% IMPORTANT: The size of the images need to be 2X.Simoncelli's toolbox is
% used, so please note a Matlab version 7.0 or previous is preferred.
%
% Z. Liu [July 2009]
%

% Ref: A novel image fusion metric based on multi-scale analysis, pp.965-968, ICSP 2008.
% by Peng-Wei Wang et al.
%

% Haar wavelet is used for this implementation.

%% pre-processing
im1=double(im1);
im2=double(im2);
fim=double(fim);

% some constant values
N=2;    % decomposition level 
alpha1=2/3; alpha2=1/3;

%% wavelet decomposition

[C1,S1]=buildWpyr(im1,N,'haar');
[C2,S2]=buildWpyr(im2,N,'haar');
[Cf,Sf]=buildWpyr(fim,N,'haar');

%% caculate the metric
% use pyrBand.m and pyrlow.m

for i=1:N
    % first input and fused result
    bandNum=(i-1)*3;
    
    H1=pyrBand(C1,S1,bandNum+1); 
    V1=pyrBand(C1,S1,bandNum+2);
    D1=pyrBand(C1,S1,bandNum+3);

    H2=pyrBand(C2,S2,bandNum+1); 
    V2=pyrBand(C2,S2,bandNum+2);
    D2=pyrBand(C2,S2,bandNum+3);

    Hf=pyrBand(Cf,Sf,bandNum+1); 
    Vf=pyrBand(Cf,Sf,bandNum+2);
    Df=pyrBand(Cf,Sf,bandNum+3);
    
    W1=H1.*H1+V1.*V1+D1.*D1;
    W2=H2.*H2+V2.*V2+D2.*D2;
    
    EP1=exp(-abs(H1-Hf))+exp(-abs(V1-Vf))+exp(-abs(D1-Df));
    EP2=exp(-abs(H2-Hf))+exp(-abs(V2-Vf))+exp(-abs(D2-Df));    
    
    
    Q(i)=sum(sum(EP1.*W1+EP2.*W2))/sum(sum(W1+W2));
    
end

Qep=(Q(1).^alpha1)*(Q(2).^alpha2);
res=Qep;