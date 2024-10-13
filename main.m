clc; clear; close all;

Fs=44100; %frequency of the audio
recObj = audiorecorder(Fs,16,1); %recording the audio
recDuration = 5;
disp("Begin speaking.")
recordblocking(recObj,recDuration);
disp("End of recording.")
analog_signal=getaudiodata(recObj);
disp("Begin Signal Input...");
% filename = 'sample.wav';
% audiowrite(filename, analog_signal, Fs)
% [analog_signal,Fs]=audioread('sample.wav');
L=length(analog_signal);
time=L*1/Fs;
f_analog=Fs; 
t_analog = 0:1/f_analog:time-1/f_analog;
min_signal=min(analog_signal);
max_signal=max(analog_signal);

     
fs=Fs*0.5; %sampling frequency
nu=10; 
beta=0;
A=1; %amplititude
r=nu*fs;
line_code_f=100*r;
N0=0*10^-5;
B=100;

% figure(1);
% plot(t_analog,analog_signal);
% title("analog signal that recorded with microphone","FontSize",14)
% ylabel("amplitud");
% xlabel("time");

[t_sampled,digital_signal,binary_encoded_signal,decimal_encoded_signal]=adc(analog_signal,time,nu,fs);
% figure(2);
% plot(t_sampled,digital_signal);
% figure(3);
% plot(binary_encoded_signal);

% [t,line_coded_signal] = line_coder_nyquist(binary_encoded_signal, r,A,beta,line_code_f);
[t,line_coded_signal] = line_coder(binary_encoded_signal, r,A,line_code_f);
% figure(4);
% plot(t,line_coded_signal);

[recieved_signal]=chanel(line_coded_signal,N0,B,fs);
% figure(5);
% plot(recieved_signal);

line_decoded_signal=line_decoder(recieved_signal,line_code_f,r);
% figure(6);
% plot(line_decoded_signal);

[analog_converted_signal]=dac(line_decoded_signal,nu,min_signal,max_signal,fs,f_analog);
% figure(7);
% plot(t_analog,analog_converted_signal);
% title("reconstructed analog signal ","FontSize",14)
% ylabel("amplitud");
% xlabel("time");


sound(analog_converted_signal,Fs);
% audiowrite("fs=20kHz|nu=10|less_noise_added.Wav", analog_converted_signal, Fs);
