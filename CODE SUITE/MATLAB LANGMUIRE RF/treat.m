function [xx,yy]=treat(x,y);
% this file is for sorting a set of x-y values is assending order in x with
% corresponding y values
z=[x;y];
z=z';
size(z);
zz=sortrows(z,1);
xx=zz(:,1);
yy=zz(:,2);