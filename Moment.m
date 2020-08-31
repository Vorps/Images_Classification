function [result] = Moment(I, param)
    [m,n] = size(I);
    x = 1:1:n;
    y = 1:1:m;
    norm = 1;
    while 1 % Simule un switch style Java/C/C++/...
        switch param(3)
            case 2
                norm = Moment(I, [0, 0, 0])^((param(1)+param(2))/2+1);
                param(3) = 1;
            case 1
                x = x - Moment(I, [1, 0, 0])/Moment(I, [0, 0, 0]);
                y = y - Moment(I, [0, 1, 0])/Moment(I, [0, 0, 0]);
                break;
            otherwise
                break;
        end
    end
    result = (y.^param(2))*I*(x'.^param(1))/norm;
end