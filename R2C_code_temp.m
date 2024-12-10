% MATH 121, Spring 2023
% Author: Mario Bencomo, CSU Fresno State
% Code for Report 2C

% Setting plotting specifications
set(0, 'defaultaxesfontsize',18,'defaultaxeslinewidth',1.2,...
       'defaultlinelinewidth',1.5,'defaultpatchlinewidth',1.0,...
       'defaulttextfontsize',18);
   
%% Problem 1

% Cubic polynomial interpolation

% Cubic near-minimax approximation

% Cubic LS approximation

% Plotting


%% Implementing methods

function L = Lagrange_poly(x_nodes,k,x_eval)
% You may copy code from Report 2A

end

function P = L_interp(x_nodes,f_vals,x_eval)
% You may copy code from Report 2A

end

function M = my_near_minimax(N,f,x_eval)
% This function implements the polynomial near-minimax approximation
% of order N of f(x) and evaluates said polynomial over x_eval.
% Inputs:
%       N = order of polynomial near-minimax approximation
%       f = anonymous function to be approximated
%  x_eval = Array of x points where we want to evaluate the polynomial 
%           approximation. It is assumed that the interval [a,b] over which 
%           we are approximating f(x) is given by x_eval, i.e.,
%               a = x_eval(1) and b = x_eval(end)
% Outputs:
%         M = Array containing near-minimax polynomial evaluated at x_eval.

% computing Chebyshev roots on [-1,1]

% Mapping nodes onto [a,b]


end
