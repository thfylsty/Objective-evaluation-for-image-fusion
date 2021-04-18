function res=metricWang(im1,im2,fim)

% function res=metricWang(im1,im2,fim)
%
% This function implements Wang's algorithms for fusion metric.
% im1, im2 -- input images;
% fim      -- fused image;
% res      -- metric value;
%
% IMPORTANT: The size of the images need to be 2X. 
% See also: NCC.m, mutual_info.m, evalu_fusion.m
%
% Z. Liu [July 2009]
%

% Ref: Performance evaluation of image fusion techniques, Chapter 19, pp.469-492, 
% in Image Fusion:  Algorithms and Applications, edited by Tania Stathaki
% by Qiang Wang
%

%% pre-processing
im1=normalize1(im1);
im2=normalize1(im2);
fim=normalize1(fim);

[hang,lie]=size(im1);
b=256;
K=3;

%% Call mutual_info.m
% two inputs

NCCxy=NCC(im1,im2);


% one input and fused image
NCCxf=NCC(im1,fim);


% another input and fused image
NCCyf=NCC(im2,fim);


%% get the correlation matrix and eigenvalue 

R=[ 1 NCCxy NCCxf; NCCxy 1 NCCyf; NCCxf NCCyf 1];
r=eig(R);

%% HR

HR=sum(r.*log2(r./K)/K);
HR=-HR/log2(b);

%% NCIE

NCIE=1-HR;

res=NCIE;