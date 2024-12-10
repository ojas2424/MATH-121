% MATH 121, Spring 2023
% Author: Mario Bencomo, CSU Fresno State
% Code for Report 2B

% Setting plotting specifications
set(0, 'defaultaxesfontsize',18,'defaultaxeslinewidth',1.2,...
       'defaultlinelinewidth',1.5,'defaultpatchlinewidth',1.0,...
       'defaulttextfontsize',18);
   
%% Problem 1

%% Problem 2
% Curve 1 data
x_c1  = [1 2 5 6 7 8 10 13 17];
f_c1  = [3.0 3.7 3.9 4.2 5.7 6.6 7.1 6.7 4.5];

% Curve 2 data
x_c2  = [17 20 23 24 25 27 27.7];
f_c2  = [4.5 7.0 6.1 5.6 5.8 5.2 4.1];

% Curve 3 data
x_c3  = [27.7 28 29 30];
f_c3  = [4.1 4.3 4.1 3.0];



%% Implementing methods

function s_eval = my_spline_nat(x_nodes,f_vals,x_eval)
% This method implements natural cubic splines.
% Inputs:
%  x_nodes = array storing x nodes
%  f_vals  = array storing f(x) evaluated on x_nodes
%  x_eval  = array storing values of x for which we want our spline to be
%            evaluated on.
% Outputs:
%   s_eval = array storing cubic spline evaluated on x_eval.

h = x_nodes(2:end)-x_nodes(1:end-1);
% Building matrix A
A_sup = [0 h(2:end)];
A_sub = [h(1:end-1) 0];
A_diag = h(2:end)+h(1:end-1);
A_diag = [1 2*A_diag 1];
A = diag(A_sub,-1) + diag(A_diag) + diag(A_sup,1);
% Bulding vector b
D = ( f_vals(2:end)-f_vals(1:end-1) )./h;
b = D(2:end)-D(1:end-1);
b = 6*[0 b 0]';
% Solving for coefficients
M = A\b;

% Evaluating cubic spline on x_eval
s_eval = zeros(size(x_eval));
for k=1:length(x_eval)
    
    x  = x_eval(k);
    % figuring out which subinterval to use
    z = (x <= x_nodes);
    zz = z(1:end-1) + z(2:end);
    i = find(zz==1);
    if isempty(i)
        i = find(x==x_nodes);
    end
    
    x0 = x_nodes(i);
    x1 = x_nodes(i+1);
    y0 = f_vals(i);
    y1 = f_vals(i+1);
    M0 = M(i);
    M1 = M(i+1);

    % Using cubic spline formula
    s_eval(k) = ( (x1-x)^3*M0 + (x-x0)^3*M1 )/(6*h(i));
    s_eval(k) = s_eval(k) - ( (x1-x)*M0 + (x-x0)*M1 )*h(i)/6;
    s_eval(k) = s_eval(k) + ( (x1-x)*y0 + (x-x0)*y1 )/h(i);
end
end

function s_eval = my_spline_clamp(x_nodes,f_vals,df_vals,x_eval)
% This method implements clamped cubic splines.
% Inputs:
%  x_nodes = array storing x nodes
%   f_vals = array storing f(x) evaluated on x_nodes
%  df_vals = array storing f'(x) evaluated at the end points. 
%            In particular, df_vals = [f'(x_0),f'(x_n)].
%   x_eval = array storing values of x for which we want our spline to be
%            evaluated on.
% Outputs:
%   s_eval = array storing cubic spline evaluated on x_eval.

% Building matrix A
A = [];
% Bulding vector b
b = [];
% Solving for coefficients
M = A\b;

% Evaluating cubic spline on x_eval
s_eval = zeros(size(x_eval));
for k=1:length(x_eval)
    
    x  = x_eval(k);
    % figuring out which subinterval to use
    z = (x <= x_nodes);
    zz = z(1:end-1) + z(2:end);
    i = find(zz==1);
    if isempty(i)
        i = find(x==x_nodes);
    end
    
    x0 = x_nodes(i);
    x1 = x_nodes(i+1);
    y0 = f_vals(i);
    y1 = f_vals(i+1);
    M0 = M(i);
    M1 = M(i+1);

    % Using cubic spline formula
    s_eval(k) = ( (x1-x)^3*M0 + (x-x0)^3*M1 )/(6*h(i));
    s_eval(k) = s_eval(k) - ( (x1-x)*M0 + (x-x0)*M1 )*h(i)/6;
    s_eval(k) = s_eval(k) + ( (x1-x)*y0 + (x-x0)*y1 )/h(i);
end
end