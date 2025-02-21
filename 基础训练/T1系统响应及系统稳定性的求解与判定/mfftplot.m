function mfftplot(xn,N)
%mfftplot(xn,N)计算序列向量 xn 的 N 点 fft 并绘制其幅频特性曲线
Xk=fft(xn,N);%计算信号 xn 的频谱的 N 点采样
%===以下为绘图部分====
k=0:N-1;wk=2*k/N;
m=abs(Xk);mm=max(m);
plot(wk,m/mm);grid on;
xlabel('\omega/\pi');ylabel('幅度(dB)');
axis([0,2,0,1.2]);
title('幅度特性曲线');