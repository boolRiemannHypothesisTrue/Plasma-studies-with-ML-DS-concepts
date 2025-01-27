function [Vup,Iup,Vdown,Idown]=separate(V,I)
% This sofware seperates data points acquired when Langmuir probe voltage
% is increasing from those acquired when the voltage is decreasing. The
% later are excluded because they are usually affected by probe plasma
% sheet collapse and delayed re-build up when fast data acquisition is used
Vup=[];
Vdown=[];
Iup=[];
Idown=[];
for i=1:length(V)-1
    if V(i+1)>V(i)
        Vup=[Vup V(i)];
        Iup=[Iup I(i)];
    end
    if V(i+1)<V(i)
        Vdown=[Vdown V(i)];
        Idown=[Idown I(i)];
    end
end
    