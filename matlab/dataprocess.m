dirr = 'C:\Users\atrox\Desktop\Work\Research\My projects\Finished project\Expanding the gamut of tactile rendering space through discretized fingerpad actuation\data\subject2\';

%% process exp1

a = figure;
a.Position(2) = 100;
a.Position(3) = 550;
a.Position(4) = 200;
subplot(1,2,1);

subjects = [11,12,13,14,15,16,17,18,19,22];

R = zeros(length(subjects),5,2);

for s = 1:length(subjects)
    
    load(strcat(dirr,num2str(subjects(s)),'\exp1.mat'));
    
    for t = 1:50
        R(s,stim1(t,1),pairs1(ord1(t))) = R(s,stim1(t,1),pairs1(ord1(t))) + (responses1(t) == pos1(t)-1);
    end
end

freqs = [5,10,20,40,80];
hold on
a = plot(freqs*1.05,mean(R(:,:,1),1)/5*100);
a.Color = [0 0 0];
a.LineWidth = .6;
a = plot(freqs*1.05,mean(R(:,:,1),1)/5*100,'s');
a.Color = [0 0 0];
a.LineWidth = 2.2;
a.MarkerSize = 3.1;
a = plot(freqs*.95,mean(R(:,:,2),1)/5*100);
a.Color = [1 0 0];
a.LineWidth = .6;
a = plot(freqs*.95,mean(R(:,:,2),1)/5*100,'.');
a.Color = [1 0 0];
a.MarkerSize = 15;

yticks([0 20 40 60 80 100])

for i = 1:5
    a = plot(freqs(i)*[1,1]*.95,mean(squeeze(R(:,i,2)))/5*100 + [1,-1]*std(squeeze(R(:,i,2)))/5*100);
    a.Color = [1 0 0];
    a.LineWidth = .6;
end

for i = 1:5
    a = plot(freqs(i)*[1,1]*1.05,mean(squeeze(R(:,i,1)))/5*100 + [1,-1]*std(squeeze(R(:,i,1)))/5*100);
    a.Color = [0 0 0];
    a.LineWidth = .6;
end

a = plot([1 200],[33 33],'--');
a.Color = [0 0 0];
a.LineWidth = .75;
a = plot([1 200],[80 80],'--');
a.Color = [0 0 0];
a.LineWidth = .75;


axis([4 100 0 110])
set(gca,'Xscale','log')
xticks(freqs)
xlabel('frequency (Hz)','Interpreter','latex','FontSize',15);
ylabel('percent correct','Interpreter','latex','FontSize',15);
set(gcf,'color','w');
set(gca,'TickLabelInterpreter','latex','FontSize',9);

subplot(1,2,2);

N = zeros(length(subjects),5,2);
Nt = zeros(length(subjects),5,5,2);
Ntt = zeros(50,5,2);

for s = 1:length(subjects)
    load(strcat(dirr,num2str(subjects(s)),'\exp1.mat'));
    
    pp = [[1 1 1 1 1];[1 1 1 1 1]];
    
    for t = 1:50
        N(s,stim1(t,1),pairs1(ord1(t))) = N(s,stim1(t,1),pairs1(ord1(t))) + length(textures_felt1{t});
        Nt(s,stim1(t,1),pp(pairs1(ord1(t)),stim1(t,1)),pairs1(ord1(t))) = length(textures_felt1{t});
        pp(pairs1(ord1(t)),stim1(t,1)) = pp(pairs1(ord1(t)),stim1(t,1))+1;
    end
    
    Nn(s,:,:) = N(s,:,:)/5;%/mean(mean(squeeze(N(s,:,:))));
end

for s = 1:10
    for t = 1:5
        for p = 1:2
            Ntt((s-1)*5+1:s*5,t,p) = Nt(s,t,:,p);
        end
    end
end

freqs = [5,10,20,40,80];
hold on
a = plot(freqs*1.05,mean(Nn(:,:,1),1)-3);
a.Color = [0 0 0];
a.LineWidth = .6;
a = plot(freqs*1.05,mean(Nn(:,:,1),1)-3,'s');
a.MarkerSize = 3;
a.Color = [0 0 0];
a.LineWidth = 2;
for i = 1:5
    a = plot(freqs(i)*[1,1]*1.05,mean(squeeze(Nn(:,i,1))-3) + [1,-1]*std(squeeze(Nn(:,i,1))));
    a.Color = [0 0 0];
    a.LineWidth = .6;
end


a = plot(freqs*.95,mean(Nn(:,:,2),1)-3);
a.Color = [1 0 0];
a.LineWidth = .6;
a = plot(freqs*.95,mean(Nn(:,:,2),1)-3,'.');
a.Color = [1 0 0];
a.MarkerSize = 15;

for i = 1:5
    a = plot(freqs(i)*[1,1]*.95,mean(squeeze(Nn(:,i,2))-3) + [1,-1]*std(squeeze(Nn(:,i,2))));
    a.Color = [1 0 0];
    a.LineWidth = .6;
end

axis([4 100 -1 13])
set(gca,'Xscale','log')
xticks(freqs)
xlabel('frequency (Hz)','Interpreter','latex','FontSize',15);
ylabel('exploration effort','Interpreter','latex','FontSize',15);
set(gcf,'color','w');
set(gca,'TickLabelInterpreter','latex','FontSize',9);

%% process exp1 histogram



%% process exp2

p = zeros(3,10);

for s = 1:1
    for t = 1:100
        p(s,stim2(t,pos2(t))) = (pos2(t)==responses2(s,t)+0) + p(s,stim2(t,pos2(t)));
    end
end
        

%% process exp3 time version 

subjects = [11,12,13,14,15,16,17,20,21,23];
%subjects = [17];

a = figure;
a.Position(2) = 100;
a.Position(3) = 500;
a.Position(4) = 500;
stimloc = zeros(3,length(subjects));
stimloc2 = zeros(3,length(subjects));
x40 = linspace(0,180,10000);
y40 = .33;
lam = 0;
hold on
astims = 1:10000;
b = 30;
trials = 25;
stimm = 3;
presented = [];

for s = 1:length(subjects)
    
    load(strcat(dirr,num2str(subjects(s)),'\exp3.mat'));
    
    P = ones(3,10000);   
    trial = 1; 
    for t = 1:trials
        for st = 1:stimm
            pp = (y40+(1-y40-lam)./(1+exp(-b/10000*(stim3(trial,pos3(trial))-astims))));            
            if pos3(trial) == responses3(t,st)
                P(st,:) = P(st,:).*pp;
            else
                P(st,:) = P(st,:).*(1-pp);              
            end
            %P(st,:) = P(st,:)/sum(P(st,:));
            trial = trial + 1;
        end
    end
    
    stimloc2(:,s) = mean(stim3(76:78,pos3(76:78)).');
    [~,stimloc(:,s)] = max(P.');
    %stimloc(:,s) = round(mean(((P.^2).*astims),2)./(mean(P.^2,2)));
    
    subplot(3,2,2)
    hold on
    a = plot(x40/2/180/40*1000,P(3,:)/sum(P(3,:))/.002);
    %a = plot(x/2/180/40*1000,P(1,:)/max(P(1,:)));
    a.Color = [1 .3 .3];
    a.Color = [0 0 0];
    axis([0 4 0 1.3])
    set(gca,'TickLabelInterpreter','latex','FontSize',10);
    subplot(3,2,4)
    hold on
    a = plot(x40/2/180/40*1000,P(1,:)/sum(P(1,:))/.002);
    %a = plot(x/2/180/80*1000,P(2,:)/max(P(2,:)));
    a.Color = [.3 1 .3];
    a.Color = [0 0 0];
    axis([0 4 0 1.3])
    set(gca,'TickLabelInterpreter','latex','FontSize',10);
    subplot(3,2,6)
    hold on
    %a = plot(x/2/180/40*1000,P(3,:)/max(P(3,:)));
    a = plot(x40/2/180/80*1000,P(2,:)/sum(P(2,:))/.002);
    a.Color = [.3 .3 1];
    a.Color = [0 0 0];
    axis([0 4 0 1.3])     
    set(gca,'TickLabelInterpreter','latex','FontSize',10);
    trial = 1;
    k = 1;
    for t = 1:75
        presented(s,trial,k) = stim3(t,pos3(t));
        k = k + 1;        
        if mod(t,3)==0
            k = 1;
            trial = trial + 1;
        end
    end
end

subplot(3,2,2)
a = plot(x40(round(mean(stimloc(3,:))))/2/180/40*1000,1.2,'.');
a.MarkerSize = 15;
a.Color = [1 .3 .3];
a.Color = [0 0 0];
a = plot([x40(round(mean(stimloc(3,:))-std(stimloc(3,:)))),x40(round(mean(stimloc(3,:))+std(stimloc(3,:))))]/2/180/40*1000,1.2*[1,1]);
a.LineWidth = 1;
a.Color = [1 .3 .3];
a.Color = [0 0 0];
xticks([0 1 2 3 4]);
yticks([])

subplot(3,2,4)
hold on
a = plot(x40(round(mean(stimloc(1,:))))/2/180/40*1000,1.2,'.');
a.MarkerSize = 15;
a.Color = [.3 1 .3];
a.Color = [0 0 0];
a = plot([x40(round(mean(stimloc(1,:))-std(stimloc(1,:)))),x40(round(mean(stimloc(1,:))+std(stimloc(1,:))))]/2/180/40*1000,1.2*[1,1]);
a.LineWidth = 1;
a.Color = [.3 1 .3];
a.Color = [0 0 0];
xticks([0 1 2 3 4]);
yticks([])
ylabel('posterior probability of perceptual threshold','Interpreter','latex','FontSize',12);

subplot(3,2,6)
a = plot(x40(round(mean(stimloc(2,:))))/2/180/80*1000,1.2,'.');
a.MarkerSize = 15;
a.Color = [.3 .3 1];
a.Color = [0 0 0];
a = plot([x40(round(mean(stimloc(2,:))-std(stimloc(2,:)))),x40(round(mean(stimloc(2,:))+std(stimloc(2,:))))]/2/180/80*1000,1.2*[1,1]);
a.LineWidth = 1;
a.Color = [.3 .3 1];
a.Color = [0 0 0];
xticks([0 1 2 3 4]);
yticks([])
xlabel('time delay (ms)','Interpreter','latex','FontSize',12);

subplot(3,2,1)
hold on
for s = 1:length(subjects)
    a = plot(x40(round(squeeze(presented(s,:,3)))).','.-');
    a.Color = [1 .3 .3];
    a.Color = [0 0 0];
    a.LineWidth = .1;
end
yticks([0 45 90])
xticks([5 10 15 20 25])
axis([0 25 0 100])
set(gca,'TickLabelInterpreter','latex','FontSize',10); 

subplot(3,2,3)
hold on
for s = 1:length(subjects)
    a = plot(x40(round(squeeze(presented(s,:,1)))).','.-');
    a.Color = [.3 1 .3];
    a.Color = [0 0 0];    
    a.LineWidth = .1;
end

yticks([0 45 90])
xticks([5 10 15 20 25])
axis([0 25 0 100])
set(gca,'TickLabelInterpreter','latex','FontSize',10);
ylabel('phase delay tested','Interpreter','latex','FontSize',12);

subplot(3,2,5)
hold on
for s = 1:length(subjects)
    a = plot(x40(round(squeeze(presented(s,:,2)))).','.-');
    a.Color = [.3 .3 1];
    a.Color = [0 0 0];
    a.LineWidth = .1;
end
yticks([0 45 90])
xticks([5 10 15 20 25])
axis([0 25 0 100])
set(gca,'TickLabelInterpreter','latex','FontSize',10);
xlabel('trial','Interpreter','latex','FontSize',12);
set(gcf,'color','w');

%% process exp3 space version 

def = 2*sin(x40/180*pi/2);

subjects = [11,12,13,14,15,16,17,20,21,23];
%subjects = [17];

a = figure;
a.Position(2) = 100;
a.Position(3) = 500;
a.Position(4) = 500;
stimloc = zeros(3,length(subjects));
stimloc2 = zeros(3,length(subjects));
x40 = linspace(0,180,10000);
y40 = .33;
lam = 0;
hold on
astims = 1:10000;
b = 30;
trials = 25;
stimm = 3;
presented = [];

for s = 1:length(subjects)
    
    load(strcat(dirr,num2str(subjects(s)),'\exp3.mat'));
    
    P = ones(3,10000);   
    trial = 1; 
    for t = 1:trials
        for st = 1:stimm
            pp = (y40+(1-y40-lam)./(1+exp(-b/10000*(stim3(trial,pos3(trial))-astims))));            
            if pos3(trial) == responses3(t,st)
                P(st,:) = P(st,:).*pp;
            else
                P(st,:) = P(st,:).*(1-pp);              
            end
            %P(st,:) = P(st,:)/sum(P(st,:));
            trial = trial + 1;
        end
    end
    
    stimloc2(:,s) = mean(stim3(76:78,pos3(76:78)).');
    [~,stimloc(:,s)] = max(P.');
    %stimloc(:,s) = round(mean(((P.^2).*astims),2)./(mean(P.^2,2)));
    
    subplot(3,2,2)
    hold on
    a = plot(def*28,P(3,:)/sum(P(3,:))/.002);
    %a = plot(x/2/180/40*1000,P(1,:)/max(P(1,:)));
    a.Color = [1 .3 .3];
    a.Color = [0 0 0];
    axis([0 30 0 1.3])
    set(gca,'TickLabelInterpreter','latex','FontSize',10);
    subplot(3,2,4)
    hold on
    a = plot(def*28,P(1,:)/sum(P(1,:))/.002);
    %a = plot(x/2/180/80*1000,P(2,:)/max(P(2,:)));
    a.Color = [.3 1 .3];
    a.Color = [0 0 0];
    axis([0 30 0 1.3])
    set(gca,'TickLabelInterpreter','latex','FontSize',10);
    subplot(3,2,6)
    hold on
    %a = plot(x/2/180/40*1000,P(3,:)/max(P(3,:)));
    a = plot(def*14,P(2,:)/sum(P(2,:))/.002);
    a.Color = [.3 .3 1];
    a.Color = [0 0 0];
    axis([0 30 0 1.3])     
    set(gca,'TickLabelInterpreter','latex','FontSize',10);
    trial = 1;
    k = 1;
    for t = 1:75
        presented(s,trial,k) = stim3(t,pos3(t));
        k = k + 1;        
        if mod(t,3)==0
            k = 1;
            trial = trial + 1;
        end
    end
end

subplot(3,2,2)
a = plot(def(round(mean(stimloc(3,:))))*28,1.2,'.');
a.MarkerSize = 15;
a.Color = [1 .3 .3];
a.Color = [0 0 0];
a = plot([def(round(mean(stimloc(3,:))-std(stimloc(3,:)))),def(round(mean(stimloc(3,:))+std(stimloc(3,:))))]*28,1.2*[1,1]);
a.LineWidth = 1;
a.Color = [1 .3 .3];
a.Color = [0 0 0];
xticks(0:5:25)
yticks([])

subplot(3,2,4)
hold on
a = plot(def(round(mean(stimloc(1,:))))*28,1.2,'.');
a.MarkerSize = 15;
a.Color = [.3 1 .3];
a.Color = [0 0 0];
a = plot([def(round(mean(stimloc(1,:))-std(stimloc(1,:)))),def(round(mean(stimloc(1,:))+std(stimloc(1,:))))]*28,1.2*[1,1]);
a.LineWidth = 1;
a.Color = [.3 1 .3];
a.Color = [0 0 0];
xticks(0:5:25)
yticks([])
ylabel('posterior probability of perceptual threshold','Interpreter','latex','FontSize',12);

subplot(3,2,6)
a = plot(def(round(mean(stimloc(2,:))))*14,1.2,'.');
a.MarkerSize = 15;
a.Color = [.3 .3 1];
a.Color = [0 0 0];
a = plot([def(round(mean(stimloc(2,:))-std(stimloc(2,:)))),def(round(mean(stimloc(2,:))+std(stimloc(2,:))))]*14,1.2*[1,1]);
a.LineWidth = 1;
a.Color = [.3 .3 1];
a.Color = [0 0 0];
xticks(0:5:25)
yticks([])
xlabel('local deformation ($\mu$m)','Interpreter','latex','FontSize',12);

subplot(3,2,1)
hold on
for s = 1:length(subjects)
    a = plot(x40(round(squeeze(presented(s,:,3)))).','.-');
    a.Color = [1 .3 .3];
    a.Color = [0 0 0];
    a.LineWidth = .1;
end
yticks([0 45 90])
xticks([5 10 15 20 25])
axis([0 25 0 100])
set(gca,'TickLabelInterpreter','latex','FontSize',10); 

subplot(3,2,3)
hold on
for s = 1:length(subjects)
    a = plot(x40(round(squeeze(presented(s,:,1)))).','.-');
    a.Color = [.3 1 .3];
    a.Color = [0 0 0];    
    a.LineWidth = .1;
end

yticks([0 45 90])
xticks([5 10 15 20 25])
axis([0 25 0 100])
set(gca,'TickLabelInterpreter','latex','FontSize',10);
ylabel('phase delay tested','Interpreter','latex','FontSize',12);

subplot(3,2,5)
hold on
for s = 1:length(subjects)
    a = plot(x40(round(squeeze(presented(s,:,2)))).','.-');
    a.Color = [.3 .3 1];
    a.Color = [0 0 0];
    a.LineWidth = .1;
end
yticks([0 45 90])
xticks([5 10 15 20 25])
axis([0 25 0 100])
set(gca,'TickLabelInterpreter','latex','FontSize',10);
xlabel('trial','Interpreter','latex','FontSize',12);
set(gcf,'color','w');


%% process exp4
mul = 10;
subjects = [11,12,13,14,17,18,19,20,21,22,23];

R = zeros(length(subjects),3,4,2);
for s = 1:length(subjects)
    load(strcat(dirr,num2str(subjects(s)),'\exp4.mat'));
    for t = 1:24
        R(s,stims4(ord4(t)),delayo4(ord4(t)),freqo4(ord4(t))) = responses4(t);
    end
    R1m = squeeze(R(s,:,:,1));
    R2m = squeeze(R(s,:,:,2));
    R(s,:,:,1) = R(s,:,:,1)*2/mean(R1m(:) + mean(R2m(:)));
    R(s,:,:,2) = R(s,:,:,2)*2/mean(R1m(:) + mean(R2m(:)));
    %R(s,:,:,1) = R(s,:,:,1)/mean(R1m(:));
    %R(s,:,:,2) = R(s,:,:,2)/mean(R2m(:));
end

X = [[1,1,1,1];[2,2,2,2];[3,3,3,3]].';
Xi = (ones(4*mul,1)*linspace(1,3,3*mul));
Y = [[1,2,3,4];[1,2,3,4];[1,2,3,4]].';
Yi = (linspace(1,4,4*mul).'*ones(1,3*mul));

R1m = squeeze(mean(R(:,:,:,1),1)).';
R2m = squeeze(mean(R(:,:,:,2),1)).';

R1s = squeeze(std(R(:,:,:,1),1)).';
R2s = squeeze(std(R(:,:,:,2),1)).';

R1i = interp2(X,Y,R1m,Xi,Yi);
R2i = interp2(X,Y,R2m,Xi,Yi);

a = figure;
a.Position(3) = 700;
a.Position(4) = 300;
subplot(1,2,1);
hold on
a = surf(Yi,Xi,R1i);
a.EdgeColor = 'none';
%a.FaceColor = 'interp';
colormap('jet');
view(-45,25)
axis([.9 4 .9 3 0 2.5])
a = plot3(Y(:),X(:),R1m(:)+.02,'.');
a.MarkerSize = 15;
a.Color = [0 0 0];
% for s = 1:12
%     a = plot3([Y(s),Y(s)].',[X(s),X(s)].',[R1m(s)+R1s(s),R1m(s)-R1s(s)].');
%     a.Color = [0 0 0];
% end

yticklabels({'S3','S4','S5'})
xticklabels({'45','90','135','180'})
set(gca,'TickLabelInterpreter','latex','FontSize',10);
subplot(1,2,2);
hold on
a = surf(Yi,Xi,R2i);
a.EdgeColor = 'none';
%a.FaceColor = 'interp';
colormap('jet');
view(-45,25)
set(gcf,'color','w');
axis([.9 4 .9 3 0 2.5])
a = plot3(Y(:),X(:),R2m(:)+.02,'.');
a.MarkerSize = 15;
a.Color = [0 0 0];

% for s = 1:12
%     a = plot3([Y(s),Y(s)].',[X(s),X(s)].',[R2m(s)+R2s(s),R2m(s)-R2s(s)].');
%     a.Color = [0 0 0];
% end

yticklabels({'S3','S4','S5'})
xticklabels({'45','90','135','180'})
set(gca,'TickLabelInterpreter','latex','FontSize',10);
map = colormap;
colormap(map(11:end,:))

%% mapping roughness to deformation

dt = cos(0) - cos([1/4*pi 2/4*pi 3/4*pi pi]);
%dt = [1,2,3,4];
%dx = sqrt([7,17,21]);
dx = [0.1546    0.3863    0.4819];
xy = dx.'*dt;
ls = length(subjects);
x40 = [];
y40 = [];
x80 = [];
y80 = [];
k = 1;
for i = 1:3
    for ii = 1:4        
        x40(k,1:ls) = xy(i,ii)*ones(1,ls);
        y40(k,1:ls) = squeeze(R(:,i,ii,1));
        x80(k,1:ls) = xy(i,ii)*ones(1,ls);
        y80(k,1:ls) = squeeze(R(:,i,ii,2));
        k = k + 1;
    end
end

a = figure;
hold on
a.Position(3) = 300;
a.Position(4) = 250;

% fun = @(x,xdata)x(1)*(xdata.^x(2));
% x = lsqcurvefit(fun,[1,.5],mean(x40,2),mean(y40,2));
% 
% a = plot(linspace(.001,10,1000),x(1)*log(linspace(.001,10,1000))+x(2));
% a.Color = [1 0 0];


a = plot(mean(x40(1:4,:),2),mean(y40(1:4,:),2),'.');
a.MarkerSize = 17;
a.Color = [0 0 0];

a = plot(mean(x40(5:8,:),2),mean(y40(5:8,:),2),'x');
a.MarkerSize = 6;
a.LineWidth = 1.5;
a.Color = [0 0 0];

a = plot(mean(x40(9:12,:),2),mean(y40(9:12,:),2),'s');
a.MarkerSize = 5;
a.LineWidth = 1.5;
a.Color = [0 0 0];

axis([0 1 0 1.75])

% a = plot(mean(x80,2),mean(y80,2),'o');
% a.MarkerSize = 7;
% a.Color = [1 0 0];
% a.LineWidth = 1;

% for i = 1:12
%     a = plot(mean(x(i,:))*[1,1],mean(y(i,:))+std(y(i,:))*[-1,1]);
%     a.Color = [0 0 0];
% end

text(.5,.5,'$R^2=.95$','Interpreter','latex','FontSize',12);

xlabel('$\overline{D(t)}$ (mm)','Interpreter','latex','FontSize',12);
ylabel('norm. roughness judgment','Interpreter','latex','FontSize',12);
set(gca,'TickLabelInterpreter','latex','FontSize',12);
set(gcf,'color','w');

%% mapping roughness to timing plot 1

% dt = [1/2/40/4 1/2/40/4*2 1/2/40/4*3 1/2/40/4*4 1/2/80/4 1/2/80/4*2 1/2/80/4*3 1/2/80/4*4];
% dx = [7,15,21];
% %dx = [0.1546    0.3863    0.4819];
% xy = dx.'*dt;

dd = [45 90 135 180 45 90 135 180]/180*pi;
dx = [7,15,21];
%dx = [0.1546    0.3863    0.4819];
xy = dx.'*dd;

% dd = sin((2*pi*linspace(0,1,10000).') - [0 45 90 135 180]/180*pi);
% dd = mean(abs(dd(:,2:5) - dd(:,1)));
% dd = dd.'*[.028,.014];
% dd = dd(:);
% dx = [7,15,21];
% xy = (dd*dx).';

ls = length(subjects);
x40 = [];
y40 = [];
x80 = [];
y80 = [];
k = 1;
for i = 1:3
    for ii = 1:4        
        x40(k,1:ls) = xy(i,ii)*ones(1,ls);
        y40(k,1:ls) = squeeze(R(:,i,ii,1));
        x80(k,1:ls) = xy(i,ii+4)*ones(1,ls);
        y80(k,1:ls) = squeeze(R(:,i,ii,2));
        k = k + 1;
    end
end

xx = [mean(x40.'),mean(x80.')];
yy = [mean(y40.'),mean(y80.')];
x40m = mean(x40.');
y40m = mean(y40.');
x80m = mean(x80.');
y80m = mean(y80.');

a = figure;
hold on
a.Position(3) = 600;
a.Position(4) = 200;

% fun = @(x,xdata)x(1)*log(xdata)+ x(2);
fun = @(x,xdata)x(1)*(xdata.^x(2));
x = lsqcurvefit(fun,[1,.5],x40m,y40m);

subplot(1,2,1);

%a = plot(logspace(-4,1,10000),x(1)*log(logspace(-4,1,10000))+x(2));
a = plot(logspace(-4,3,10000),x(1)*(logspace(-4,3,10000).^x(2)));
a.Color = [1 0 0];
a.LineWidth = .5;

[r,p] = corr(x(1)*(x40m.'.^x(2)),y40m.');
p
Rsquared = r.^2

hold on

a = plot(x40m(1:4),y40m(1:4),'.');
a.MarkerSize = 17;
a.Color = [0 0 0];

a = plot(x40m(5:8),y40m(5:8),'x');
a.MarkerSize = 6;
a.LineWidth = 1.5;
a.Color = [0 0 0];

a = plot(x40m(9:12),y40m(9:12),'s');
a.MarkerSize = 5;
a.LineWidth = 1.5;
a.Color = [0 0 0];


text(.025,1.85,'$R^2=.95$','Interpreter','latex','FontSize',12);

xlabel('total delay (s)','Interpreter','latex','FontSize',12);
ylabel('norm. roughness judgment','Interpreter','latex','FontSize',12);
set(gca,'TickLabelInterpreter','latex','FontSize',12);
set(gcf,'color','w');

axis([0 max(x80m)*1.1 0 2]);

box off

subplot(1,2,2);

%fun = @(x,xdata)x(1)*log(xdata) + x(2);
fun = @(x,xdata)x(1)*(xdata.^x(2));
x = lsqcurvefit(fun,[1,.5],x80m,y80m);

% a = plot(linspace(.001,10,1000),x(1)*log(linspace(.001,10,1000))+x(2));
a = plot(logspace(-4,3,10000),x(1)*(logspace(-4,3,10000).^x(2)));

a.Color = [1 0 0];
a.LineWidth = .5;

[r,p] = corr(x(1)*(x80m.'.^x(2)),y80m.');
p
Rsquared = r.^2

hold on

a = plot(x80m(1:4),y80m(1:4),'.');
a.MarkerSize = 17;
a.Color = [0 0 0];

a = plot(x80m(5:8),y80m(5:8),'x');
a.MarkerSize = 6;
a.LineWidth = 1.5;
a.Color = [0 0 0];

a = plot(x80m(9:12),y80m(9:12),'s');
a.MarkerSize = 5;
a.LineWidth = 1.5;
a.Color = [0 0 0];

axis([0 max(x80m)*1.1 0 2])
text(.025,1.85,'$R^2=.67$','Interpreter','latex','FontSize',12);

xlabel('total delay (s)','Interpreter','latex','FontSize',12);
set(gca,'TickLabelInterpreter','latex','FontSize',12);
set(gcf,'color','w');

box off

%% mapping roughness to timing plot 2

dd = [1/2/40/4 1/2/40/4*2 1/2/40/4*3 1/2/40/4*4 1/2/80/4 1/2/80/4*2 1/2/80/4*3 1/2/80/4*4];
dx = [7,15,21];
%dx = [0.1546    0.3863    0.4819];
xy = dx.'*dd;
ls = length(subjects);
x40 = [];
y40 = [];
x80 = [];
y80 = [];
k = 1;
for i = 1:3
    for ii = 1:4        
        x40(k,1:ls) = xy(i,ii)*ones(1,ls);
        y40(k,1:ls) = squeeze(R(:,i,ii,1));
        x80(k,1:ls) = xy(i,ii+4)*ones(1,ls);
        y80(k,1:ls) = squeeze(R(:,i,ii,2));
        k = k + 1;
    end
end

xx = [mean(x40.'),mean(x80.')];
yy = [mean(y40.'),mean(y80.')];
% xx = [mean(x40.')];
% yy = [mean(y40.')];
% xx = [mean(x80.')];
% yy = [mean(y80.')];


a = figure;
hold on
a.Position(3) = 350;
a.Position(4) = 250;

% fun = @(x,xdata)x(1)*log(xdata) + x(2);
% x = lsqcurvefit(fun,[1,.5],xx,yy);
% fun = @(x,xdata)x(1)*(xdata.^x(2));
% x = lsqcurvefit(fun,[1,.5],xx,yy)
% 
% %a = plot(logspace(-2,2,1000),x(1)*log(logspace(-2,2,1000))+x(2));
% a = plot(logspace(-4,2,1000),x(1)*(logspace(-4,2,1000).^x(2)));
% a.Color = [0 0 0];
% a.LineWidth = 1;

% [r,p] = corr((x(1)*log(xx) + x(2)).',yy.');
% [r,p] = corr(x(1)*xx.^x(2).',yy.');
% p
% Rsquared = r^2

a = plot(mean(x40(1:4,:),2),mean(y40(1:4,:),2),'.');
a.MarkerSize = 17;
a.Color = [0 0 1];

a = plot(mean(x40(5:8,:),2),mean(y40(5:8,:),2),'x');
a.MarkerSize = 6;
a.LineWidth = 1.5;
a.Color = [0 0 1];

a = plot(mean(x40(9:12,:),2),mean(y40(9:12,:),2),'s');
a.MarkerSize = 5;
a.LineWidth = 1.5;
a.Color = [0 0 1];

a = plot(mean(x80(1:4,:),2),mean(y80(1:4,:),2),'.');
a.MarkerSize = 17;
a.Color = [1 0 0];

a = plot(mean(x80(5:8,:),2),mean(y80(5:8,:),2),'x');
a.MarkerSize = 6;
a.LineWidth = 1.5;
a.Color = [1 0 0];

a = plot(mean(x80(9:12,:),2),mean(y80(9:12,:),2),'s');
a.MarkerSize = 5;
a.LineWidth = 1.5;
a.Color = [1 0 0];

axis([0 .3 0 2])

text(.175,.55,strcat('$R^2=',num2str(Rsquared,2),'$'),'Interpreter','latex','FontSize',12);
text(.175,.30,strcat('$y=',num2str(x(1),2),'x^{',num2str(x(2),2),'}$'),'Interpreter','latex','FontSize',12);

xlabel('total time delay, T(s)','Interpreter','latex','FontSize',12);
ylabel('norm. roughness judgment','Interpreter','latex','FontSize',12);
set(gca,'TickLabelInterpreter','latex','FontSize',12);
set(gcf,'color','w');

%% mapping roughness to phase plot 2
dd = [45 90 135 180 45 90 135 180]/180*pi;
dx = [7,15,21];
%dx = [0.1546    0.3863    0.4819];
xy = dx.'*dd;
ls = length(subjects);
x40 = [];
y40 = [];
x80 = [];
y80 = [];
k = 1;
for i = 1:3
    for ii = 1:4        
        x40(k,1:ls) = xy(i,ii)*ones(1,ls);
        y40(k,1:ls) = squeeze(R(:,i,ii,1));
        x80(k,1:ls) = xy(i,ii+4)*ones(1,ls);
        y80(k,1:ls) = squeeze(R(:,i,ii,2));
        k = k + 1;
    end
end

xx = [mean(x40.'),mean(x80.')];
yy = [mean(y40.'),mean(y80.')];
% xx = [mean(x40.')];
% yy = [mean(y40.')];
% xx = [mean(x80.')];
% yy = [mean(y80.')];

a = figure;
hold on
a.Position(3) = 350;
a.Position(4) = 250;

fun = @(x,xdata)x(1)*log(xdata) + x(2);
x = lsqcurvefit(fun,[1,.5],xx,yy);
fun = @(x,xdata)x(1)*(xdata.^x(2));
x = lsqcurvefit(fun,[1,.5],xx,yy)

%a = plot(logspace(-2,2,1000),x(1)*log(logspace(-2,2,1000))+x(2));
a = plot(logspace(-4,2,1000),x(1)*(logspace(-4,2,1000).^x(2)));
a.Color = [0 0 0];
a.LineWidth = 1;

[r,p] = corr((x(1)*log(xx) + x(2)).',yy.');
[r,p] = corr(x(1)*xx.^x(2).',yy.');

Rsquared = r^2
p

% SSres = sum((x(1)*log(xx) + x(2) - yy).^2);
% SStot = sum((yy - mean(yy)).^2);
% 
% Rsquared = 1 - (SSres/SStot);


a = plot(mean(x40(1:4,:),2),mean(y40(1:4,:),2),'.');
a.MarkerSize = 17;
a.Color = [0 0 1];

a = plot(mean(x40(5:8,:),2),mean(y40(5:8,:),2),'x');
a.MarkerSize = 6;
a.LineWidth = 1.5;
a.Color = [0 0 1];

a = plot(mean(x40(9:12,:),2),mean(y40(9:12,:),2),'s');
a.MarkerSize = 5;
a.LineWidth = 1.5;
a.Color = [0 0 1];

a = plot(mean(x80(1:4,:),2),mean(y80(1:4,:),2),'.');
a.MarkerSize = 17;
a.Color = [1 0 0];

a = plot(mean(x80(5:8,:),2),mean(y80(5:8,:),2),'x');
a.MarkerSize = 6;
a.LineWidth = 1.5;
a.Color = [1 0 0];

a = plot(mean(x80(9:12,:),2),mean(y80(9:12,:),2),'s');
a.MarkerSize = 5;
a.LineWidth = 1.5;
a.Color = [1 0 0];

axis([0 70 0 1.8])
text(45,.55,strcat('$R^2=',num2str(Rsquared,2),'$'),'Interpreter','latex','FontSize',12);
text(45,.30,strcat('$y=',num2str(x(1),2),'x^{',num2str(x(2),2),'}$'),'Interpreter','latex','FontSize',12);


xlabel('total phase delay, $\Theta$(rad)','Interpreter','latex','FontSize',12);
ylabel('norm. roughness judgment','Interpreter','latex','FontSize',12);
set(gca,'TickLabelInterpreter','latex','FontSize',12);
set(gcf,'color','w');

%% mapping roughness to deformation plot 2
dd1 = sin((2*pi*40*linspace(0,1,10000).') - [0 45 90 135 180]/180*pi);
dd1 = dd1(:,2:5) - dd1(:,1);
dd1 = dd1*.028;

dd2 = sin((2*pi*80*linspace(0,1,10000).') - [0 45 90 135 180]/180*pi);
dd2 = dd2(:,2:5) - dd2(:,1);
dd2 = dd2*.014;

dd = [mean(abs(dd1)).';mean(abs(dd2)).'];

dx = [7,15,21];
xy = (dd*dx).';
ls = length(subjects);
x40 = [];
y40 = [];
x80 = [];
y80 = [];
k = 1;
for i = 1:3
    for ii = 1:4        
        x40(k,1:ls) = xy(i,ii)*ones(1,ls);
        y40(k,1:ls) = squeeze(R(:,i,ii,1));
        x80(k,1:ls) = xy(i,ii+4)*ones(1,ls);
        y80(k,1:ls) = squeeze(R(:,i,ii,2));
        k = k + 1;
    end
end

xx = [mean(x40.'),mean(x80.')];
yy = [mean(y40.'),mean(y80.')];
% xx = [mean(x40.')];
% yy = [mean(y40.')];
% xx = [mean(x80.')];
% yy = [mean(y80.')];

a = figure;
hold on
a.Position(3) = 350;
a.Position(4) = 250;

% fun = @(x,xdata)x(1)*log(xdata) + x(2);
% x = lsqcurvefit(fun,[1,.5],xx,yy);
% fun = @(x,xdata)x(1)*(xdata.^x(2));
% x = lsqcurvefit(fun,[1,.5],xx,yy);
% 
%a = plot(logspace(-2,2,1000),x(1)*log(logspace(-2,2,1000)).^x(2));

x = [2.1618,.5939];

a = plot(logspace(-4,2,1000),x(1)*(logspace(-4,2,1000).^x(2)));
a.Color = [0 0 0];
a.LineWidth = 1;


%[r,p] = corrR((x(1)*log(xx) + x(2)).',yy.');
%[r,p] = corrR(x(1)*xx.^x(2).',yy.');

r = corrR(x(1)*xx.^x(2).',yy.');


Rsquared = r^2

SSres = sum((x(1)*xx.^x(2) - yy).^2);
SStot = sum((yy - mean(yy)).^2);

Rsquared = 1 - (SSres/SStot);


a = plot(mean(x40(1:4,:),2),mean(y40(1:4,:),2),'.');
a.MarkerSize = 17;
a.Color = [0 0 1];

a = plot(mean(x40(5:8,:),2),mean(y40(5:8,:),2),'x');
a.MarkerSize = 6;
a.LineWidth = 1.5;
a.Color = [0 0 1];

a = plot(mean(x40(9:12,:),2),mean(y40(9:12,:),2),'s');
a.MarkerSize = 5;
a.LineWidth = 1.5;
a.Color = [0 0 1];

a = plot(mean(x80(1:4,:),2),mean(y80(1:4,:),2),'.');
a.MarkerSize = 17;
a.Color = [1 0 0];

a = plot(mean(x80(5:8,:),2),mean(y80(5:8,:),2),'x');
a.MarkerSize = 6;
a.LineWidth = 1.5;
a.Color = [1 0 0];

a = plot(mean(x80(9:12,:),2),mean(y80(9:12,:),2),'s');
a.MarkerSize = 5;
a.LineWidth = 1.5;
a.Color = [1 0 0];

axis([0 .85 0 2])
xticks([0 .2 .4 .6 .8])
text(.55,.55,strcat('$R^2=',num2str(Rsquared,2),'$'),'Interpreter','latex','FontSize',12);
text(.55,.30,strcat('$y=',num2str(x(1),2),'x^{',num2str(x(2),2),'}$'),'Interpreter','latex','FontSize',12);
xlabel('summary displacement, D(mm)','Interpreter','latex','FontSize',12);
ylabel('norm. roughness judgment','Interpreter','latex','FontSize',12);
set(gca,'TickLabelInterpreter','latex','FontSize',12);
set(gcf,'color','w');

%% mapping roughness to d/dt displacement plot 2

dd1 = diff(sin((2*pi*40*linspace(0,1,10000).') - [0 45 90 135 180]/180*pi));
dd1 = dd1(:,2:5) - dd1(:,1);
dd1 = dd1*.028;

dd2 = diff(sin((2*pi*80*linspace(0,1,10000).') - [0 45 90 135 180]/180*pi));
dd2 = dd2(:,2:5) - dd2(:,1);
dd2 = dd2*.014;

dd = [mean(abs(dd1)).'*10000;mean(abs(dd2)).'*10000];

dx = [7,15,21];
xy = (dd*dx).';
ls = length(subjects);
x40 = [];
y40 = [];
x80 = [];
y80 = [];
k = 1;
for i = 1:3
    for ii = 1:4        
        x40(k,1:ls) = xy(i,ii)*ones(1,ls);
        y40(k,1:ls) = squeeze(R(:,i,ii,1));
        x80(k,1:ls) = xy(i,ii+4)*ones(1,ls);
        y80(k,1:ls) = squeeze(R(:,i,ii,2));
        k = k + 1;
    end
end

xx = [mean(x40.'),mean(x80.')];
yy = [mean(y40.'),mean(y80.')];
% xx = [mean(x40.')];
% yy = [mean(y40.')];
% xx = [mean(x80.')];
% yy = [mean(y80.')];

a = figure;
hold on
a.Position(3) = 350;
a.Position(4) = 250;

% fun = @(x,xdata)x(1)*log(xdata) + x(2);
% x = lsqcurvefit(fun,[1,.5],xx,yy);
% fun = @(x,xdata)x(1)*(xdata.^x(2));
% x = lsqcurvefit(fun,[1,.5],xx,yy);
% 
%a = plot(logspace(-2,2,1000),x(1)*log(logspace(-2,2,1000)).^x(2));

x = [.060,.6196];

a = plot(logspace(-4,3,1000),x(1)*(logspace(-4,3,1000).^x(2)));
a.Color = [0 0 0];
a.LineWidth = 1;


%[r,p] = corrR((x(1)*log(xx) + x(2)).',yy.');
%[r,p] = corrR(x(1)*xx.^x(2).',yy.');

r = corrR(x(1)*xx.^x(2).',yy.');


Rsquared = r^2

SSres = sum((x(1)*xx.^x(2) - yy).^2);
SStot = sum((yy - mean(yy)).^2);

Rsquared = 1 - (SSres/SStot);


a = plot(mean(x40(1:4,:),2),mean(y40(1:4,:),2),'.');
a.MarkerSize = 17;
a.Color = [0 0 1];

a = plot(mean(x40(5:8,:),2),mean(y40(5:8,:),2),'x');
a.MarkerSize = 6;
a.LineWidth = 1.5;
a.Color = [0 0 1];

a = plot(mean(x40(9:12,:),2),mean(y40(9:12,:),2),'s');
a.MarkerSize = 5;
a.LineWidth = 1.5;
a.Color = [0 0 1];

a = plot(mean(x80(1:4,:),2),mean(y80(1:4,:),2),'.');
a.MarkerSize = 17;
a.Color = [1 0 0];

a = plot(mean(x80(5:8,:),2),mean(y80(5:8,:),2),'x');
a.MarkerSize = 6;
a.LineWidth = 1.5;
a.Color = [1 0 0];

a = plot(mean(x80(9:12,:),2),mean(y80(9:12,:),2),'s');
a.MarkerSize = 5;
a.LineWidth = 1.5;
a.Color = [1 0 0];

axis([0 200 0 2])
% xticks([0 .2 .4 .6 .8])
text(125,.55,strcat('$R^2=',num2str(Rsquared,2),'$'),'Interpreter','latex','FontSize',12);
text(125,.30,strcat('$y=',num2str(x(1),2),'x^{',num2str(x(2),2),'}$'),'Interpreter','latex','FontSize',12);
xlabel('summary rate of displacement, RD(mm/s)','Interpreter','latex','FontSize',12);
ylabel('norm. roughness judgment','Interpreter','latex','FontSize',12);
set(gca,'TickLabelInterpreter','latex','FontSize',12);
set(gcf,'color','w');


%% mapping roughness to stretch plot 2
dd1 = sin((2*pi*40*linspace(0,1,10000).') - [0 45 90 135 180]/180*pi);
dd1 = dd1(:,2:5) - dd1(:,1);
dd1 = dd1*.028;
dd1 = sqrt(dd1.^2 + 1.5^2) - 1.5;

dd2 = sin((2*pi*80*linspace(0,1,10000).') - [0 45 90 135 180]/180*pi);
dd2 = dd2(:,2:5) - dd2(:,1);
dd2 = dd2*.014;
dd2 = sqrt(dd2.^2 + 1.5^2) - 1.5;

dd = [mean(abs(dd1)).';mean(abs(dd2)).'];

dx = [7,15,21];
xy = (dd*dx).';
ls = length(subjects);
x40 = [];
y40 = [];
x80 = [];
y80 = [];
k = 1;

for i = 1:3
    for ii = 1:4        
        x40(k,1:ls) = xy(i,ii)*ones(1,ls);
        y40(k,1:ls) = squeeze(R(:,i,ii,1));
        x80(k,1:ls) = xy(i,ii+4)*ones(1,ls);
        y80(k,1:ls) = squeeze(R(:,i,ii,2));
        k = k + 1;
    end
end

xx = [mean(x40.'),mean(x80.')];
yy = [mean(y40.'),mean(y80.')];
% xx = [mean(x40.')];
% yy = [mean(y40.')];
% xx = [mean(x80.')];
% yy = [mean(y80.')];

h = figure;
hold on
h.Position(3) = 350;
h.Position(4) = 250;
xtickformat('%1.0f')


% fun = @(x,xdata)x(1)*log(xdata) + x(2);
% x = lsqcurvefit(fun,[1,.5],xx,yy);
% fun = @(x,xdata)x(1)*(xdata.^x(2));
% x = lsqcurvefit(fun,[1,.5],xx,yy);
% 
%a = plot(logspace(-2,2,1000),x(1)*log(logspace(-2,2,1000)).^x(2));

x = [11.626,.3702];

a = plot(logspace(-4,2,1000),x(1)*(logspace(-4,2,1000).^x(2)));
a.Color = [0 0 0];
a.LineWidth = 1;


%[r,p] = corrR((x(1)*log(xx) + x(2)).',yy.');
%[r,p] = corrR(x(1)*xx.^x(2).',yy.');

r = corrR(x(1)*xx.^x(2).',yy.');


Rsquared = r^2

SSres = sum((x(1)*xx.^x(2) - yy).^2);
SStot = sum((yy - mean(yy)).^2);

Rsquared = 1 - (SSres/SStot);


a = plot(mean(x40(1:4,:),2),mean(y40(1:4,:),2),'.');
a.MarkerSize = 17;
a.Color = [0 0 1];

a = plot(mean(x40(5:8,:),2),mean(y40(5:8,:),2),'x');
a.MarkerSize = 6;
a.LineWidth = 1.5;
a.Color = [0 0 1];

a = plot(mean(x40(9:12,:),2),mean(y40(9:12,:),2),'s');
a.MarkerSize = 5;
a.LineWidth = 1.5;
a.Color = [0 0 1];

a = plot(mean(x80(1:4,:),2),mean(y80(1:4,:),2),'.');
a.MarkerSize = 17;
a.Color = [1 0 0];

a = plot(mean(x80(5:8,:),2),mean(y80(5:8,:),2),'x');
a.MarkerSize = 6;
a.LineWidth = 1.5;
a.Color = [1 0 0];

a = plot(mean(x80(9:12,:),2),mean(y80(9:12,:),2),'s');
a.MarkerSize = 5;
a.LineWidth = 1.5;
a.Color = [1 0 0];

axis([0 .007 0 2])
%xticks([0 .2 .4 .6 .8])
text(.005,.55,strcat('$R^2=',num2str(Rsquared,2),'$'),'Interpreter','latex','FontSize',12);
text(.005,.30,strcat('$y=',num2str(x(1),2),'x^{',num2str(x(2),2),'}$'),'Interpreter','latex','FontSize',12);
xlabel('summary stretch, S(mm)','Interpreter','latex','FontSize',12);
ylabel('norm. roughness judgment','Interpreter','latex','FontSize',12);
set(gca,'TickLabelInterpreter','latex','FontSize',12);
set(gcf,'color','w');

%% mapping roughness to d/dt displacement plot 2

dd1 = sin((2*pi*40*linspace(0,1,10000).') - [0 45 90 135 180]/180*pi);
dd1 = dd1(:,2:5) - dd1(:,1);
dd1 = dd1*.028;
dd1 = sqrt(dd1.^2 + 2.5^2) - 2.5;
dd1 = diff(dd1)*10000;

dd2 = sin((2*pi*80*linspace(0,1,10000).') - [0 45 90 135 180]/180*pi);
dd2 = dd2(:,2:5) - dd2(:,1);
dd2 = dd2*.014;
dd2 = sqrt(dd2.^2 + 2.5^2) - 2.5;
dd2 = diff(dd2)*10000;

dd = [mean(abs(dd1)).';mean(abs(dd2)).'];
%dd = [1,1,1,1,1,1,1,1].';

dx = [7,15,21];
xy = (dd*dx).';
ls = length(subjects);
x40 = [];
y40 = [];
x80 = [];
y80 = [];
k = 1;
for i = 1:3
    for ii = 1:4        
        x40(k,1:ls) = xy(i,ii)*ones(1,ls);
        y40(k,1:ls) = squeeze(R(:,i,ii,1));
        x80(k,1:ls) = xy(i,ii+4)*ones(1,ls);
        y80(k,1:ls) = squeeze(R(:,i,ii,2));
        k = k + 1;
    end
end

xx = [mean(x40.'),mean(x80.')];
yy = [mean(y40.'),mean(y80.')];
% xx = [mean(x40.')];
% yy = [mean(y40.')];
% xx = [mean(x80.')];
% yy = [mean(y80.')];

a = figure;
hold on
a.Position(3) = 350;
a.Position(4) = 250;

% fun = @(x,xdata)x(1)*log(xdata) + x(2);
% x = lsqcurvefit(fun,[1,.5],xx,yy);
% fun = @(x,xdata)x(1)*(xdata.^x(2));
% x = lsqcurvefit(fun,[1,.5],xx,yy);
% 
%a = plot(logspace(-2,2,1000),x(1)*log(logspace(-2,2,1000)).^x(2));

x = [1.2847,.4493];

a = plot(logspace(-4,3,1000),x(1)*(logspace(-4,3,1000).^x(2)));
a.Color = [0 0 0];
a.LineWidth = 1;


%[r,p] = corrR((x(1)*log(xx) + x(2)).',yy.');
%[r,p] = corrR(x(1)*xx.^x(2).',yy.');

r = corrR(x(1)*xx.^x(2).',yy.');


Rsquared = r^2

SSres = sum((x(1)*xx.^x(2) - yy).^2);
SStot = sum((yy - mean(yy)).^2);

Rsquared = 1 - (SSres/SStot);


a = plot(mean(x40(1:4,:),2),mean(y40(1:4,:),2),'.');
a.MarkerSize = 17;
a.Color = [0 0 1];

a = plot(mean(x40(5:8,:),2),mean(y40(5:8,:),2),'x');
a.MarkerSize = 6;
a.LineWidth = 1.5;
a.Color = [0 0 1];

a = plot(mean(x40(9:12,:),2),mean(y40(9:12,:),2),'s');
a.MarkerSize = 5;
a.LineWidth = 1.5;
a.Color = [0 0 1];

a = plot(mean(x80(1:4,:),2),mean(y80(1:4,:),2),'.');
a.MarkerSize = 17;
a.Color = [1 0 0];

a = plot(mean(x80(5:8,:),2),mean(y80(5:8,:),2),'x');
a.MarkerSize = 6;
a.LineWidth = 1.5;
a.Color = [1 0 0];

a = plot(mean(x80(9:12,:),2),mean(y80(9:12,:),2),'s');
a.MarkerSize = 5;
a.LineWidth = 1.5;
a.Color = [1 0 0];

axis([0 2.5 0 2])
% xticks([0 .2 .4 .6 .8])
text(1.75,.55,strcat('$R^2=',num2str(Rsquared,2),'$'),'Interpreter','latex','FontSize',12);
text(1.75,.30,strcat('$y=',num2str(x(1),2),'x^{',num2str(x(2),2),'}$'),'Interpreter','latex','FontSize',12);
xlabel('summary rate of stretch, RS(mm/s)','Interpreter','latex','FontSize',12);
ylabel('norm. roughness judgment','Interpreter','latex','FontSize',12);
set(gca,'TickLabelInterpreter','latex','FontSize',12);
set(gcf,'color','w');