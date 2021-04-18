function deltaG = Definition(imgf)
%% Definition - 清晰度(平均梯度)
% 在图像中，某一方向的灰度级变化率越大，平均梯度Avg_Gradient也越大,可敏感地反映出图像中微小细节
% 反差和纹理变换特征,用来评价图像的相对清晰(模糊)程度。平均梯度越大，图像层次越多，也就越清晰。
img = double(imgf);
[M,N] = size(img);
Grad = 0;
for i = 1:(M-1)
    for j = 1:(N-1)
        diffx = img(i,j)-img(i,j+1);     %计算图像F在x和y方向上的差分
        diffy = img(i,j)-img(i+1,j);
        Grad = Grad+sqrt((diffx.^2+diffy.^2)/2);
    end
end

deltaG = Grad./((M-1)*(N-1));  %计算融合后图像清晰度ΔG