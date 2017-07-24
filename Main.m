function Main ()

StaticI = double(dicomread('D:\Users\anmou\Documents\MATLAB\demon_registration_version_8f\Test006\0.6\1\Image25.dcm'));
MoveI   = double(dicomread('D:\Users\anmou\Documents\MATLAB\demon_registration_version_8f\Test006\0.6\2\Image25.dcm'));

StaticI = double(dicomread('knee1.dcm'));
MoveI   = double(dicomread('knee2.dcm'));

a = imread('.\Examples\sunli.jpg');
StaticI = double(sum(a,3));
b = imread('.\Examples\libingbing.jpg');
MoveI = double(sum(b,3));

h = figure('Resize','on','HandleVisibility','on',...
                 'IntegerHandle','off','NumBerTitle','off','MenuBar','none',...
                 'ToolBar','figure','Name','ImageMorphing Demo -- By An Mou');
             
ax1 = axes(h,'Position',[0.05, 0.1,0.4,0.8]);
imshow(StaticI, 'Parent',ax1, 'DisplayRange',[0,700]); colormap(ax1,'gray');
ax2 = axes(h,'Position',[0.55, 0.1,0.4,0.8]);
imshow(MoveI, 'Parent',ax2, 'DisplayRange',[0,700]); colormap(ax1,'gray');

StaticLines = zeros(2,2,0);
MoveLines   = zeros(2,2,0);
i = 0;
while true
    i = i + 1;
    button = questdlg('Are you going on?','','Continue','Stop','Continue');
    if strcmpi(button, 'Stop')
        break;
    end
    axes(ax1); [x,y] = ginput(2);
    hold on; plot(ax1,x,y,'r-');
    StaticLines(:,:,i) = [x,y];
    axes(ax2); [x,y] = ginput(2);
    hold on; plot(x,y,'r-');
    MoveLines(:,:,i) = [x,y];
end

drawnow;
[ morphI ] = Morphing( StaticI, StaticLines, MoveI, MoveLines );

figure, imshow(morphI, 'DisplayRange',[0,700]);

figure, imshowpair(MoveI, StaticI, 'falsecolor');
title('Nothing');

figure, imshowpair(morphI, StaticI, 'falsecolor');
title('Morphing');

% figure; imagesc(morphI); colormap(gray);

end