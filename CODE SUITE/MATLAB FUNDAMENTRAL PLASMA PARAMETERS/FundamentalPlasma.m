% Fundamental Plasma Functions - CGS gaussian units
%
% All inputs are in cgs gaussion units except Temperature which is in [eV]
% Use cgs2SI and SI2cgs to convert between Sia nd cgs units
% Use physicalConstants-SI and physicalConstants-cgs for values of
% constants
%
% EXAMPLE USAGE:
%
% B = SI2cgs(5,'Magnetic Field'); % Magnetic field, Gauss
% n = SI2cgs(1e20, 'Density'); % Electron density [cm^-3]
% F = FundamentalPlasma(); % create object
% F.getElectronGyroFreq(B); % Electron gyro frequency, [s^-1]
% cgs2SI(F.getIonGyroRadius(Ti,B,Z,A),'Length')) % Ion gyro radis in [m]
%
% Reference(s):
% ?Shea, J. J. (2003). A plasma formulary for physics, technology, and astrophysics [Book Review].
%  IEEE Electrical Insulation Magazine, 19(1), 52?52. https://doi.org/10.1109/mei.2003.1178121

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright 2021 Rishabh Datta, MIT
%%%%%%%%%%%%%%%%%%%%%%%%%%
classdef FundamentalPlasma
    properties
    end
    methods
        function obj = FundamentalPlasma()            
        end
        % Frequencies [rad/s]
        function out = getElectronGyroFreq(~,B) % Electron gyro-frequency
            % Returns electron gyro-frequency
            % Inputs:
            %   B = magnetic field [Gauss]
            % w_ce = eB/me.c [rad/s]
            out = 1.76e7 * B; % [rad/s]
        end 
        function out = getIonGyroFreq(~,B,Z,A) % Ion gyro-frequency
            % Inputs:
            %   B [Gauss] = Magnetic field
            %   Z [-] = Ionization
            %   A [-] = Atomic weight, ion mass / proton mass
            out = 9.58e3 .* Z ./ A .* B; % [rad/s]
        end 
        function out = getElecPlasmaFreq(~,ne) % Electron plasma freq.
            % Inputs:
            %       ne [cm^-3] = electron number density
            out = 5.64e4 * sqrt(ne); % [rad/s]
        end
        function out = getIonPlasmaFreq(~,ni,Z,A) % Ion plasma freq.
            % Inputs:
            %   ni [cm^-3] = ion number density
            %   Z [-] = Ionization
            %   A [-] = Atomic weight, ion mass / proton mass
            out = 1.32e3 .* Z .* A .^ (-0.5) .* sqrt(ni); % [rad/s]
        end
        function out = getElElCollFreq(obj,ne,Te) % Electron-Electron Collison Freq
            % ne [cm^-3] = electron number density
            % Te [eV] = electron temperature
            lnA = obj.getCoulombLog(ne,Te); % coulomb logarithm
            out = 2.91e-6 .* ne * lnA .* Te^(-3/2); % 1/sec
        end 
        function out = getElIonCollFreq(obj,ne,Te) % Electrin-Ion Collision freq
            out = 2 * obj.getElElCollFreq(ne,Te); % [s^-1]
        end 
        function out = getIonIonCollFreq(obj,ni,Z,A,Ti,Te) % Ion-Ion Collison Freq
            % Inputs:
            %   ni [cm^-3] = Ion numbe density
            %   Z [-] = Ionization
            %   A [-] = Atomic weight, ion mass / proton mass
            %   Ti, Te [eV] = Ion, Electron temperature
            lnA = obj.getCoulombLog(Z*ni,Te); % coulomb logarithm
            out = 4.8e-8 .* Z.^4 .* A^(-1/2) .* ni .* lnA .* Ti.^(-3/2); 
        end
        function out = getIonElCollFreq(obj,ne,Te,A) % Ion-Electron Collison Freq
            out = A * obj.getElIonCollFreq(ne,Te); 
        end
        % Characteristic Times
        function out = getElElCollTime(obj,ne,Te)
            out = 1 ./ obj.getElElCollFreq(ne,Te); % [s]
        end
        function out = getIonIonCollTime(obj,ni,Z,A,Ti,Te)
            out = 1 ./ obj.getIonIonCollFreq(ni,Z,A,Ti,Te); % [s]
        end
        function out = getEnergyEqmTime(obj,ne,Te,A) % Energy Equilibriation time
            % INPUTS:
            %       ne [cm^-3] = electron number density
            %       Te [eV] = electron temperature
            %       A [-] = atomic mass, ion mass / proton mass
            load physicalConstants-cgs me mp
            out = 1/2 * A * mp / me .* obj.getElElCollTime(ne,Te); 
        end
        % Lengths [cm]
        function out = getElecDeBrogLen(~,Te) % Electron de Broglie length
            % Inputs:
            %   Te [eV] = electron temp.
            out = 2.76e-8 .* Te.^(-0.5); % [cm]
        end
        function out = getClasMinApproach(~,Te) % Classic dist. of minimum approach
            % Inputs:
            %   Te [eV] = electron temp.
            out = 1.44e-7 .* (1./Te); % [cm], electron temperature
        end
        function out = getElecGyroRadius(~,Te,B) % Electron Gyro-radius
            % Inputs:
            %   Te [eV] = electron temperature
            %   B [Gauss] = magnetic field
             out = sqrt(2) * 2.38 .* Te .^ 0.5 * (1./B); % [cm]
        end
        function out = getIonGyroRadius(~,Ti,B,Z,A) % Ion Gyro-Radius
            % Inputs:
            %   Ti [eV] = ion temperature
            %   B [Gauss] = magnetic field
            %   Z [-] = Ionization
            %   A [-] = Atomic weight, ion mass / proton mass
            out = sqrt(2) * 1.02e2 * A.^(0.5) * Z.^-1 * Ti.^0.5 * B.^-1; % [cm]
        end 
        function out = getDebyeLen(~,n,T) % Debye length
            % Inputs:
            % n [cm^-3] = elec. number density
            % T [eV] = temperature
            out = sqrt(2) * 7.43e2 * T.^0.5 * n.^(-0.5); % [cm]
        end
        function out = getElecSkinDepth(obj,ne) % Electron Skin Depth
            % Inputs:
            %       ne [cm^-3] = electron number density
            load physicalConstants-cgs c
            out = c ./  obj.getElecPlasmaFreq(ne); % cm
        end
        function out = getIonSkinDepth(obj,ni,Z,A) % Ion Skin depth
            % Inputs:
            %   ni [cm^-3] = ion number density
            %   Z [-] = Ionization
            %   A [-] = Atomic weight, ion mass / proton mass
            load physicalConstants-cgs c
            out = c /  obj.getIonPlasmaFreq(ni,Z,A); % [cm]
        end
        function out = getElElMfp(obj,ne,Te) % Electron-Electron mean free Path
            % Inputs:
            %   ne [cm^-3] = electron number density
            %   Te [eV] = electron temperature
            out = obj.getElecThermalVel(Te) .* obj.getElElCollTime(ne,Te); % [cm]
        end
        function out = getIonIonMfp(obj,ni,Z,A,Ti,Te) % Ion-Ion mfp
            % Inputs:
            %   ni [cm^-3] = Ion numbe density
            %   Z [-] = Ionization
            %   A [-] = Atomic weight, ion mass / proton mass
            %   Ti, Te [eV] = Ion, Electron temperature
            out = obj.getIonThermalVel(Ti,A) .* obj.getIonIonCollTime(ni,Z,A,Ti,Te);  
        end
        function out = getElecInerLen(~,ne) % Electron inertial length
            % Inputs:
            %   ne [cm^-3] = electron number density
            out = 5.31e5 * ne.^(-0.5); % [cm]
        end
        function out = getIonInerLen(~,ni,Z,A) % Ion inertial length
            % Inputs:
            %   ni [cm^-3] = ion number density
            %   Z [-] = Ionization
            %   A [-] = Atomic weight, ion mass / proton mass
            out = 2.28e7 * Z.^(-1) .* (A ./ ni)^0.5; % [cm] 
        end
        % Velocities [cm/s]
        function out = getElecThermalVel(~,Te) % Electron thermal velocity
            % Inputs:
            %   Te [eV] = Electron temp.
            out = sqrt(2) * 4.19e7 * Te.^0.5; % [cm/s]
        end
        function out = getIonThermalVel(~,Ti,A) % Ion thermal velocity
            % Inputs:
            %   Ti [eV] = ion temp.
            %   A [-] = Atomic weight, ion mass / proton mass
            out = sqrt(2) * 9.79e5 .* A^-0.5 .* Ti.^0.5; % [cm/s]
        end
        function out = getIonSoundSpeed(~,Te,Z,A,gamma) % Ion sound speed
            % Inputs:
            %   Te [eV] = electron temp.
            %   Z [-] = Ionization
            %   A [-] = Atomic weight, ion mass / proton mass
            %   gamma [-] = Adiabatic const.
            out = 9.79e5 .* (gamma .* Z .* Te / A).^0.5; % [cm/s]
        end
        function out = getAlfvenSpeed(~,B,A,ni) % Alfven speed
            % Inputs:
            %   B [Gauss] = Magnetic field
            %   A [-] = Atomic weight, ion mass / proton mass
            %   ni [cm^-3] = Ion number denisty
            out = 2.18e11 * A.^(-0.5) .* ni.^(-0.5) .* B; % [cm/s]
        end
        % Misc.
        function out = getBohmDiffConst(~,T,B) % Bohm diffusion const.
            % Inputs:
            %   T [eV] = Temperature
            %   B [gauss] = Magnetic field
            out = 6.25e6 .* T .* (1./B); % [cm^2/s]
        end
        function out = getTransSpitzerRes(obj,Z,T,n) % eta_perp, Transverse spitzer resitivity
            % Inputs:
            %   Z [-] = Ionization
            %   T [eV] = Temperature
            %   n [cm^-3] = electron number density
            lnA = obj.getCoulombLog(n,T); 
            out = 1.03e-2 .* Z * lnA * T.^(-3/2); % [Ohm-cm]
        end
        function out = getParSpitzerRes(obj,Z,T,n) % eta_perp, Transverse spitzer resitivity
            % Inputs:
            %   Z [-] = Ionization
            %   T [eV] = Temperature
            %   n [cm^-3] = electron number density
            out = 0.5 * obj.getTransSpitzerRes(Z,T,n);
        end
        function out = getParIonViscosity(obj,ni,Ti,Te,Z,A) % Parallel viscosity [SI output]
             % Inputs:
            %   Z [-] = Ionization
            %   Ti [eV] = Ion Temperature
            %   ni [cm^-3] = Ion number density
            
            tau_i = obj.getIonIonCollTime(ni,Z,A,Ti,Te); % s
            % convert to SI
            ni = cgs2SI(ni,'Density'); % m^-3
            load physicalConstants-SI.mat E0
            Ti = Ti * E0; % [J]
            
            out = 0.96 * ni * Ti * tau_i; % [kg/m^3 * m^2/s]
            
        end
        function out = getCoulombLog(obj,n,T) % Coulomb logarithm
            % n [cm^-3] = electron number density
            % T [eV] = temperature
            lamD = obj.getDebyeLen(n,T); % Debye length, [cm]
            out = log(12 * pi .* n .* lamD.^3); 
        end
        function out = getGamma(~,ni,Te)
            p = 1.6e-12 * ni .* Te .* (1 + 0.63 .* sqrt(Te) - 2.76e-8 .* ni.^(1/3));
            re = 1.6e-12 .* ni .* ( 1.43 .* sqrt(Te) + 4.2 .* Te + Te.^1.5 .*...
                (1.3 - 0.315.* log(ni * 1e-23 ./ Te)));
            out = 1 + p ./ re;
        end % adiabatic index for ionizing plasma
        % Kinetic theory
        function out = getMaxwellDist1D(~,v,vth) % 1D Normalized Maxwellian Distribution
            % Inputs:
            %   v [cm/s] = velocity
            %   vth [cm/s] = sqrt(2 * kb * T / m) = thermal velocity
            out = (pi * vth^2)^(-1/2) .* exp(-v.^2./vth^2); 
        end
        function out = getMaxwellDist(~,v,vth) % 3D Normalized Maxwellian Distribution
            % Inputs:
            %   v [cm/s] = velocity
            %   vth [cm/s] = sqrt(2 * kb * T / m) = thermal velocity
            out = (pi * vth^2)^(-3/2) .* exp(-v.^2./vth^2); 
        end
        % MHD Theory
        function out = collisionalityCriterion(obj,ni,Z,A,Ti,Te,a) % Check if plasma is highly collisional
            % Inputs:
            %   ni [cm^-3] = Ion numbe density
            %   Z [-] = Ionization
            %   A [-] = Atomic weight, ion mass / proton mass
            %   Ti, Te [eV] = Ion, Electron temperature
            %   a [cm] = Chaacteristic plasma length
            load physicalConstants-cgs mp me
            out = sqrt(A * mp / me) .* (1./a) .* obj.getIonIonMfp(ni,Z,A,Ti,Te); % << 1 for highly collisonal
        end
    end
end