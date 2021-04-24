% medium transmission line -> pi & T models
%given :
%R=0.036 ohm/km/phase, L=1.326 mH/km/phase,C=0.0112*10^-6F/km/phase(transmission line resistance & inductance)
%length of transmission line= 150km
%receiving end line voltage=300kv
%short transmission line supplies a load of 250 MVA @ 0.8 power factor lagging
clc;
length=150;
res=0.036;
ind=0.8*10^-3;
cap=0.0112*10^-6;
f=50;
mva=250;
vrline=300;
pf=0.8;
r=res*length;
l=ind*length;
c=cap*length;
xl=2*pi*f*l;
disp('Transmission Line Impedance')
z=r+i*xl 
disp('Shunt Admittance')
y=0+i*2*pi*f*c
disp('Receiving end voltage & current')
vrph=vrline/sqrt(3)
disp('Before incorporating power factor angle ')
irmag=mva/(3*vrph)%mva=3*vph*iph 
disp('Receiving end power factor angle')
theta=acos(pf)*(-1) %theta is in radian
disp('After incorporating power factor angle ')
ir=irmag.*exp(i*theta)% converting  mag*angle(theta) -> a+ib 
for tmodel=0:1
if (tmodel==1)
disp(' T-MODEL OF MEDIUM TRANSMISSION LINE ')
disp('       Sending end voltage & current')
a=1+0.5*z*y;
d=a;
b=(1+0.25*z*y)*z;
c=y;
else 
disp(' PI-MODEL OF MEDIUM TRANSMISSION LINE ')
disp('       Sending end voltage & current')
a=1+0.5*z*y;
d=a;
c=(1+0.25*z*y)*y;
b=z;
end
vs=a*vrph+b*ir
is=c*vrph+d*ir
vrnoload=abs(vs)/abs(a)
regulation=(vrnoload-vrph)*100/vrph
inpow=3*abs(vs)*abs(is)*cos(angle(vs)-angle(is))%i/p power=3*|vs|*|is|*cos(sending voltage angle-sending current angle); (sending end power)
outpow=3*vrph*irmag*pf %o/p power=3*|vr|*|ir|*power factor(receiving end power)
efficiency=(outpow/inpow)*100
end