%% run psychometrix sim

p = ones(1,10000);
y = 1/3;
lam = 0;
beta = 15;
a = 1001;
astims = 1:10000;
x = 5001;
actp = (y+(1-y-lam)./(1+exp(-beta*2/10000*(astims - a))));
belp = (y+(1-y-lam)./(1+exp(-beta/10000*(astims - x))));

alikelya = zeros(1000,100);

for t = 1:1000
    p = ones(1,10000);
    x = 5001;
    flag = 0;

    for i = 1:100
        r = rand(1);
        if r<actp(x)
            p = p.*belp;
        else
            p = p.*(1-belp);
        end
        [~,alikely] = max(p);
        alikely = round(mean((p.^2).*astims)/mean(p.^2));
        belp = (y+(1-y-lam)./(1+exp(-beta/1/10000*(x-astims))));
        belpi = (y+(1-y-lam)./(1+exp(-beta/1/10000*(astims-alikely))));
        [~,x] = min(abs(.75 - belpi));
        
        alikelya(t,i) = alikely;
        %plot(alikelya);
        %pause(.1);
    end
%     [~,alikely] = max(p);
%     alikelya(t,i) = alikely;
    t
end


%% testing effect of slope

p = ones(1,10000);
y = 1/3;
lam = 0;
beta = 15;
a = 1001;
astims = 1:10000;
x = 5001;
actp = (y+(1-y-lam)./(1+exp(-beta/10000*(astims - a))));
belp = (y+(1-y-lam)./(1+exp(-beta/10000*(astims - x))));
bstims = logspace(-1,1,10);
alikelya = zeros(length(bstims),1000,100);

for b = 1:length(bstims)
    for t = 1:1000
        p = ones(1,10000);
        x = 5001;
        flag = 0;
        
        for i = 1:25
            r = rand(1);
            if r<actp(x)
                p = p.*belp;
            else
                p = p.*(1-belp);
            end
            [~,alikely] = max(p);
            alikely = round(mean((p.^2).*astims)/mean(p.^2));
            belp = (y+(1-y-lam)./(1+exp(-beta*bstims(b)/10000*(alikely-astims))));
            belpi = (y+(1-y-lam)./(1+exp(-beta*bstims(b)/10000*(astims-alikely))));
            [~,x] = min(abs(2/3 - belpi));
            
            alikelya(b,t,i) = alikely;
            %plot(alikelya);
            %pause(.1);
        end
        %t
    end
    b
end

%% computing both beta and alpha
trials = 100;
its = 100;
p = ones(1,10000);
y = 1/3;
lam = 0;
beta = 15;
a = 1001;
astims = 1:10000;
x = 5001;
bstims = logspace(0,2,200).';
alikelya = zeros(its,trials);
blikelya = zeros(its,trials);
actp = (y+(1-y-lam)./(1+exp(-beta/10000*(astims - a))));
belp = (y+(1-y-lam)./(1+exp(-bstims/10000*(astims - x))));

for t = 1:its
    p = ones(200,10000);
    x = 5001;
    flag = 0;
    
    for i = 1:trials
        r = rand(1);
        if r<actp(x)
            p = p.*belp;
        else
            p = p.*(1-belp);
        end
        [~,alikely] = max(sum(p));
        [~,blikely] = max(sum(p.'));
        %alikely = round(mean(mean((p.^2).*astims)./mean(p.^2)));
        %blikely = round(mean(mean((p.'.^2).*bstims.')./mean(p.'.^2)));
        
        belp = (y+(1-y-lam)./(1+exp(-bstims/10000*(alikely-astims))));
        belpi = (y+(1-y-lam)./(1+exp(-blikely/10000*(astims-alikely))));
        [~,x] = min(abs(2/3 - prod(belpi)));
        
        alikelya(t,i) = alikely;
        blikelya(t,i) = blikely;
%         close all
        plot(blikelya(t,:));
        plot(alikelya(t,:));
        pause(.1);
    end
    t
end
