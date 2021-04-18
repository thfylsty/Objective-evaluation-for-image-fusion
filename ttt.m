function [ result ] = evaluation( imgA, imgB, imgF )
%%  边缘强度
result(1) = Edge_Intensity(imgF);

result(2) = OverallCrossEntropy(imgA, imgB, imgF);  % 总体交叉熵


end

