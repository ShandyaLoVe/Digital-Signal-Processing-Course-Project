function xt=xtg(N)
%题目五信号 x(t)产生,并显示信号的幅频特性曲线
%xt=xtg(N) 产生一个长度为 N,有加性高频噪声的单频调幅信号 xt,采样频率 Fs=1000Hz
%载波频率 fc=Fs/10=100Hz,调制正弦波频率 f0=fc/10=10Hz.
Fs=1000;T=1/Fs;Tp=N*T;
t=0:T:(N-1)*T;
fc=Fs/10;f0=fc/10; %载波频率 fc=Fs/10， 单频调制信号频率为 f0=Fc/10;
mt=cos(2*pi*f0*t); %产生单频正弦波调制信号 mt， 频率为 f0
ct=cos(2*pi*fc*t); %产生载波正弦波信号 ct， 频率为 fc
xt=mt.*ct; %相乘产生单频调制信号 xt
nt=2*rand(1,N)-1; %产生随机噪声 nt
%设计高通滤波器 hn,用于滤除噪声 nt 中的低频成分,生成高通噪声
%========================
fp=150; fs=200;Rp=0.1;As=70; % 滤波器指标
fb=[fp,fs];m=[0,1]; % 计算 remezord 函数所需参数 f,m,dev
dev=[10^(-As/20),(10^(Rp/20)-1)/(10^(Rp/20)+1)];
[n,fo,mo,W]=remezord(fb,m,dev,Fs); % 确定 remez 函数所需参数
hn=remez(n,fo,mo,W); % 调用 remez 函数进行设计,用于滤除噪声 nt 中的低频成分
yt=filter(hn,1,10*nt); %滤除随机噪声中低频成分， 生成高通噪声 yt
xt=xt+yt; %噪声加信号
fst=fft(xt,N);k=0:N-1;f=k/Tp;
subplot(2,1,1);plot(t,xt);grid;xlabel('t/s');ylabel('x(t)');
axis([0,Tp/5,min(xt),max(xt)]);title('(a) 信号加噪声波形')
subplot(2,1,2);plot(f,abs(fst)/max(abs(fst)));grid;title('(b) 信号加噪声的频谱')
axis([0,Fs/2,0,1.2]);xlabel('f/Hz');ylabel('幅度')