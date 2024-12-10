% MATH 121, Spring 2023
% Author: Mario Bencomo, CSU Fresno State
% Lesson 15, demo on Lagrange interpolation
% Code based on "Elementary Numerical Analysis", 3rd ed., Atkinson & Hans.

%% Interpolating f(x)=sin(x) over [-pi/2,pi/2]
a = -pi/2;
b = pi/2;
N = 10;

figure;
for n=1:N
    x_nodes = linspace(a,b,n+1);
    f_values = sin(x_nodes);
    divdif_f = divdif(x_nodes,f_values);
    
    x_plot = linspace(a,b,1001);
    f_plot = sin(x_plot);
    p_plot = L_interp(x_nodes,divdif_f,x_plot);
    
    subplot(1,2,1);
    plot(x_plot,f_plot,'b-',...
         x_plot,p_plot,'r--',...
         x_nodes,f_values,'ro',...
         'LineWidth',2,'MarkerSize',12);
  
    legend({'$f(x)$','$P_n(x)$','interpolation points'},...
            'Interpreter','latex','FontSize',20,'Location','NorthWest');
    xlabel('$x$','Interpreter','latex');
    ylim([min(f_plot),max(f_plot)])
    set(gca,'fontsize',20);
    
    subplot(1,2,2);
    plot(x_plot,abs(f_plot-p_plot),'k-','LineWidth',2);
    xlabel('$x$','Interpreter','latex');
    ylabel('$|f(x)-P_n(x)|$','Interpreter','latex');
    set(gca,'fontsize',20);
    pause;
end      

%% Runge's phenomenon example, using equidistant points
a = -5;
b = 5;
N = 10;

figure;
for n=1:N
    x_nodes = linspace(a,b,n+1);
    f_values = 1./(1+x_nodes.^2);
    divdif_f = divdif(x_nodes,f_values);
    
    x_plot = linspace(a,b,1001);
    f_plot = 1./(1+x_plot.^2);
    p_plot = L_interp(x_nodes,divdif_f,x_plot);
    
    subplot(1,2,1);
    plot(x_plot,f_plot,'b-',...
         x_plot,p_plot,'r--',...
         x_nodes,f_values,'ro',...
         'LineWidth',2,'MarkerSize',12);
  
    legend({'$f(x)$','$P_n(x)$','interpolation points'},...
            'Interpreter','latex','FontSize',20,'Location','NorthWest');
    xlabel('$x$','Interpreter','latex');
    ylim([-1,2])
    set(gca,'fontsize',20);
    
    subplot(1,2,2);
    plot(x_plot,abs(f_plot-p_plot),'k-','LineWidth',2);
    xlabel('$x$','Interpreter','latex');
    ylabel('$|f(x)-P_n(x)|$','Interpreter','latex');
    set(gca,'fontsize',20);
    
    title('With equidistant points')
    pause;
end    

%% Runge's example with Chebyshev nodes
figure;
for n=1:N
    x_nodes = 0.5*(a+b) + 0.5*(b-a)*cos((2*(1:n+1)-1)/(2*(n+1))*pi);
    f_values = 1./(1+x_nodes.^2);
    divdif_f = divdif(x_nodes,f_values);
    
    x_plot = linspace(a,b,1001);
    f_plot = 1./(1+x_plot.^2);
    p_plot = L_interp(x_nodes,divdif_f,x_plot);
    
    subplot(1,2,1);
    plot(x_plot,f_plot,'b-',...
         x_plot,p_plot,'r--',...
         x_nodes,f_values,'ro',...
         'LineWidth',2,'MarkerSize',12);
  
    legend({'$f(x)$','$P_n(x)$','interpolation points'},...
            'Interpreter','latex','FontSize',20,'Location','NorthWest');
    xlabel('$x$','Interpreter','latex');
    ylim([-1,2])
    set(gca,'fontsize',20);
    
    subplot(1,2,2);
    plot(x_plot,abs(f_plot-p_plot),'k-','LineWidth',2);
    xlabel('$x$','Interpreter','latex');
    ylabel('$|f(x)-P_n(x)|$','Interpreter','latex');
    set(gca,'fontsize',20);
    
    title('With Chebyshev points')
    pause;
end  

%% Implementing methods

function divdif_f = divdif(t_nodes,f_values)
% This function calculates the divided differences of the function values 
% given in the vector f_values, which are the values of some function f(t) 
% at nodes given in t_nodes. On exit,
%   divdif_f(i) = f[t_1,...,t_i], i=1,...,m
% with m the length of t_nodes.

divdif_f = f_values;
m = length(t_nodes);
for i=2:m
    for j=m:-1:i
        divdif_f(j) = ( divdif_f(j)-divdif_f(j-1) )...
                            /( t_nodes(j)-t_nodes(j-i+1) );
    end
end
end

function p_eval = L_interp(x_nodes,divdif_y,x_eval)
% This function calculates the Newton divided difference form of the
% interpolation polynomial of degree m-1, where the nodes are given in
% x_nodes, m is the length of x_nodes, and the divided differences are
% given in divdif_y. The points at which the interpolation is to be carried
% out are given by x_eval.

m = length(x_nodes);
p_eval = divdif_y(m)*ones(size(x_eval));
for i=m-1:-1:1
    p_eval = divdif_y(i) + (x_eval - x_nodes(i)).*p_eval;
end

end

        