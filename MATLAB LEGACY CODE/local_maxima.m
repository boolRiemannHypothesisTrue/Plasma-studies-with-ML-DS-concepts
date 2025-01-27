%local maxima of Datax time

 function [Imax] = local_maxima(Datax);
 if length(Datax)<5
     'data length <5'
     return
 end
Imax = find(diff(sign(diff(Datax)))==-2)+1;
return
