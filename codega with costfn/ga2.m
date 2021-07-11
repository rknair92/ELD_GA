

function genalgo=ga2(x)

genalgo=x;
genalgo.variables=6;% obtains no of generators
genalgo.pop=80;% population size generated
% initial population generation
genalgo.Chrom=generatePower(genalgo.pop,genalgo.bound,genalgo.variables);%calls function for random power 
genalgo.gen=0;
genalgo.objfn='ELDCost3';
genalgo.iterations=200; %specifies no of iterations
gen=0;
genalgo.xmin=[];%variable which stores minimum generation
genalgo.fxmin=inf; %variable stores the array of cost function for each iteration
genalgo.r=(1:genalgo.pop)';%variable used for proprtionate ranking
genalgo.Pc=0.9; %probability of cross over
while (genalgo.gen<genalgo.iterations)
    genalgo.gen=gen;
    genalgo=gaObj(genalgo);  
    % Increase generation counter        ------------------
    genalgo.xmingen(gen+1,:)=genalgo.xmin;
    genalgo.fxmingen(gen+1,:)=genalgo.fxmin;
    gen=gen+1;
end
garesults(genalgo);

% subfuncion for initial power generation
function Chrom=generatePower(pop,bound,variable)
novar=variable;% takes no of generators
range(1,:)= bound(2,:)- bound(1,:);% obtains the difference between Pmin and Pmax
randMat=rand(pop,novar);% creates a random matrix
rangeMat=ones(pop,1)*range;% copies the range of each generators to all the population
lb=ones(pop,1)*bound(1,:);% takes the Pmin of each generator
Chrom=lb+rangeMat.*randMat; % obtains the initial random power for each population

function genalgo=gaObj(genalgo)

Chrom=genalgo.Chrom; % random power generation matrix
nind=size(Chrom,1);%gives no of rows of random power generation matrix
ObjV=inf(nind,1); % initializes the fitness fn to infinity
for i=1:nind
  
                [ObjV(i),Chrom(i,:)]=feval(genalgo.objfn,Chrom(i,:),genalgo.input);

end
    genalgo.ObjV=ObjV;
%best individual in the generation
[fvm,ino]=min(ObjV);
if fvm<=genalgo.fxmin
    genalgo.xmin=Chrom(ino,:);
    genalgo.fxmin=fvm;
end
% Fitness evaluation ---------------------------------------
FitV=rank(genalgo.ObjV,genalgo.pop,Chrom);
% SELECTION and crossover-----------------------------------------------
Scr = Selcr(FitV);
% MUTATION ------------------------------------------------
Chrom = mutation(Scr,genalgo.bound);
% Reinsert the best individual  ---------------------------;
Chrom(round(genalgo.pop/2),:) = genalgo.xmin;
genalgo.Chrom=Chrom;
gaiteration(genalgo); 

function FitV=rank(ObjVal,pop,chrom)
[val,pos]=sort(ObjVal);
 newchrom=chrom;
for i=1:pop
        newchrom(i,:)=chrom(pos(i),:);
end
FitV=newchrom;


function [Scr]=Selcr(Chrom)

no_select_keep=size(Chrom,1)*0.5;
no_of_variables=size(Chrom(1,:),2);
no_mating=ceil(no_select_keep/2);
for i=1:no_select_keep
    for j= 1:no_of_variables
   newgen(i,j)= Chrom(i,j);
    end
end
b=1;
inc_oper=1;
while b <= no_mating

select_mate_ind_1= randi([1,no_mating],1,1);
select_mate_ind_2= randi([1,no_mating],1,1);

parent_1 = newgen(select_mate_ind_1,:);
parent_2 = newgen(select_mate_ind_2,:);
% crossover 
beta=rand;

offspring_1= beta*parent_1 +(1-beta)*parent_2;
offspring_2= beta*parent_2 +(1-beta)*parent_1;

for j= 1 : no_of_variables
newgen(no_select_keep+inc_oper,j)=offspring_1(1,j);
newgen(no_select_keep+inc_oper+1,j)=offspring_2(1,j);
end
inc_oper = inc_oper+2;
b=b+1;
end
Scr=newgen;


function Chrom=mutation(OldGen,GenRange)
pop=size(OldGen,1);
gen_nos=size(GenRange(1,:),2);
Mut=rand(pop,gen_nos)<0.1;
GenKeep=ones(pop,gen_nos)-Mut;
genHalfRange=[-1 1]*GenRange*0.5;
genRangeMat=ones(pop,1)*genHalfRange;
MutMat=Mut.*genRangeMat.*rand+OldGen.*GenKeep;
NewGen=MutMat;
% limit the Generators to its min or max if it exceeds the limits
aux = ones(pop,1);
auxf1=aux*GenRange(1,:);
auxf2=aux*GenRange(2,:);
Chrom = (NewGen>auxf2).*auxf2+(NewGen<auxf1).*auxf1+(NewGen<=auxf2 & NewGen>=auxf1).*NewGen;

function gaiteration(gaDat)

 disp('------------------------------------------------')
 disp(['Iteration: ' num2str(gaDat.gen)])
 disp(['   xmin: ' mat2str(gaDat.xmin) ' -- f(xmin): ',num2str(gaDat.fxmin)])
 
 function garesults(gaDat)
% Optional user task executed when the algorithm ends

disp('------------------------------------------------')
disp(['######   MOST OPTIMAL RESULT AT TIME=' mat2str(gaDat.time)])
disp(['Total cost of generation ' num2str(gaDat.fxmin) '$'])
disp(['     P1 = ' mat2str(gaDat.xmin(1,1)) 'MW' ])
disp(['     P2 = ' mat2str(gaDat.xmin(1,2)) 'MW'])
disp(['     P3 = ' mat2str(gaDat.xmin(1,3)) 'MW'])
disp(['     P4 = ' mat2str(gaDat.xmin(1,4)) 'MW'])
disp(['     P5 = ' mat2str(gaDat.xmin(1,5)) 'MW'])
disp(['     P6 = ' mat2str(gaDat.xmin(1,6)) 'MW'])
disp('------------------------------------------------')





