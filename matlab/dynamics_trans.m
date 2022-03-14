dirr = 'C:\Users\atrox\Desktop\Work\Research\My projects\Finished project\Expanding the gamut of tactile rendering space through discretized fingerpad actuation\data\transducer_dyn2\';
dur = 2;
sr = 100000;
t = linspace(0,dur,sr*dur);

%% set up sampling
st = daq.createSession('ni');
st.Rate = sr;
ch1 = addAnalogInputChannel(st,'Dev1','ai9','Voltage');
ch1.InputType = 'SingleEnded'; %% lateral force
st.DurationInSeconds = dur;
ch2 = addAnalogInputChannel(st,'Dev1','ai1','Voltage');
ch2.InputType = 'SingleEnded'; %% lateral force
ch3 = addAnalogOutputChannel(st,'Dev1','ao1','Voltage');

%% take data
spkr = 14;
freqs = [5,10,20,40,80];
amps = linspace(.5,2.5,7);
[b2,a2] = butter(1,2*2000/sr,'low');
[b1,a1] = butter(1,2*1/sr,'high');
vel = 100;
K = 2.7;

%% take data 
for f = 1:length(freqs)
    for a = 1:length(amps)
        sig = amps(a)*(sin(2*pi*freqs(f)*t));
        sig(end) = 0;
        queueOutputData(st,sig.');
        out = startForeground(st);
        save(strcat(dirr,num2str(spkr),'\',num2str(f),'_',num2str(a),'.mat'),'sig','out');
        pause(.1);
    end
end
    
%% fit

A1 = zeros(14,length(amps),length(freqs));
P1 = zeros(14,length(amps),length(freqs));
A2 = zeros(14,length(amps),length(freqs));
P2 = zeros(14,length(amps),length(freqs));
R = zeros(14,length(amps),length(freqs));

for s = 1:14
    for a = 1:length(amps)
        for f = 1:length(freqs)
            load(strcat(dirr,num2str(s),'\',num2str(f),'_',num2str(a),'.mat'));
            out = out - mean(out);
            tt = (sr+1):(2*sr);
            vib = out(tt,1)*vel/4/1000;
            sig = amps(a)*(sin(2*pi*freqs(f)*t));
            cur = out(tt,2);
            cura = mean(abs(cur-mean(cur)))*pi/2;
            
            fun = @(x,xdata)x(1)*sin(2*pi*xdata*freqs(f) + x(2)) + x(3)*sin(2*pi*xdata*freqs(f) + x(2)).^3;
            x = lsqcurvefit(fun,[1,1,1],t(tt),vib.',[0 -pi 0],[100 pi 100],optimset('Display','off'));
            
            R(s,a,f,1) = corr((x(1)*sin(2*pi*t(tt)*freqs(f) + x(2)) + x(3)*sin(2*pi*t(tt)*freqs(f) + x(2)).^3).',vib).^2;
            
            
            ss1 = sin(2*pi*freqs(f)*t(tt));
            cc1 = cos(2*pi*freqs(f)*t(tt));
            s1 = 2*mean(ss1.*vib.');
            c1 = 2*mean(cc1.*vib.');
            a1 = sqrt(c1.^2 + s1.^2);
            p1 = atan2(s1,c1);
            
            vibl = ss1*s1 + cc1*c1 - vib.';
            ss2 = sin(2*pi*freqs(f)*3*t(tt));
            cc2 = cos(2*pi*freqs(f)*3*t(tt));
            s2 = 2*mean(ss2.*vibl);
            c2 = 2*mean(cc2.*vibl);
            a2 = sqrt(c2.^2 + s2.^2);
            p2 = atan2(s2,c2);
            
            A1(s,a,f) = a1/(cura*K);
            P1(s,a,f) = p1;
            A2(s,a,f) = x(3)/(cura*K);
            P2(s,a,f) = x(2);
            
            R(s,a,f,2) = corr((s1.*ss1 + c1.*cc1).',vib).^2;

        end
    end
    s
end

save(strcat(dirr,'summary.mat'),'R','A1','P1','A2','P2');

%%
a = figure;
a.Position(3) = 500;
a.Position(4) = 200;

subplot(1,2,1);
hold on

freqs = [5,10,20,40,80];
s = freqs.*2*pi*sqrt(-1);
T = 1 + .0001*s + 1000./s;
a = plot(freqs,abs(T),'--');
a.Color = [1,0,0];

a.LineWidth = 1;
for i = 1:14
    a = plot(freqs,squeeze(1./(squeeze(A1(i,5,:)).')));
    a.Color = [0 0 0];    
end

set(gca,'Yscale','log')
set(gca,'Xscale','log')
set(gcf,'color','w');
axis([5 80 1 400])

ylabel('$|Z|$ (Ns/m)','Interpreter','latex','FontSize',11);
xlabel('frequency (Hz)','Interpreter','latex','FontSize',11);
set(gca,'TickLabelInterpreter','latex','FontSize',11);
xticks(freqs)
yticks([1 10 100])

subplot(1,2,2)
hold on
for i = 1:14
    if mean((squeeze(P1(i,5,:)).'+pi/2)*180/pi)>0        
        a = plot(freqs,(squeeze(P1(i,5,:)).'+pi/2)*180/pi - 180)
    else
        a = plot(freqs,(squeeze(P1(i,5,:)).'+pi/2)*180/pi)
    end
    a.Color = [0 0 0];
end
set(gca,'Xscale','log')
set(gcf,'color','w');


a = plot(freqs,angle(T)*180/pi,'--');
a.Color = [1,0,0];
a.LineWidth = 1;

axis([5 80 -90 0])

ylabel('$\angle Z$ (degrees)','Interpreter','latex','FontSize',11);
xlabel('frequency (Hz)','Interpreter','latex','FontSize',11);
xticks(freqs)
set(gca,'TickLabelInterpreter','latex','FontSize',11);
yticks([-90 -60 -30 0])

%%
a = figure;
a.Position(3) = 600;
a.Position(4) = 300;

freqs = [5,10,20,40,80];
[b2,a2] = butter(1,2*1000/sr,'low');
a = [7,7,7,7,7];
lims = [6,10,17,27,39];
dirr = 'C:\Users\atrox\Desktop\Work\Research\My projects\Finished project\Expanding the gamut of tactile rendering space theough discretized fingerpad actuation\data\transducer_dyn2\';

xt = [[0 .5 1];[0 .25 .5];[0 .1 .2];[0 .05 .1];[0 .025 .05]];

for f = 1:5
    viba = [];
    subplot(2,3,f)
    hold on
    for s = 1:14
        load(strcat(dirr,num2str(s),'\',num2str(f),'_',num2str(a(f)),'.mat'));
        out = out - mean(out);
        tt = (sr+1):(2*sr);
        vib = filtfilt(b2,a2,out(tt,1)*vel/4/1000);
        if vib(1)<0
            vib = -vib;
        end
        
        viba(s) = mean(abs(vib))*pi/2*1.15;
        
        cur = out(tt,2);
        cura = mean(abs(cur-mean(cur)))*pi/2;
        g = plot(t(1:sr),vib*1000);
        g.Color = [.8 .8 .8];
    end
    
    xticks(xt(f,:));
    sig = mean(viba)*sin(2*pi*freqs(f)*t(tt) - mean(squeeze(P1(:,a(f),f))));
    g = plot(t(1:sr),sig*1000,'--');
    g.Color = [1 0 0];   
    g.LineWidth = 1.2;
    
    axis([0 5./freqs(f) -lims(f) lims(f)])

    ylabel('pin velocity (mm/s)','Interpreter','latex','FontSize',11);
    xlabel('time (s)','Interpreter','latex','FontSize',11);
    set(gca,'TickLabelInterpreter','latex','FontSize',10);
    %title(strcat('frequency =',num2str(freqs(f)),' Hz'));
end
set(gcf,'color','w');
    
