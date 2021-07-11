
input=[0.007	7	240	100	500
0.0095	10	200	50	200
0.009	8.5	220	80	300
0.009	11	200	50	150
0.008	10.5	220	50	200
0.0075	12	120	50	120];
% %solar data
I=0.001;
eta=.153;
radian=[0 0.262 0.524 0.785 1.047 1.309 1.571];
temp=[18 19 21 23 26 29 33]; 
time=[6 7 8 9 10 11 12];
for i=1:7
    
    F=I*sin(radian(i))*eta*1300000*(1-0.0043*(2.2*sin(radian(i))*temp(i)-25));
    
    input(5,:)=[0 100 0 F F];

genalgo.input=input;
lobound=input(:,4)';
upbound=input(:,5)';
genalgo.bound=[lobound;upbound];%generate 2*6 row matrix
genalgo.time=time(i);
genalgo=ga2(genalgo);
end