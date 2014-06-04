%% Nathaniel Cooper project
% with no prey selection variablity in the top preditor (find stable
% population levels
% Paramters
time=1:1000; % time span in years

rk=0.5; % growth rate of species K calculated from  loss estmate
ak=0.44; % capture efficancy of species K (best logical guess)

rd=0.5; % growth rate of species D calculated from  loss estmate
ad=0.44; % capture efficancy of species D (best logical guess)

bk=0.65; % conversion efficancy of prey K (best logical guess)
ag=0.305; % capture efficancy of species G (Ostfeld 1982)
qg=0.01; % death rate of species G (beast logical estament)

bd=0.65; % conversion efficeancy of prey D (best logical guess)
ac=0.267; % capture efficeancy of species C (Ostfeld 1982)
qc=0.01; % death rate of species C (beast logical estament)

bc=0.25; % conversion efficeancy of prey C normilized and calculated from (Ostfeld 1982)
bg=0.75; % conversion efficeancy of prey G normilized and calculated from (Ostfeld 1982)
qa=0.23; % death rate of species A, from the number of documented staranding (Estes and Hatfield 2003)
 

% dK/dt = rk*K-ak*K*G;
% dD/dt = rd*D-ad*D*C;
% dG/dt = (bk*ak*K*G-qg*G)-ag*G*A;
% dC/dt = (bd*ad*D*C-qc*C)-ac*C*A;
% dA/dt = (bc*ac*C*A+bg*ag*G*A)-qa*A;

n0=[700;700;70;70;2]; % starting pop size with biomass at next level calculated from (Reed and Foster 1984) and (Ostfeld 1982)

eq=0; % extinction level of population

[T, Y] = ode45(@(t,y) LV_Predcom(y,rk,rd,ak,ad,ag,ac,bk,bd,bc,bg,qg,qc,qa),time,n0); % Solve ODE    


figure;
plot(T,Y);
xlabel('time'); ylabel(' Abundance of preditors and prey');
legend({'K,abundance','D,abundance', 'G, abundance','C,abundance','A,abundance'});
%% Stable population (no varabliity)
clear all 
time=1:1000; % time span in years

rk=0.5; % growth rate of species K calculated from  loss estmate
ak=0.44; % capture efficancy of species K (best logical guess)

rd=0.5; % growth rate of species D calculated from  loss estmate
ad=0.44; % capture efficancy of species D (best logical guess)

bk=0.65; % conversion efficancy of prey K (best logical guess)
ag=0.305; % capture efficancy of species G (Ostfeld 1982)
qg=0.01; % death rate of species G (beast logical estament)

bd=0.65; % conversion efficeancy of prey D (best logical guess)
ac=0.267; % capture efficeancy of species C (Ostfeld 1982)
qc=0.01; % death rate of species C (beast logical estament)

bc=0.25; % conversion efficeancy of prey C normilized and calculated from (Ostfeld 1982)
bg=0.75; % conversion efficeancy of prey G normilized and calculated from (Ostfeld 1982)
qa=0.23; % death rate of species A, from the number of documented staranding (Estes and Hatfield 2003)
 

% dK/dt = rk*K-ak*K*G;
% dD/dt = rd*D-ad*D*C;
% dG/dt = (bk*ak*K*G-qg*G)-ag*G*A;
% dC/dt = (bd*ad*D*C-qc*C)-ac*C*A;
% dA/dt = (bc*ac*C*A+bg*ag*G*A)-qa*A;

n0=[325;384;0.81;0.84;304]; % satble population levels 

eq=0; % extinction level of population

[T, Y] = ode45(@(t,y) LV_Predcom(y,rk,rd,ak,ad,ag,ac,bk,bd,bc,bg,qg,qc,qa),time,n0); % Solve ODE    


figure;
plot(T,Y);
xlabel('time'); ylabel(' Abundance of preditors and prey');
legend({'K,abundance','D,abundance', 'G, abundance','C,abundance','A,abundance'});
%%
% with prey selection varabilty in top preditor using a beta distrabution
clear all
% Paramters

time=1:50; % time span in years

rk=0.33; % growth rate of species K calculated from  loss estmate
ak=0.44; % capture efficancy of species K (best logical guess)

rd=0.33; % growth rate of species D calculated from  loss estmate
ad=0.44; % capture efficancy of species D (best logical guess)

bk=0.10; % conversion efficancy of prey K (best logical guess)
qg=0.01; % death rate of species G (beast logical estament)

bd=0.10; % conversion efficeancy of prey D (best logical guess)
qc=0.01; % death rate of species C (beast logical estament)

bc=0.25; % conversion efficeancy of prey C normilized and calculated from (Ostfeld 1982)
bg=0.75; % conversion efficeancy of prey G normilized and calculated from (Ostfeld 1982)
qa=0.23; % death rate of species A, from the number of documented staranding (Estes and Hatfield 2003)
 
L=500; % carrining capacity

% dK/dt = rk*K-ak*K*G;
% dD/dt = rd*D-ad*D*C;
% dG/dt = (bk*ak*K*G-qg*G)-ag*G*A;
% dC/dt = (bd*ad*D*C-qc*C)-ac*C*A;
% dA/dt = (bc*ac*C*A+bg*ag*G*A)-qa*A;

n0=[555;555;60;60;1]; % starting pop size with biomass at next level calculated from (Reed and Foster 1984) and (Ostfeld 1982)

eq=0;

for i=1:50 % solve ODE every seven days for 100 years 52 weeks * 100=5200 weekes
   p=betarnd(4,2); % capture efficeancy of prey C; A=0.5 B=0.5
   ac=p;
   ag=ac*(1-p); % capture efficeancy of prey G
[T, Y] = ode45(@(t,y) LV_Predcom(y,rk,rd,ak,ad,ag,ac,bk,bd,bc,bg,qg,qc,qa),time,n0); % Solve ODE
end

figure;
plot(T,Y);
xlabel('time'); ylabel(' Abundance of preditors and prey');
legend({'K,abundance','D,abundance', 'G, abundance','C,abundance','A,abundance'});
