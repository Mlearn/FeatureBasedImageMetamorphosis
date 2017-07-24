function [ morphI ] = Morphing( StaticI, StaticLines, MoveI, MoveLines )
%MORPHING 根据图像中的标定线段进行图像的变形
% Based on
% Beier, T., & Neely, S. (1992). Feature-based image metamorphosis.
% ACM SIGGRAPH Computer Graphics, 26, 35–42. http://doi.org/10.1145/142920.134003
%
% StaticI 目标图像
% StaticLines 线段序列
% MoveI 待变形图像
% MoveLines 线段序列
%
% StaticLines 与 MoveLines 线段序列数需一致，其格式为2x2xN，N为线段个数
% 对于一个线段来说，其线段断点坐标表示为：
% [起点x坐标, 起点y坐标;
%  终点x坐标, 终点y坐标]
%
%  Function is written by Mou An (July 21, 2017)

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

[rN, cN] = size(MoveI);
[xx, yy] = meshgrid(1:cN, 1:rN);
morphI = interp2(xx,yy, MoveI, xp,yp, 'linear',0);

end

