function [ newindex ] = correcting(index,I)   %�����ַ���֤����
%CORRECTING �˴���ʾ�йش˺�����ժҪ   �������ƶ�ʽ��ֱ��ˮƽɨ���߷�
global exactchara;   %�ַ�Ԫ��1
jiaoyan=cell2mat(exactchara(I));     %Ԫ���������ת��

if index==17 || index==9 || index==12 %  G-8-B
    corrflag=10;
    for i=7:25
        black=0;
        for j=20:-1:1
            if jiaoyan(i,j)==0
                black=black+1;
            end
            if  jiaoyan(i,j)~=0
                if black<10
                    corrflag=0;  %8 ����B
                else
                    corrflag=1;                  
                end
                break;
            end
        end
        if corrflag==1
            break;
        end
    end
    if corrflag==1
        newindex=17;
    end    
    if corrflag==0
        for i=5:25
            black=0;
            for j=1:10
                if jiaoyan(i,j)==0
                    black=black+1;
                end
                if  jiaoyan(i,j)~=0
                    if black<2
                        corrflag=2;  % B
                    else
                        corrflag=3;    %  8
                    end
                    break;
                end
            end
            if corrflag==3
                break;
            end           
        end
        if corrflag==3
            newindex=9;
        else 
            newindex=12;
        end
    end
end

if index==36 || index==3   %  Z-2
   corrflag=5;
    for i=1:40
        if jiaoyan(i,10)~=0 && corrflag~=1
            corrflag=1;  %��ʼ
        end
        if jiaoyan(i,10)==0 && corrflag==1  %����
            k=0;
            for j=1:10
                if jiaoyan(i+1,j)>0
                    k=k+1;
                end
            end
            if k>=3
                newindex=3;     % 2
            else
                newindex=36;     % Z
            end
            break;
        end
    end
end

if index==6 || index==29    %  5-S
    corrflag=5;
    for i=1:40
        if jiaoyan(i,10)~=0 && corrflag~=1
            corrflag=1;    %��ʼ
        end
        if jiaoyan(i,10)==0 && corrflag==1  %����
            k=0;
            for j=20:-1:10
                if jiaoyan(i+2,j)>0
                    k=k+1;
                end
            end
            if k>=3
                newindex=29;     % S
            else
                newindex=6;     % 5
            end
            break;
        end
    end
end

if index==26 || index==16   %  P-F
    corrflag=10;
    for i=5:13
        black=0;
        for j=20:-1:1
            if jiaoyan(i,j)==0
                black=black+1;
            end
            if  jiaoyan(i,j)~=0
                if black<5
                    corrflag=0;  %  P
                else
                    corrflag=1;  %  F           
                end
                break;
            end
        end
        if corrflag==1
            break;
        end
    end
    if corrflag==1
        newindex=16;
    else  
        newindex=26;
    end
end

end

