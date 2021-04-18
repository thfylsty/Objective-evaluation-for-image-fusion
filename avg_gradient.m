%   感谢亲亲使用此代码，此代码解决您的问题了吗~(@^_^@)~
%   没解决的话告诉亲亲一个好消息，我这里可以1分钱帮助代码改错，还提供1分钱成品代码(′▽`〃)哦~
%   登录淘宝店铺“大成软件工作室”便可领取
%   是的，亲亲真的没有看错，挠破头皮的问题真的1分钱就可以解决了\(^o^)/YES!
%   小的这就把传送门给您，记得要收藏好哦(づ￣3￣)づ╭～
%   传送门：https://item.taobao.com/item.htm?spm=a1z10.1-c.w4004-15151018122.5.uwGoq5&id=538759553146
%   如果传送门失效，亲亲可以来店铺讨要，客服MM等亲亲来骚扰哦~(*/ω╲*)
function outval = avg_gradient(img) 
% OUTVAL = AVG_GRADIENT(IMG) 
 
if nargin == 1 
    img = double(img); 
    % Get the size of img 
    [r,c,b] = size(img); 
     
    dx = 1; 
    dy = 1; 
    for k = 1 : b 
        band = img(:,:,k); 
        [dzdx,dzdy] = gradient(band,dx,dy); 
        s = sqrt((dzdx .^ 2 + dzdy .^2) ./ 2); 
        g(k) = sum(sum(s)) / ((r - 1) * (c - 1)); 
    end 
    outval = mean(g); 
else 
    error('Wrong number of input!'); 
end
