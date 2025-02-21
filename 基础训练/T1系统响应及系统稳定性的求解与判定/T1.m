%题目 1： 系统响应及系统稳定性
close all;clear
%======内容 1： 调用 filter 解差分方程， 由系统对 u(n)的响应判断稳定性======
A=[1,-0.9];B=[0.05,0.05]; %系统差分方程系数向量 B 和 A
x1n=[1 1 1 1 1 1 1 1 zeros(1,50)]; %产生信号 x1(n)=R8(n)，门信号
x2n=ones(1,128); %产生信号 x2(n)=u(n)
hn=impz(B,A,58); %求系统单位脉冲响应 h(n)，0-57将前58个数据输出。
subplot(2,2,1);y='h(n)';tstem(hn,y); %调用函数 tstem 绘图
title('(a) 系统单位脉冲响应 h(n)');box on
y1n=filter(B,A,x1n); %求系统对 x1(n)的响应 y1(n)
subplot(2,2,2);y='y1(n)';tstem(y1n,y);
title('(b) 系统对 R8(n)的响应 y1(n)');box on
y2n=filter(B,A,x2n); %求系统对 x2(n)的响应 y2(n)
subplot(2,2,4);y='y2(n)';tstem(y2n,y);
title('(c) 系统对 u(n)的响应 y2(n)');box on
%===内容 2： 调用 conv 函数计算卷积============================
x1n=[1 1 1 1 1 1 1 1 ]; %产生信号 x1(n)=R8(n)
h1n=[ones(1,10) zeros(1,10)];
h2n=[1 2.5 2.5 1 zeros(1,10)];
y21n=conv(h1n,x1n);
y22n=conv(h2n,x1n);
figure(2)
subplot(2,2,1);y='h1(n)';tstem(h1n,y); %调用函数 tstem 绘图
title('(d) 系统单位脉冲响应 h1(n)');box on
subplot(2,2,2);y='y21(n)';tstem(y21n,y);
title('(e) h1(n)与 R8(n)的卷积 y21(n)');box on
subplot(2,2,3);y='h2(n)';tstem(h2n,y); %调用函数 tstem 绘图
title('(f) 系统单位脉冲响应 h2(n)');box on
subplot(2,2,4);y='y22(n)';tstem(y22n,y);
title('(g) h2(n)与 R8(n)的卷积 y22(n)');box on
%=========内容 3： 谐振器分析========================
un=ones(1,256); %产生信号 u(n)
n=0:255;%256个采样点？
xsin=sin(0.014*n)+sin(0.4*n); %产生正弦信号
A=[1,-1.8237,0.9801];B=[1/100.49,0,-1/100.49]; %系统差分方程系数向量 B 和 A
y31n=filter(B,A,un); %谐振器对 u(n)的响应 y31(n)
y32n=filter(B,A,xsin); %谐振器对 xsin的响应 y32(n)
figure(3)
subplot(2,1,1);y='y31(n)';tstem(y31n,y);
title('(h) 谐振器对 u(n)的响应 y31(n)');box on
subplot(2,1,2);y='y32(n)';tstem(y32n,y);
title('(i) 谐振器对正弦信号的响应 y32(n)');box on
figure(4);tstem(xsin,'xsin');box on
