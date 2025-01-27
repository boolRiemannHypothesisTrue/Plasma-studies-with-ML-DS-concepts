
function coefs = cwtbb(signal,scale,wname)


%   cwtbb Continuous Wavelet Coefficients 1-D.

%   coefs = cwtbb(s,scales,'wname') computes the continuous
%   wavelet coefficients of the vector "signal" at real, positive
%   scale, using wavelet whose name is 'wname'.
%
%   

if nargin<2

  disp('Impossible processing: It must a signal with time!') 
  return

end;

if nargin<3 

   wname='morl'; 
   disp('You use morlet wavelet')
    
end

signal  = signal(:)';
len     = length(signal);
coefs   = zeros(length(scale),len);

% Morlet Wavelet

% psi_xval correspond to time
% psi_integ is the complex values of the Morlet Wavelet

%[psi_integ,psi_xval]  = morletbb(-4,4,1024);
[psi_integ,psi_xval]  = morletbb(-4,4,4096);

%figure
%plot(psi_xval,real(psi_integ),'r--')
%hold on
%plot(psi_xval,imag(psi_integ),'b')
%grid
%xlabel('time')
%ylabel('Wavelet')
%title('Morlet Wavelet, real part (dashed line) and imaginary part (solide line)')

psi_xval=psi_xval-psi_xval(1);

ind=1;
% h=waitbar(0,'wavelet processing ')

for  a=scale
    
    j = [1+floor([0:a*psi_xval(length(psi_xval))]/(a*psi_xval(2)))];
    
    if length(j)==1
       
       j = [1 1]; 
       
    end
    
    % Y= wkeep1(X,L) extracts the vector Y 
    % from the vector X. L is the length of result Y.
    
    % Eq (3) in ref: Lee and Yamamoto
    
    coefs(ind,:)=-sqrt(a)*wkeep1(diff(conv(signal,fliplr(psi_integ(j)))),len); 
    
    ind= ind+1;
 %  waitbar(ind/length(scale),h)   

end

%close(h)  

