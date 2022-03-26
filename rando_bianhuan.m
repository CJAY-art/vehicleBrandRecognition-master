function [picture,angle] = rando_bianhuan(bw) %倾斜校正  picture 返回校正后的图片 angle倾斜角度
I=rgb2gray(bw);
figure('NumberTitle','off','Name','车牌灰度图像');
imshow(I);title('车牌灰度图像');
I=edge(I);
theta = 1:180;
[R,xp] = radon(I,theta);
[I,J] = find(R>=max(max(R)));                 %J记录了倾斜角
angle=90-J;
picture=imrotate(bw,angle,'bilinear','crop'); %返回旋转后的图像矩阵。正数表示逆时针旋转， 负数表示顺时针旋转。
figure('NumberTitle','off','Name','倾斜校正图像');
imshow(picture);title('倾斜校正');
% imwrite(picture,'倾斜校正车牌.jpg');