function res=metricZheng(im1,im2,fim)

% function res=metricZheng(im1,im2,fim)
%
% This function implements Zheng's algorithm for fusion metric.
% im1, im2 -- input images;
% fim      -- fused image;
% res      -- metric value;
%
% IMPORTANT: The size of the images need to be 2X. 
% See also: evalu_fusion.m
%
% Z. Liu [July 2009]
%

% Ref: A new metric based on extended spatial frequency and its application
% to DWT based fusion algorithms, Information Fusion 8 (2007) 177-192.
% By Yufeng Zheng et al.
% 

% This may be a problem with the author's equation (7) and (8). This matlab
% function modified the equations in the paper. 


%% pre-processing
im1=double(im1);
im2=double(im2);
fim=double(fim);

%% spatial frequency
[RF,CF]=sf1(fim);
[MDF,SDF]=sf2(fim);

SFf=sqrt(RF*RF+CF*CF+MDF*MDF+SDF*SDF);

RFr=grad(im1,im2,1);
CFr=grad(im1,im2,2);
MDFr=grad(im1,im2,3);
SDFr=grad(im1,im2,4);

SFr=sqrt(RFr+CFr+MDFr+SDFr);
rSFe=(SFf-SFr)/SFr;
res=rSFe;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% sub-function
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [RF,CF]=sf1(im)

[hang,lie]=size(im);
% caculate the spatial horizatal and vertical frequency

% for column
buff=circshift(im,[0,-1]);
diff=im-buff;
misa=diff(:,1:end-1);
misa=misa.*misa;
RF=sqrt(sum(misa(:))/(hang*lie));

% for row
buff=circshift(im,[-1,0]);
diff=im-buff;
misa=diff(1:end-1,:);
misa=misa.*misa;
CF=sqrt(sum(misa(:))/(hang*lie));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [MDF,SDF]=sf2(im)
% caculate diagonal frequency

Wd=sqrt(2)/2;
[hang,lie]=size(im);
result=0;

for i=2:hang
    for j=2:lie
        result=result+(im(i,j)-im(i-1,j-1)).^2;
    end
end

MDF=sqrt(Wd*result/(hang*lie));

result=0;
for j=1:lie-1
    for i=2:hang
        result=result+(im(i,j)-im(i-1,j+1)).^2;
    end
end

SDF=sqrt(Wd*result/(hang*lie));

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
function res=grad(im1,im2,sw)

% caculate the Grad
% sw: 1 -- H
%     2 -- V
%     3 -- MD
%     4 -- SD

[hang,lie]=size(im1);
Wd=sqrt(2)/2;
switch sw
    case 1
        % for H
        % for column
        buff=circshift(im1,[0,-1]);
        diff=im1-buff;
        misa1=diff(:,1:end-1);

        buff=circshift(im2,[0,-1]);
        diff=im2-buff;
        misa2=diff(:,1:end-1);
                
        GradH=max(abs(misa1),abs(misa2));
        RFh=GradH.*GradH;
        
        res=sum(RFh(:))/(hang*lie);
        
    case 2
        % for row
        buff=circshift(im1,[-1,0]);
        diff=im1-buff;
        misa1=diff(1:end-1,:);

        buff=circshift(im2,[-1,0]);
        diff=im2-buff;
        misa2=diff(1:end-1,:);

        GradV=max(abs(misa1),abs(misa2));
        RFv=GradV.*GradV;
        
        res=sum(RFv(:))/(hang*lie);
        
    case 3
        % MD

        result=0;

        for i=2:hang
            for j=2:lie
                buff1=im1(i,j)-im1(i-1,j-1);
                buff2=im2(i,j)-im2(i-1,j-1);
                buff=max(abs(buff1),abs(buff2));
                result=result+buff*buff;
            end
        end
        res=Wd*result/(hang*lie);
        
    case 4
        
        result=0;
        for j=1:lie-1
            for i=2:hang
                buff1=im1(i,j)-im1(i-1,j+1);
                buff2=im2(i,j)-im2(i-1,j+1);
                buff=max(abs(buff1),abs(buff2));
                result=result+buff*buff;
            end
        end

        res=Wd*result/(hang*lie);
        
    otherwise
        error('Wrong input for sub-function Grad');
end
