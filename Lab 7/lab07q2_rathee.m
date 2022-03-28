clear
clc
format long


fprintf('Solution is %.15f', func(0, 1, 0.1, 0.2))

function val = f1(x,y)
    val = x - (1/y);
end

function val = func(x0, y0, h, target)
    yk = y0 + h*f1(x0,y0);
    yk = method(x0, y0, h, yk);
    if abs(target-x0)>0.001
        val = func(x0+h, yk, h, target);
    else
        val = y0;
    end
end

function val = method(xn, yn, h, yn1km)
    yn1k = yn + (h/2)*(f1(xn,yn) + f1(xn +h, yn1km));
    if abs(yn1k - yn1km)/abs(yn1k)>0.0001
        val = method(xn, yn, h, yn1k);
    else
        val = yn1k;
    end
end
