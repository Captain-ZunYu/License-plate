function [ output_args ] = Dingwei( input_args )
%DINGWEI �˴���ʾ�йش˺�����ժҪ  ��λ����
%   �˴���ʾ��ϸ˵��
global I;            %��Ƭԭͼ
global exactarea;    %���ƾ�ȷ��λ��ɫRGBͼ:��GUI������ʾ
global Yexactbw;     %��ȥ�ַ��и�(�к����ֵͼ)
global L1;           %ʱ��
tic
Igray=rgb2gray(I);                                            %�ҶȻ�
%*************�Ҷ�ͼ����************************************
%ͼ��ƽ��
Igray=double(Igray);
ma=double(max(max(Igray)));
mi=double(min(min(Igray)));
Igray=(255/(ma-mi))*Igray-(255*mi)/(ma-mi);
Igray=uint8(Igray);
%****************ͻ��Ŀ�����***********
SE=strel('disk',15);            %�뾶Ϊr=20��Բ��ģ��
IS=imopen(Igray,SE);            %������    
%��ԭʼͼ���뱳��ͼ������������ǿͼ��
Igray=imsubtract(Igray,IS);     %�޸��ŻҶ�ͼ
%*******************************************************

%************��ֵ��************************************
%�Ҷ�ֵ������TH����ֵ������TL
%***********��ֵ������TL*****
TH=100;TL=30;      %�趨������30��������100  ��һ��65  �����ֵС��65����ʶ��
XC=1;              %ѭ������Ԥ��
uefc=2;            %�ܷ��ҵ����Ƶı�־
while XC<=4
    if uefc==0     %���ҵ�����
        TH = V;    %����
    elseif uefc==1
        TL = V;    %����
    end
    V = round((TH+TL)/2);                  %  ȡ��ֵ
    test = imbinarize(Igray,V/255);        %�ö���ֵV���ж�ֵ���õ������õĶ�ֵͼ
    testedge = bwperim(test);              %��Ե����
    %*******����һ���Ƿ�����ҵ����ƣ� 
    testedge=double(testedge);
    [y,x,~] = size(testedge);
    temp11 = 10;                            %ˮƽ��ֵ
    temp12 = 80;
    cary = y;                              %����������һ��
    num = 0;                               %��ֱ�������������ʼֵ
    Im1=sum(testedge,2);                       %���ڼ�¼��ɨ��ʱ�׵�ĸ��� 
    
    uefc=0;
    while  num <= 5  || num>=15
        %*******ˮƽͶӰ���ֵ��������������ӵ��п�ʼ
        while  ( Im1(cary,1)<temp11 || Im1(cary,1)>temp12 )
            cary=cary-1;
            if cary < round(y/3)
                break;
            end
        end
        if cary < round(y/3)
            uefc=1;
            break;
        end
        flag1=cary;                 %����½�          
        while   Im1(cary,1)>=temp11 && Im1(cary,1)<=temp12
            cary=cary-1; 
            if cary < round(y/3)
                break;
            end
        end
        flag2=cary;                %����Ͻ�  
        if (flag1-flag2)<=10        %С��10����������
            continue;
        end
        %******* ��ʱ�õ��д���֤��  ��������
        %��֤һ�£�����ֱͶӰ
            book=testedge(flag2:flag1,1:x);     % ��ȡ������ ����ͼ book                   
            Im2=sum(book,1);                    %ɨ������õ�����֤ͼ�Ĵ�ֱ������Im2  
            [booky,~]=size(book);              
            temp2=3;         %ȷ���Ƿ��зָ��϶����ֵ  
            flag3=0;         %�趨��־λ
            num=0;           %�����������
            for i=1:x
                if flag3==0 && Im2(1,i)>temp2
                    flag3=1;
                    begin=i;
                end
                if flag3==1 && Im2(1,i)<=temp2
                    if (i-begin<3) || ( (i-begin)> booky*4/5 )
                        flag3=0;
                    else
                        flag3=0;
                        num=num+1;
                    end
                end
            end
            %������
            if  num <= 5 || num>=15
                if booky>80
                    cary=flag1-10;
                else
                    cary=flag2-1;
                end
            end
    end
    XC=XC+1;
end
TLL=V;              %����Ϊ����
%*******************************************************
%***********Ѱ�Ҷ�ֵ������TH***************************
TH=170;TL=TLL;      %�趨������TLL��������TH
XC=1;              %ѭ������
uefc=2;            %�ܷ��ҵ����Ƶı�־
while XC<=4
    if uefc==0     %���ҵ�����
        TL = V;    %����
    elseif uefc==1
        TH = V;    %����
    end
    V = round((TH+TL)/2);                  %  ȡ��ֵ
    test = imbinarize(Igray,V/255);        %�ö���ֵV���ж�ֵ���õ������õĶ�ֵͼ
    testedge = bwperim(test);
    %*******����һ���Ƿ�����ҵ����ƣ�
    testedge=double(testedge);
    [y,x,~] = size(testedge);
    temp11 = 10;                            %ˮƽ��ֵ
    temp12 = 80;
    cary = y;                              %����������һ��
    num = 0;                               %��ֱ�������������ʼֵ
    Im1=sum(testedge,2);                   %���ڼ�¼��ɨ��ʱ�׵�ĸ���   
    uefc=0;
    
    while  num <= 5 || num>=15
        %*******ˮƽͶӰ���ֵ��������������ӵ��п�ʼ
        while  ( Im1(cary,1)<temp11 || Im1(cary,1)>temp12 )
            cary=cary-1;
            if cary < round(y/3)
                break;
            end
        end
        if cary < round(y/3)
            uefc=1;
            break;
        end
        flag1=cary;                 %�������          
        while   Im1(cary,1)>=temp11 && Im1(cary,1)<=temp12
            cary=cary-1; 
            if cary < round(y/3)
                break;
            end
        end
        flag2=cary;                %�������      
        if (flag1-flag2)<10        %С��10����������
            continue;
        end
        %******* ��ʱ�õ��д���֤��  ��������
        %��֤һ�£�����ֱͶӰ
            book=testedge(flag2:flag1,1:x);     % ��ȡ������ ����ͼ book                   
            Im2=sum(book,1);                    %ɨ������õ�����֤ͼ�Ĵ�ֱ������Im2  
            [booky,~]=size(book);              
            temp2=3;         %ȷ���Ƿ��зָ��϶����ֵ  
            flag3=0;         %�趨��־λ
            num=0;           %�����������
            for i=1:x
                if flag3==0 && Im2(1,i)>temp2
                    flag3=1;
                    begin=i;
                end
                if flag3==1 && Im2(1,i)<=temp2
                    if (i-begin<3) || ( (i-begin)> booky*4/5 )
                        flag3=0;
                    else
                        flag3=0;
                        num=num+1;
                    end
                end
            end
            %������
            if  num <= 5 || num>=15
                if booky>80
                    cary=flag1-10;
                else
                    cary=flag2-1;
                end
            end
    end
    XC=XC+1;
end
TH=V;                  %����Ϊ����
zz=((TH+TLL)/2)*1.1;
%*******************************************************
Thresh=zz/255;                %ȷ�����ͼƬ�������ֵ              
Ibinary=imbinarize(Igray,Thresh);       %ִ�����Ķ�ֵ��

Iedge = bwperim(Ibinary);             %��Ե��
I1=imclearborder(Iedge,8);            % 8 ��ͨI1
%*********************************************
%***************��һ�δֶ�λ*****************
st1=ones(2,14);
st3=ones(2,7); 
I2=imclose(I1,st1);                  %��
Iarea=imopen(I2,st3);                %��
Iarea=bwareaopen(Iarea,600);         %С����ɾ��

[Iareay,Iareax]=size(Iarea);
[U,areanum] = bwlabel(Iarea,8);      %������
Feastats=regionprops(U,'all');       %����������ȡ
Area=[Feastats.Area];                %������������
rects = cat(1,Feastats.BoundingBox);   
rects=int16(rects);
rougharea=[];                        %�ֶ�λ��ɫͼ
while  any(Area)~= 0
    [~,index]=max(Area);
    cornerx=rects(index,1);   %���Ͻ�����
    cornery=rects(index,2);
    width=rects(index,3);     %��
    width=double(width);
    height=rects(index,4);    %��
    height=double(height);
    proportion=width/height;
    %**********һ�������Ϳ��������֤*******
    if proportion<3.5  || proportion>6.5
        Area(index)=0;
        continue;
    end
    if ( width/Iareax >0.45 || width/Iareax <0.15 )
        Area(index)=0;
        continue;
    end
    %******************************
    testbw=imcrop(Ibinary,[cornerx cornery width height]);   %����ֵͼ������г�������
    testbw=double(testbw);
    [testbwy,testbwx]=size(testbw);
    Im3=sum(testbw,1);
    %*********����binaryͼ�׵����������֤******
    T=( sum(Im3)/(width*height) );
    if  T>0.7  ||  T<0.2
        Area(index)=0;
        continue;
    end
    %*******��������������������֤*******
    TH=(testbwy/4.5);
    flag3=0;                          %�趨��־λ
    num=0;                            %�����������
    for i=1:testbwx
        if flag3==0 && Im3(1,i)>=TH
            flag3=1;
            begin=i;
        end
        if flag3==1 && Im3(1,i)<TH
            if (i-begin)>(testbwy*2/3) || (i-begin)<3
                flag3=0;
            else
                flag3=0;
                num=num+1;
            end
        end
    end
    if num >=7 && num <=13
        rougharea=imcrop(I,[cornerx cornery width height]);     %���ֲ�ͼ���г���
        roughbw=imcrop(Ibinary,[cornerx cornery width height]); %���ֶ�ֵͼ���г���
        roughedge=imcrop(Iedge,[cornerx cornery width height]); %���ֶ�ֵͼ���г���
        break;
    else
        Area(index)=0;
    end
end
effect=isempty(rougharea);
if effect == 0   %����ҵ�

    findout=1;
else             %û�ҵ�
    findout=0;
end

%********************�ڶ��δֶ�λ************************
if findout==0
    st1=ones(2,28);           %���һ�δֶ�λ��ͬ�ĽṹԪ��
    st2=ones(2,10);
    I2=imclose(I1,st1);                  %��
    Iarea=imopen(I2,st2);
%     Iarea=imopen(Iarea,ones(10,1));
    Iarea=bwareaopen(Iarea,1300);        %С����ɾ��

    %**********************��������ֶ�λ**********************
    [U,areanum] = bwlabel(Iarea,8);      %������
    Feastats=regionprops(U,'all');       %����������ȡ
    Area=[Feastats.Area];                %������������
    rects = cat(1,Feastats.BoundingBox);
    rects=int16(rects);
    rougharea=[];                        %�ֶ�λ��ɫͼ
    while  any(Area)~= 0
        [~,index]=max(Area);
        cornerx=rects(index,1);   %���Ͻ�����
        cornery=rects(index,2);
        width=rects(index,3);     %��
        width=double(width);
        height=rects(index,4);    %��
        height=double(height);
        proportion=width/height;
        %**********һ������������֤*******
        if proportion<2.5  || proportion>5.5
            Area(index)=0;
            continue;
        end
        if ( width/Iareax >0.6 || width/Iareax <0.15 )
            Area(index)=0;
            continue;
        end
        %******************************
        testbw=imcrop(Ibinary,[cornerx cornery width height]);   %����ֵͼ������г�������
        testbw=double(testbw);
        [testbwy,testbwx]=size(testbw);
        Im3=sum(testbw,1);
        %*********����binaryͼ�׵����������֤******
        T=( sum(Im3)/(width*height) );
        if  T>0.5  ||  T<0.1
            Area(index)=0;
            continue;
        end
        %*******��������������������֤*******
        TH=(testbwy/4.5);
        flag3=0;                          %�趨��־λ
        num=0;                            %�����������
        for i=1:testbwx
            if flag3==0 && Im3(1,i)>=TH
                flag3=1;
                begin=i;
            end
            if flag3==1 && Im3(1,i)<TH
                if (i-begin)>(testbwy*2/3) || (i-begin)<3
                    flag3=0;
                else
                    flag3=0;
                    num=num+1;
                end
            end
        end
        if num >=6 && num <=12
            rougharea=imcrop(I,[cornerx cornery width height]);     %���ֲ�ͼ���г���
            roughbw=imcrop(Ibinary,[cornerx cornery width height]); %���ֶ�ֵͼ���г���
            roughedge=imcrop(Iedge,[cornerx cornery width height]); %����Եͼ���г���
            break;
        else
            Area(index)=0;
        end
    end
    effect=isempty(rougharea);
end

%************��бУ��************
if effect == 0    
    theta = 0:1:179;
    [r, xp] = radon(roughedge,theta);
    len = sum(r > 0);
    [l, index] = min(len);
    theta = theta(index);
    rougharea = imrotate(rougharea,90-theta, 'crop');
    roughbw = imrotate(roughbw,90-theta, 'crop');
end
%*******����ȥ���߿��í������ȷ��λ**************
if effect == 0
    find=1;
    [roughbwy,roughbwx,~]=size(roughbw);  %���С
    flag4=0;                              %�趨��־λ
    exactnum=zeros(roughbwy,1);      
    for i=roughbwy:-1:1
        for j=1:roughbwx
            if flag4==0  && roughbw(i,j)==1
                flag4=1;
            end
            if flag4==1 && roughbw(i,j)==0
                flag4=0;
                exactnum(i,1)=exactnum(i,1)+1;
            end
        end
    end
    TH1=6;                     %���������ֵ6-18��
    TH2=18;
    nowcary=1;
    while 1             %�к���ΧѰ�� 
    %****************��������ɨ��
        while  exactnum(nowcary,1)<TH1  ||  exactnum(nowcary,1)>TH2
            nowcary=nowcary+1;
            if nowcary == roughbwy
                break;
            end
        end
        if nowcary == roughbwy
            find=0;
            break;
        end
        flag1=nowcary;                       
        %����Ͻ�
        while   exactnum(nowcary,1)>=TH1  && exactnum(nowcary,1)<=TH2
            nowcary=nowcary+1;
            if nowcary == roughbwy 
                break;
            end
        end
        flag2=nowcary;                      
        %����½�
        if flag2-flag1 < round(roughbwy/3)
            continue;
        else         
            Yexactbw=roughbw(flag1:flag2,1:roughbwx);
            exactarea=rougharea(flag1:flag2,1:roughbwx,:);        
            break;
        end
    end
end
L1=toc;
%**************����Ϊִ�е�������Ĺ۲��Ĳ���*************
global shibie;
if shibie==0
    figure(2);
    subplot(2,3,1);
    imshow(Ibinary);title('��ֵͼ');
    subplot(2,3,2);
    imshow(Iarea);title('��״ͼ');
    if effect == 0         %�ֶ�λ�ҵ���
        figure(2);
        subplot(2,3,3);
        imshow(rougharea);title('�ֶ�λ��ͼ');
        if find==0     %�ҵ��Ĳ��ǳ���
            figure(2);
            subplot(2,3,3);
            cla;
            title('ʧ��');
            subplot(2,3,4);
            cla;
            subplot(2,3,5);
            cla;
            rougharea=[];
        else
            subplot(2,3,4);
            imshow(Yexactbw);title('ȥ���±߿�');
            subplot(2,3,5);
            imshow(rougharea);
            title('У���� ');
        end
    else                 %û�ҵ�
        figure(2);
        subplot(2,3,3);
        cla;
        title('ʧ��');
        subplot(2,3,4);
        cla;
        subplot(2,3,5);
        cla;
    end
end
end

