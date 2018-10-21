clear;
clc;
%========== Define ==========
fs = 44100; %sampling frequency (Hz)
t0 = 0 : 1/fs : 0.6; %time axis (seconds)
t1 = 0 : 1/fs : 0.5;
t2 = 0 : 1/fs : 0.3;
t3 = 0 : 1/fs : 0.1;
f_A0=440; f_E2=1318.51; f_D2=1174.66; f_Fs1=739.99; f_Gs1=830.61; f_Cs2=1108.73; f_Cs1=554.37; f_A1=880.00; f_B1=987.77; f_D1=587.33; f_E1=659.25;
A = 0.2; %amplitude
w = 0; %phase
creMelody =[];

%========== Create Melody ==========
A0 = A*sin(2*pi*f_A0*t1 +w);
E2 = A*sin(2*pi*f_E2*t2 +w);
D2 = A*sin(2*pi*f_D2*t2 +w);
Fs1 = A*sin(2*pi*f_Fs1*t1 +w);
Gs1 = A*sin(2*pi*f_Gs1*t0 +w);
Cs2 = A*sin(2*pi*f_Cs2*t2 +w);
B1 = A*sin(2*pi*f_B1*t2 +w);
D1 = A*sin(2*pi*f_D1*t1 +w);
E1 = A*sin(2*pi*f_E1*t0 +w);
A1 = A*sin(2*pi*f_A1*t2 +w);
Cs1 = A*sin(2*pi*f_Cs1*t1 +w);
mute = 0*sin(2*pi*t3);
creMelody = [E2 D2 Fs1 Gs1 mute Cs2 B1 D1 E1 mute B1 A1 Cs1 E1 A1 A1]; %nokia ringtone
[input,fs] = audioread('orig_input.wav'); %read audio file
c = creMelody + (input(1:length(creMelody)))'; %Combine orig_input & melody
soundsc(c,44100); %play sound
fileName = 'melody.wav';
audiowrite(fileName,c,fs);

%========== Fast Fourier Transform ==========
[y,fs] = audioread('melody.wav');
Y = fft(y);
figure(1)
plot(abs(Y));
title('melody.wav');
xlabel('Frequency(Hz)');
figure(2)
N = fs; % number of FFT points
transform = fft(y,N)/N;
mag = abs(transform);
faxis = linspace(-N/2,N/2,N);
plot(faxis,fftshift(mag));
% axis([0 length(faxis)/2, 0 max(mag)])% view frequency content up to half the sampling rate
xlabel('Frequency(Hz)');
title('Fast Fourier Transform');

%_________Spectrogram_________
win = 64 % window length in samples
h = win/2           
nfft = win %width of each frequency bin
figure(3)
spectrogram(y,win,h,nfft,fs,'yaxis');
title('Spectrogram');
