clc;
clear all;
l1 = -1;
l2 = 0;
l3 = 1;
A = 1/2 * [l2+l3 l3-l1 l2-l1;
           l3-l2 l1+l3 l1-l2;
           l2-l3 l1-l3 l1+l2];
y0 = [1;1;1];

f = @(y) A*y;
k1 = @(y,h) h*f(y);
k2 = @(y,h) h*f(y+k1(y,h)/2);
k3 = @(y,h) h*f(y+k2(y,h)/2);
k4 = @(y,h) h*f(y+k3(y,h));

N = [10 20 40 80];
for n = N
    fprintf("For n = %d\n",n);
    h = 1/n;
    y = y0;
    for x = 0:h:1
        y = y + h*f(y);
    end
    
    yrk = y0;
    for x = 0:h:1
        yrk = yrk+1/6*(k1(yrk,h)+2*k2(yrk,h)+k4(yrk,h)+2*k3(yrk,h));
    end

    ysoln = soln(l1,l2,l3,x);
    fprintf("  Y(EM)           Error(EM)       Y(RK4)          Error(RK4)\n")
    for i = 1:3
        fprintf("%10f %15f %15f %15f\n",y(i),abs(y(i)-ysoln(i)),yrk(i),abs(yrk(i)-ysoln(i)));
    end
end

function y = soln(l1,l2,l3,x)
    y(1) = -exp(l1*x) + exp(l2*x) + exp(l3*x);
    y(2) = exp(l1*x) - exp(l2*x) + exp(l3*x);
    y(3) = exp(l1*x) + exp(l2*x) - exp(l3*x);
end
