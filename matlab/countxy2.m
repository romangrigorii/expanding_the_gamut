function out = countxy2(A,prox,x)
    out = 0;
    for i = 1:length(x)
        out = out + sum(A(i) + A(x(i) ~= x(prox(i,:) == 1)));
    end
end