%% Nathaniel Cooper project
% with no prey selection variablity in the top preditor (find stable
% population levels
% Paramters
time=1:100; % time span in years

rk=1.5; % growth rate of species K 
ak=0.01; % capture efficancy of species K 

rd=1.5; % growth rate of species D calculated from  loss estmate
ad=0.01; % capture efficancy of species D 

bk=0.7; % conversion efficancy of prey K 
ag=0.025; % capture efficancy of species G 
qg=0.0001; % death rate of species G 

bd=0.7; % conversion efficeancy of prey D 
ac=0.026; % capture efficeancy of species C 
qc=0.0001; % death rate of species C 

bc=0.25; % conversion efficeancy of prey C  
bg=0.25; % conversion efficeancy of prey G 
qa=0.43; % death rate of species 
 

% dK/dt = rk*K*(1-K/1000)-ak*K*G;
% dD/dt = rd*D*(1-D/1000)-ad*D*C;
% dG/dt = (bk*ak*K*G-qg*G)-ag*G*A;
% dC/dt = (bd*ad*D*C-qc*C)-ac*C*A;
% dA/dt = (bc*ac*C*A+bg*ag*G*A)-qa*A;

n0=[700;700;70;70;2]; % starting pop size 


[T, Y] = ode45(@(t,y) LV_Predcom(y,rk,rd,ak,ad,ag,ac,bk,bd,bc,bg,qg,qc,qa),time,n0); % Solve ODE    

n1=Y(end,1:5)

figure;
plot(T,Y);
xlabel('time'); ylabel(' Abundance of preditors and prey');
legend({'K,abundance','D,abundance', 'G, abundance','C,abundance','A,abundance'});
%% with preterbation
n1(1)=n1(1)*0.5; % preterbation of species K (new K=190)
[T, Y] = ode45(@(t,y) LV_Predcom(y,rk,rd,ak,ad,ag,ac,bk,bd,bc,bg,qg,qc,qa),time,n1); % Solve ODE    

figure;
plot(T,Y);
xlabel('time'); ylabel(' Abundance of preditors and prey');
legend({'K,abundance','D,abundance', 'G, abundance','C,abundance','A,abundance'});
%% stable (varable predation)
time=1:100;
for i=1:time % solve ODE every seven days for 100 years 52 weeks * 100=5200 weekes
   p=betarnd(0.5,2.56); % capture efficeancy of prey C; A=0.5 B=2.65
   ac=p;
   ak=ac;
   ag=ac*(1-p); % capture efficeancy of prey G
   ad=ag;
   [T, Y] = ode45(@(t,y) LV_Predcom(y,rk,rd,ak,ad,ag,ac,bk,bd,bc,bg,qg,qc,qa),time,n1); % Solve ODE
    n1=Y(end,1:5);
end
figure;
plot(T,Y);
xlabel('time'); ylabel(' Abundance of preditors and prey');
legend({'K,abundance','D,abundance', 'G, abundance','C,abundance','A,abundance'});

%% with Preterbation (varable predation)
time=1:100
for i=1:time % solve ODE every seven days for 100 years 52 weeks * 100=5200 weekes
    n1(1)=n1(1)*.5 % preterbation
   p=betarnd(0.5,2.56); % capture efficeancy of prey C; A=0.5 B=2.56
   ac=p; % capture efficeancy of prey C
   ag=ac*(1-p); % capture efficeancy of prey G
   [T, Y] = ode45(@(t,y) LV_Predcom(y,rk,rd,ak,ad,ag,ac,bk,bd,bc,bg,qg,qc,qa),time,n1); % Solve ODE
    n1=Y(end,1:5);
end
figure;
plot(T,Y);
xlabel('time'); ylabel(' Abundance of preditors and prey');
legend({'K,abundance','D,abundance', 'G, abundance','C,abundance','A,abundance'});