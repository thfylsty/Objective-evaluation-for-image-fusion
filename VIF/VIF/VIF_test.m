%% vif   VISUAL INFORMATION FIDELITY 

imorg = imread('G:\retinex paper数据\new实验数据\Original.jpg');
imdist = imread('G:\retinex paper数据\new实验数据\AAQR.jpg');

if size(imorg, 3) == 3
    imorg = rgb2gray(imorg);
end

if size(imdist, 3) == 3
    imdist = rgb2gray(imdist);
end

imorg  = im2double(imorg);
imdist = im2double(imdist);
score  = vifvec(imorg,imdist);