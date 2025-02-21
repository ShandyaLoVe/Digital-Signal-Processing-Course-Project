%(1)myplot;计算时域离散系统损耗函数并绘制曲线图。
function myplot(B,A)
%B 为系统函数分子多项式系数向量
%A 为系统函数分母多项式系数向量
[H,W]=freqz(B,A,1000)
m=abs(H);
plot(W/pi,20*log10(m/max(m)));grid on;
xlabel('\omega/\pi');ylabel('幅度(dB)')
axis([0,1,-80,5]);title('损耗函数曲线');