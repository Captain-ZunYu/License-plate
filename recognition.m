function [ ] = recognition( )
%RECOGNITION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
global exactchara;   %�ַ�Ԫ��1
global bpzifu;       %�ַ�Ԫ��2
global doce;    %��ȥ��ʾ
global L1;

tic
load bpnet2.mat;
input=converion1(bpzifu{1});
Y=sim(net2,input);
Y=compet(Y);
d=find(Y==1);
switch d
    case 6
        str='��';
    case 1
        str='��';
    case 2
        str='��';
    case 3
        str='��';
    case 4
        str='��';
    case 5
        str='��';
    case 7
        str='��';
    case 8
        str='��';
    case 9
        str='��';
    case 10
        str='��';
    case 11
        str='��';
    case 12
        str='��';
    case 13
        str='³';
    case 14
        str='��';
    case 15
        str='��';
    case 16
        str='��';
    case 17
        str='��';
    case 18
        str='��';
    case 19
        str='ԥ';
    case 20
        str='��';
    case 21
        str='��';
    case 22
        str='��';
    case 23
        str='��';
    case 24
        str='��';
    case 25
        str='��';
    case 26
        str='��';
    case 27
        str='��';
    otherwise
end

liccode=char(['0':'9' 'A':'Z' ]);
%�����Զ�ʶ���ַ������  1~10 ����  11~36  ��ĸ 
                %l����ڼ����ַ�
V=1;
for I=1:7
    mubanchara{I}=bwdist(exactchara{I});     %����ģ����Ԫ�������Ԫ�ص���̾���
    exactchara{I} = double(exactchara{I});
    if V==2                                  %�ڶ�λ A~Z ��ĸʶ��
        kmin=11;
        kmax=36;
    elseif V==1
        Code(V*2-1)=str;
        Code(V*2)=' '; 
        V=V+1;
        continue;
    elseif V >= 3                         %����λ�Ժ�����ĸ������ʶ��
        kmin=1;
        kmax=36;
    end
    for k=kmin:kmax
        fname=strcat('��׼ģ���\',liccode(k),'.jpg');% ÿ�β����ַ����ӵ�ַ
        SamBw = imread(fname);
        SamBw = im2bw(SamBw);   %��ģ���ֵ��
        SamBwos=bwdist(SamBw);  %����ģ����Ԫ�������Ԫ�ص���̾���
        osdist(k)= corr2(SamBwos,mubanchara{I});  %��ضȱȽ�
    end
    test=osdist(kmin:kmax);    
    [dest,index]=max(abs(test(:)));  %�ҵ�����ֵ�������ַ��ŵ��±�
    index=index+kmin-1;              %����ǰ��ı��
    if index==3 || index==6 || index==9 || index==17 || index==29 || index==36 ||...
            index==26 || index==16  || index==12
        index=correcting(index,I);
    end
    Code(V*2-1)=liccode(index);
    Code(V*2)=' ';                    %�ճ�Code�����һ���ַ�λ
    V=V+1;
end
doce=Code;
L3=toc;
L1=L1+L3;
end


