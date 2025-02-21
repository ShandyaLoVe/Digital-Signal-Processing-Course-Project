% IIR 数字滤波器设计及软件实现
clear;close all
Fs=10000;T=1/Fs; %采样频率
%调用信号产生函数 mstg 产生由三路抑制载波调幅信号相加构成的复合信号 st
st=mstg;
%低通滤波器设计与实现=================================
fp=280;fs=450;
wp=2*fp/Fs;ws=2*fs/Fs;rp=0.1;rs=60; %DF 指标（低通滤波器的通、 阻带边界频）
[N,wp]=ellipord(wp,ws,rp,rs); % ellipord 计算椭圆 DF 阶数 N 和通带截止频率 wp
[B,A]=ellip(N,rp,rs,wp); %调用 ellip 计算椭圆带通 DF 系统函数系数向量 B 和 A
y1t=filter(B,A,st); %滤波器软件实现
% 低通滤波器设计与实现绘图部分
figure(2);subplot(2,1,1);
myplot(B,A); %调用绘图函数 myplot 绘制损耗函数曲线
yt='y_1(t)';
subplot(2,1,2);tplot(y1t,T,yt);title('y1t输出波形') %调用绘图函数 tplot 绘制滤波器输出波形
%带通滤波器设计与实现=====================================
fpl=440;fpu=560;fsl=275;fsu=900;
wp=[2*fpl/Fs,2*fpu/Fs];ws=[2*fsl/Fs,2*fsu/Fs];rp=0.1;rs=60;
[N,wp]=ellipord(wp,ws,rp,rs); %调用 ellipord 计算椭圆 DF 阶数 N 和通带截止频率 wp
[B,A]=ellip(N,rp,rs,wp); %调用 ellip 计算椭圆带通 DF 系统函数系数向量 B 和 A
y2t=filter(B,A,st); %滤波器软件实现
% 带通滤波器设计与实现绘图部分
figure(3);subplot(2,1,1);
myplot(B,A); %调用绘图函数 myplot 绘制损耗函数曲线
yt='y_2(t)';
subplot(2,1,2);tplot(y2t,T,yt);title('y2t输出波形') %调用绘图函数 tplot 绘制滤波器输出波形
%高通滤波器设计与实现=======================
fp=890;fs=600;
wp=2*fp/Fs;ws=2*fs/Fs;rp=0.1;rs=60; %DF 指标（低通滤波器的通、 阻带边界频）
[N,wp]=ellipord(wp,ws,rp,rs); % ellipord 计算椭圆 DF 阶数 N 和通带截止频率 wp
[B,A]=ellip(N,rp,rs,wp,'high'); % ellip 计算椭圆带通 DF 系统函数系数向量 B 和 A
y3t=filter(B,A,st); %滤波器软件实现
% 高低通滤波器设计与实现绘图部分
figure(4);subplot(2,1,1);
myplot(B,A); %调用绘图函数 myplot 绘制损耗函数曲线
yt='y_3(t)';
subplot(2,1,2);tplot(y3t,T,yt);title('y3t输出波形') %调用绘图函数 tplot 绘制滤波器输出波形