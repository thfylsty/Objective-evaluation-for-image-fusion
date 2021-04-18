% 计算图像的平均梯度
function G = AverageGradient(img)
img = double(img);
[m,n] = size(img);
Grad = 0;
for i = 1:m-1
    for j = 1:n-1
        diffx = img(i,j)-img(i+1,j);
        diffy = img(i,j)-img(i,j+1);
        Grad = Grad+sqrt((diffx^2+diffy^2)/2);
    end
end
        
G = Grad./(m*n);