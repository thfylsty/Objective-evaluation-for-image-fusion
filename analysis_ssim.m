function [SSIM] = ssim(image1,image2,image_fused)

% SSIM_a
SSIM1 = ssim(image_fused,image1);
SSIM2 = ssim(image_fused,image2);
SSIM = (SSIM1+SSIM2)/2;

end

