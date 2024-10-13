function [t_sampled,digital_signal,binary_encoded_signal,decimal_encoded_signal]=adc(analog_signal,time,nu,fs)

    f_analog=length(analog_signal)/time; 
    sampled_signal=downsample(analog_signal,ceil(f_analog/fs)); %sampling
    L=length(sampled_signal);
    quantized_signal=zeros(1,L);
    N=2^nu;
    min_signal=min(sampled_signal);
    max_signal=max(sampled_signal);
    delta=(max_signal-min_signal)/N;

    %quantization
    for i=1:1:L
        for k=0:1:N-1
            if((sampled_signal(i)>=min_signal+k*delta)&&(sampled_signal(i)<=min_signal+(k+1)*delta))
               quantized_signal(i)=min_signal+k*delta+delta/2;
            end
        end
    end

    digital_signal=quantized_signal;
    t_sampled=linspace(0,time,length(digital_signal));
    
    %encoding
    min_signal=min(digital_signal);
    max_signal=max(digital_signal);
    delta=(max_signal-min_signal)/(N-1);
    decimal_encoded_signal=(digital_signal-(min_signal))/delta;
    binary_encoded_signal=reshape(de2bi(decimal_encoded_signal,'left-msb').',1,[]);

end


