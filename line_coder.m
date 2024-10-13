function [t,line_coded_signal] = line_coder(encoded_signal, r,A,line_code_f)

    L=length(encoded_signal);
    T = L/r; 
    D=1/r;
    n = line_code_f*D;
    N = n*L;
    dt = T/N;
    t = 0:dt:T-dt;
    line_coded_signal = zeros(1,length(t));
    ak=(encoded_signal-0.5).*(A);
    for i = 0:1:L-1
        line_coded_signal(i*n+1:(i+1)*n) = ak(i+1);
    end

end