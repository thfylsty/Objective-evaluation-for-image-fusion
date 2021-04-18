README
Last modified: Nov 28, 2012

%-----------------------------------------------------------------------
This package contains Matlab code for image fusion metrics. The references for each metric is given in the corresponding Matlab functions. All these functions are provided "as is" without express or implied warranty.
%-----------------------------------------------------------------------

Reference: 

Liu, Z., Blasch, E., Xue, Z., Zhao, J., Lagani¨¦re, R., and Wu, W., ``Objective assessment of multiresolution image fusion algorithms for context enhancement in Night vision: A comparative study", IEEE Transactions on Pattern Analysis and Machine Intelligence, Volume 34, Issue 1, 2012, Article number 5770270, Pages 94-109.  


@article{10.1109/TPAMI.2011.109,
author = {Zheng Liu and Erik Blasch and Zhiyun Xue and Jiying Zhao and Robert Laganiere and Wei Wu},
title = {Objective Assessment of Multiresolution Image Fusion Algorithms for Context Enhancement in Night Vision: A Comparative Study},
journal ={IEEE Transactions on Pattern Analysis and Machine Intelligence},
volume = {34},
issn = {0162-8828},
year = {2012},
pages = {94-109},
doi = {http://doi.ieeecomputersociety.org/10.1109/TPAMI.2011.109},
publisher = {IEEE Computer Society},
address = {Los Alamitos, CA, USA},
}
%-----------------------------------------------------------------------

Contents:

[1] - metricMI.m: revised mutual information based metric; Tsallis entropy (Cvejic & Nava);  
[2] - metricWang.m: nonlinear correlation information entropy;
[3] - metricXydeas.m: Xydeas's fusion metric;
[4] - metricPWW.m: multi-scale fusion metric; 
(*Simoncelli's steerable pyramid toolbox is used, which is available at: http://www.cns.nyu.edu/~eero/steerpyr/. However, you can use the functions from Matlab wavelet toolbox. Need a little bit modification of this function.)
[5] - metricZheng.m: metric based on spatial frequency;
[6] - metricZhao.m: image phase congruency based metric;
(This function uses the phase congruency implementation [phasecong2.m] from Dr. Peter Kovesi, available at http://www.csse.uwa.edu.au/~pk/research/matlabfns/. The modified version myphasecong3.m is used in this fusion metric function.)
[7] - metricPeilla.m: Peilla's metric;
(This metric uses the ssim_index function by Dr. Zhou Wang, available at https://ece.uwaterloo.ca/~z70wang/research/ssim/.)
[8] - metricCvejic.m: two fusion metric by Cvejic;
[9] - metricYang.m: image similarity based metric;
[10] - metricChen.m: human perception inspired qualtiy metric (by Dr. Hao Chen);
[11] - metricChenBlum.m: fusion metric by Dr. Yin Chen. 


- The example of using the fusion metrics is given in function fusionAssess.m.


------------------------------------
Please send your comments/questions to: 

Dr. Zheng liu
Toyota Technological Insititute (Nagoya)
zheng.liu@ieee.org
------------------------------------
 
######################################################################### 
Note:
#########################################################################

* Some functions in steerable pyramid toolbox need to be recompiled for the new version of matlab.

Please follow the steps to accomplish this: (credit: Patrick J. Mineault) 
[ http://xcorr.net/2008/05/21/getting-the-steerable-pyramid-toolbox-to-work-in-matlab-2008a/ ]

1)  Install Visual C++ express edition.
2)  Restart your computer
3)  In Matlab, type mex -setup. Ask it to locate installed compilers. It should find the Microsoft C++ compiler in C:\Program Files\Microsoft Visual Studio 9.0. Select it, and it should update the options file.
4)  Change your Matlab working directory to the MEX folder of the steerable pyramid toolbox. Delete all of the .mex files you see in there.
5)  Type the following commands in the Matlab command window:
        mex corrDn.c wrap.c convolve.c edges.c
        mex upConv.c wrap.c convolve.c edges.c
        mex pointOp.c
        mex histo.c
        mex range2.c
6)  Now add the MEX folder to your Matlab path, and the toolbox should use the new mex files which appear to work fine.

