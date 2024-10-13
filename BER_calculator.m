function rate=BER_calculator(encoded_signal,line_decoded_signal)
    num_errors=sum((encoded_signal-line_decoded_signal).^2);
    L=length(encoded_signal);
    rate=(num_errors/L)*100;
end