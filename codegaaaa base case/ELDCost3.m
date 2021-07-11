function [F P1]=ELDCost3(x,data)

B=1e-4*[0.14	0.17	0.15	0.19	0.26	0.22
0.17	0.6	0.13	0.16	0.15	0.2
0.15	0.13	0.65	0.17	0.24	0.19
0.19	0.16	0.17	0.71	0.3	0.25
0.26	0.15	0.24	0.3	0.69	0.32
0.22	0.2	0.19	0.25	0.32	0.85];
Pd=700;
n=length(data(:,1));
P=x(1,2:n);

B11=B(1,1);
B1n=B(1,2:n);
Bnn=B(2:n,2:n);
A=B11;
BB1=2*B1n*P';
B1=(BB1-1)';
C1=(P*Bnn*P');
C=Pd-(sum(P))+C1; %kron's reduction done
 A=B11;
    y=[A B1 C];
x1=roots(y);
 x2=(abs(min(x1)));

 if x2>data(1,5)
     x2=data(1,5);
 else
 end
   if x2<data(1,4)
x2=data(1,4);
   else
   end
 P1=[x2 P];
 a=data(:,1);
 b=data(:,2);
 c=sum(data(:,3));
 F=P1.*P1*a+P1*b+c;
Ploss=(P1*B*P1');
loss=abs(sum(P1)-Pd-Ploss);
F=(F)+1000*loss;
end
 


