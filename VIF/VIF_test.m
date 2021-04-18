%% vif   VISUAL INFORMATION FIDELITY 

%imorg = imread('G:\retinex paper数据\new实验数据\混合\处理后原图\混合02.jpg');
%imdist = imread('G:\retinex paper数据\new实验数据\混合\处理后\MF\MF_2.jpg');
%imorg = imread('G:\retinex paper数据\new实验数据\Original.jpg');
%imdist = imread('G:\retinex paper数据\new实验数据\MF.jpg');
%imdist = imread('L:\Retinex Paper\test\49.jpg');

clear;clc
%% Complex
%initialization VIF
 score_LIME_complex  = 0;
 score_MF_complex    = 0;
 score_DONG_complex  = 0;
 score_BIMEF_complex = 0;
 score_SRIE_complex  = 0;
 score_NPE_complex   = 0;
 score_MSRCR_complex = 0;
 score_AAQR_complex  = 0;

 for k=50:1:99     
imdist = imread(['G:\retinex paper数据\new实验数据\混合\处理后原图\混合0',num2str(k),'.jpg']);
imdist = rgb2gray(imdist);

%LIME
imorg_LIME = imread(['G:\retinex paper数据\new实验数据\混合\处理后\LIME\LIME_',num2str(k),'.jpg']);
imorg_LIME = rgb2gray(imorg_LIME);
score  = vifvec(imorg_LIME,imdist);
score_LIME_complex = score_LIME_complex + score;

%MF
imorg_MF = imread(['G:\retinex paper数据\new实验数据\混合\处理后\MF\','MF_',num2str(k),'.jpg']);
imorg_MF = rgb2gray(imorg_MF);
score  = vifvec(imorg_MF,imdist);
score_MF_complex = score_MF_complex + score;

%DONG
imorg_DONG = imread(['G:\retinex paper数据\new实验数据\混合\处理后\DONG\','DONG_',num2str(k),'.jpg']);
imorg_DONG = rgb2gray(imorg_DONG);
score  = vifvec(imorg_DONG,imdist);
score_DONG_complex = score_DONG_complex + score;

%BIMEF
imorg_BIMEF = imread(['G:\retinex paper数据\new实验数据\混合\处理后\BIMEF\','BIMEF_',num2str(k),'.jpg']);
imorg_BIMEF = rgb2gray(imorg_BIMEF);
score  = vifvec(imorg_BIMEF,imdist);
score_BIMEF_complex = score_BIMEF_complex + score;

%SRIE
imorg_SRIE = imread(['G:\retinex paper数据\new实验数据\混合\处理后\SRIE\','SRIE_',num2str(k),'.jpg']);
imorg_SRIE = rgb2gray(imorg_SRIE);
score  = vifvec(imorg_SRIE,imdist);
score_SRIE_complex = score_SRIE_complex + score;

%NPE
imorg_NPE = imread(['G:\retinex paper数据\new实验数据\混合\处理后\NPE\','NPE_',num2str(k),'.jpg']);
imorg_NPE = rgb2gray(imorg_NPE);
score  = vifvec(imorg_NPE,imdist);
score_NPE_complex = score_NPE_complex + score;

%MSRCR
imorg_MSRCR = imread(['G:\retinex paper数据\new实验数据\混合\处理后\MSRCR\','MSRCR_',num2str(k),'.jpg']);
imorg_MSRCR = rgb2gray(imorg_MSRCR);
score  = vifvec(imorg_MSRCR,imdist);
score_MSRCR_complex = score_MSRCR_complex + score;

%AAQR
imorg_AAQR = imread(['G:\retinex paper数据\new实验数据\混合\处理后\AAQR\','AAQR_',num2str(k),'.jpg']);
imorg_AAQR = rgb2gray(imorg_AAQR);
score  = vifvec(imorg_AAQR,imdist);
 score_AAQR_complex = score_AAQR_complex + score;
 end
 
 %Mean VIF
 score_LIME_complex  = score_LIME_complex/50;
 score_MF_complex    = score_MF_complex/50;
 score_DONG_complex  = score_DONG_complex/50;
 score_BIMEF_complex = score_BIMEF_complex/50;
 score_SRIE_complex  = score_SRIE_complex/50;
 score_NPE_complex   = score_NPE_complex/50;
 score_MSRCR_complex = score_MSRCR_complex/50;
 score_AAQR_complex  = score_AAQR_complex/50;
 
%% left&right
%initialization VIF
 score_LIME_left_right  = 0;
 score_MF_left_right    = 0;
 score_DONG_left_right  = 0;
 score_BIMEF_left_right = 0;
 score_SRIE_left_right = 0;
 score_NPE_left_right   = 0;
 score_MSRCR_left_right = 0;
 score_AAQR_left_right  = 0;

 for k=50:1:99     
imdist = imread(['G:\retinex paper数据\new实验数据\左右\处理后原图\左右0',num2str(k),'.jpg']);
imdist = rgb2gray(imdist);

%LIME
imorg_LIME = imread(['G:\retinex paper数据\new实验数据\左右\处理后\LIME\','LIME_',num2str(k),'.jpg']);
imorg_LIME = rgb2gray(imorg_LIME);
score  = vifvec(imorg_LIME,imdist);
score_LIME_left_right = score_LIME_left_right + score;

%MF
imorg_MF = imread(['G:\retinex paper数据\new实验数据\左右\处理后\MF\','MF_',num2str(k),'.jpg']);
imorg_MF = rgb2gray(imorg_MF);
score  = vifvec(imorg_MF,imdist);
score_MF_left_right = score_MF_left_right + score;

%DONG
imorg_DONG = imread(['G:\retinex paper数据\new实验数据\左右\处理后\DONG\','DONG_',num2str(k),'.jpg']);
imorg_DONG = rgb2gray(imorg_DONG);
score  = vifvec(imorg_DONG,imdist);
score_DONG_left_right = score_DONG_left_right + score;

%BIMEF
imorg_BIMEF = imread(['G:\retinex paper数据\new实验数据\左右\处理后\BIMEF\','BIMEF_',num2str(k),'.jpg']);
imorg_BIMEF = rgb2gray(imorg_BIMEF);
score  = vifvec(imorg_BIMEF,imdist);
score_BIMEF_left_right = score_BIMEF_left_right + score;

%SRIE
imorg_SRIE = imread(['G:\retinex paper数据\new实验数据\左右\处理后\SRIE\','SRIE_',num2str(k),'.jpg']);
imorg_SRIE = rgb2gray(imorg_SRIE);
score  = vifvec(imorg_SRIE,imdist);
score_SRIE_left_right = score_SRIE_left_right + score;

%NPE
imorg_NPE = imread(['G:\retinex paper数据\new实验数据\左右\处理后\NPE\','NPE_',num2str(k),'.jpg']);
imorg_NPE = rgb2gray(imorg_NPE);
score  = vifvec(imorg_NPE,imdist);
score_NPE_left_right = score_NPE_left_right + score;

%MSRCR
imorg_MSRCR = imread(['G:\retinex paper数据\new实验数据\左右\处理后\MSRCR\','MSRCR_',num2str(k),'.jpg']);
imorg_MSRCR = rgb2gray(imorg_MSRCR);
score  = vifvec(imorg_MSRCR,imdist);
score_MSRCR_left_right = score_MSRCR_left_right + score;

%AAQR
imorg_AAQR = imread(['G:\retinex paper数据\new实验数据\左右\处理后\AAQR\','AAQR_',num2str(k),'.jpg']);
imorg_AAQR = rgb2gray(imorg_AAQR);
score  = vifvec(imorg_AAQR,imdist);
score_AAQR_left_right = score_AAQR_left_right + score;
 end
 
 %Mean VIF
 score_LIME_left_right  = score_LIME_left_right/50;
 score_MF_left_right    = score_MF_left_right/50;
 score_DONG_left_right  = score_DONG_left_right/50;
 score_BIMEF_left_right = score_BIMEF_left_right/50;
 score_SRIE_left_right  = score_SRIE_left_right/50;
 score_NPE_left_right   = score_NPE_left_right/50;
 score_MSRCR_left_right = score_MSRCR_left_right/50;
 score_AAQR_left_right  = score_AAQR_left_right/50;
 
 %% up&down
%initialization VIF
 score_LIME_up_down  = 0;
 score_MF_up_down    = 0;
 score_DONG_up_down  = 0;
 score_BIMEF_up_down = 0;
 score_SRIE_up_down  = 0;
 score_NPE_up_down   = 0;
 score_MSRCR_up_down = 0;
 score_AAQR_up_down  = 0;

 for k=50:1:99     
imdist = imread(['G:\retinex paper数据\new实验数据\上下\处理后原图\上下0',num2str(k),'.jpg']);
imdist = rgb2gray(imdist);

%LIME
imorg_LIME = imread(['G:\retinex paper数据\new实验数据\上下\处理后\LIME\','LIME_',num2str(k),'.jpg']);
imorg_LIME = rgb2gray(imorg_LIME);
score  = vifvec(imorg_LIME,imdist);
score_LIME_up_down = score_LIME_up_down + score;

%MF
imorg_MF = imread(['G:\retinex paper数据\new实验数据\上下\处理后\MF\','MF_',num2str(k),'.jpg']);
imorg_MF = rgb2gray(imorg_MF);
score  = vifvec(imorg_MF,imdist);
score_MF_up_down = score_MF_up_down + score;

%DONG
imorg_DONG = imread(['G:\retinex paper数据\new实验数据\上下\处理后\DONG\','DONG_',num2str(k),'.jpg']);
imorg_DONG = rgb2gray(imorg_DONG);
score  = vifvec(imorg_DONG,imdist);
score_DONG_up_down = score_DONG_up_down + score;

%BIMEF
imorg_BIMEF = imread(['G:\retinex paper数据\new实验数据\上下\处理后\BIMEF\','BIMEF_',num2str(k),'.jpg']);
imorg_BIMEF = rgb2gray(imorg_BIMEF);
score  = vifvec(imorg_BIMEF,imdist);
score_BIMEF_up_down = score_BIMEF_up_down + score;

%SRIE
imorg_SRIE = imread(['G:\retinex paper数据\new实验数据\上下\处理后\SRIE\','SRIE_',num2str(k),'.jpg']);
imorg_SRIE = rgb2gray(imorg_SRIE);
score  = vifvec(imorg_SRIE,imdist);
score_SRIE_up_down = score_SRIE_up_down + score;

%NPE
imorg_NPE = imread(['G:\retinex paper数据\new实验数据\上下\处理后\NPE\','NPE_',num2str(k),'.jpg']);
imorg_NPE = rgb2gray(imorg_NPE);
score  = vifvec(imorg_NPE,imdist);
score_NPE_up_down = score_NPE_up_down + score;

%MSRCR
imorg_MSRCR = imread(['G:\retinex paper数据\new实验数据\上下\处理后\MSRCR\','MSRCR_',num2str(k),'.jpg']);
imorg_MSRCR = rgb2gray(imorg_MSRCR);
score  = vifvec(imorg_MSRCR,imdist);
score_MSRCR_up_down = score_MSRCR_up_down + score;

%AAQR
imorg_AAQR = imread(['G:\retinex paper数据\new实验数据\上下\处理后\AAQR\','AAQR_',num2str(k),'.jpg']);
imorg_AAQR = rgb2gray(imorg_AAQR);
score  = vifvec(imorg_AAQR,imdist);
score_AAQR_up_down = score_AAQR_up_down + score;
 end
 
 %Mean VIF
 score_LIME_up_down  = score_LIME_up_down/50;
 score_MF_up_down    = score_MF_up_down/50;
 score_DONG_up_down  = score_DONG_up_down/50;
 score_BIMEF_up_down = score_BIMEF_up_down/50;
 score_SRIE_up_down  = score_SRIE_up_down/50;
 score_NPE_up_down   = score_NPE_up_down/50;
 score_MSRCR_up_down = score_MSRCR_up_down/50;
 score_AAQR_up_down  = score_AAQR_up_down/50;
 