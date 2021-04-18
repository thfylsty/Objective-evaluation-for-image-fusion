%% vif   VISUAL INFORMATION FIDELITY 

imorg = imread('1.bmp');
imdist = imread('2.bmp');

if size(imorg, 3) == 3
    imorg = rgb2gray(imorg);
end

if size(imdist, 3) == 3
    imdist = rgb2gray(imdist);
end

imorg  = im2double(imorg);
imdist = im2double(imdist);
score  = vifvec(imorg,imdist);