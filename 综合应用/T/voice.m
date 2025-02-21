function Y=voice(y1,fs,p)      %更改采样率使基频改变 f>1降低;f<1升高?
%clc;clear;
%[y1,fs]=audioread('../sound/plastic_love2.mp3');%读取音乐信号
y1=y1(:,1);%取一个声道
%f=2;%？？
f=round(p*fs);%f为2000？
%重采样，将信号点数扩大到2倍。
d=resample(y1,f,fs);      %时长整合使语音文件恢复原来时长

W=400;
Wov=W/2;        %overlap? Wov=200
Kmax=W*2;       %Kmax?    Kmax=W=400
Wsim=Wov;       %Wsim     Wsim=200
xdecim=8;       %间隔
kdecim=2;
X=d';           %X为重采样数据
F=p;       %F是重采样频率/1000，就是扩大倍数
Ss=W-Wov;       %Ss为400-200 
xpts=size(X,2); %数据个数
ypts=round(xpts/F);%原数据个数
Y=zeros(1,ypts);%1*ypts的零矩阵
xfwin=(1:Wov)/(Wov+1);%（1-200）/201，归一化？
ovix=(1-Wov):0;%负数到0
newix=1:(W-Wov);%1~（400-200）
simix=(1:xdecim:Wsim)-Wsim;%1:8:200-200=-199:8:0
padX=[zeros(1,Wsim),X,zeros(1,Kmax+W-Wov)];%[200个0，重采样的数据，800+400-200个0]
Y(1:Wsim)=X(1:Wsim);    %取重采样后的前200个数据给Y
lastxpos=0;             %？
km=0;                   %？
    for ypos=Wsim:Ss:(ypts-W)       %ypos取值范围为200:200:原数据长度-400
        xpos=round(F*ypos);         %xpos每一次取值为2*ypos
        kmpred=km+(xpos-lastxpos);  %kmpred=0+现在的xpos-上一次xpos
        lastxpos=xpos;              %上一个xpos
        if(kmpred<=Kmax)            %如果差值小于等于Kmax，即小于等于800
            km=kmpred;              %km，修正量？就赋值为差值
        else                        %如果差值大于Kmax，即大于800
            ysim=Y(ypos+simix);     %ysim=重采样后的前200个数据中
            rxy=zeros(1,Kmax+1);    %创建一个长为Kmax+1的行向量    
            rxx=zeros(1,Kmax+1);    %创建一个长为Kmax+1的行向量  
            Kmin=0;                 %Kmin清0
            for k=Kmin:kdecim:Kmax  %k的取值范围为0:2:Kmax
                xsim=padX(Wsim+xpos+k+simix);%取200+2*200/2*400/...+0/2/4...+[-199:8:0]
                rxx(k+1)=norm(xsim);%xsim的向量模存入rxx(1/3/5/7/...)
                rxy(k+1)=(ysim*xsim');%1×25乘25×1，存入rxy(1/3/5/7/...)
            end
            Rxy=(rxx~=0).*rxy./(rxx+(rxx==0));%Rxy存
            km=min(find(Rxy==max(Rxy))-1);
        end
        xabs=xpos+km;
        Y(ypos+ovix)=((1-xfwin).*Y(ypos+ovix))+(xfwin.*padX(Wsim+xabs+ovix));
        Y(ypos+newix)=padX(Wsim+xabs+newix);
    end
end