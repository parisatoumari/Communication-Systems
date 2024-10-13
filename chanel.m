function [noise_added_signal,recieved_signal]=chanel(line_coded_signal,N0,B,fs)

    var=N0*B;
    noise=wgn(size(line_coded_signal,1),size(line_coded_signal,2),var,'linear'); %adding the noise
    noise_added_signal=noise+line_coded_signal;
    filtered_signal=lowpass(noise_added_signal,B,fs);%passing through a bandlimitted channel
    recieved_signal=filtered_signal;

end