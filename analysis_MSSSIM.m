function [MS_SSIM] = MSSSIM(image1,image2,image_fused)

[s1,s2] = size(image1);
imgSeq = zeros(s1, s2, 2);
imgSeq(:, :, 1) = image1;
imgSeq(:, :, 2) = image2;

%MS_SSIM
[MS_SSIM,t1,t2]= analysis_ms_ssim(imgSeq, image_fused);

end

