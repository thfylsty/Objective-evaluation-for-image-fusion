clear;
p = parpool('local',5) ;
currentFolder = pwd;
addpath(genpath(currentFolder));
fusion_name = ["0","5","10","15","20"];
nums = 50;
%road TNO bmp 
for fm=1:5
    name = fusion_name(fm);
    disp(name);
    fused_path = '../result/transfuse/result/road/result/';

    parfor i =1:nums

        disp(['name ',name,'  image:',num2str(i)]);
        
%         
%         source_ir  = ['../TNO/ir/',num2str(i),'.bmp'];
%         source_vis = ['../TNO/vi/',num2str(i),'.bmp'];
         source_ir  = ['../road/ir/',num2str(i),'.jpg'];
        source_vis = ['../road/vi/',num2str(i),'.jpg'];

        
%         source_ir  = ['../Test_ir/',num2str(i),'.bmp'];
%         source_vis = ['../Test_vi/',num2str(i),'.bmp'];
        
        image1 = imread(source_ir);
        image2 = imread(source_vis);
        if size(image1, 3) == 3
            image1 = rgb2gray(image1);
        end
        if size(image2, 3) == 3
            image2 = rgb2gray(image2);
        end
        
        try
            fused   = strcat(fused_path,name,'/road/sm/',num2str(i),'.bmp');
            fused_image   = imread(fused);
        catch

            fused   = strcat(fused_path,name,'/road/sm/',num2str(i),'.png');
            fused_image   = imread(fused);
        end
        disp(fused);
        if size(fused_image, 3) == 3
            fused_image = rgb2gray(fused_image);
        end

        image1 = imresize(image1,size(fused_image));
        image2 = imresize(image2,size(fused_image));
        result = evalution(image1,image2,fused_image);
        a(i,:) = result;
    end
    b(:) = sum(a(:,:))/nums;
    c(fm,:) = b;
    save_path = strcat(fused_path,'/',name);
    save(save_path,'a','b') ;
end
save_path = strcat(fused_path,'/all');
save(save_path,'c') ;

delete(gcp('nocreate'));

