clear;
close all;
clc;

syms x1 x2 p1 p2 u;
%state
Dx1 = x2;
Dx2 = -0.5*x2 -0.1*x2^2 + u; 
%L
L = 10*x2*u + 0.3*u^2;
%Hamiltonian
syms p1 p2 H;
H = L + p1*Dx1 + p2*Dx2;
%costate
Dp1 = -diff(H, x1);
Dp2 = -diff(H, x2);
%control u
du = diff(H, u);
sol_u = solve(du, u); 
%substitute u to Dx2 (state equation)
Dx2 = subs(Dx2, u,  sol_u);
eq1 = strcat('Dx1=', char(Dx1));
eq2 = strcat('Dx2=', char(Dx2));
eq3 = strcat('Dp1=', char(Dp1));
eq4 = strcat('Dp2=', char(Dp2));

sol_h = dsolve(eq1,eq2,eq3,eq4);
%conA1 = 'x1(0) = 0';
%conA2 = 'x2(0) = 0';
%p1 = 2c1(x1(T)-x1f), p2 = 2c2x2(T)
myeq1 = char(subs(sol_h.x1, 't', 0));
myeq2 = char(subs(sol_h.x2, 't', 0));
myeq3 = strcat(char(subs(sol_h.p1, 't', 10)),'=', 2000*char(subs(sol_h.x1, 't', 10)), '-10');
myeq4 = strcat(char(subs(sol_h.p2, 't', 10)),'=', 1000*char(subs(sol_h.x2, 't', 10)), '+0');
solution = solve(myeq1, myeq2, myeq3, myeq4);