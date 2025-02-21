clc;clear;
[org_sound,fs_music]=audioread('../sound/plastic_love2.mp3');
len=length(org_sound);t=0:1/fs_music:(len-1)/fs_music;
fp=0:fs_music/len:fs_music*(len-1)/len;wpic=2*fp/fs_music;%归一化
org_fft=fft(org_sound(:,1));
change_v=voice(org_sound,fs_music,1.3);%最后一个大于1则基频变低，小于1则基频变高
change_v=voice(org_sound,fs_music,1.3);%最后一个大于1则基频变低，小于1则基频变高
cv_fft=fft(change_v);
%画图
figure(1);
subplot(2,2,1);plot(t,org_sound(:,1));xlabel('t/s');ylabel('幅度');
title('原信号时域波形');axis([0,(len-1)/fs_music,-Inf,Inf]);
subplot(2,2,2);plot(wpic,abs(org_fft));xlabel(' w/\pi');ylabel('幅度');
title('原信号频谱图');%axis([0,fs_music*(len-1)/len,-Inf,Inf]);
subplot(2,2,3);plot(t,change_v);xlabel('t/s');ylabel('幅度');
title('变声信号时域波形');axis([0,(len-1)/fs_music,-Inf,Inf]);
subplot(2,2,4);plot(wpic,abs(cv_fft));xlabel('w/\pi');ylabel('幅度');
title('变声信号频谱图');%axis([0,fs_music*(len-1)/len,-Inf,Inf]);
Org=audioplayer(org_sound,fs_music);play(Org);pause(3);
Change=audioplayer(change_v,fs_music);play(Change);pause(3);