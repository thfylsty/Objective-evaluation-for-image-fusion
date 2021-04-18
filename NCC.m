function res=NCC(im1,im2)

% function res=NCC(im1,im2)
% 
% This function is caculate the mutual information of two input images.
% im1   -- input image one;
% im2   -- input image two;
%
% res    -- NNC (nonlinear correlation coefficient
%
%
% Note: 1) The input images need to be in the range of 0-255. (see function:
% normalize1.m); 2) This function is similar to mutual information but they
% are different.
%
% Z. Liu @ NRCC [July 17, 2009]

im1=double(im1);
im2=double(im2);

[hang,lie]=size(im1);
count=hang*lie;
N=256;
b=256;

%% caculate the joint histogram
h=zeros(N,N);

for i=1:hang
    for j=1:lie
        % in this case im1->x (row), im2->y (column)
        h(im1(i,j)+1,im2(i,j)+1)=h(im1(i,j)+1,im2(i,j)+1)+1;
    end
end

%% marginal histogram

% this operation converts histogram to probability
%h=h./count;
h=h./sum(h(:));

im1_marg=sum(h);    % sum each column for im1
im2_marg=sum(h');   % sum each row for im2


%for i=1:N
%    if (im1_marg(i)>eps)
%        % entropy for image1
%        Hx=Hx+(-im1_marg(i)*(log2(im1_marg(i))));
%    end
%    if (im2_marg(i)>eps)
%        % entropy for image2
%        Hy=Hy+(-im2_marg(i)*(log2(im2_marg(i))));
%    end
%end

H_x=-sum(im1_marg.*log2(im1_marg+(im1_marg==0)));
H_y=-sum(im2_marg.*log2(im2_marg+(im2_marg==0)));


% joint entropy

%H_xy=0;

%for i=1:N
%    for j=1:N
%        if (h(i,j)>eps)
%            H_xy=H_xy+h(i,j)*log2(h(i,j));
%        end
%    end
%end

H_xy=-sum(sum(h.*log2(h+(h==0))));
H_xy=H_xy/log2(b);


%H_xy=-sum(sum(h.*(log2(h+(h==0)))));

H_x=H_x/log2(b);
H_y=H_y/log2(b);

% NCC
res=H_x+H_y-H_xy;
