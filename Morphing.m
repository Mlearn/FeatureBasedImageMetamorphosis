function [ morphI ] = Morphing( StaticI, StaticLines, MoveI, MoveLines )
%MORPHING ����ͼ���еı궨�߶ν���ͼ��ı���
%   
% StaticI Ŀ��ͼ��
% StaticLines �߶�����
% MoveI ������ͼ��
% MoveLines �߶�����
%
% StaticLines �� MoveLines �߶���������һ�£����ʽΪ2x2xN��NΪ�߶θ���
% ����һ���߶���˵�����߶ζϵ������ʾΪ��
% [���x����, ���y����;
%  �յ�x����, �յ�y����]

[rN, cN] = size(StaticI);
[x,y] = meshgrid(1:cN, 1:rN);
X = [x(:),y(:)];
XpFinal = zeros(size(X));
Wsum = zeros(length(x(:)),1);

for i = 1:size(StaticLines,3)
    P = StaticLines(1,:,i);
    Q = StaticLines(2,:,i);
    Pp = MoveLines(1,:,i);
    Qp = MoveLines(2,:,i);
    [ Xp, W] = GetXpW( P, Q, X, Pp, Qp );
    XpFinal = XpFinal + bsxfun(@times, Xp, W);
    Wsum = Wsum + W;
end
XpFinal = bsxfun(@times, XpFinal, 1./Wsum);

xp = reshape(XpFinal(:,1), rN, cN);
yp = reshape(XpFinal(:,2), rN, cN);

morphI = interp2(x,y, MoveI, xp,yp, 'linear',0);

end
