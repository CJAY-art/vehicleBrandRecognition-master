function [picture,angle] = rando_bianhuan(bw) %��бУ��  picture ����У�����ͼƬ angle��б�Ƕ�
I=rgb2gray(bw);
figure('NumberTitle','off','Name','���ƻҶ�ͼ��');
imshow(I);title('���ƻҶ�ͼ��');
I=edge(I);
theta = 1:180;
[R,xp] = radon(I,theta);
[I,J] = find(R>=max(max(R)));                 %J��¼����б��
angle=90-J;
picture=imrotate(bw,angle,'bilinear','crop'); %������ת���ͼ�����������ʾ��ʱ����ת�� ������ʾ˳ʱ����ת��
figure('NumberTitle','off','Name','��бУ��ͼ��');
imshow(picture);title('��бУ��');
% imwrite(picture,'��бУ������.jpg');