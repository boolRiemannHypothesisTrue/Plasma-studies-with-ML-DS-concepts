% Test
clc; clear; 

Te = 3 * 1e3; % [eV]
Ti = Te; 

B = SI2cgs(5,'Magnetic Field'); % Gauss
n = SI2cgs(1e20, 'Density'); % [cm^-3]
ne = n;
ni = n;

Z = 1;
A = 2; 

F = FundamentalPlasma(); 

% Times
fprintf('lnA = %f\n',F.getCoulombLog(ne,Te));
fprintf('tau_ce = %d\n',2*pi/F.getElectronGyroFreq(B)); 
fprintf('tau_pe = %d\n',2*pi/F.getElecPlasmaFreq(ne)); 
fprintf('tau_pe = %d\n',2*pi/F.getIonPlasmaFreq(ni,Z,A)); 
fprintf('tau_ci = %d\n',2*pi/F.getIonGyroFreq(B,Z,A));
fprintf('tau_ee = %d\n',F.getElElCollTime(ne,Te)); 
fprintf('tau_ii = %d\n',F.getIonIonCollTime(ni,Z,A,Ti,Te)); 
fprintf('tau_E = %d\n',F.getEnergyEqmTime(ne,Te,A)); 
fprintf('\n');
% Lengths
fprintf('rLe = %d\n',cgs2SI(F.getElecGyroRadius(Te,B),'Length'));
fprintf('lamD = %d\n',cgs2SI(F.getDebyeLen(ne,Te),'Length'));
fprintf('del_e = %d\n',cgs2SI(F.getElecSkinDepth(ne),'Length'));
fprintf('rLi = %d\n',cgs2SI(F.getIonGyroRadius(Ti,B,Z,A),'Length'));
fprintf('del_i = %d\n',cgs2SI(F.getIonSkinDepth(ni,Z,A),'Length'));
fprintf('lam_ii = %d\n',cgs2SI(F.getIonIonMfp(ni,Z,A,Ti,Te),'Length'));
fprintf('lam_ee = %d\n',cgs2SI(F.getElElMfp(ne,Te),'Length'));