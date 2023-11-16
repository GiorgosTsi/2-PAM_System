%%%%%%%%  EXERCISE 1 %%%%%%%%%
% Tsikritzakis Gewrgios Marios 2020030055
% Koutsovasilis Vasileios      2020030137

clear all;
clc;
close all;
pkg load signal;

%%%%%%%A1

T = 10^(-3); %%Symbol Period
over = 10  ;
A = 4; 
a = [0 0.5 1]; %%3 roll of factors
Ts = T/over ; %%signal's sampling period

%%plot of the srrc signals:
figure(1);

[srrc0, t0] = srrc_pulse(T , over , A , a(1));
plot(t0,srrc0);
title('SRRC pulses with a = 0 , 0.5 , 1');
xlim([-0.004 0.004]);
xlabel('Time axis');
ylabel('SRRC signals')
grid on;
hold on;

[srrc1, t1] = srrc_pulse(T , over , A , a(2));
plot(t1,srrc1);

[srrc2, t2] = srrc_pulse(T , over , A , a(3));
plot(t2,srrc2);
grid on;

legend('SRRC pulse with a = 0','SRRC pulse with a = 0.5','SRRC pulse with a = 1');
hold off;

%%%%%%%A2

nfft = 2048 ; %% Number of samples for the fourier signals

%create f axis
Fs = 1/Ts;

F_axis = [-Fs/2 : Fs/nfft : Fs/2 - Fs/nfft ]; %nfft samples of fourier axis

XF0 = fftshift(fft(srrc0,nfft))*Ts ; %%Fourier Transform of SRRC0 centralized in 0
XF1 = fftshift(fft(srrc1,nfft))*Ts ; %%Fourier Transform of SRRC1 centralized in 0
XF2 = fftshift(fft(srrc2,nfft))*Ts ; %%Fourier Transform of SRRC2 centralized in 0

%plot the energy spectral density:

figure(2);

plot(F_axis, abs(XF0).^2);
title('energy spectral density of SRRC Pulse with a = 0 , 0.5 , 1');
grid on;
xlabel('F(Hz)')
hold on;

plot(F_axis, abs(XF1).^2);

plot(F_axis, abs(XF2).^2);

legend('energy spectral density of SRRC Pulse with a = 0',
'energy spectral density of SRRC Pulse with a = 0.5',
'energy spectral density of SRRC Pulse with a = 1');

hold off;


%plot the energy spectral density in logarithmic y axis:

figure(3);

semilogy(F_axis , abs(XF0).^2);
title('energy spectral density of SRRC Pulse with a = 0 , 0.5 , 1');
grid on;
xlabel('F(Hz)')
hold on;

semilogy(F_axis , abs(XF1).^2);

semilogy(F_axis , abs(XF2).^2);

legend('energy spectral density of SRRC Pulse with a = 0',
'energy spectral density of SRRC Pulse with a = 0.5',
'energy spectral density of SRRC Pulse with a = 1');
hold off;


%%%%%%%%A3

c1 = T/10^3;
c2 = T/10^5;

figure(4);

subplot(3,1,1);
semilogy(F_axis , abs(XF0).^2  );
hold on;
title('energy spectral density of SRRC Pulse with a = 0 , and y=T/10^3');
grid on;
xlabel('F(Hz)');
%semilogy(F_axis , c1*ones(length(F_axis)) , 'r');
%Draw a horizontal line y=c1:
line([-Fs/2 Fs/2],[c1 c1]);
hold off;

subplot(3,1,2);
semilogy(F_axis , abs(XF1).^2 );
hold on;
title('energy spectral density of SRRC Pulse with a = 0.5 , and y=T/10^3');
grid on;
xlabel('F(Hz)')
line([-Fs/2 Fs/2],[c1 c1]);
hold off;

subplot(3,1,3);
semilogy(F_axis , abs(XF2).^2  );
hold on;
title('energy spectral density of SRRC Pulse with a = 1 , and y=T/10^3');
grid on;
xlabel('F(Hz)')
line([-Fs/2 Fs/2],[c1 c1]);
hold off;

%%Same procedure for y=c2

figure(5);

subplot(3,1,1);
semilogy(F_axis , abs(XF0).^2  );
hold on;
title('energy spectral density of SRRC Pulse with a = 0 , and y=T/10^5');
grid on;
xlabel('F(Hz)')
%semilogy(F_axis , c1*ones(length(F_axis)) , 'r');
%Draw a horizontal line y=c2:
line([-Fs/2 Fs/2],[c2 c2]);
hold off;

subplot(3,1,2);
semilogy(F_axis , abs(XF1).^2 );
hold on;
title('energy spectral density of SRRC Pulse with a = 0.5 , and y=T/10^5');
grid on;
xlabel('F(Hz)')
line([-Fs/2 Fs/2],[c2 c2]);
hold off;

subplot(3,1,3);
semilogy(F_axis , abs(XF2).^2  );
hold on;
title('energy spectral density of SRRC Pulse with a = 1 , and y=T/10^5');
grid on;
xlabel('F(Hz)')
line([-Fs/2 Fs/2],[c2 c2]);
hold off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% B

signal_vector = [srrc0 ; srrc1 ; srrc2];%array of our srrc signals.

for i=1:3 % a(roll factor) loop
  for k=0:2% k loop
    srrc_signal = signal_vector(i,:); %pare thn i grammi tou pinaka, dhladh olo to shma srrc.
    
    %%Create the phi(t-kT):
    %%Metatopish kata kT = k*Ts*over
    %%Vale k*over mhdenika apo aristera kai vgale k*over deigmata apo deksia
    srrc_shifted = [zeros(1,k*over) srrc_signal(1: (end - k*over)) ]; %Phi(t-kT), k>0
    
    %% 1) plot the signals:
    figure();
    plot(t0,srrc_signal,t0,srrc_shifted);
    xlim([-0.004 0.004]);
    xlabel('Time axis');
    legend('Phi(t)','Phi(t-kT)');
    string = sprintf('Phi(t) and Phi(t -%d*T) with a=%d', k , (i-1)*0.5);
    title(string);
    
    
    %% 2) plot the phi(t)*phi(t-kT):
    figure();
    plot(t0,srrc_signal.*srrc_shifted);
    xlim([-0.004 0.004]);
    string2 = sprintf('Phi(t)*Phi(t -%d*T) with a=%d', k , (i-1)*0.5);
    title(string2);
    xlabel('time');
    
    %% 3) Compute the integral of phi(t)*phi(t-kT)
    total = sum(srrc_signal.*srrc_shifted*Ts) ;
    sprintf('Integral of Phi(t)*Phi(t -%d*T) =%d with a=%d', k ,total , (i-1)*0.5)
    
  end

end

%%Compute the same integral for k = 3, for all roll factors.

for i=1:3 
  
  srrc_signal = signal_vector(i,:);
  srrc_shifted = [zeros(1,3*over) srrc_signal(1: (end - 3*over)) ]; %%phi(t-3T)
  total =  sum(srrc_signal.*srrc_shifted*Ts) ;
  sprintf('Integral of Phi(t)*Phi(t -3*T) =%d with a=%d',total , (i-1)*0.5)

end

%%%%%%%%% C

T = 10^(-3); %periodos sumbolou
over=10;
a = 0.5;
A=4;
Ts = T/over;

[phi, t] = srrc_pulse(T , over , A , a); %Phi(t) signal

N=50; % plithos bits eisodou

%C1
b = (sign (randn(N,1)) + 1) / 2 ; % bits eisodou.

%C2

%a)
X = bitsTo2PAM(b); % ta sumbola eisodou.

%b)

X_delta = 1/Ts * upsample(X,over);

n = linspace(0,(N-1)*T , size(X_delta)(1) );
%or
td = [0 : (N-1)*T / size(X_delta)(1) : (N-1)*T - (N-1)*T / size(X_delta)(1)  ];

figure(24);
stem(td,X_delta);

%c

tconv = [t(1) + td(1) : Ts : t(end) + td(end) + 10*Ts];

Y = Ts * (conv(X_delta,phi));

figure(25);
plot(tconv , Y);
title('Convolution of X_delta and Phi pulse');
xlabel('time');


%d

%%Z(t) = Y(t) * phi(-t)

phiInverse = phi(end : -1 : 1) ; 
tInv = -1 * t(end : -1 : 1);

tconv2 = [ tconv(1) + tInv(1) : Ts : tconv(end) + tInv(end) ];
Z = Ts* conv(Y,phiInverse);

figure(26);
plot(tconv2 , Z );
title('Z(t) = X(t) * Phi(-t)');

for i= 0: N-1 
   index = interp1(tconv2,1:length(tconv2),i*T,'nearest');
   Xn(i+1) = Z(index); 
end

figure(27);

plot(tconv2 , Z );
title('Z(t) signal and values of X(red)');
xlabel('time');
hold on;

stem([0 : N - 1] * T , X , 'r' );
legend('Z(t)','X[n]');
hold off;









