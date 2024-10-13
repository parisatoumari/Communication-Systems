function [line_decoded_signal]=line_decoder(recieved_signal,line_code_f,r)

    sampled = recieved_signal(1:line_code_f/r:end); 
    L=length(sampled);
    line_decoded_signal = zeros(1,L);
    line_decoded_signal(sampled>0)=1; 

end