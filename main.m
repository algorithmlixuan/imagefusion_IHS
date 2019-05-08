%% @author������
% title������HIS��Image Fusion
% Algorithm : 
% ���߷ֱ��ȫɫӰ��͵ͷֱ��ʵĶ����Ӱ������ںϴ����
% �õ������Ӱ��ʹ�ںϺ�Ӱ����нϸߵĿռ�ֱ��ʣ�ͬʱ
% ���нϷḻ�Ĺ�����Ϣ
close all
clear
clc
%% ����߹���ͼ��
I_MSS = mat2gray(im2double(imread('1-MSS.tif')));
I_MSS = I_MSS(:,:,1:3);
subplot(121)
imshow(I_MSS)
title('�����ͼ��')

I_MSS = imresize(I_MSS,4);    % LMS�ϲ���4��
R = I_MSS(:,:,1);
G = I_MSS(:,:,2);
B = I_MSS(:,:,3);

%% ����ȫɫͼ��
I_PAN = mat2gray(im2double(imread('1-PAN.tif')));
[ylen, xlen, c] = size(I_MSS);

%% IHS�任
% RGB ==> IHS ���任����
tran1 = [ 1/3,         1/3,         1/3;       
          -sqrt(2)/6,  -sqrt(2)/6,  sqrt(2)/3;      
          1/sqrt(2),   -1/sqrt(2),  0         ];
  
% IHS ==> RGB ��任����
tran2 = [ 1,  -1/sqrt(2),  1/sqrt(2);       
          1,  -1/sqrt(2),  -1/sqrt(2);      
          1,  sqrt(2),     0           ];

trans_in = [reshape(R, 1, ylen * xlen); ...
            reshape(G, 1, ylen * xlen); ...
            reshape(B, 1, ylen * xlen)];

% ���� RGB ==> IHS ���任
trans_res = tran1 * trans_in;
% ���� PAN �滻 I ����
trans_res(1,:) = reshape(I_PAN, 1, ylen*xlen);
% ���� IHS ==> RGB ���任
trans_res = tran2 * trans_res;

% �ѱ任������浽 I_FUS ��
I_FUS = zeros(ylen, xlen, 3);
I_FUS(:,:,1) = reshape(trans_res(1, :), ylen, xlen);
I_FUS(:,:,2) = reshape(trans_res(2, :), ylen, xlen);
I_FUS(:,:,3) = reshape(trans_res(3, :), ylen, xlen);
subplot(122)
imshow(I_FUS)
title('�ںϺ��ͼ��')








