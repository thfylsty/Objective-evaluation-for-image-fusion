function [img_cc] = my_cc(imgA, imgB, imgF)
% 
img = double(imgF); 
% Get rows and colums of img 
[r c] = size(imgF); 
     
% Mean value 
imgA_mean = mean(mean(imgA));
imgB_mean = mean(mean(imgB));
imgF_mean = mean(mean(imgF));

% Variance 
imgA_var = sum(sum((imgA - imgA_mean).^2)) / (r * c );
imgB_var = sum(sum((imgB - imgB_mean).^2)) / (r * c );
imgF_var = sum(sum((imgF - imgF_mean).^2)) / (r * c );

% IR - F
temp  = sum(sum((imgA - imgA_mean).*(imgF - imgF_mean))) / (r * c);
imAF = temp / sqrt(imgA_var * imgF_var);
% VIS - F
temp1  = sum(sum((imgB - imgB_mean).*(imgF - imgF_mean))) / (r * c);
imBF = temp1 / sqrt(imgB_var * imgF_var);

img_cc = (imAF + imBF ) / 2;
end