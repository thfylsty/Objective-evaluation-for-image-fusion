clear all;
close all;
clc;

% addpath(genpath('sparsefusion'));
% addpath(genpath('dtcwt_toolbox'));
% addpath(genpath('fdct_wrapping_matlab'));
% addpath(genpath('nsct_toolbox'));

load('sparsefusion/Dictionary/D_100000_256_8.mat');

%[imagename1 imagepath1]=uigetfile('source_images\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
%image_input1=imread(strcat(imagepath1,imagename1));    
%[imagename2 imagepath2]=uigetfile('source_images\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
%image_input2=imread(strcat(imagepath2,imagename2));     

image_input1 = imread(strcat('H:\matlab\cuttest\Multufocus data\LytroDataset\multiA\','lytro-15-A.jpg'));%%%CSR 方法不要im2double
image_input2 = imread(strcat('H:\matlab\cuttest\Multufocus data\LytroDataset\multiB\','lytro-15-B.jpg')); 

subplot(2,2,1);imshow(image_input1);title('MA');
subplot(2,2,2);imshow(image_input2);title('MB');

if size(image_input1)~=size(image_input2)
    error('two images are not the same size.');
end
if size(image_input1,3)>1
    image_input1=rgb2gray(image_input1);
    image_input2=rgb2gray(image_input2);
else
    image_input1=image_input1;
    image_input2=image_input2;
end
img1=double(image_input1);
img2=double(image_input2);

overlap = 6;                    
epsilon=0.1;
level=2;

% To make a comparison, please use 
% LP-SR for medical image fusion, 
% DTCWT-SR for visible-infrared image fusion,
% NSCT-SR for multi-focus image fusion.

tic;
model_name = 'cnnmodel.mat';
if size(img1,3)==1    %for gray images
    %% 融合图像质量评价 - 主观视觉效果和多种客观评价指标
    display('灰度图，保存融合结果，进行融合质量评价');
    disp('Adopt Different Indexs to Evaluate the Fused Image');
    disp('采用不同指标对融合图像进行性能评价');
%     %LP
%     %imgf = lp_sr_fuse(img1,img2,level,3,3,D,overlap,epsilon);
%     imgf = lp_fuse(img1, img2, level, 3, 3);
%     imwrite(uint8(imgf),'gray_fusion/fused_lp.jpg');
%     final_result(:,1) = evaluation(uint8(img1), uint8(img2), uint8(imgf));
%     %PCNN
%     imgf = Demo_PCNN(img1,img2);                         
%     imwrite(uint8(imgf),'gray_fusion/fused_pcnn.jpg');
%     final_result(:,2) = evaluation(uint8(img1), uint8(img2), uint8(imgf));  
%     %RP
%     imgf = rp_fuse(img1, img2, level, 3, 3);      %RP    
%     imwrite(uint8(imgf),'gray_fusion/fused_rp.jpg');
%     final_result(:,3) = evaluation(uint8(img1), uint8(img2), uint8(imgf)); 
%     %DTCWT
%     fs = 2;
%     imgf = dtcwt_fuse(img1, img2,3);  
%     imwrite(uint8(imgf),'gray_fusion/fused_dtcwt.jpg');
%     final_result(:,4) = evaluation(uint8(img1), uint8(img2), uint8(imgf)); 
%     %CVT
%     imgf = curvelet_fuse(img1, img2,level+1);      %CVT
%     imwrite(uint8(imgf),'gray_fusion/fused_cvt.jpg');
%     final_result(:,5) = evaluation(uint8(img1), uint8(img2), uint8(imgf));
%     %NSCT
%     imgf =  curvelet_sr_fuse(img1,img2,level+1,D,overlap,epsilon); %CVT-SR
%     imwrite(uint8(imgf),'gray_fusion/fused_nsct.jpg');
%     final_result(:,6) = evaluation(uint8(img1), uint8(img2), uint8(imgf));
    %CNN
    imgf=CNN_Fusion(img1,img2,model_name);
    subplot(2,2,3);imshow(uint8(imgf));title('cnn');
    imwrite(uint8(imgf),'gray_fusion/fused_cnn.jpg');
    final_result(:,9) = evaluation(uint8(img1), uint8(img2), uint8(imgf));
%     % strdwt
%     imgf = strdwt(double(img1),double(img2));
%     imwrite(uint8(imgf),'gray_fusion/fused_strdwt.jpg');
%     final_result(:,8) = evaluation(uint8(img1), uint8(img2), uint8(imgf)); 
%     % GP
%     imgf=gp_fusion(double(img1),double(img2));
%     imwrite(uint8(imgf),'gray_fusion/fused_gp.jpg');
%     final_result(:,9) = evaluation(uint8(img1), uint8(img2), uint8(imgf)); 
    % proposed
    mat=load('H:\matlab\cuttest\multifouces\feature_map\preds_reimg_xsh_weight0.mat');
    preds=mat.preds_reimg_xsh;
    preds_re1 = uint8(preds);
    subplot(2,2,4);imshow(uint8(preds_re1));title('Proposed');
    if size(preds_re1,3)>1
        imgf=rgb2gray(preds_re1);
    end
    imwrite(uint8(imgf),'gray_fusion/fused_proposed.jpg');
    % end strcat('./L_IR_VIS/IR',num2str(index),'.png')'xmyresult/proposed.jpg'
    %  __100en_800
    %imwrite(uint8(preds_re1),strcat('xmyresult/proposed_',num2str(index),'__500.jpg'));
    final_result(:,10) = evaluation(uint8(img1), uint8(img2), uint8(imgf));
else                  %for color images
    imgf=zeros(size(img1));
    display('RGB图，分通道融合，保存RGB结果');
    for i=1:3
        %imgf(:,:,i) = lp_sr_fuse1(img1(:,:,i),img2(:,:,i),level,3,3,D,overlap,epsilon);      %LP-SRhsiung,lp+cnn
        %imgf(:,:,i) = lp_sr_fuse_old(img1(:,:,i),img2(:,:,i),level,3,3,D,overlap,epsilon);      %LP-SR
        %imgf(:,:,i) = rp_sr_fuse(img1(:,:,i),img2(:,:,i),level,3,3,D,overlap,epsilon);     %RP-SR
        %imgf(:,:,i) = dwt_sr_fuse(img1(:,:,i),img2(:,:,i),level,D,overlap,epsilon);        %DWT-SR
        %imgf(:,:,i) = dtcwt_sr_fuse(img1(:,:,i),img2(:,:,i),level,D,overlap,epsilon);      %DTCWT-SR
        %imgf(:,:,i) = curvelet_sr_fuse(img1(:,:,i),img2(:,:,i),level+1,D,overlap,epsilon); %CVT-SR
        %imgf(:,:,i) = nsct_sr_fuse(img1(:,:,i),img2(:,:,i),[2,3,3,4],D,overlap,epsilon);   %NSCT-SR
        
    end
end
toc;
final_result = final_result';

%final_result = evaluation(uint8(img1), uint8(img2), uint8(imgf));
save('final_result.mat','final_result');