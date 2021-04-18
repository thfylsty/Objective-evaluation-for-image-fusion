function [evals] = evaluation(oriA, oriB, imgf)
%% 采用多种评价指标对融合效果进行评估

% 均值Mean Value，指图像中所有像素灰度值的算术平均，对人眼反映为平均亮度。
% imgfMEAN = mean2(imgf);
% sprintf('融合图像的均值为 : %.4f ',imgfMEAN)

% 标准差Standard Deviation，反映图像灰度相对于灰度均值的离散程度，可用于评价图像
% 反差的大小。标准差越大，灰度级越分散，图像反差越大(对比度越大)，即包含更多的信息。
imgfSTD = std2(imgf);
% imgfSTD = MyStd(imgf);
sprintf('融合图像的标准差为 : %.4f ',imgfSTD)
evals(1)=imgfSTD;

% 信噪比SNR - 信号与噪声的方差之比，值越大融合图像视觉效果越好。
% imgfSNR = 20*log10(255/imgfSTD);
% sprintf('融合图像的信噪比为 : %.4f ',imgfSNR)

% 熵Entropy - 熵值反映了图像携带信息量的多少,熵值越大，说明包含的信息量越多，融合效果越好。
% imgfH = MyEntropy(imgf);
imgfH = entropy(imgf);
sprintf('融合图像的熵为 : %.4f ',imgfH)
evals(2)=imgfH;

% 清晰度Clarity - 清晰度(高频成分)反映图像对微小细节反差表达的能力，清晰度越高则图像融合效果越好。
% 平均梯度反映了图像细节反差程度和纹理变化特征，一般来说，AG值越大，表明图像越清晰，融合效果越好。
imgfG = Definition(imgf);
sprintf('融合图像的清晰度(平均梯度)为 : %.4f ',imgfG)
evals(3)=imgfG;

% 空间频率Space Frequency - 空间频率反映图像空间域的全面活跃水平，其值越大图像越清晰，即融合效果越好。
imgfSF = MySF(imgf);
sprintf('融合图像的空间频率为 : %.4f ',imgfSF)  
evals(4)=imgfSF;
% 边缘强度用于衡量图像边缘细节的丰富程度，其值越大，则融合图像的边缘越清晰，效果越好。
imgfEI = Edge_Intensity(imgf);
sprintf('融合图像的边缘强度为 : %.4f ',imgfEI)
evals(5)=imgfEI;

% 互信息可作为两个变量之间相关性的量度或一个变量包含另一个变量信息量的量度，互信息越大则融合图像包含源图像信息越多。
[MIInf] = MIabf(oriA, oriB, uint8(imgf));
sprintf('源图像与融合图像之间的互信息为 : %.4f ',MIInf)
evals(6)=MIInf;
%%%%
% 
SSIM_P = metricPeilla(oriA, oriB, imgf, 1);      % SSIM
sprintf('源图像与融合图像之间的SSIM_P为 : %.4f ',SSIM_P)
evals(7)=SSIM_P;
SSIM_yang= metricYang(oriA, oriB, imgf);      % SSIM-metricYang
sprintf('源图像与融合图像之间的SSIM_yang为 : %.4f ',SSIM_yang)
evals(8)=SSIM_yang;
SSIM_Cvejic = metricCvejic(oriA, oriB, imgf,2);      % SSIM-metricCvejic
sprintf('源图像与融合图像之间的SSIM_Cvejic为 : %.4f ',SSIM_Cvejic)
evals(9)=SSIM_Cvejic;
% % 计算源图像和融合图像之间的结构相似性，其值越大则图像融合效果越好
% % 参考文献：Z. Wang, A.C. Bovik, H.R. Sheikh, E.P. Simoncelli. Image quality assessment:from error 
% % visibility to structural similarity, IEEE Transactios on Image Processing，2004，13(4):600–612.
% [ssim1] = (ssim(oriA(:,:,1), imgf(:,:,1))+ssim(oriB(:,:,1), imgf(:,:,1)))/2;
% [ssim2] = (ssim(oriA(:,:,1), imgf(:,:,2))+ssim(oriB(:,:,2), imgf(:,:,2)))/2;
% [ssim3] = (ssim(oriA(:,:,1), imgf(:,:,3))+ssim(oriB(:,:,3), imgf(:,:,3)))/2;
% SSIM = (ssim1+ssim2+ssim3)/3;
% sprintf('源图像与融合图像之间的结构相似性SSIM为 : %.4f ',SSIM)
% 平均交叉熵Mean Cross Entropy - 值越小说明融合图像从源图像中提取的信息越多，融合效果越好
% [MCE] = OverallCrossEntropy(oriA, oriB, uint8(imgf));
% sprintf('源图像与融合图像之间的平均交叉熵为 : %.4f ',MCE)

% % 计算Qo指标取值，其值越接近1，表明图像融合效果越好
% Qo1= (MyQo(oriA(:,:,1),imgf(:,:,1))+MyQo(oriB(:,:,1),imgf(:,:,1)))/2;
% Qo2= (MyQo(oriA(:,:,1),imgf(:,:,2))+MyQo(oriB(:,:,2),imgf(:,:,2)))/2;
% Qo3= (MyQo(oriA(:,:,1),imgf(:,:,3))+MyQo(oriB(:,:,3),imgf(:,:,3)))/2;
% Qo= (Qo1+Qo2+Qo3)/3;
% sprintf('源图像与融合图像之间的Qo值为 : %.4f ',Qo)
% 
% % 计算Qw指标取值，其值越接近1，表明图像融合效果越好
% Qw1 = MyQw(oriA(:,:,1), oriB(:,:,1), imgf(:,:,1));
% Qw2 = MyQw(oriA(:,:,1), oriB(:,:,2), imgf(:,:,2));
% Qw3 = MyQw(oriA(:,:,1), oriB(:,:,3), imgf(:,:,3));
% Qw = (Qw1+Qw2+Qw3)/3;
% sprintf('源图像与融合图像之间的Qw值为 : %.4f ',Qw)
% 
% % 融合图像质量评价指标Qabf利用Sobel边缘检测算子来衡量有多少边缘信息从源图像转移到了融合图像，
% % 可综合评价源图像与融合图像之间的结构相似度，其值越接近1，说明图像融合效果越好。
% [Q1] = Qabf(oriA(:,:,1), oriB(:,:,1), imgf(:,:,1));
% [Q2] = Qabf(oriA(:,:,1), oriB(:,:,2), imgf(:,:,2));
% [Q3] = Qabf(oriA(:,:,1), oriB(:,:,3), imgf(:,:,3));
% Q = (Q1+Q2+Q3)/3;
% sprintf('源图像与融合图像之间的Qabf值为 : %.4f ',Q)
% 

% 
% % 光谱扭曲度Warping Degree - 直接反映了融合影像的光谱失真程度，值越小融合效果越好
% % 偏差指数Bias Index - 表示融合影像和低分辨率多波段源影像的偏离程度，值越小融合效果越好
% [warp1] = analyse(imgf(:,:,1), oriB(:,:,1));
% [warp2] = analyse(imgf(:,:,2), oriB(:,:,2));
% [warp3] = analyse(imgf(:,:,3), oriB(:,:,3));
% warp = (warp1+warp2+warp3)/3;
% sprintf('源图像与融合图像之间的光谱扭曲度为 : %.4f ',warp)