% MATH 121, Spring 2023
% Author: Mario Bencomo, CSU Fresno State
% Demo code for Lesson 21, near-minimax approximations

% Setting plotting specifications
set(0, 'defaultaxesfontsize',18,'defaultaxeslinewidth',1.2,...
       'defaultlinelinewidth',1.5,'defaultpatchlinewidth',1.0,...
       'defaulttextfontsize',18);

x = linspace(-1,1,101);
f = exp(x);

% Taylor expansions centered at xc=0
T1 = 1+x;
T3 = 1 + x + x.^2/2 + x.^3/6;


% Minimax polynomial approximations
m1 = 1.2643 + 1.1752*x;
m3 = 0.994579 + 0.995668*x + 0.542973*x.^2 + 0.179533*x.^3;

% Near-minimax approximations
x0 = cos(pi/4);
x1 = cos(pi*3/4);
c1 = exp(x0)*(x-x1)/(x0-x1) + exp(x1)*(x-x0)/(x1-x0);

x0 = cos(pi/8);
x1 = cos(3*pi/8);
x2 = cos(5*pi/8);
x3 = cos(7*pi/8);
c3 = exp(x0)*(x-x1).*(x-x2).*(x-x3)/((x0-x1)*(x0-x2)*(x0-x3)) + ...
     exp(x1)*(x-x0).*(x-x2).*(x-x3)/((x1-x0)*(x1-x2)*(x1-x3)) + ...
     exp(x2)*(x-x0).*(x-x1).*(x-x3)/((x2-x0)*(x2-x1)*(x2-x3)) + ...
     exp(x3)*(x-x0).*(x-x1).*(x-x2)/((x3-x0)*(x3-x1)*(x3-x2));

figure;
plot(x,f,'-g'); hold on;
plot(x,T1,'-k');
plot(x,m1,'--b');
plot(x,c1,'--r')


legend({'$f(x)=e^x$','$T_1(x)$','$m_1(x)$','$c_1(x)$'},'Interpreter','latex');
xlabel('x');

figure;
plot(x,abs(f-T1),'-k'); hold on;
plot(x,abs(f-m1),'--b');
plot(x,abs(f-c1),'--r');
legend({'$T_1(x)$','$m_1(x)$','$c_1(x)$'},'Interpreter','latex');
xlabel('x');

figure;
plot(x,abs(f-T3),'-k'); hold on;
plot(x,abs(f-m3),'--b');
plot(x,abs(f-c3),'--r');
legend({'$T_3(x)$','$m_3(x)$','$c_3(x)$'},'Interpreter','latex');
xlabel('x');


