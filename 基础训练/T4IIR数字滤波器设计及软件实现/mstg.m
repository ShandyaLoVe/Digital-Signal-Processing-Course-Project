function st=mstg
%产生信号序列向量 st,并显示 st 的时域波形和频谱
%st=mstg 返回三路调幅信号相加形成的混合信号， 长度 N=1600
N=1600; %N 为信号 st 的长度
Fs=10000;T=1/Fs;Tp=N*T; %采样频率 Fs=10kHz， Tp 为采样时间
t=0:T:(N-1)*T;k=0:N-1;f=k/Tp;
fc1=Fs/10; %第 1 路调幅信号的载波频率 fc1=1000Hz
fm1=fc1/10; %第 1 路调幅信号的调制信号频率 fm1=100Hz
fc2=Fs/20; %第 2 路调幅信号的载波频率 fc2=500Hz
fm2=fc2/10; %第 2 路调幅信号的调制信号频率 fm2=50Hz
fc3=Fs/40; %第 3 路调幅信号的载波频率 fc3=250Hz
fm3=fc3/10; %第 3 路调幅信号的调制信号频率 fm3=25Hz
xx1=(1+cos(2*pi*fm1*t)).*cos(2*pi*fc1*t);
xx2=(1+cos(2*pi*fm2*t)).*cos(2*pi*fc2*t);
xx3=(1+cos(2*pi*fm3*t)).*cos(2*pi*fc3*t);
xt1=cos(2*pi*fm1*t).*cos(2*pi*fc1*t); %产生第 1 路调幅信号
xt2=cos(2*pi*fm2*t).*cos(2*pi*fc2*t); %产生第 2 路调幅信号
xt3=cos(2*pi*fm3*t).*cos(2*pi*fc3*t); %产生第 3 路调幅信号
st=xt1+xt2+xt3; %三路调幅信号相加
st=xx1+xx2+xx3;
fxt=fft(st,N); %计算信号 st 的频谱
%====以下为绘图部分， 绘制 st 的时域波形和幅频特性曲线====3
subplot(3,1,1);
plot(t,st);grid;xlabel('t/s');ylabel('s(t)');
axis([0,Tp/8,min(st),max(st)]);title('(a) s(t)的波形');
subplot(3,1,2);
stem(f,abs(fxt)/max(abs(fxt)),'.');grid;title('(b) s(t)的频谱');
axis([0,Fs/5,0,1.2]);
xlabel('f/Hz');ylabel('幅度');