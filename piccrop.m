function [] = piccrop()
%PICCROP �����ַ�����
%   �˴���ʾ��ϸ˵��
global Yexactbw;    %�к���Χ��ֵͼ
global exactchara;  %��ȥ  ʶ��
global L1;          %ʱ���¼
global bpzifu;

tic
[y,x]=size(Yexactbw);
% Yexactbw=double(Yexactbw);
Is1=sum(Yexactbw,1);          % ��ֱͶӰ(������)
Flag=0;
num=1;                         %�ڼ���slice�ַ����ο�
%****************��¼ÿһ�����ο��������Ϣ**********************
for i=1:x
    if Is1(i)>=2 &&  Flag==0
        Flag=1;
        begin=i;
    end
    if (Is1(i)<2 &&  Flag==1) || (i==x && Flag==1)
        Flag=0;
        slice.tag(1,num)='N';                                      %���                       
        slice.length(1,num)=i-begin;                               %�ַ�����
        slice.asprat(1,num)=y/slice.length(1,num);                 %�ַ��߿����
        slice.chara{num}=imcrop(Yexactbw,[begin 1 (i-begin) y]);   %����ͼ
        slice.ratio(1,num)= sum(sum(slice.chara{num})) / ( y*slice.length(num)) ;%��ɫ��ռ��
        num=num+1;      
    end
end

j=1;
for i=1:num-1
    if slice.asprat(1,i)<=2.8 && slice.asprat(1,i)>=1.5   %��߱ȷ����������ֵĸ���� ����һ
       slice.tag(1,i)='Y';   
    end
    if slice.ratio(1,i)  < 0.2 || slice.ratio(1,i)>0.7   %��������һ �� �����а׵����������Ҫ��ĸ��ȥ
       slice.tag(1,i)='N'; 
    end   
    if slice.asprat(1,i)>4 && slice.asprat(1,i)<=13 && slice.ratio(1,i)>0.4  %  ������ '��' ����  ������1����ƫ�Ի��߱߿�
       idx(j)=i; %��¼һ���ǵڼ���
       j=j+1;
       slice.tag(1,i)='Y';  %�ȸ����
    end
    if slice.asprat(1,i)<6 && slice.asprat(1,i)>2.8 && i<6 && i>1    % �����Ǻ����ұ߲��� 
        combine=y/(slice.length(1,i)+slice.length(1,i-1)); %���һ�¿��Ƿ����
        if combine<=2.6 && combine>=1.5  %������Ϻ����ұ߲��� 
            slice.chara{i}=[slice.chara{i-1}, slice.chara{i}];
            slice.tag(1,i-1)='N';
            slice.tag(1,i)='Y';
            slice.asprat(1,i)=2.5;
        end
    end
end

%**************************��������  '��' ����************

if j>1    %������һ�� '��' ����
    if j>=4 && idx(3)-idx(1)==2 && slice.asprat(1,idx(3)+1)<2.5   % ������ǡ�����
        slice.chara{idx(3)}=[slice.chara{idx(1)}, slice.chara{idx(2)}, slice.chara{idx(3)}];
        slice.tag(1,idx(1))='N';slice.tag(1,idx(2))='N';
    elseif j>=5 && idx(4)-idx(2)==2  % ������Ǳ߿�ʹ���ϣ��� [�� ��
        slice.chara{idx(4)}=[slice.chara{idx(2)}, slice.chara{idx(3)}, slice.chara{idx(4)}];
        slice.tag(1,idx(1))='N';slice.tag(1,idx(2))='N';slice.tag(1,idx(3))='N';
    elseif idx(1)<3  && slice.asprat(1,idx(1))~=2.5   %  '��' ��һ���������� ���ǵ�һ�� '��' ��λ��������
        slice.tag(1,idx(1))='N';             %   �߿�ȥ��
    end
end

k=find(slice.tag=='Y');   %�ҵ������ַ����Ϊ��Y�����ַ���
% figure(3);
Yzero=zeros(y,2);
Xzero=zeros(2,32);
global shibie;
%���ַ��и���������洢������
if length(k)>=7
    for j=1:7     
        exactchara{j}=imresize(slice.chara{k(j)},[40 20]);   %��һ��
        bpzifu{j}= [Yzero,slice.chara{k(j)},Yzero];
        bpzifu{j}=imresize(bpzifu{j},[36 32]);               %��һ��
        bpzifu{j}= [Xzero;bpzifu{j};Xzero];
        if shibie==1
            figure(3);
            subplot(2,7,j);
            imshow(exactchara{j});
            subplot(2,7,j+7);
            imshow(bpzifu{j})
        end
        bpzifu{j}=uint8(bpzifu{j});
        exactchara{j}=uint8(exactchara{j});
    end
else
    if shibie==1
        figure(3);
        title('ʧ��');
    end
end
L2=toc;
L1=L1+L2;
end

