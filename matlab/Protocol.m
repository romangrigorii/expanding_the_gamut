addpath(genpath('C:\Users\atrox\Desktop\Work\Research\My projects\vibtex'));
addpath(genpath('C:\Users\atrox\Desktop\Work\Research\Code'));
addpath(genpath('C:\Users\atrox\Desktop\Work\Research\My projects\vibtex\code\matlab'));
%%

clear all
 
createstim();
dirr = 'C:\Users\atrox\Desktop\Work\Research\My projects\vibtex\data\subject\';dirr = 'C:\Users\atrox\Desktop\Work\Research\My projects\Finished project\Expanding the gamut of tactile rendering space theough discretized fingerpad actuation\data\subject\';

subj = '24';
if ~isempty(instrfind)
    fclose(instrfind);
end

port = serial('COM5', 'BaudRate', 230400, 'FlowControl', 'hardware');
fopen(port);

fprintf(port,'\n');
v = fscanf(port);

%% experiment 0

expt = exp1;

responses0 = [];

pause(.1)

for t = 1:10
    expt.setlabel.Text = strcat('set number: ',num2str(t),'/10');

    while expt.enter == 0
        if expt.feel_texture ~= 0
            commandlist(port,'c',.0001)
            pause(.1)
            commandlist(port,'f',freqs0(stim0(t,1)));
            commandlist(port,'s',stim0(t,expt.feel_texture+1));
            commandlist(port,'c',amps0(stim0(t,1)));
            
            expt.feel_texture = 0;
        end
        pause(.3);
    end
    
    commandlist(port,'c',.0001)

    if pos0(t) == 2
        expt.feel_1.BackgroundColor = [.5 1 .5]*.96;
    end
    if pos0(t) == 3
        expt.feel_2.BackgroundColor = [.5 1 .5]*.96;
    end
    if pos0(t) == 4
        expt.feel_3.BackgroundColor = [.5 1 .5]*.96;
    end
    pause(1);
    
    expt.enter = 0;
    expt.pick_1.BackgroundColor = [1 1 1]*.96;
    expt.pick_2.BackgroundColor = [1 1 1]*.96;
    expt.pick_3.BackgroundColor = [1 1 1]*.96;
    expt.feel_1.BackgroundColor = [1 1 1]*.96;
    expt.feel_2.BackgroundColor = [1 1 1]*.96;
    expt.feel_3.BackgroundColor = [1 1 1]*.96;
    expt.next_texture.BackgroundColor = [1 1 1]*.96;
    expt.texture_final = 0;
    expt.textures_felt = 0;
    
end

%% experiment 1

expt = exp1;

% responses1 = [];
% textures_felt1 = {};

pause(.1)
T = (1:50).*(stim1(:,1).'==5 + 0);
T = T(T~=0);

for t = 1:50
    expt.setlabel.Text = strcat('set number: ',num2str(t),'/50');
    textures_felt1{t} = [];
    stim1(t,:)
    while expt.enter == 0
        if expt.feel_texture ~= 0
            textures_felt1{t} = [textures_felt1{t},expt.feel_texture];
            commandlist(port,'c',.0001)
            pause(.3)
            commandlist(port,'f',freqs1(stim1(t,1)));
            commandlist(port,'s',stim1(t,expt.feel_texture+1));
            %commandlist(port,'c',amps1(stim1(t,1)));
            if stim1(t,expt.feel_texture+1) == 5
                commandlist(port,'c',amps1(stim1(t,1)));
            else
                commandlist(port,'c',amps1(stim1(t,1)));
            end
            expt.feel_texture = 0;
        end
        pause(.2);
    end
    
    commandlist(port,'c',.0001)
    
    responses1(t) = expt.texture_final;
    expt.enter = 0;
    expt.pick_1.BackgroundColor = [1 1 1]*.96;
    expt.pick_2.BackgroundColor = [1 1 1]*.96;
    expt.pick_3.BackgroundColor = [1 1 1]*.96;
    expt.feel_1.BackgroundColor = [1 1 1]*.96;
    expt.feel_2.BackgroundColor = [1 1 1]*.96;
    expt.feel_3.BackgroundColor = [1 1 1]*.96;
    expt.next_texture.BackgroundColor = [1 1 1]*.96;
    expt.texture_final = 0;
    expt.textures_felt = 0;
    
end

save(strcat(dirr,subj,'\','exp1.mat'),'responses1','textures_felt1','stim1','ord1','pos1','comb1','freqo1','pairs1','freqs1','amps1');

%% experiment 2

expt = exp1;

responses2 = [];
textures_felt2 = {};
pause(.1)

stimtype2 = {'t','t','m'};
freq2 = [40.0001,80.001,40.0001];
amps2 = [.3, .25, .3];

for ss = 1
    commandlist(port,'f',freq2(ss));
    for t = 1:100        
        expt.setlabel.Text = strcat('set number: ',num2str(t),'/100');
        textures_felt2{ss,t} = [];
        while expt.enter == 0
            if expt.feel_texture ~= 0
                textures_felt2{ss,t} = [textures_felt2{ss,t},expt.feel_texture];
                commandlist(port,'c',.0001)
                pause(.3)
                commandlist(port,stimtype2{ss},stim2(t,expt.feel_texture)/10*mul2+.00001);
                commandlist(port,'c',amps2(ss));
                expt.feel_texture = 0;
            end
            pause(.2);
        end
        
        commandlist(port,'c',.0001)
        
        responses2(ss,t) = expt.texture_final
        expt.enter = 0;
        expt.pick_1.BackgroundColor = [1 1 1]*.96;
        expt.pick_2.BackgroundColor = [1 1 1]*.96;
        expt.pick_3.BackgroundColor = [1 1 1]*.96;
        expt.feel_1.BackgroundColor = [1 1 1]*.96;
        expt.feel_2.BackgroundColor = [1 1 1]*.96;
        expt.feel_3.BackgroundColor = [1 1 1]*.96;
        expt.next_texture.BackgroundColor = [1 1 1]*.96;
        expt.texture_final = 0;
        expt.textures_felt = 0;
        
    end
end

save(strcat(dirr,subj,'\','exp2.mat'),'responses2','textures_felt2','stim2','ord2','pos2','freq2','amps2','mul2');


%% experiment 3

expt = exp1;

trials = 25;
stimn = 3;
stimtype3 = {'t','t','m'};
responses3 = [];
textures_felt3 = {};
trial = 1;
P = ones(3,10000);

y = 1/3;
lam = 0;
b = 15;
alikely = zeros(1,3);
alikelya = zeros(trials,3);

for t = 1:trials
    for s = 1:stimn
             
        textures_felt3{t,s} = [];
        expt.setlabel.Text = strcat('set number: ',num2str(trial),'/75');        
        while expt.enter == 0
            if expt.feel_texture ~= 0
                textures_felt3{t,s} = [textures_felt3{t,s},expt.feel_texture];
                commandlist(port,'c',.0001)
                pause(.3)
                commandlist(port,stimtype3{s},arange(stim3(trial,expt.feel_texture))+.00001);
                commandlist(port,'f',freqs3(s));                
                commandlist(port,'c',amps3(s));
                expt.feel_texture = 0;
            end
            pause(.1);
        end
        
        commandlist(port,'c',.0001)
        
        responses3(t,s) = expt.texture_final;
        
        expt.enter = 0;
        expt.pick_1.BackgroundColor = [1 1 1]*.96;
        expt.pick_2.BackgroundColor = [1 1 1]*.96;
        expt.pick_3.BackgroundColor = [1 1 1]*.96;
        expt.feel_1.BackgroundColor = [1 1 1]*.96;
        expt.feel_2.BackgroundColor = [1 1 1]*.96;
        expt.feel_3.BackgroundColor = [1 1 1]*.96;
        expt.next_texture.BackgroundColor = [1 1 1]*.96;
        expt.texture_final = 0;
        expt.textures_felt = 0;
        
        pp = (y+(1-y-lam)./(1+exp(-b/10000*(stim3(trial,pos3(trial))-astims))));
        
        if pos3(trial) == responses3(t,s) 
            P(s,:) = P(s,:).*pp;
        else
            P(s,:) = P(s,:).*(1-pp);
        end
        P(s,:) = P(s,:)/sum(P(s,:));
        
        alikely(s) = round(mean((P(s,:).^2.*astims))/(mean(P(s,:).^2)));
        ps = (y+(1-y-lam)./(1+exp(-b/10000*(astims-alikely(s)))));        
        [~,stim3(trial+3,pos3(trial+3))] = min(abs(.66 - ps));        
        alikelya(t,s) = alikely(s);
        trial = trial + 1;
        %plot(P.')
        pause(.01);
    end
end
           
            
save(strcat(dirr,subj,'\','exp3.mat'),'responses3','P','alikelya','textures_felt3','stim3','pos3','freqs3','amps3');    

%% experiment 4

expt = exp3;
stimtype4 = {'m','y','t'};
responses4 = [];

for t = 1:24
        
        expt.setlabel.Text = strcat('set number: ',num2str(t),'/24');  
    
        while expt.enter == 0
            if expt.textures_felt ~= 0
                commandlist(port,stimtype4{stims4(ord4(t))},arange(delays4(delayo4(ord4(t))))+.00001)
                commandlist(port,'f',freqs4(freqo4(ord4(t))));
                commandlist(port,'c',amps4(freqo4(ord4(t))));
                expt.feel_texture = 0;
            end
            pause(.1);
        end
        
        commandlist(port,'c',.0001)
        
        responses4(t) = expt.total;
        
        expt.textures_felt = 0;
        expt.editfield.Value = '0';
        expt.total = 0;
        expt.enter = 0;
        expt.mul = 1;
        expt.period = 0;
        expt.feel_1.BackgroundColor = [1 1 1]*.96;
        expt.next_texture.BackgroundColor = [1 1 1]*.96;
        
end

save(strcat(dirr,subj,'\','exp4.mat'),'responses4','stims4','freqs4','amps4','delays4','freqo4','delayo4','ord4');    

