p = parpool('local',5) 

for sm=1:1
    sname = 'test';
    if(sm==2)
        sname = 'S';
    end
    if(sm==3)
        sname = 'H';
    end
    for fm=1:1
        fused_file_num = fm;
        name = 'channel';
        if(fm==2)
            name = 'l1';
        end
        if(fm==3)
            name = 'channel';
        end
        disp([name]);
        
        fused_path = ['../result/double/5.16/',sname];
        for epoch =1:1
            parfor i =1:10
                
                disp(['name ',name,'   f  ',num2str(fused_file_num),'   epoch:',num2str(epoch),'   image:',num2str(i)]);
                source_ir  = ['../Test_ir/',num2str(i),'.bmp'];
                source_vis = ['../Test_vi/',num2str(i),'.bmp'];

                fused   = [fused_path,'/',name,'/fusion',num2str(i),'.bmp'];   
                
                image1 = imread(source_ir);image1=image1(:,:,1);
                image2 = imread(source_vis);image2=image2(:,:,1);
                fused_image   = imread(fused);
                fused_image=fused_image(:,:,1);
                
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
end

