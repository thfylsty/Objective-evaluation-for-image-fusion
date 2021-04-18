function res=metricMI(im1,im2,fim,sw)

% function res=metricMI(im1,im2,fim,sw)
%
% This function implements the revised mutual information algorithms for fusion metric.
% im1, im2 -- input images;
% fim      -- fused image;
% sw       -- 1: revised MI; 2: Tsallis entropy (Cvejie); 3: Nava.
% res      -- metric value;
%
% IMPORTANT: The size of the images need to be 2X. This is not an
% implementation of Qu's algorithm. See the function for details.
%
% Z. Liu [July 2009]
%

% Ref: Comments on "Information measure for performance of image fusion"
% By M. Hossny et al.
% Electronics Letters Vol. 44, No.18, 2008
%
% Ref: Mutual information impoves image fusion quality assessments
% By Rodrigo Nava et al.
% SPIE Newsroom
%
% Ref: Image fusion metric based on mutual information and Tsallis entropy
% By N. Cvejie et al.
% Electronics Letters, Vol.42, No. 11, 2006

%% pre-processing
im1=normalize1(im1);
im2=normalize1(im2);
fim=normalize1(fim);

if nargin==3
    sw=1;
end

switch sw
    case 1
        % revised MI algorithm (Hossny)
        [I_fx,H_xf,H_x,H_f1]=mutual_info(im1,fim);
        [I_fy,H_yf,H_y,H_f2]=mutual_info(im2,fim);
        
        MI=2*(I_fx/(H_f1+H_x)+I_fy/(H_f2+H_y));
        res=MI;
    case 2
        q=1.85;    % Cvejic's constant
        I_fx=tsallis(im1,fim,q);
        I_fy=tsallis(im2,fim,q);
        res=I_fx+I_fy;
        
    case 3
        % MI and Tsallis entropy
        % set up constant q
        q=0.43137; % Nava's constant
        
        I_fx=tsallis(im1,fim,q);
        I_fy=tsallis(im2,fim,q);
        I_xy=tsallis(im1,im2,q);        
       
        [M_xy,H_xy,H_x,H_y]=mutual_info(im1,im2);

        MI=(I_fx+I_fy)/(H_x.^q+H_y.^q+I_xy);
        res=MI;
    otherwise
        error('Your input is wrong! Please check help file.');
end

