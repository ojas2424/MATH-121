% MATH 121, Spring 2023
% Author: Mario Bencomo, CSU Fresno State
% Demo code for L6: Bisection method

set(0, 'defaultaxesfontsize',18,'defaultaxeslinewidth',1.2,...
       'defaultlinelinewidth',1.0,'defaultpatchlinewidth',1.0,...
       'defaulttextfontsize',18);

MAX_ITER = 100;
ETOL = 1e-10;
FTOL = 1e-10;

%% Demo: Iterative approach to division, i.e., computing 1/z with z>0
z = 6;%sqrt(2);
f = @(x) x*z-1;
a = 0; b = z;

VERBOSE = true;
[r_B,err_B] = my_bisect(a,b,f,MAX_ITER,ETOL,FTOL,VERBOSE);

figure;
semilogy(abs(r_B-r_B(end)),'-ob'); hold on;
semilogy(err_B,'--b');

title('Error analysis of iterative division');
xlabel('iteration count');
legend({'true err','est err'},'Interpreter','latex');


%% Implementation of methods

function [r,err] = my_bisect(a0,b0,f,MAX_ITER,ETOL,FTOL,VERBOSE)
% function my_bisect(a0,b0,f,MAX_ITER,TOL,VERBOSE)
%
% This is an implementation of the bisection method for solving f(x)=0.
% Inputs:
%         a0 = left side of search interval
%         b0 = right side of search interval
%          f = function for which we want to find the root of
%   MAX_ITER = maximum number of iterations for stopping criterion
%       ETOL = tolerance on error bound
%       FTOL = tolerance in abs(f(r))
%    VERBOSE = if true will output and plot intermediate results
% Outputs:
%     r = approximation of root; if VERBOSE=true, then it will contain
%         intermediate approximations too
%   err = b-r, error bound of the root approximation; if VERBOSE=true, then
%         it will contain intermediate errors

if a0 >= b0
    disp('Error(my_bisection): a0<b0 is not true! Exiting!')
    return
end

a = a0;
b = b0;
fa = f(a);
fb = f(b);

if sign(fa)*sign(fb) > 0
    disp('Error(my_bisection): f(a0) and f(b0) are of the same sign! Exiting!')
    return
end

r = (a+b)/2;
count = 0;
err = b-r;

r_hist = r;
err_hist = err;
fr = f(r);

if VERBOSE
    x = linspace(a0,b0,101);
    figure;
    plot(x,f(x),'-b'); hold on;
    plot([a0,b0],[0,0],'--k');
    plot(r,f(r),'ro');
    xlabel('x');
    
    fprintf('\nFrom my_bisection')
    fprintf('\ncount root    error est  f(r)\n');
    fprintf('%5d %6.5f %6.4e %6.4e\n',[count,r,err,fr]);
    pause
end

while abs(err)>ETOL && count<MAX_ITER && abs(fr)>FTOL

    if sign(fb)*sign(fr)<=0
        a = r;
        fa = fr;
    else
        b = r;
        fb = fr;
    end
    count = count+1;
    r = (a+b)/2;
    err = b-r;
    fr = f(r);

    if VERBOSE
        plot(r,f(r),'ro');
        fprintf('%5d %6.5f %6.4e %6.4e\n',[count,r,err,fr]);
        r_hist = [r_hist r];
        err_hist = [err_hist err];
        pause
    end
end

if count==MAX_ITER
    disp('Warning(my_bisection): terminated after max number of iterations.')
end

if VERBOSE
    r = r_hist;
    err = err_hist;
end
end