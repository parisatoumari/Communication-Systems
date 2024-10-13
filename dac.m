function[analog_converted_signal]=dac(line_decoded_signal,nu,min_signal,max_signal,fs,f_analog)

    N=2^nu;
    delta=(max_signal-min_signal)/N;
    dec_data=reshape(line_decoded_signal,nu,length(line_decoded_signal)/nu)';
    decoded_sampled=bi2de(dec_data,'left-msb').'; %converting the binary string to decimal levels
    reconstructed_signal=(delta*decoded_sampled); %reconstructing the signalS
    reconstructed_signal=reconstructed_signal+(min_signal+ delta/2);
    analog_converted_signal=interp(reconstructed_signal,f_analog/fs);

end