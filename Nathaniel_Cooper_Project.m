%% Nathaniel Cooper project
% with no prey selection variablity in the top preditor (find stable
% population levels
% Paramters
time=1:100; % time span in years

rk=1.5; % growth rate of species K calculated from  loss estmate
ak=0.01; % capture efficancy of species K (best logical guess)

rd=1.5; % growth rate of species D calculated from  loss estmate
ad=0.01; % capture efficancy of species D (best logical guess)

bk=0.7; % conversion efficancy of prey K (best logical guess)
ag=0.025; % capture efficancy of species G (Ostfeld 1982)
qg=0.0001; % death rate of species G (beast logical estament)

bd=0.7; % conversion efficeancy of prey D (best logical guess)
ac=0.026; % capture efficeancy of species C (Ostfeld 1982)
qc=0.0001; % death rate of species C (beast logical estament)

bc=0.25; % conversion efficeancy of prey C normilized and calculated from (Ostfeld 1982)
bg=0.25; % conversion efficeancy of prey G normilized and calculated from (Ostfeld 1982)
qa=0.43; % death rate of species A, from the number of documented staranding (Estes and Hatfield 2003)
 

% dK/dt = rk*K*(1-K/1000)-ak*K*G;
% dD/dt = rd*D*(1-D/1000)-ad*D*C;
% dG/dt = (bk*ak*K*G-qg*G)-ag*G*A;
% dC/dt = (bd*ad*D*C-qc*C)-ac*C*A;
% dA/dt = (bc*ac*C*A+bg*ag*G*A)-qa*A;

n0=[700;700;70;70;2]; % starting pop size with biomass at next level calculated from (Reed and Foster 1984) and (Ostfeld 1982)


[T, Y] = ode45(@(t,y) LV_Predcom(y,rk,rd,ak,ad,ag,ac,bk,bd,bc,bg,qg,qc,qa),time,n0); % Solve ODE    

n1=Y(end,1:5)

figure;
plot(T,Y);
xlabel('time'); ylabel(' Abundance of preditors and prey');
legend({'K,abundance','D,abundance', 'G, abundance','C,abundance','A,abundance'});
%% with preterbation

[T, Y] = ode45(@(t,y) LV_Predcom(y,rk,rd,ak,ad,ag,ac,bk,bd,bc,bg,qg,qc,qa),time,n1); % Solve ODE    

figure;
plot(T,Y);
xlabel('time'); ylabel(' Abundance of preditors and prey');
legend({'K,abundance','D,abundance', 'G, abundance','C,abundance','A,abundance'});
%% stable (varable predation)
time=1:10
for i=1:time % solve ODE every seven days for 100 years 52 weeks * 100=5200 weekes
   p=betarnd(0.5,0.5); % capture efficeancy of prey C; A=0.5 B=0.5
   ac=p;
   ag=ac*(1-p); % capture efficeancy of prey G
   [T, Y] = ode45(@(t,y) LV_Predcom(y,rk,rd,ak,ad,ag,ac,bk,bd,bc,bg,qg,qc,qa),time,n1); % Solve ODE
    n1=Y(end,1:5);
end
figure;
plot(T,Y);
xlabel('time'); ylabel(' Abundance of preditors and prey');
legend({'K,abundance','D,abundance', 'G, abundance','C,abundance','A,abundance'});

%% with Preterbation (varable predation)
time=1:10
for i=1:time % solve ODE every seven days for 100 years 52 weeks * 100=5200 weekes
   p=betarnd(0.5,0.5); % capture efficeancy of prey C; A=0.5 B=0.5
   ac=p;
   ag=ac*(1-p); % capture efficeancy of prey G
   [T, Y] = ode45(@(t,y) LV_Predcom(y,rk,rd,ak,ad,ag,ac,bk,bd,bc,bg,qg,qc,qa),time,n1); % Solve ODE
    n1=Y(end,1:5);
    if i=25
        n1(1)=n(1)*.5
    end
end
figure;
plot(T,Y);
xlabel('time'); ylabel(' Abundance of preditors and prey');
legend({'K,abundance','D,abundance', 'G, abundance','C,abundance','A,abundance'});