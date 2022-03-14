function out = psyfun(x,g,l,b,a)
out = g + (1-g-l)./(1+exp(b*(a-x)));
end