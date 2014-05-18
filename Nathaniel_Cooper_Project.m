%% Nathaniel Cooper project

% Paramters
time=1:100 % time span in years 
rk=0.5 % growth rate of species K
ak=0.2 % capture efficancy of species K

rd=0.5 % growth rate of species D
ad=0.5 % capture efficancy of species D

bk=0.2 % conversion efficancy of prey K
qg=0.4 % death rate of species G

bd=0.2 % conversion efficeancy of prey D
qc=0.4 % death rate of species C

bc=0.5 % conversion efficeancy of prey C
bg=0.5 % conversion efficeancy of prey G
qa=0.5 % death rate of species A

% species K= dK/dt=rk*K-ak*K*G
% species D= dD/dt=rd*D-ad*D*C
% species G= dG/dt=bk*K*G-qg*G
% species C= dC/dt=bd*D*C-qc*C
% species A= dA/dt=(bc*C*A+bg*G*A)-qa*A

function[dy] = LV_Predcom(y,rk,rd,ak,ad,bk,bd,bc,bg,qg,qc,qa)
% Lotka Volterra predator-prey model, linked differential equaitons for
% community
    K = y(1);
    D = y(2);
    G = y(3);
    C = y(4);
    A = y(5);
    dKdt = rk*K-ak*K*G;
    dDdt = rd*D-ad*D*C;
    dGdt = bk*K*G-qg*G;
    dCdt = bd*D*C-qc*C;
    dAdt = (bc*C*A+bg*G*A)-qa*A;
    dy = [dKdt; dDdt; dGdt; dCdt; dAdt];
end

n0=[10000;10000;1000;1000;100]; % starting pop size with 10% biomass at next level 

[T, Y] = ode45(@(t,y) LV_Predcom(y,rk,rd,ak,ad,bk,bd,bc,bg,qg,qc,qa),time,n0); % Solve ODE


