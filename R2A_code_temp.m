% MATH 121, Spring 2023
% Author: Mario Bencomo, CSU Fresno State
% Code for Report 2A

%% Setting plotting specifications
set(0, 'defaultaxesfontsize',18,'defaultaxeslinewidth',1.2,...
       'defaultlinelinewidth',1.0,'defaultpatchlinewidth',1.0,...
       'defaulttextfontsize',18);

%% Problem 1: f(x)=x^4 over [0,3]




%% Implementing methods

function P = Taylor_poly(xc,dfs_vals,x_eval)
% This function implements the Taylor polynomial of order N=length(dfs_vals)-1 
% and evaluates said polynomial over x_eval.
% Inputs:
%        xc = Centering x point of Taylor polynomial.
%  dfs_vals = Array of derivatives fo f(x) evaluated at xc. 
%             In particular, dfs_vals(n) = (n-1)th of f evaluated at xc.
%             Note, length(dfs_vals)=N+1.
%    x_eval = Array of x points where we want to evaluate the Taylor polynomial.
% Outputs:
%         P = Array containing Taylor polynomial evaluated at x_eval.


end

function L = Lagrange_poly(x_nodes,k,x_eval)
% This function implements the kth Lagrange basis interpolation polynomial
% of order N=length(x_nodes)-1 and evaluates said polynomial over x_eval.
% Inputs:
%   x_nodes = Array interpolation nodes.
%         k = Index for kth Lagrange polynomial.
%    x_eval = Array of x points where we want to evaluate the Lagrange polynomial.
% Outputs:
%         P = Array containing Lagrange polynomial evaluated at x_eval.

end

function P = L_interp(x_nodes,f_vals,x_eval)
% This function implements the Lagrange formula for polynomial interpolation
% of order N=length(x_nodes)-1 and evaluates said polynomial over x_eval.
% Inputs:
%   x_nodes = Array interpolation nodes.
%    f_vals = Array of values of f(x) evaluated at x_nodes.
%    x_eval = Array of x points where we want to evaluate the Lagrange polynomial.
% Outputs:
%         P = Array containing Lagrange polynomial evaluated at x_eval.
    

end

function H = H3_interp(x_nodes,f_vals,df_vals,x_eval)
% This function implements cubic Hermite interpolation, evaluating the
% resulting cubic polynomial over x_eval.
% Inputs:
%   x_nodes = Array interpolation nodes.
%    f_vals = Array of values of f(x) evaluated at x_nodes.
%   df_vals = Array of values of f'(x) evaluated at x_nodes.
%    x_eval = Array of x points where we want to evaluate the Lagrange polynomial.
% Outputs:
%         H = Array containing cubic Hermite polynomial evaluated at x_eval.
    

end    