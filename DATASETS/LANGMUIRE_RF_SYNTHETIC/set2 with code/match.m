function[VV,II]=match(V,I)
% This software acts the bring two sets of data points vectors to have the same number of element. 
if length(V)>length(I);
    k=((length(V)-length(I)));
    N=length(V);
    NN=floor(N/k);
    V(NN:NN:length(V))=[];
end
if length(V)<length(I);
    k=((length(I)-length(V)));
    N=length(I);
    NN=floor(N/k);
    I(NN:NN:length(I))=[];
end
VV=V;
II=I;

    
        
    