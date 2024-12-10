%% Setting plotting specifications
set(0, 'defaultaxesfontsize',18,'defaultaxeslinewidth',1.2,...
       'defaultlinelinewidth',1.0,'defaultpatchlinewidth',1.0,...
       'defaulttextfontsize',18);

MAX_ITER = 100;
ETOL = 1e-10;
FTOL = 1e-20;

%% Demo: Iterative approach to division, i.e., computing 1/z with z>0
z = 6; %sqrt(2);
f = @(x) x*z-1;
a = 0; b = z;
VERBOSE = true;
[r_B,err_B] = my_bisect(a,b,f,MAX_ITER,ETOL,FTOL,VERBOSE);

x0 = 1.5/z;
[r_N,err_N] = iter_div(x0,z,MAX_ITER,ETOL,FTOL,VERBOSE);

% Plotting
figure;
true_ans = 1/z;

semilogy(abs(r_B-true_ans),'b-'); hold on;
semilogy(err_B,'b*','MarkerSize',6);

semilogy(abs(r_N-true_ans),'r-'); hold on;
semilogy(abs(err_N),'r*','MarkerSize',6);

xlabel('iteration count');
legend({'true err, bisection','est err, bisection','true err, Newton','est err, Newton'},'Interpreter','latex');


%% Implementation of methods

function [r,err] = my_bisect(a0,b0,f,MAX_ITER,ETOL,FTOL,VERBOSE)
% function my_bisect(a0,b0,f,MAX_ITER,ETOL,FTOL,VERBOSE)
%
% This is an implementation of the bisection method for solving f(x)=0.
% Inputs:
%         a0 = left side of search interval
%         b0 = right side of search interval
%          f = function for which we want to find the root of
%   MAX_ITER = maximum number of iterations for stopping criterion
%       ETOL = tolerance on error bound
%       FTOL = tolerance on abs(f(r))
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
fr = f(r);

r_hist = r;
err_hist = err;

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

while err>ETOL && count<MAX_ITER && abs(fr)>FTOL

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
        fprintf('%5d %6.5f %6.4e %6.4e\n',[count,r,err,f(r)]);
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

function [r,err] = iter_div(x0,z,MAX_ITER,ETOL,FTOL,VERBOSE)
% function iter_div(x0,z,MAX_ITER,ETOL,FTOL,VERBOSE)
%
% This is an implementation of Newton's method specific to solving for root
% of f(x)=z-1/x, i.e., an iterative approach to division that is division free.
% Inputs:
%         x0 = initial estimate of root
%          z = value for which we want to compute 1/z
%   MAX_ITER = maximum number of iterations for stopping criterion
%       ETOL = tolerance on error bound
%       FTOL = tolerance on abs(f(r))
%    VERBOSE = if true will output and plot intermediate results
% Outputs:
%     r = approximation of root; if VERBOSE=true, then it will contain
%         intermediate approximations too
%   err = b-r, error bound of the root approximation; if VERBOSE=true, then
%         it will contain intermediate errors
count = 0;
err = 1;
r0 = x0;
r_hist = r0;
err_hist = [];

f = @(x) z - 1./x;
f_iter = @(x) x.*(2-z*x);

if VERBOSE
    a0 = -abs(x0);
    b0 = abs(x0);
    x = linspace(a0,b0,101);
    figure;
    plot(x,f(x),'-b'); hold on;
    plot([a0,b0],[0,0],'--k');
    plot(x0,f(x0),'ro');
    xlabel('x');
    
    fprintf('\nFrom iter_div')
    fprintf('\ncount root    error est  f(r)\n');
    fprintf('%5d %6.5f %6.4e %6.4e\n',[count,r0,err,f(r0)]);
    pause
end

while abs(err)>ETOL && count<MAX_ITER && abs(f(r0))>FTOL
    r = f_iter(r0);
    err = r-r0;
    count = count+1;
    r0 = r;

    if VERBOSE
        plot(r0,f(r0),'ro');
        fprintf('%5d %6.5f %6.4e %6.4e\n',[count,r0,err,f(r0)]);
        r_hist = [r_hist r0];
        err_hist = [err_hist err];
        pause
    end
end

if VERBOSE
    r = r_hist;
    err = err_hist;
end
end

