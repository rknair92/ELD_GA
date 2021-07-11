

input=[0.007	7	240	100	500
0.0095	10	200	50	200
0.009	8.5	220	80	300
0.009	11	200	50	150
0.008	10.5	220	50	200
0.0075	12	190	50	120];


genalgo.input=input;
lobound=input (:,4)';
upbound=input (:,5)';
genalgo.bound=[lobound;upbound];% generate 2*6 row matrix
genalgo=ga2(genalgo);

