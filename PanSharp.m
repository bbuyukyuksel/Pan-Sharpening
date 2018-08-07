%% Ödev Sahibi
clc;clear;close all;
%Reference: https://onlinecourses.science.psu.edu/stat501/node/382
name = 'Burak Büyükyüksel';
no = '150208060';
%% Görüntüler Okundu
Iorg = double(imread('original.tiff'));
Ipan = double(imread('pan.tiff'));
Irgb = double(imread('rgb.tiff'));

%% R,G,B ve Pan tek boyutlu matrise dönü?türüldü
Ip = Ipan(:);
r= Irgb(:,:,1); r= r(:);
g= Irgb(:,:,2); g= g(:);
b= Irgb(:,:,3); b= b(:);

%% Multiplier Regresyon i?lemine tabii tutuldu
X = [ones(size(r)) r g b];
REG = regress(Ip,X);    A0 = REG(1);  AR = REG(2); AG = REG(3); AB = REG(4);
%% Regresyon de?erleri ile Pan-Sentetik görüntü olu?turuldu
Is(:,:,1) = Iorg(:,:,1) .* AR + Iorg(:,:,2) .* AG +Iorg(:,:,3) .* AB + A0;
Is(:,:,2) = Iorg(:,:,1) .* AR + Iorg(:,:,2) .* AG +Iorg(:,:,3) .* AB + A0;
Is(:,:,3) = Iorg(:,:,1) .* AR + Iorg(:,:,2) .* AG +Iorg(:,:,3) .* AB + A0;
%% Pan Keskinle?tirme i?lemi gerçekle?tirildi
Inew = (Iorg ./ Is) .* Ipan;

%% Çizimler Görüntülendi
figure(1);
subplot(2,2,1);
imshow(uint8(Irgb));
title("RGB");
subplot(2,2,2);
imshow(uint8(Is));
title("Sentetik");
subplot(2,2,3);
imshow(uint8(Inew));
title("Pan-Sharp");
subplot(2,2,4);
imshow(uint8(Iorg));
title("Iorg");
[peaksnr, snr] = psnr(uint8(Inew),uint8(Iorg));
str = sprintf('\n The Peak-SNR value is %0.4f', peaksnr);
txt = sprintf('%s | %s',name,no);

text(-573,-220,str,'Color','Red','FontSize',14,'BackgroundColor','k');
text(-570,-228,txt,'Color','Green','FontSize',10,'BackgroundColor','k');

%% Çizimler Kaydedildi
saveas(figure(1),'PanSharpFig.bmp');
imwrite(uint8(Inew),'PanSharpImg.bmp');


