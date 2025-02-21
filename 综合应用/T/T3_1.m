clear;clc;
[y,fs_music]=audioread('../sound/plastic_love2.mp3');
[x,fs_tian]=audioread('../sound/小田正和.mp3');
%x为样本数据第一列为左声道，第二列为右声道，fs为采样率
len=length(y);
T=len./fs_music;dt=1/fs_music;
y1=y(:,1);y2=y(:,2);
t=0:dt:(len-1)/fs_music;subplot(2,1,1);
plot(t,y1);xlabel('时间/s');ylabel('幅度');
title('左声道音频信号时域波形');subplot(2,1,2);
plot(t,y2);xlabel('时间/s');ylabel('幅度');
title('右声道音频信号时域波形');
%语音信号声音大小调节
y_big=10.*y;
y_small=y./10;
%对语音信号进行混音——原理是两个语音数据融合
if length(x)<length(y)%x长度小于y时
    co_sound = y;
    for i = 1:1:length(x)
        co_sound(i,1) = co_sound(i,1)+x(i,1);
        co_sound(i,2) = co_sound(i,2)+x(i,2);
    end
else%x长度大于y时
    co_sound = x;
    for i = 1:1:length(y)
        co_sound(i:1) = co_sound(i:1)+y(i:1);
        co_sound(i:2) = co_sound(i:2)+y(i:2);
    end
end
plot(t,y2);xlabel('时间/s');ylabel('幅度');
title('右声道音频信号时域波形');
%对语音信号进行回音——原理是同一个语音数据延时再插入
cut_sound = x;
zeroo = zeros(20000,2);
temp1 = [cut_sound;zeroo;zeroo];
temp2 = [zeroo;cut_sound*0.1;zeroo];
temp3 = [zeroo;zeroo;cut_sound*0.01];
delay_sound = temp1+temp2+temp3;
org=audioplayer(y,fs_music);play(org);pause(3);%原语音
bigg=audioplayer(y_big,fs_music);play(bigg);pause(3);%增大音量
smalll=audioplayer(y_small,fs_music);play(smalll);pause(3);%减小音量
com=audioplayer(co_sound,fs_music);play(com);pause(3);%混音
dels=audioplayer(delay_sound,fs_tian);play(dels);pause(3);%回音

