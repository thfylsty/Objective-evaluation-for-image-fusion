clear;
% p = parpool('local',4) ;
for fm=1:1
    fused_file_num = fm;
    name = 'channel';
    if(fm==2)
        name = 'ori';
    end
    if(fm==3)
        name = 'channel';
    end
    disp([name]);
    
    fused_path = '../result/split/5.20';
    for epoch =1:1
        for i =1:10
            
            disp(['name ',name,'   f  ',num2str(fused_file_num),'   epoch:',num2str(epoch),'   image:',num2str(i)]);
            source_ir  = ['../Test_ir/',num2str(i),'.bmp'];
            source_vis = ['../Test_vi/',num2str(i),'.bmp'];

            fused   = [fused_path,'/',name,'/fusion',num2str(i),'.bmp'];   
            
            image1 = imread(source_ir);
            image2 = imread(source_vis);
            if size(image1, 3) == 3
                image1 = rgb2gray(image1);
            end
            if size(image2, 3) == 3
                image2 = rgb2gray(image2);
            end

            fused_image   = imread(fused);
            if size(fused_image, 3) == 3
                fused_image = rgb2gray(fused_image);
            end
     
            image1 = imresize(image1,size(fused_image));
            image2 = imresize(image2,size(fused_image));
            
            result = evaluation(image1,image2,fused_image);
            a(i,:,epoch) = result;
        end
        b(epoch,:) = sum(a(:,:,epoch))/10;
    end
    c(:,:,epoch) = b;
    save([fused_path,'/',name],'a','b','c') ;
    
end
% delete(gcp('nocreate'));

