function len = converion1( I )
%CONVERION1 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%��ͼƬת���������� 

len=zeros(1,1280);
for i=1:40
    for j=1:32
        len(1,32*(i-1)+j)=I(i,j);
    end
end
len=len';
end

