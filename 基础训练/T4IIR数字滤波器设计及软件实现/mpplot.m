%(2)mpplot;计算时域离散系统损耗函数和相频特性函数， 并绘制曲线图。
function mpplot(B,A,Rs)
%mpplot(B,A,Rs)
%时域离散系统损耗函数和相频特性绘图
%B 为系统函数分子多项式系数向量
%A 为系统函数分母多项式系数向量
%Rs 为滤波器阻带最小衰减， 省略则幅频曲线最小值取－80dB
if nargin<3 ymin=-80;
else ymin=-Rs-20;
end%确定幅频曲线纵坐标最小值
[H,W]=[H,W]=freqz(B,A,1000);
m=abs(H);
subplot(2,2,1);
plot(W/pi,20*log10(m/max(m)));grid on;
xlabel('\omega/\pi');ylabel('幅度(dB)')
axis([0,1,ymin,5]);title('损耗函数曲线');
subplot(2,2,3);
plot(W/pi,p/pi);
xlabel('\omega/\pi');ylabel('相位/\pi');grid on;
title('(b)相频特性曲线');