% MATH 121, Spring 2023
% Author: Mario Bencomo, CSU Fresno State
% Demo code for Lesson 21, best approximation problem

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

figure;
plot(x,f,'-b'); hold on;
plot(x,T1,'-k');
plot(x,m1,'--k');
plot(x,T3,'-r');
plot(x,m3,'--r');

legend({'$f(x)=e^x$','$T_1(x)$','$m_1(x)$','$T_3(x)$','$m_3(x)$'},'Interpreter','latex');
xlabel('x');

figure;
plot(x,abs(f-T1),'-k'); hold on;
plot(x,abs(f-m1),'--k');
legend({'$T_1(x)$','$m_1(x)$'},'Interpreter','latex');
xlabel('x');

figure;
plot(x,abs(f-T3),'-r'); hold on;
plot(x,abs(f-m3),'--r');
legend({'$T_3(x)$','$m_3(x)$'},'Interpreter','latex');
xlabel('x');

