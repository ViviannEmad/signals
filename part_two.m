clear;
clc;
close all;
load filter1.mat;
load filter2.mat;
%plot the signal1 before and after applying the filter

[x1,fs1]=audioread('input1.wav');
 y1=filter(low1,x1);

N1=length(x1);
X1=fft(x1,N1);
f1=(-N1/2:(N1/2)-1)*fs1/N1;


N2=length(y1);
X2=fft(y1,N1);
f2=(-N2/2:(N2/2)-1)*fs1/N2;
figure;
subplot(2,1,2); plot(f2,abs(fftshift(X2))/N2);  title('filtered signal1');
subplot(2,1,1); plot(f1,abs(fftshift(X1))/N1);  title('original signal1');

%plot the signal2 before and after applying the filter
[x3,fs3]=audioread('input2.wav');
 y2=filter(low1,x3);

N3=length(x3);
X3=fft(x3,N3);
f3=(-N3/2:(N3/2)-1)*fs3/N3;


N4=length(y2);
X4=fft(y2,N4);
f4=(-N4/2:(N4/2)-1)*fs3/N4;
figure;
subplot(2,1,1); plot(f3,abs(fftshift(X3))/N3); title('original signal2');
subplot(2,1,2); plot(f2,abs(fftshift(X4))/N4); title('filtered signal2');



[y1, fs1] = audioread('input1.wav');
x1= filter(low1,y1);
N1=length(x1);
X1=fft(x1,N1);
f1=(-N1/2:(N1/2)-1)*fs1/N1;

[y2, fs2] = audioread('input2.wav');
x2= filter(low2,y2);
N2=length(x2);
X2=fft(x2,N2);
f2=(-N2/2:(N2/2)-1)*fs2/N2;
figure;
subplot(3,1,1); plot(f1,abs(fftshift(X1))/N1); title('Signal 1');
subplot(3,1,2); plot(f2,abs(fftshift(X2))/N2); title('Signal 2');


Fcarrier1 =5000;
Fcarrier2 = 15000;
% Normalize the signals to ensure they have the same amplitude
x1_normalized = x1 / max(abs(x1));
x2_normalized = x2 / max(abs(x2));
t1 = 0:1/fs1:(length(x1_normalized)-1)/fs1;
t2 = 0:1/fs2:(length(x2_normalized)-1)/fs2;
carrier_wave1 = cos(2*pi*Fcarrier1*t1(1:length(x1_normalized)));
carrier_wave2 = cos(2*pi*Fcarrier2*t2(1:length(x2_normalized)));
modulated_signal1 = x1_normalized .* carrier_wave1';
modulated_signal2 = x2_normalized .* carrier_wave2';
sum_modulated = modulated_signal1 + modulated_signal2;
% Perform the Fourier transform on the sum of modulated signals
fft_sum_modulated = fftshift(fft(sum_modulated));
%Frequency axis for the FFT
N = length(sum_modulated);
f = (-fs1/2):(fs1/N):(fs1/2-fs1/N);
%Plot the frequency response
subplot(3,1,3); plot(f, abs(fft_sum_modulated));
title('Amplitude-Modulated Signal');

%demodulation
demodulated_signal1 = 2*max(abs(x1))* sum_modulated.* carrier_wave1';
demodulated_signal2 = 2*max(abs(x2))*sum_modulated.* carrier_wave2';

out1_filtered = filter(low1,demodulated_signal1);
audiowrite('output1.wav', out1_filtered, fs1);
out2_filtered = filter(low2, demodulated_signal2);
audiowrite('output2.wav', out2_filtered, fs2);
disp('Playing demodulated signals....');
m1_demodulatedandfilt = audioplayer(out1_filtered, fs1);
play(m1_demodulatedandfilt);
pause(10);
m2_demodulatedandfilt = audioplayer(out2_filtered, fs2);
play(m2_demodulatedandfilt);

N2=length(out1_filtered);
X2=fft(out1_filtered,N2);

f2=(-N2/2:(N2/2)-1)*fs2/N2;

N3=length(out2_filtered);
 X3=fft(out2_filtered,N3);
 
 f3=(-N2/2:(N2/2)-1)*fs2/N2;
 figure;
subplot(2,1,1); plot(f2,abs(fftshift(X2)/N2)); title('Signal1 demodulated');
subplot(2,1,2); plot(f3,abs(fftshift(X3)/N3)); title('Signal2 demodulated');





