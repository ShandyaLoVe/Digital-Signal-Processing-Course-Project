clc;clear;
[bird1,fs_bird1]=audioread('sound/云雀.wav');
[bird2,fs_bird2]=audioread('sound/斑鸠.wav');
[bird3,fs_bird3]=audioread('sound/喜鹊.wav');
[bird4,fs_bird4]=audioread('sound/大雁.wav');
[bird5,fs_bird5]=audioread('sound/布谷鸟.wav');
[bird6,fs_bird6]=audioread('sound/白头翁.wav');
[bird7,fs_bird7]=audioread('sound/公鸡.wav');
[bird8,fs_bird8]=audioread('sound/海鸥.wav');
[bird9,fs_bird9]=audioread('sound/黄鹂.wav');
[bird10,fs_bird10]=audioread('sound/燕子.wav');
%截取前350000个数据
cbird1=bird1(1:350208);cbird1_fft=fft(cbird1);
cbird2=bird2(1:350208);cbird2_fft=fft(cbird2);
cbird3=bird3(1:350208);cbird3_fft=fft(cbird3);
cbird4=bird4(1:350208);cbird4_fft=fft(cbird4);
cbird5=bird5(1:350208);cbird5_fft=fft(cbird5);
cbird6=bird6(1:350208);cbird6_fft=fft(cbird6);
cbird7=bird7(1:350208);cbird7_fft=fft(cbird7);
cbird8=bird8(1:350208);cbird8_fft=fft(cbird8);
cbird9=bird9(1:350208);cbird9_fft=fft(cbird9);
cbird10=bird10(1:350208);cbird10_fft=fft(cbird10);
len=length(cbird1);t=0:1/fs_bird1:(len-1)/fs_bird1;
fp=0:fs_bird1/len:fs_bird1*(len-1)/len;wpic=2*fp/fs_bird1;%归一化
% subplot(5,2,1);plot(t,cbird1);xlabel('t/s');ylabel('幅度');
% title('云雀声音波形');axis([0,(len-1)/fs_bird1,-Inf,Inf]);
% subplot(5,2,2);plot(wpic,abs(cbird1_fft));xlabel('w/\pi');ylabel('幅度');
% title('云雀声音频谱');
% subplot(5,2,3);plot(t,cbird2);xlabel('t/s');ylabel('幅度');
% title('斑鸠声音波形');axis([0,(len-1)/fs_bird1,-Inf,Inf]);
% subplot(5,2,4);plot(wpic,abs(cbird2_fft));xlabel('w/\pi');ylabel('幅度');
% title('斑鸠声音频谱');
% subplot(5,2,5);plot(t,cbird3);xlabel('t/s');ylabel('幅度');
% title('喜鹊声音波形');axis([0,(len-1)/fs_bird1,-Inf,Inf]);
% subplot(5,2,6);plot(wpic,abs(cbird3_fft));xlabel('w/\pi');ylabel('幅度');
% title('喜鹊声音频谱');
% subplot(5,2,7);plot(t,cbird4);xlabel('t/s');ylabel('幅度');
% title('大雁声音波形');axis([0,(len-1)/fs_bird1,-Inf,Inf]);
% subplot(5,2,8);plot(wpic,abs(cbird4_fft));xlabel('w/\pi');ylabel('幅度');
% title('大雁声音频谱');
% subplot(5,2,9);plot(t,cbird5);xlabel('t/s');ylabel('幅度');
% title('布谷鸟声音波形');axis([0,(len-1)/fs_bird1,-Inf,Inf]);
% subplot(5,2,10);plot(wpic,abs(cbird5_fft));xlabel('w/\pi');ylabel('幅度');
% title('布谷鸟声音频谱');
%用互相关函数求频谱的相似性进行识别
test_voice=cbird8_fft(1:len/2);
r1=xcorr(test_voice,cbird1_fft(1:len/2));M1=max(abs(r1));
r2=xcorr(test_voice,cbird2_fft(1:len/2));M2=max(abs(r2));
r3=xcorr(test_voice,cbird3_fft(1:len/2));M3=max(abs(r3));
r4=xcorr(test_voice,cbird4_fft(1:len/2));M4=max(abs(r4));
r5=xcorr(test_voice,cbird5_fft(1:len/2));M5=max(abs(r5));
r6=xcorr(test_voice,cbird6_fft(1:len/2));M6=max(abs(r6));
r7=xcorr(test_voice,cbird7_fft(1:len/2));M7=max(abs(r7));
r8=xcorr(test_voice,cbird8_fft(1:len/2));M8=max(abs(r8));
r9=xcorr(test_voice,cbird9_fft(1:len/2));M9=max(abs(r9));
r10=xcorr(test_voice,cbird10_fft(1:len/2));M10=max(abs(r10));
Mpp=[M1,M2,M3,M4,M5,M6,M7,M8,M9,M10];[~,Thisone]=max(Mpp);
switch(Thisone)
    case 1
        disp('此声音为云雀叫声');
    case 2
        disp('此声音为斑鸠叫声');
    case 3
        disp('此声音为喜鹊叫声');
    case 4
        disp('此声音为大雁叫声');
    case 5
        disp('此声音为布谷鸟叫声');
end
figure(2);
subplot(5,1,1);plot(1:len-1,abs(r1));xlabel('抽样点');ylabel('相关性');
title('与云雀声音的相关程度');
subplot(5,1,2);plot(1:len-1,abs(r2));xlabel('抽样点');ylabel('相关性');
title('与斑鸠声音的相关程度');
subplot(5,1,3);plot(1:len-1,abs(r3));xlabel('抽样点');ylabel('相关性');
title('与喜鹊声音的相关程度');
subplot(5,1,4);plot(1:len-1,abs(r4));xlabel('抽样点');ylabel('相关性');
title('与大雁声音的相关程度');
subplot(5,1,5);plot(1:len-1,abs(r5));xlabel('抽样点');ylabel('相关性');
title('与布谷鸟声音的相关程度');
%用短时自相关估计基频进行识别
% lag=255;
% wlen=1024;inc=0.5*wlen;             %帧长取21.3ms
% framenum=(len-wlen)/inc+1;          %帧数
% signal=enframe(bird1,wlen,inc)';    %分帧
% %取出一帧数据
% framedata = signal(:,15);
% % plot(frametime,framedata);
% %对数据进行短时自相关计算
% [c2,lags2,bound]=autocorr(framedata,lag);
B1=audioplayer(bird1,fs_bird1);play(B1);pause(3);
B2=audioplayer(bird2,fs_bird1);play(B2);pause(3);
B3=audioplayer(bird3,fs_bird1);play(B3);pause(3);
B4=audioplayer(bird4,fs_bird1);play(B4);pause(3);
B5=audioplayer(bird5,fs_bird1);play(B5);pause(3);
B6=audioplayer(bird1,fs_bird1);play(B6);pause(3);
B7=audioplayer(bird2,fs_bird1);play(B7);pause(3);
B8=audioplayer(bird3,fs_bird1);play(B8);pause(3);
B9=audioplayer(bird4,fs_bird1);play(B9);pause(3);
B10=audioplayer(bird5,fs_bird1);play(B10);pause(3);