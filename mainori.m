
for fm=1:1
    
    fused_path = '../result/insert/';
    disp(fused_path)
    for epoch =1:1
        for i=1:10
            disp(['   image:',num2str(i)]);
            source_ir  = ['../Test_ir/',num2str(i),'.bmp'];
            source_vis = ['../Test_vi/',num2str(i),'.bmp'];

            fused   = [fused_path,num2str(i),'.bmp'];   

            image1 = imread(source_ir);image1=image1(:,:,1);
            image2 = imread(source_vis);image2=image2(:,:,1);
            fused_image   = imread(fused);

            %disp(source_ir)
            %disp(source_vis)
            %disp(fused)
            fused_image=fused_image(:,:,1);

            image1 = imresize(image1,size(fused_image));
            image2 = imresize(image2,size(fused_image));

            % result(3) =i;
            %result(4) = i;
            result = evaluation(image1,image2,fused_image);
            a(i,:,epoch) = result;
        end
        b(epoch,:) = sum(a(:,:,epoch))/10;
      
    
    end
    path_s1 = [fused_path,'/abc'];
    disp(path_s1)
    save(path_s1,'a','b');
    
end
delete(p)
