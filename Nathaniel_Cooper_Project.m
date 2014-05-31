%% Nathaniel Cooper project
% with no prey selection variablity in the top preditor
% Paramters
time=1:100 % time span in years 

rk=1.23 % growth rate of species K calculated from (Reed and Foster 1984) loss estmate
ak=1.00 % capture efficancy of species K (best logical guess)

rd=1.23 % growth rate of species D calculated from (Reed and Foster 1984) loss estmate
ad=1.00 % capture efficancy of species D (best logical guess)

bk=0.10 % conversion efficancy of prey K (best logical guess)
ag=0.305 % capture efficancy of species G (Ostfeld 1982)
qg=0.05 % death rate of species G (beast logical estament)

bd=0.10 % conversion efficeancy of prey D (best logical guess)
ac=0.267 % capture efficeancy of species C (Ostfeld 1982)
qc=0.05 % death rate of species C (beast logical estament)

bc=0.25 % conversion efficeancy of prey C normilized and calculated from (Ostfeld 1982) 
bg=0.75 % conversion efficeancy of prey G normilized and calculated from (Ostfeld 1982)
qa=0.23 % death rate of species A, from the number of documented staranding (Estes and Hatfield 2003)

% species K= dK/dt=rk*K-ak*K*G
% species D= dD/dt=rd*D-ad*D*C
% species G= dG/dt=(bk*K*G-qg*G)-ag*G*A
% species C= dC/dt=(bd*D*C-qc*C)-ac*C*A
% species A= dA/dt=(bc*C*A+bg*G*A)-qa*A

n0=[3555000;100;337500;4050000;3]; % starting pop size with biomass at next level calculated from (Reed and Foster 1984) and (Ostfeld 1982)

eq=0; % extinction level of population

for t=1:40 % solve ODE every seven days for 100 years 52 weeks * 100=5200 weekes
[T, Y] = ode45(@(t,y) LV_Predcom(y,rk,rd,ak,ad,ag,ac,bk,bd,bc,bg,qg,qc,qa),time,n0); % Solve ODE    
end

figure;
plot(T,Y);
xlabel('time'); ylabel(' Abundance of preditors and prey');
legend({'K,abundance','D,abundance', 'G, abundance','C,abundance','A,abundance'});

%%
% with prey selection varabilty in top preditor using a beta distrabution 
clear all
% Paramters
time=1:100 % time span in years

rk=1.23 % growth rate of species K calculated from (Reed and Foster 1984) loss estmate
ak=1.00 % capture efficancy of species K (best logical guess)

rd=1.23 % growth rate of species D calculated from (Reed and Foster 1984) loss estmate
ad=1.00 % capture efficancy of species D (best logical guess)

bk=0.10 % conversion efficancy of prey K (best logical guess)
qg=0.05 % death rate of species G (beast logical estament)

bd=0.10 % conversion efficeancy of prey D (best logical guess)
qc=0.05 % death rate of species C (beast logical estament)

bc=0.25 % conversion efficeancy of prey C normilized and calculated from (Ostfeld 1982) 
bg=0.75 % conversion efficeancy of prey G normilized and calculated from (Ostfeld 1982)
qa=0.23 % death rate of species A, from the number of documented staranding (Estes and Hatfield 2003)

% species K= dK/dt=rk*K-ak*K*G
% species D= dD/dt=rd*D-ad*D*C
% species G= dG/dt=(bk*K*G-qg*G)-ag*G*A
% species C= dC/dt=(bd*D*C-qc*C)-ac*C*A
% species A= dA/dt=(bc*C*A+bg*G*A)-qa*A

n0=[3555000;100;337500;4050000;3]; % starting pop size with biomass at next level calculated from (Reed and Foster 1984) and (Ostfeld 1982)

eq=0;

for t=1:30 % solve ODE every seven days for 100 years 52 weeks * 100=5200 weekes
    p=betarnd(0.5,0.5); % capture efficeancy of prey C; A=0.5 B=0.5
    ac=p;
    ag=ac*(1-p); % capture efficeancy of prey G
[T, Y] = ode45(@(t,y) LV_Predcom(y,rk,rd,ak,ad,ag,ac,bk,bd,bc,bg,qg,qc,qa),time,n0); % Solve ODE
end

figure;
plot(T,Y);
xlabel('time'); ylabel(' Abundance of preditors and prey');
legend({'K,abundance','D,abundance', 'G, abundance','C,abundance','A,abundance'});

