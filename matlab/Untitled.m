dur = 1;
sr = 11;
t = linspace(0,dur,sr*dur);
f = 1;
%pha = [3,4,2,3,4,1,2,3,4,1,2,3,1,2].'*pi/2;
%pha = [1,2,1,2,3,1,2,3,4,2,3,4,3,4].'*pi/2;
%pha = [1,1,1,1,1,1,1,0,0,0,0,0,0,0]*pi*32/180;
pha = [1,0,0,1,1,1,0,0,0,0,1,1,1,0]*pi*37/180;
%pha = [0,1,1,1,0,1,0,1,1,1,0,0,0,0]*pi;
pins = zeros(14,length(t));

for i = 1:14
    pins(i,:) = cos(2*pi*t*f + pha(i));
end

xx = [2,4,1,3,5,0,2,4,6,1,3,5,2,4];
yy = [2,2,1,1,1,0,0,0,0,-1,-1,-1,-2,-2];


for tt = 1:length(t)-1
    close all
    a = figure;
    a.Position(3) = 250;
    a.Position(4) = 300;
    hold on
    for i = 1:14
        a = plot(xx(i),yy(i),'.');
        a.MarkerSize = 10 + (pins(i,tt)+1)/2*40;
        a.Color = (pins(i,tt)+1)/2*[1 0 0] + (1 - (pins(i,tt)+1)/2)*[0 0 1];
    end
    axis([-1 7 -3 3])
    axis off
    set(gcf,'color','w');
    saveas(gcf,strcat('C:\Users\atrox\Desktop\Work\Research\My projects\Finished project\Expanding the gamut of tactile rendering space theough discretized fingerpad actuation\vid\stim10\png\',num2str(tt),'.png'))
    saveas(gcf,strcat('C:\Users\atrox\Desktop\Work\Research\My projects\Finished project\Expanding the gamut of tactile rendering space theough discretized fingerpad actuation\vid\stim10\svg\',num2str(tt),'.svg'))
    pause(.01)
end

%%

v = VideoWriter('C:\Users\atrox\Desktop\Work\Research\My projects\vibtex\vid\stim5\stim5.avi','Uncompressed AVI');
open(v);

for tt = 1:length(t) 
   frame = imread(strcat('C:\Users\atrox\Desktop\Work\Research\My projects\vibtex\vid\stim5\',num2str(tt),'.png'));
   writeVideo(v,frame);
end
close(v)