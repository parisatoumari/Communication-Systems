function [t,line_coded_signal] = line_coder_nyquist(encoded_signal, r,A,beta,line_code_f)

    L=length(encoded_signal);
    D=1/r;
    tD=-L*D/2:1/line_code_f:L*D/2-1/line_code_f;
    ak=(encoded_signal-0.5)*A;
    line_coded_signal=zeros(1,round(2*L*D*line_code_f));
    p =cos(2*pi*beta*tD) ./ (1-(4*beta*tD).^2) .* sinc(r*tD);
%     p=[p zeros(1,L*D*line_code_f)];
    for k=0:1:L-1
%         s=circshift(p,round(k*D*line_code_f));
%         s=[s(1:k*D*line_code_f)*0 s(1+k*D*line_code_f:end)];
        s=[zeros(1,round(k*D*line_code_f)) p zeros(1,round((L-k)*D*line_code_f))];
        line_coded_signal=line_coded_signal+ak(k+1)*s;
    end
    line_coded_signal=line_coded_signal(1/2*L*D*line_code_f:3/2*L*D*line_code_f-1);
    t=0:1/line_code_f:L*D-1/line_code_f;
end