function out = countxy(prox,x)
    out = 0;
    for i = 1:length(x)
        out = out + sum(x(i) ~= x(prox(i,:) == 1));
    end
end