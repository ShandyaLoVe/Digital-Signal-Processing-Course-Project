% 1.时域采样理论验证程序 exp2a.m
Tp=64/1000; %观察时间 Tp=64 微秒，毫秒？
%产生 M 长采样序列 x(n)
Fs=1000;T=1/Fs;%采样频率和采样间隔时间
M=Tp*Fs;n=0:M-1;%采样点数及序列
A=444.128;alph=pi*50*2^0.5;omega=pi*50*2^0.5;
xnt1=A*exp(-alph*n*T).*sin(omega*n*T);
Xk=T*fft(xnt1,M); %M 点 FFT[xnt]
yn='xa(nT)';subplot(3,2,1);
tstem(xnt1,yn); %调用自编绘图函数 tstem 绘制序列图
box on;title('(a) Fs=1000Hz');
k=0:M-1;fk=k/Tp;
subplot(3,2,2);plot(fk,abs(Xk));title('(b) T*FT[xa(nT)],Fs=1000Hz');
xlabel('f(Hz)');ylabel('幅度');axis([0,Fs,0,1.2*max(abs(Xk))])
%=================================================
Tp=64/300; %观察时间 Tp=64 微秒，毫秒？
%产生 M 长采样序列 x(n)
Fs=300;T=1/Fs;%采样频率和采样间隔时间
M=Tp*Fs;n=0:M-1;%采样点数及序列
A=444.128;alph=pi*50*2^0.5;omega=pi*50*2^0.5;
xnt2=A*exp(-alph*n*T).*sin(omega*n*T);
Xk=T*fft(xnt2,M); %M 点 FFT[xnt]
yn='xa(nT)';subplot(3,2,3);
tstem(xnt2,yn); %调用自编绘图函数 tstem 绘制序列图
box on;title('(c) Fs=300Hz');
k=0:M-1;fk=k/Tp;
subplot(3,2,4);plot(fk,abs(Xk));title('(d) T*FT[xa(nT)],Fs=300Hz');
xlabel('f(Hz)');ylabel('幅度');axis([0,Fs,0,1.2*max(abs(Xk))])
%=================================================
Tp=64/200; %观察时间 Tp=64 微秒，毫秒？
%产生 M 长采样序列 x(n)
Fs=200;T=1/Fs;%采样频率和采样间隔时间
M=Tp*Fs;n=0:M-1;%采样点数及序列
A=444.128;alph=pi*50*2^0.5;omega=pi*50*2^0.5;
xnt3=A*exp(-alph*n*T).*sin(omega*n*T);
Xk=T*fft(xnt3,M); %M 点 FFT[xnt]
yn='xa(nT)';subplot(3,2,5);
tstem(xnt3,yn); %调用自编绘图函数 tstem 绘制序列图
box on;title('(e) Fs=200Hz');
k=0:M-1;fk=k/Tp;
subplot(3,2,6);plot(fk,abs(Xk));title('(f) T*FT[xa(nT)],Fs=200Hz');
xlabel('f(Hz)');ylabel('幅度');axis([0,Fs,0,1.2*max(abs(Xk))])
% Fs=300Hz 和 Fs=200Hz 的程序与上面 Fs=1000Hz 完全相同。
