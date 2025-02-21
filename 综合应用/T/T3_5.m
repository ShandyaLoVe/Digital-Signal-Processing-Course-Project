clc;clear;
[org_sound,fs_music]=audioread('../sound/plastic_love2.mp3');
fc_H=4400000;wc_H=pi*2*fc_H;
len=length(org_sound);t=0:1/fs_music:(len-1)/fs_music;
fp=0:fs_music/len:fs_music*(len-1)/len;wpic=2*fp/fs_music;%归一化
%载波频率最高取4.4MHz
carry_H=cos(wc_H*t);rf_H=(org_sound(:,1)).*carry_H';rfft_H=fft(rf_H);
rec_H=rf_H.*carry_H';recfft_H=fft(rec_H);
    %解调信号时域波形及频谱
subplot(2,1,1);plot(t,rec_H);xlabel('t/s');ylabel('幅度');
title('解调信号时域波形');
subplot(2,1,2);plot(wpic,abs(recfft_H));xlabel('w/\pi');ylabel('幅度');
title('解调信号频谱');
%设计巴特沃斯低通滤波器
wp=6000/(fs_music/2);%通带截止频率，取0-10kHz中间的值，并对其归一化
ws=9000/(fs_music/2);%阻带截止频率，取0-10kHz中间的值，并对其归一化
alpha_p=0.1;%通带允许最大衰减为  db
alpha_s=50;%阻带允许最小衰减为  db
[N1,wc1]=buttord(wp,ws,alpha_p,alpha_s);%获取阶数和截止频率
[b,a]=butter(N1,wc1,'low');%获得转移函数系数
[Hw,w]=freqz(b,a);figure(2);%求频响
subplot(3,1,1);plot(w/pi,abs(Hw));xlabel('w/\pi');ylabel('幅度');
title('低通巴特沃斯频率响应曲线');
    %滤波及绘制经过滤波后的信号波形及频谱
r_rec=filter(b,a,rec_H);r_recfft=fft(r_rec);
subplot(3,1,2);plot(t,r_rec);xlabel('t/s');ylabel('幅度');
title('经巴特沃斯输出信号时域波形');
subplot(3,1,3);plot(wpic,abs(r_recfft));xlabel('w/\pi');ylabel('幅度');
title('经巴特沃斯输出信号频谱');
%窗函数设计FIR滤波器,指标在巴特沃斯部分
    %矩形窗
wc=wp+ws;
B=2*pi*(ws-wp); %过渡带宽度指标
Nb=ceil(11*pi/B); %blackman 窗的长度 N
hn=fir1(Nb-1,wc,rectwin(Nb));
Hw=abs(fft(hn,1024)); %求设计的滤波器频率特性
db_Hw=20*log(Hw)/log(10);
r_rec21=fftfilt(hn,rec_H,len); %调用函数 fftfilt 对 xt 滤波
figure(3);subplot(3,1,1);plot(2*(0:(length(db_Hw)-1))/length(db_Hw),db_Hw);
xlabel('w/\pi');ylabel('幅度/dB');title('低通矩形窗FIR频率响应曲线');
subplot(3,1,2);plot(t,r_rec21);xlabel('t/s');ylabel('幅度');
title('经矩形窗FIR输出时域波形');r_recfft21=fft(r_rec21);
subplot(3,1,3);plot(wpic,abs(r_recfft21));xlabel('w/\pi');ylabel('幅度');
title('经矩形窗FIR输出信号频谱');
    %blackman窗户
hn=fir1(Nb-1,wc,blackman(Nb));
Hw=abs(fft(hn,1024)); %求设计的滤波器频率特性
db_Hw=20*log(Hw)/log(10);
r_rec22=fftfilt(hn,rec_H,len); %调用函数 fftfilt 对 xt 滤波
figure(4);subplot(3,1,1);plot(2*(0:(length(db_Hw)-1))/length(db_Hw),db_Hw);
xlabel('w/\pi');ylabel('幅度/dB');title('低通布莱克曼窗FIR频率响应曲线');
subplot(3,1,2);plot(t,r_rec22);xlabel('t/s');ylabel('幅度');
title('经布莱克曼窗FIR输出时域波形');r_recfft22=fft(r_rec22);
subplot(3,1,3);plot(wpic,abs(r_recfft22));xlabel('w/\pi');ylabel('幅度');
title('经布莱克曼窗FIR输出信号频谱');
%播放解调音乐
btws=audioplayer(r_rec,fs_music);play(btws);pause(3);
rct=audioplayer(r_rec21,fs_music);play(rct);pause(3);
black=audioplayer(r_rec22,fs_music);play(black);pause(3);