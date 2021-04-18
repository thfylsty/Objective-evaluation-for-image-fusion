for fm=4:8
    count=1;
    fused_path = ['C:\Users\Administrator\Desktop\。\口嫌体直\报告\code\常用融合\融合结果\F\',num2str(fm)];
    for i=1:10
        disp(['fm:',num2str(fm),'   image:',num2str(i)]);
        source_ir  = ['C:\Users\Administrator\Desktop\ceshi\中训练集\Test_ir\',num2str(i),'.bmp'];
        source_vis = ['C:\Users\Administrator\Desktop\ceshi\中训练集\Test_vi\',num2str(i),'.bmp'];
        fused   = [fused_path,'\',num2str(i),'.png'];    
        image1 = imread(source_ir);image1=image1(:,:,1);
        image2 = imread(source_vis);image2=image2(:,:,1);
        fused_image   = imread(fused);
        [m,n] = size(image1);
        fused_image=fused_image(1:m,1:n,1);
        
        result = evaluation(image1,image2,fused_image);
        %result =entropy(fused_image);
    
        a(i,:,count) = result;
    end
    b(count,:) = sum(a(:,:,count))/i;
    count = count+1;
    save([fused_path,'\data',num2str(fm)],'a','b');

    %c(:,:,fused_file_num) = b;
    save([fused_path,'\..\c'],'c');
end
% for sss =9:14
%     d=c(:,:,sss);
%     p = sum(d);
%     pp = diag(p);
%     norm = d*(pp^-1);
%     plot(norm,'DisplayName','norm')
% end

disp('Done');
% for fm=1:8
% load(['C:\Users\Administrator\Desktop\。\口嫌体直\报告\code\常用融合\融合结果\F\',num2str(fm),'\data',num2str(fm),'.mat'])
% c(fm:fm,:)=b;
% end
