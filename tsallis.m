function RES=tsallis(im1,im2,q)

% function RES=tsallis(im1,im2,q)
% 
% This function is caculate Tsallis entropy for two input images.
% im1   -- input image one;
% im2   -- input image two;
% q     -- constant
%
% RES    -- Tsallis entropy;
%
%
% Note: The input images need to be in the range of 0-255. 
%
% Z. Liu @ NRCC [July 17, 2009]

im1=double(im1);
im2=double(im2);

[hang,lie]=size(im1);
count=hang*lie;
N=256;

%% caculate the joint histogram
h=zeros(N,N);

for i=1:hang
    for j=1:lie
        % in this case im1->x, im2->y
        h(im1(i,j)+1,im2(i,j)+1)=h(im1(i,j)+1,im2(i,j)+1)+1;
    end
end

%% marginal histogram

% this operation converts histogram to probability
h=h./sum(h(:));

im1_marg=sum(h);
im2_marg=sum(h');

result=0;
for i=1:N
    for j=1:N
        buff=im1_marg(i)*im2_marg(j);
        if buff~=0
            result=result+h(i,j).^q/(buff).^(q-1);
        end
    end
end

RES=(1-result)/(1-q);
