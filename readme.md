如果可以帮到你，感谢简单引用一下我们的文章。

If you got some help, thank you for simply quoting our article. 

## Methods

### 1 [PerceptualFusion](https://github.com/thfylsty/imagefusion_Perceptual_FusionGan)

Fu, Yu, Xiao-Jun Wu, and Tariq Durrani. "Image fusion based on generative adversarial network consistent with perception." *Information Fusion* (2021).

```
@article{fu2021image,
  title={Image fusion based on generative adversarial network consistent with perception},
  author={Fu, Yu and Wu, Xiao-Jun and Durrani, Tariq},
  journal={Information Fusion},
  year={2021},
  publisher={Elsevier}
}
```

### 2 [Dualbranch_Fusion](https://github.com/thfylsty/ImageFusion_Dualbranch_Fusion)

```
@inproceedings{fu2021dual,
  title={A Dual-branch Network for Infrared and Visible Image Fusion},
  author={Fu, Yu and Wu, Xiao-Jun},
  booktitle={2020 25th International Conference on Pattern Recognition},
  year={2020}
}
```

### 3 [DeepDecFusion](https://github.com/thfylsty/ImageFusion_DeepDecFusion)

```
@article{fu2021deep,
  title={A Deep Decomposition Network for Image Processing: A Case Study for Visible and Infrared Image Fusion},
  author={Fu, Yu and Wu, Xiao-Jun and Kittler, Josef},
  journal={arXiv preprint arXiv:2102.10526},
  year={2021}
}
```



### 4 An Effective Method for Fusing Infrared and Visible Images. 

(later)

### 5  PPT Fusion

(later)







# run

"main.m"

代码没写注释，有点乱

## 1.多进程 

默认开启了多进程，核心为5个，

如果不需要，注释第二行和最后一行，以及将parfor改成for


```matlab
line1: p = parpool('local',5) ;
......
line13: parfor ->>>  for
......
line62: delete(gcp('nocreate'));
```

## 2.多个文件夹评价

设置这里可以进行多个文件夹的评价


```matlab
line5: fusion_name = ["0","5","10","15","20"];
```

比如，多种方法可以写成


```matlab
line5: fusion_name = ["CVT","DCWT","Deepfuse"..........];
```

比如，多次迭代的结果可以写成


```matlab
line5: fusion_name = ["0","5","10","15","20"];
```

然后由第8,9行来控制评价的文件夹

```matlab
for fm=1:5
    name = fusion_name(fm);
```

## 输入图像

```matlab
%         source_ir  = ['../TNO/ir/',num2str(i),'.bmp'];
%         source_vis = ['../TNO/vi/',num2str(i),'.bmp'];
source_ir  = ['../road/ir/',num2str(i),'.jpg'];
source_vis = ['../road/vi/',num2str(i),'.jpg'];
        
fused = strcat(fused_path,name,'/road/sm/',num2str(i),'.bmp');

```

## 输出结果

在所在文件夹保存成.mat文件

```matlab
    save_path = strcat(fused_path,'/',name);
    save(save_path,'a','b') ;
    
save_path = strcat(fused_path,'/all');
save(save_path,'c') ;
```

然后用excel自己处理吧。

这是表头

| EI   | CrossEntropy | SF   | EN   | Qabf | SCD  | FMI_w | FMI_dct | SSIM | MS_SSIM | FMI_pixel | Nabf | MI   | VIF  | SD   | EN   | DF   | QSF  | QMI  | QS   | QY   | QC   | QNCIE | Q^{AB/F} | AG   | MIabf | QG   | CC   | VIFF | QP   | QW   | QE   | QCV  | QCB  |
| ---- | ------------ | ---- | ---- | ---- | ---- | ----- | ------- | ---- | ------- | --------- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ----- | -------- | ---- | ----- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
|      |              |      |      |      |      |       |         |      |         |           |      |      |      |      |      |      |      |      |      |      |      |       |          |      |       |      |      |      |      |      |      |      |      |



=======================

=======================

=======================



# run

"main.m"

The code is not commented, it's a bit messy

## 1. Multi-process

Multi-process is enabled by default, with 5 cores,

If not needed, comment the second and last lines, and change parfor to for


```matlab
line1: p = parpool('local',5);
......
line13: parfor ->>> for
......
line62: delete(gcp('nocreate'));
```

## 2. Multiple folder evaluation

Set here to evaluate multiple folders


```matlab
line5: fusion_name = ["0","5","10","15","20"];
```

For example, multiple methods can be written as


```matlab
line5: fusion_name = ["CVT","DCWT","Deepfuse"..........];
```

For example, the result of multiple iterations can be written as


```matlab
line5: fusion_name = ["0","5","10","15","20"];
```

Then lines 8 and 9 control the evaluation folder

```matlab
for fm=1:5
    name = fusion_name(fm);
```

## Input image

```matlab
% source_ir = ['../TNO/ir/',num2str(i),'.bmp'];
% source_vis = ['../TNO/vi/',num2str(i),'.bmp'];
source_ir = ['../road/ir/',num2str(i),'.jpg'];
source_vis = ['../road/vi/',num2str(i),'.jpg'];
        
fused = strcat(fused_path,name,'/road/sm/',num2str(i),'.bmp');

```

## Output result

Save as a .mat file in the folder where it is located

```matlab
    save_path = strcat(fused_path,'/',name);
    save(save_path,'a','b');
    
save_path = strcat(fused_path,'/all');
save(save_path,'c');
```

Then use excel to handle it yourself.

This is the header

| EI   | CrossEntropy | SF   | EN   | Qabf | SCD  | FMI_w | FMI_dct | SSIM | MS_SSIM | FMI_pixel | Nabf | MI   | VIF  | SD   | EN   | DF   | QSF  | QMI  | QS   | QY   | QC   | QNCIE | Q^{ AB/F} | AG   | MIabf | QG   | CC   | VIFF | QP   | QW   | QE   | QCV  | QCB  |
| ---- | ------------ | ---- | ---- | ---- | ---- | ----- | ------- | ---- | ------- | --------- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ----- | --------- | ---- | ----- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
|      |              |      |      |      |      |       |         |      |         |           |      |      |      |      |      |      |      |      |      |      |      |       |           |      |       |      |      |      |      |      |      |      |      |