function Y=voice(y1,fs,p)      %���Ĳ�����ʹ��Ƶ�ı� f>1����;f<1����?
%clc;clear;
%[y1,fs]=audioread('../sound/plastic_love2.mp3');%��ȡ�����ź�
y1=y1(:,1);%ȡһ������
%f=2;%����
f=round(p*fs);%fΪ2000��
%�ز��������źŵ�������2����
d=resample(y1,f,fs);      %ʱ������ʹ�����ļ��ָ�ԭ��ʱ��

W=400;
Wov=W/2;        %overlap? Wov=200
Kmax=W*2;       %Kmax?    Kmax=W=400
Wsim=Wov;       %Wsim     Wsim=200
xdecim=8;       %���
kdecim=2;
X=d';           %XΪ�ز�������
F=p;       %F���ز���Ƶ��/1000������������
Ss=W-Wov;       %SsΪ400-200 
xpts=size(X,2); %���ݸ���
ypts=round(xpts/F);%ԭ���ݸ���
Y=zeros(1,ypts);%1*ypts�������
xfwin=(1:Wov)/(Wov+1);%��1-200��/201����һ����
ovix=(1-Wov):0;%������0
newix=1:(W-Wov);%1~��400-200��
simix=(1:xdecim:Wsim)-Wsim;%1:8:200-200=-199:8:0
padX=[zeros(1,Wsim),X,zeros(1,Kmax+W-Wov)];%[200��0���ز��������ݣ�800+400-200��0]
Y(1:Wsim)=X(1:Wsim);    %ȡ�ز������ǰ200�����ݸ�Y
lastxpos=0;             %��
km=0;                   %��
    for ypos=Wsim:Ss:(ypts-W)       %yposȡֵ��ΧΪ200:200:ԭ���ݳ���-400
        xpos=round(F*ypos);         %xposÿһ��ȡֵΪ2*ypos
        kmpred=km+(xpos-lastxpos);  %kmpred=0+���ڵ�xpos-��һ��xpos
        lastxpos=xpos;              %��һ��xpos
        if(kmpred<=Kmax)            %�����ֵС�ڵ���Kmax����С�ڵ���800
            km=kmpred;              %km�����������͸�ֵΪ��ֵ
        else                        %�����ֵ����Kmax��������800
            ysim=Y(ypos+simix);     %ysim=�ز������ǰ200��������
            rxy=zeros(1,Kmax+1);    %����һ����ΪKmax+1��������    
            rxx=zeros(1,Kmax+1);    %����һ����ΪKmax+1��������  
            Kmin=0;                 %Kmin��0
            for k=Kmin:kdecim:Kmax  %k��ȡֵ��ΧΪ0:2:Kmax
                xsim=padX(Wsim+xpos+k+simix);%ȡ200+2*200/2*400/...+0/2/4...+[-199:8:0]
                rxx(k+1)=norm(xsim);%xsim������ģ����rxx(1/3/5/7/...)
                rxy(k+1)=(ysim*xsim');%1��25��25��1������rxy(1/3/5/7/...)
            end
            Rxy=(rxx~=0).*rxy./(rxx+(rxx==0));%Rxy��
            km=min(find(Rxy==max(Rxy))-1);
        end
        xabs=xpos+km;
        Y(ypos+ovix)=((1-xfwin).*Y(ypos+ovix))+(xfwin.*padX(Wsim+xabs+ovix));
        Y(ypos+newix)=padX(Wsim+xabs+newix);
    end
end