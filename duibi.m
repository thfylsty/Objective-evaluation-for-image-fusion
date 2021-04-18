h = []
for i = 1:12
    GYH = a(i,:);
    IFCNN = b(i,:);
    LPSR = c(i,:);
    GFF = d(i,:);
    MFCNN = e(i,:);
    %densefuse = f(i,:);
    g = [GYH;IFCNN;LPSR;GFF;MFCNN];
    h = [h;g]
end