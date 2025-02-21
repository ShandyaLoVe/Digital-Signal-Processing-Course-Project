function tstem(xn,yn)
%时域序列绘图函数
%xn:被绘图的信号数据序列， yn:绘图信号的纵坐标名称（字符串）
n=0:length(xn)-1;
stem(n,xn,'.');
xlabel('n');ylabel(yn);
axis([0,n(end),min(xn),1.2*max(xn)]);