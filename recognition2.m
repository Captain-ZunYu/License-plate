function [ output_args ] = recognition2( input_args )
%RECOGNITION2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
global exactchara;   %�ַ�Ԫ��1
global doce;    %��ȥ��ʾ
global L1;

tic
liccode=char(['0':'9' 'A':'Z' '�������ջ���ش������ɼ�³���������ԥ����ɽ����¹��' ]);
%�����Զ�ʶ���ַ������  1~10 ����  11~36  ��ĸ  37~63 
                %l����ڼ����ַ�
V=1;
for I=1:7
    mubanchara{I}=bwdist(exactchara{I});     %��ʶ���ַ�ŷ�Ͼ���
    exactchara{I} = double(exactchara{I});
    if V==2                                  %�ڶ�λ A~Z ��ĸʶ��
        kmin=11;
        kmax=36;
    elseif V==1
        kmin=37;
        kmax=63;
    elseif V >= 3                         %����λ�Ժ�����ĸ������ʶ��
        kmin=1;
        kmax=36;
    end
    for k=kmin:kmax
        fname=strcat('��׼ģ���\',liccode(k),'.jpg');  %ÿ�β��������ַ����ӵ�ַ
        SamBw = imread(fname);
        SamBw = im2bw(SamBw);
        SamBwos=bwdist(SamBw);                    %�ַ�ģ��ŷ�Ͼ���
        osdist(k)= corr2(SamBwos,mubanchara{I});  %��ضȱȽ�
    end
    test=osdist(kmin:kmax);
    [dest,index]=max(abs(test(:)));   
    index=index+kmin-1;
    if index==3 || index==6 || index==9 || index==17 || index==29 || index==36 ||...
            index==26 || index==16  || index==12
        index=correcting(index,I);      %��һ�������ǶԻ������ַ������ٴ���֤  ��Z��2��5��S��Щ
    end
    Code(V*2-1)=liccode(index);
    Code(V*2)=' ';                    %�ճ�Code�����һ���ַ�λ
    V=V+1;
end
doce=Code;
L3=toc;
L1=L1+L3;
end

