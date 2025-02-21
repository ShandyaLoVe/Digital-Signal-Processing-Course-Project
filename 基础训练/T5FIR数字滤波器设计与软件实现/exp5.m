% FIR 数字滤波器设计及软件实现
clear;close all;
%==调用 xtg 产生信号 xt, xt 长度 N=1000,并显示 xt 及其频谱,=========
N=1000;xt=xtg(N);
fp=120; fs=150;Rp=0.2;As=60;Fs=1000; % 输入给定指标
% (1) 用窗函数法设计滤波器
wc=(fp+fs)/Fs; %理想低通滤波器截止频率(关于 pi 归一化）
B=2*pi*(fs-fp)/Fs; %过渡带宽度指标
Nb=ceil(11*pi/B); %blackman 窗的长度 N
hn=fir1(Nb-1,wc,blackman(Nb));
Hw=abs(fft(hn,1024)); % 求设计的滤波器频率特性
db_Hw=20*log(Hw)/log(10);
ywt=fftfilt(hn,xt,N); %调用函数 fftfilt 对 xt 滤波
%以下为用窗函数法设计法的绘图部分（滤波器损耗函数， 滤波器输出信号波形）
figure(2);subplot(2,1,1);plot(db_Hw);axis([0,512,-200,0]);xlabel('频率/Hz');ylabel('幅度/dB');title('(c) 窗函数法设计滤波器损耗函数');
yt='yw(t)';subplot(2,1,2);tplot(ywt,1/fs,yt);title('(d) ywt输出波形') %调用绘图函数 tplot 绘制滤波器输出波形
% (2) 用等波纹最佳逼近法设计滤波器
fb=[fp,fs];m=[1,0]; % 确定 remezord 函数所需参数 f,m,dev
dev=[(10^(Rp/20)-1)/(10^(Rp/20)+1),10^(-As/20)];
[Ne,fo,mo,W]=remezord(fb,m,dev,Fs); % 确定 remez 函数所需参数
hn=remez(Ne,fo,mo,W); % 调用 remez 函数进行设计
Hw=abs(fft(hn,1024)); % 求设计的滤波器频率特性
db_Hw=20*log(Hw)/log(10);
yet=fftfilt(hn,xt,N); % 调用函数 fftfilt 对 xt 滤波
%以下为用等波纹设计法的绘图部分（滤波器损耗函数， 滤波器输出信号 yw(nT)波形）
figure(3);subplot(2,1,1);plot(db_Hw);axis([0,512,-200,0]);xlabel('频率/Hz');ylabel('幅度/dB');title('(e) 等波纹法设计滤波器损耗函数');
yt='ye(t)';subplot(2,1,2);tplot(yet,1/fs,yt);title('(f) yet输出波形') %调用绘图函数 tplot 绘制滤波器输出波形