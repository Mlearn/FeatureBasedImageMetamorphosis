function [ Xs, W] = GetXpW( Pd, Qd, Xd, Ps, Qs )
%GETXP 根据两张图中的线段位置变化，逆向映射来求出目标图像中各点对应的源图中位置
% Based on
% Beier, T., & Neely, S. (1992). Feature-based image metamorphosis.
% ACM SIGGRAPH Computer Graphics, 26, 35–42. http://doi.org/10.1145/142920.134003
%
% 坐标格式1x2 (x,y)
% Pd 目标图像线段起点坐标
% Qd 目标图像线段终点坐标
% Xd 目标图像中像素点坐标序列
% Ps 源图像线段起点坐标
% Qs 源图像线段终点坐标
% W  各像素点对应的权值
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

