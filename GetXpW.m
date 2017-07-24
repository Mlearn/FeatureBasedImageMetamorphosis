function [ Xs, W] = GetXpW( Pd, Qd, Xd, Ps, Qs )
%GETXP ��������ͼ�е��߶�λ�ñ仯������ӳ�������Ŀ��ͼ���и����Ӧ��Դͼ��λ��
% Based on
% Beier, T., & Neely, S. (1992). Feature-based image metamorphosis.
% ACM SIGGRAPH Computer Graphics, 26, 35�C42. http://doi.org/10.1145/142920.134003
%
% �����ʽ1x2 (x,y)
% Pd Ŀ��ͼ���߶��������
% Qd Ŀ��ͼ���߶��յ�����
% Xd Ŀ��ͼ�������ص���������
% Ps Դͼ���߶��������
% Qs Դͼ���߶��յ�����
% W  �����ص��Ӧ��Ȩֵ
%
%  Function is written by Mou An (July 21, 2017)

Xs = zeros(size(Xd));
W = zeros(size(Xd,1),1);

for i = 1:size(Xd,1)
    x = Xd(i,:);
    PX = x-Pd;
    PQ = Qd-Pd;
    PQ2 = PQ*PQ';
    u = PX*PQ'/PQ2;
    PerpendicularQP = PQ*[0,-1;1,0];
    v = PX*PerpendicularQP'./PQ2;
    
    PQp = Qs-Ps;
    PerpendicularQPp = PQp*[0,-1;1,0];
    xp = Ps+u*PQp+v*PerpendicularQPp;
    
    Xs(i,:) = xp;
    
    v = abs(v).*sqrt(PQ2);
    w = (1/(1+v)).^2;
    W(i) = w;
end

end

