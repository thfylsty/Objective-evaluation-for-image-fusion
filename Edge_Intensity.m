function Edgein = Edge_Intensity(imgf) 
%% Edge Intensity of the Fusion Image - 计算融合图像的边缘强度
% 边缘强度，主要是指边缘与邻近像素的对比强度。图像细节越丰富，其边缘也就越清晰。
img = double(imgf); 
% Create horizontal sobel matrix - 创建水平Sobel矩阵 
w = fspecial('sobel'); 

% Get the size of img 
[M,N] = size(img); 

% 采用3*3的Sobel(一种边缘检测滤波器)窗口提取图像边缘，并进行统计
gx = imfilter(img,w,'replicate'); 
gy = imfilter(img,w','replicate'); 

for i = 1:M
    for j = 1:N
        g(i,j) = sqrt(gx(i,j)*gx(i,j) + gy(i,j)*gy(i,j));
    end
end
Edgein = mean2(g); 