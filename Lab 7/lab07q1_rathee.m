clear
clc
format long


y0 = [1;1;1];


B = ['    EM     ', '              RK4    ', '            Error(EM)    ', '        Error(RK4)'];

t1 = [euler(0, y0, 1/10, 1), fork(0, y0, 1/10, 1), abs(exact(1)- euler(0, y0, 1/10, 1)), abs(exact(1)- fork(0, y0, 1/10, 1))];
t2 = [euler(0, y0, 1/20, 1), fork(0, y0, 1/20, 1), abs(exact(1)- euler(0, y0, 1/20, 1)), abs(exact(1)- fork(0, y0, 1/20, 1))];
t3 = [euler(0, y0, 1/40, 1), fork(0, y0, 1/40, 1), abs(exact(1)- euler(0, y0, 1/40, 1)), abs(exact(1)- fork(0, y0, 1/40, 1))];
t4 = [euler(0, y0, 1/80, 1), fork(0, y0, 1/80, 1), abs(exact(1)- euler(0, y0, 1/80, 1)), abs(exact(1)- fork(0, y0, 1/80, 1))];

disp(B);
disp(t1);
disp(t2);
disp(t3);
disp(t4);

% disp(exact(1));

function val = f1(y)
    lm1=-1;
    lm2=0;
    lm3=1;
    A = [lm2+lm3 ,lm3-lm1 ,lm2-lm1;
         lm3-lm2 ,lm1+lm3, lm1-lm2;
         lm2-lm3 ,lm1-lm3, lm1+lm3];
    A = A*(1/2);
    val = A*y;
end
function val = exact(x)
    lm1=-1;
    lm2=0;
    lm3=1;
    y = [-exp(lm1*x)+exp(lm2*x)+exp(lm3*x);
          exp(lm1*x)-exp(lm2*x)+exp(lm3*x);
          exp(lm1*x)+exp(lm2*x)-exp(lm3*x)];
    val = y;
end

function val = euler(x, y, h, target)
    k = y + h*f1(y);
    if abs(target-x)>0.001
        val = euler(x+h, k, h, target);
    else
        val = y;
    end
end
function val = fork(x, y, h, target)
    k1 = h*f1(y);
    k2 = h*f1(y+k1/2);
    k3 = h*f1(y+k2/2);
    k4 = h*f1( y+k3);
    k = y + (1/6 *(k1+ 2*k2 + 2*k3 + k4));
    if abs(target - x) >0.001
        val = fork(x+h, k, h, target);
    else
        val = y;
    end
end