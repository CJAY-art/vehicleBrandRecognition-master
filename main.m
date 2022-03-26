clc;
clear;  
close all;   

% ==============开始计时==============================
tic
%=====================读入图片=========================
[fn,pn,fi] = uigetfile('汽车图片\*.jpg','选择图片');%显示检索文件的对话框 fn返回的文件名 pn返回的文件的路径名 fi返回选择的文件类型 
I = imread([pn fn]);                %读入彩色图像
% figure('NumberTitle','off','Name','原始图像');
% imshow(I);title('原始图像');        %显示原始图像

%==================加入进度条===========================
% waitbar_;

%================图像分割区域(车牌定位)==========================
% picture =location(I);
picture =image_segmentation1(I);
threshold=50;

%========================倾斜校正=================
[picture_1,angle] = rando_bianhuan(picture); %倾斜校正  picture 返回校正后的图片 angle 返回倾斜角度

%=============对图像进一步裁剪，去除边框===========
picture_2=qubian(picture_1);
%=================文字分割 ===================================
image=qiege(picture_2);
%=================识别================================
bb =zifu_shibie(image);
% imshow(picture_1),title (['识别车牌号码:', bb],'Color','r');

%=====================导出文本===========================
fid=fopen('Data.txt','a+');
fprintf(fid,'%s\r\n',bb,datestr(now));
fclose(fid);

%===================读出声音============================
% duchushengyin(bb);

% ================读取计时===================================
t= toc;
