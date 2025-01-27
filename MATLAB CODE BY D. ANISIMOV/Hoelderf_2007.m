 
%%%%%%%%% Hoelder exponent from Morlet wavelet
 %%%%%%%%%%%%%%%%%%%wavelet decomposition
 %singularity analysis in time series 
%Datax - time series signal
% falfa(alfa)- scaling exponent
%alfaerr - ERROR in alfa
%falfaerr - ERROR in falfa
%%
%%%  Nuzhno - vybirat' diapazon analiza wavelet!!! - xdiap 

 function [Multifractality ,q,h,Dh,Zqa,tau,Ptau,xdiap] = Hoelderf_2007(Datax );
    
   global Zqa Dqa hqa 
   clear Tpsi

   Datax=((Datax-mean(Datax))/std(Datax));
   Nx=length(Datax) 

   %%%%%%% wavelet decomposition 
   wname='0';
  %xdiap=2.^([1:0.5:(2*floor(log2(Nx)/2)-3)]);
    xdiap=2.^([0.25:0.25:8]);  
    %xdiap= 2:100;
   lentt=length(xdiap);
 
   cmorl  = cwtbb(Datax ,xdiap,wname  );
   %cmorlm  = cwt(Datax ,xdiap,'morl'  );
   lx=log2(xdiap);
  % Tpsi=abs(cmorl);
   %%%%%%%%%%%%%%  NUZHNO OTFILTROVAT na kazhdom urovne - svoy filter
     %%%%%% filtering    to smooth oscillations in wavelet abs for 3,5,7,9,... a levels
 
   for ia=1:lentt 
       [b1,a1]=ellip(6,0.05,30,1.1/xdiap(ia));
     % Tpsi(ia,:)=filtfilt(b1,a1,abs(cmorl(ia,:))/(xdiap(ia)^1.5));  
     Tpsi(ia,:)=filtfilt(b1,a1,abs(cmorl(ia,:)) );  
   end
   %plot(1:Nx,abs(cmorl(ia,:)),'b',1:Nx,Tpsi(ia,:),'r')
   %contourf(Tpsi,20)
  %%%%%%%%%%%%%%% Hoelder exponent local   %%%%%%%%%%%%%%%%%%%%%%%%%%
  
 % for iti=1:Nx
  %[PD,SD] =  polyfit( log10(xdiap(2:lentt))', log10(abs(cmorl (2:lentt,iti))),1);
  %[PD,SD] =  polyfit( log10(xdiap(2:lentt))', log10(Tpsi(2:lentt,iti)),1);
  %[YD,DELTA] =  polyval(PD,log10(xdiap(2:lentt)) ,SD) ; 
  %He(iti)= PD(1);
  %Herr(iti)=mean(abs( DELTA));
  %end
 
%He=He/2;  %  eto tak sootvetstvuet alfa i Hoelder exponent
%%%%%%%%%%%%%%%% end Hoelder
 
  %%%  
    %q=[-4 -3   -2 -1.5  -1 -0.5 -0.3 -0.1 0 0.1 0.3 0.5  1 1.5 2   3 4]; 
  %q=[-4 -3   -2 -1.5  -1 -0.5 -0.3 -0.1  ]; 
    q=[-9:0.1:9];
   % q=[-4:0.1:10];
   lenq=length(q);
    
    
   %maximums finding and Z matrix
   for iq=1:lenq  % loop for q
      qt=q(iq);
       for ia=1:lentt
          [Imax  ] = local_maxima(Tpsi(ia,:));
      %plot(Imax,ia*ones(size(Imax)),'.') %%% plot of skeleton of singularities
     %hold on
     %
          Tpsiqa=(Tpsi(ia,Imax).^qt);
          Tpsiqa=Tpsiqa/sum(Tpsiqa);
          Tpsiqah=Tpsiqa.*log(Tpsi(ia,Imax));
          TpsiqaD=Tpsiqa.*log(Tpsiqa);
          Zqa(iq,ia)=sum(Tpsi(ia,Imax).^qt);
          hqa(iq,ia)=sum(Tpsiqah);
          Dqa(iq,ia)=sum(TpsiqaD);
          
          clear Imax Tpsiqah TpsiqaD
       end
   %%%%%%%%%%%% h(q)
  
   [Ph,Sh] =  polyfit( log(xdiap), hqa(iq,:),1);
  [Yz,DELTAh] =  polyval(Ph,log(xdiap) ,Sh) ; 
  h(iq,1)= Ph(1); 
  h(iq,2)=mean(abs( DELTAh));
  %herr(iq)=mean(abs( DELTAh));
  %%%%%%%%%%%% D(q)
  
   [PDh,SDh] =  polyfit( log(xdiap), Dqa(iq,:),1);
  [Yz,DELTAhD] =  polyval(PDh,log(xdiap) ,SDh) ; 
  Dh(iq,1)= PDh(1); 
  Dh(iq,2)=mean(abs( DELTAhD));
  %Dherr(iq)=mean(abs( DELTAhD));
 
   end % iq %%%%%
   %%% tay(q)
  
   for iq=1:lenq  % loop for q
      Iq0=find(q==0); 
    [Pz,Sz] =  polyfit( log(xdiap), log(Zqa(iq,:)./Zqa(Iq0,:)),1);
    [Yz,DELTAz] =  polyval(Pz,log(xdiap) ,Sz) ; 
    tau(iq,1)= Pz(1); 
    tau (iq,2)=mean(abs( DELTAz));
   %tauerr(iq)=mean(abs( DELTAz));
   end % iq %%%%%
 Multifractality=(max(h(:,1))-min(h(:,1)));

 [Ptau,Stau] =  polyfit( q', tau(:,1),2);
  [Ytau,DELTAtau] =  polyval(Ptau,q ,Stau) ; 
  tauerr(iq)=mean(abs( DELTAtau));
  
%   if nargin>1 
  figure()
  subplot(2,2,1)
   plot(h(:,1),Dh(:,1) ,'ok')
  ylabel('D(h)','FontName','Times','FontSize',14)
  xlabel('h','FontName','Times','FontSize',14)
   set(gca ,'FontSize',16,'LineWidth' ,2)
 whitebg('white')
 set(gcf,'Color','white')
 
   subplot(2,2,2)
  plot(q,h(:,1),'ok') 
    ylabel('h','FontName','Times','FontSize',14)
  xlabel('q','FontName','Times','FontSize',14)
  title(['Multifractality=',num2str(max(h(:,1))-min(h(:,1))) ])
 set(gca ,'FontSize',16,'LineWidth' ,2)
 whitebg('white')
 set(gcf,'Color','white')
 

  subplot(2,2,3)
  plot(q,Dh(:,1) ,'ok')
    ylabel('D(q)','FontName','Times','FontSize',14)
  xlabel('q','FontName','Times','FontSize',14)
 set(gca ,'FontSize',16,'LineWidth' ,2)
 whitebg('white')
 set(gcf,'Color','white')
 
  subplot(2,2,4)
  plot(q,tau(:,1) ,'ok')
  ylabel('\tau (q)','FontName','Times','FontSize',14)
  xlabel('q','FontName','Times','FontSize',14)
title(['scaling=',num2str(Ptau(2)),'q',num2str(Ptau(1)),'q^2'])
 set(gca ,'FontSize',16,'LineWidth' ,2)
 whitebg('white')
 set(gcf,'Color','white')
%  
%   end %%%if 

   
% singularity spectrum D(h)
%hh=0:0.1:1
%for ih=1:length(hh);
%hd=hh(ih);
%D(ih)=min(hd*q-tau);
%end
 %plot(hh,D)
% 
%plot(log(xdiap),Dqa(1,:))
%%%%%%%%%% for moments

  
 %%%%%%%%%% plot at given a
 % Tpsi=abs(cmorl);
 % plot(500*Tpsi(15,:),'s')
 %;hold on;
 %plot( ( (diff(Tpsi(15,:)))),'or')
 %;hold on;
 %plot((sign(diff(Tpsi(15,:)))),'og')
 %;hold on;
 %plot(diff(sign(diff(Tpsi(15,:)))),'sy')
 %grid
 %Imax = find(diff(sign(diff(Tpsi(15,:))))==-2)+1;
 %plot(Imax,ones(size(Imax)),'>r')
 % hold off

%%%%%%%%%%%%%% plot of Hoelder
%figure(77)
%subplot(2,1,1)
%plot(Datax)
%ylabel('signal','FontName','Times','FontSize',14),

%subplot(2,1,2)
%plot(He)
%title(['Degree of multifractality=',num2str(Multifractality)],'FontName','Times','FontSize',14),
%ylabel('Hoelder exp. h=alfa/2','FontName','Times','FontSize',14),
%xlabel('time','FontName','Times','FontSize',14),
 
%figure(14)
 %colg='obogorocsbsgsk>b>g>r>c';
 %for irc=4:4:40
 %plot(log10(xdiap),log10(Zqa(irc  ,:)./Zqa(find(q==0) ,:)),colg(2*irc/4-1:2*irc/4))
%plot(log10(xdiap),log10(hqa(irc  ,:) ),colg(2*irc/4-1:2*irc/4))
 %hold on
 %end 
% hold off
% ylabel('Z(q,a)','FontName','Times','FontSize',14),
% xlabel('log10(a)','FontName','Times','FontSize',14),
%  set(gca ,'FontSize',16,'LineWidth' ,2)
% whitebg('white')
% set(gcf,'Color','white')
 
  return