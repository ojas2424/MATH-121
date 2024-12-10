% MATH 121, Spring 2023
% Author: Mario Bencomo, CSU Fresno State
% Demo code for L9, fixed point iteration

set(0, 'defaultaxesfontsize',18,'defaultaxeslinewidth',1.2,...
       'defaultlinelinewidth',1.0,'defaultpatchlinewidth',1.0,...
       'defaulttextfontsize',18);

MAX_ITER = 15;
TOL = 1e-10;
VERBOSE = true;

%% Demo
x0 = 2.5;

g1 = @(x) 5 + x - x.^2;
g2 = @(x) 5./x;
g3 = @(x) 1 + x - x.^2/5;
g4 = @(x) (x + 5./x)/2;

p1 = my_fixedpoint(x0,g1,MAX_ITER,VERBOSE);
p2 = my_fixedpoint(x0,g2,MAX_ITER,VERBOSE);
p3 = my_fixedpoint(x0,g3,MAX_ITER,VERBOSE);
p4 = my_fixedpoint(x0,g4,MAX_ITER,VERBOSE);

true_ans = sqrt(5);
figure;
semilogy(abs(true_ans-p1),'b-o'); hold on;
semilogy(abs(true_ans-p2),'r-o');
semilogy(abs(true_ans-p3),'k-o');
semilogy(abs(true_ans-p4),'m--x');

xlabel('iteration count');
ylabel('$|\alpha-x_n|$','Interpreter','latex');
legend({'g1','g2','g3','g4'});


%% Implementation of generic fixed point iteration
function [p] = my_fixedpoint(x0,g,MAX_ITER,VERBOSE)

count = 0;
p = x0;
p_hist = x0;

while count < MAX_ITER
    count = count +1;
    p = g(p);
    if VERBOSE
        p_hist = [p_hist p];
    end
end

if VERBOSE
    p = p_hist;
end
end
