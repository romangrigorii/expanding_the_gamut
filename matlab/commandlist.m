function out = commandlist(port,comm,val)
switch comm
    case 'c'
        fprintf(port,'c');
        v = fscanf(port);
        fprintf(port,val);
        v = fscanf(port);
    case 'f'
        fprintf(port,'f');
        v = fscanf(port);
        fprintf(port,val);
        v = fscanf(port);
    case 's'
        switch val
            case 1
                fprintf(port,'z');
                v = fscanf(port);
            case 2
                fprintf(port,'n');
                v = fscanf(port); 
            case 3 
                fprintf(port,'e');
                v = fscanf(port);
            case 4
                fprintf(port,'r');
                v = fscanf(port);
            case 5
                fprintf(port,'k');
                v = fscanf(port);
            case 6
                fprintf(port,'l');
                v = fscanf(port);
        end
    case 'm'
        fprintf(port,'m');
        v = fscanf(port);
        fprintf(port,val);
        v = fscanf(port);
    case 'y'
        fprintf(port,'y');
        v = fscanf(port);
        fprintf(port,val);
        v = fscanf(port);
    case 't'
        fprintf(port,'t');
        v = fscanf(port);
        fprintf(port,val);
        v = fscanf(port);
end
end