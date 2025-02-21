% 用 FFT 对信号作频谱分析
clear;close all
%题目 3 内容(1)===================================================
x1n=[ones(1,4)]; %产生序列向量 x1(n)=R4(n)
M=8;xa=1:(M/2); xb=(M/2):-1:1; x2n=[xa,xb]; %产生长度为 8 的三角波序列 x2(n)
x3n=[xb,xa];
X1k8=fft(x1n,8); %计算 x1n 的 8 点 DFT
X1k16=fft(x1n,16); %计算 x1n 的 16 点 DFT
X2k8=fft(x2n,8); %计算 x1n 的 8 点 DFT
X2k16=fft(x2n,16); %计算 x1n 的 16 点 DFT
X3k8=fft(x3n,8); %计算 x1n 的 8 点 DFT
X3k16=fft(x3n,16); %计算 x1n 的 16 点 DFT
%以下绘制幅频特性曲线
subplot(2,2,1);mstem(X1k8); %绘制 8 点 DFT 的幅频特性图
title('(1a) 8 点 DFT[x_1(n)]');xlabel('ω/π');ylabel('幅度');
axis([0,2,0,1.2*max(abs(X1k8))])
subplot(2,2,3);mstem(X1k16); %绘制 16 点 DFT 的幅频特性图
title('(1b)16 点 DFT[x_1(n)]');xlabel('ω/π');ylabel('幅度');
axis([0,2,0,1.2*max(abs(X1k16))])
figure(2)
subplot(2,2,1);mstem(X2k8); %绘制 8 点 DFT 的幅频特性图
title('(2a) 8 点 DFT[x_2(n)]');xlabel('ω/π');ylabel('幅度');
axis([0,2,0,1.2*max(abs(X2k8))])
subplot(2,2,2);mstem(X2k16); %绘制 16 点 DFT 的幅频特性图
title('(2b)16 点 DFT[x_2(n)]');xlabel('ω/π');ylabel('幅度');
axis([0,2,0,1.2*max(abs(X2k16))])
subplot(2,2,3);mstem(X3k8); %绘制 8 点 DFT 的幅频特性图
title('(3a) 8 点 DFT[x_3(n)]');xlabel('ω/π');ylabel('幅度');
axis([0,2,0,1.2*max(abs(X3k8))])
subplot(2,2,4);mstem(X3k16); %绘制 16 点 DFT 的幅频特性图
title('(3b)16 点 DFT[x_3(n)]');xlabel('ω/π');ylabel('幅度');
axis([0,2,0,1.2*max(abs(X3k16))])
%题目 3 内容(2) 周期序列谱分析==================================
N=8;n=0:N-1; %FFT 的变换区间 N=8
x4n=cos(pi*n/4);
x5n=cos(pi*n/4)+cos(pi*n/8);
X4k8=fft(x4n); %计算 x4n 的 8 点 DFT
X5k8=fft(x5n); %计算 x5n 的 8 点 DFT
N=16;n=0:N-1; %FFT 的变换区间 N=168
x4n=cos(pi*n/4);
x5n=cos(pi*n/4)+cos(pi*n/8);
X4k16=fft(x4n); %计算 x4n 的 16 点 DFT
X5k16=fft(x5n); %计算 x5n 的 16 点 DFT
figure(3)
subplot(2,2,1);mstem(X4k8); %绘制 8 点 DFT 的幅频特性图
title('(4a) 8 点 DFT[x_4(n)]');xlabel('ω/π');ylabel('幅度');
axis([0,2,0,1.2*max(abs(X4k8))])
subplot(2,2,3);mstem(X4k16); %绘制 16 点 DFT 的幅频特性图
title('(4b)16 点 DFT[x_4(n)]');xlabel('ω/π');ylabel('幅度');
axis([0,2,0,1.2*max(abs(X4k16))])
subplot(2,2,2);mstem(X5k8); %绘制 8 点 DFT 的幅频特性图
title('(5a) 8 点 DFT[x_5(n)]');xlabel('ω/π');ylabel('幅度');
axis([0,2,0,1.2*max(abs(X5k8))])
subplot(2,2,4);mstem(X5k16); %绘制 16 点 DFT 的幅频特性图
title('(5b)16 点 DFT[x_5(n)]');xlabel('ω/π');ylabel('幅度');
axis([0,2,0,1.2*max(abs(X5k16))])
%题目 3 内容(3) 模拟周期信号谱分析===============================
figure(4)
Fs=64;T=1/Fs;
N=16;n=0:N-1; %FFT 的变换区间 N=16
x6nT=cos(8*pi*n*T)+cos(16*pi*n*T)+cos(20*pi*n*T); %对 x6(t)16 点采样
X6k16=fft(x6nT); %计算 x6nT 的 16 点 DFT
X6k16=fftshift(X6k16); %将零频率移到频谱中心
Tp=N*T;F=1/Tp; %频率分辨率 F
k=-N/2:N/2-1;fk=k*F; %产生 16 点 DFT 对应的采样点频率（以零频率为中心）
subplot(3,1,1);stem(fk,abs(X6k16),'.');box on %绘制 8 点 DFT 的幅频特性图
title('(6a) 16 点|DFT[x_6(nT)]|');xlabel('f(Hz)');ylabel('幅度');
axis([-N*F/2-1,N*F/2-1,0,1.2*max(abs(X6k16))])
N=32;n=0:N-1; %FFT 的变换区间 N=16
x6nT=cos(8*pi*n*T)+cos(16*pi*n*T)+cos(20*pi*n*T); %对 x6(t)32 点采样
X6k32=fft(x6nT); %计算 x6nT 的 32 点 DFT
X6k32=fftshift(X6k32); %将零频率移到频谱中心
Tp=N*T;F=1/Tp; %频率分辨率 F
k=-N/2:N/2-1;fk=k*F; %产生 16 点 DFT 对应的采样点频率（以零频率为中心）
subplot(3,1,2);stem(fk,abs(X6k32),'.');box on %绘制 8 点 DFT 的幅频特性图
title('(6b) 32 点|DFT[x_6(nT)]|');xlabel('f(Hz)');ylabel('幅度');
axis([-N*F/2-1,N*F/2-1,0,1.2*max(abs(X6k32))])
N=64;n=0:N-1; %FFT 的变换区间 N=16
x6nT=cos(8*pi*n*T)+cos(16*pi*n*T)+cos(20*pi*n*T); %对 x6(t)64 点采样
X6k64=fft(x6nT); %计算 x6nT 的 64 点 DFT
X6k64=fftshift(X6k64); %将零频率移到频谱中心
Tp=N*T;F=1/Tp; %频率分辨率 F
k=-N/2:N/2-1;fk=k*F; %产生 16 点 DFT 对应的采样点频率（以零频率为中心）9
subplot(3,1,3);stem(fk,abs(X6k64),'.'); box on%绘制 8 点 DFT 的幅频特性图
title('(6c) 64 点|DFT[x_6(nT)]|');xlabel('f(Hz)');ylabel('幅度');
axis([-N*F/2-1,N*F/2-1,0,1.2*max(abs(X6k64))])