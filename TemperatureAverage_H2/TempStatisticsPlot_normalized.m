% Time to plot
% What do you want to plot? 
% Mass fractions: 
% Reactions: 
clear all
clc
Rplots = [1 3 8 9 11 12 13];
load('Data_0.mat') % Load laminar data
load('Data_4730.mat') % Maximum stretch data
load('TempBinH2.mat')
Ka = [1 4 12 36];

%% Plotting for Reactions
Reactions = char('O+H_2{\rightarrow}H+OH','H_2+OH{\rightarrow}H_2O+H','H+OH+M{\rightarrow}H_2O+M','H+O_2(+M){\rightarrow}HO_2(+M)', ...
    'HO_2+H{\rightarrow}OH+OH','HO_2+O{\rightarrow}O_2+H_2O','HO_2+OH{\rightarrow}H_2O+O_2');

for i = 1 : 1 : length(Rplots)
    figure(Rplots(i))
    for jj = 1 : 1 : length(Ka)
        plot(BinTemp(:,jj),BinRR(:,Rplots(i),jj)/max(BinRR(:,Rplots(i),jj)),'LineWidth',3)
%         plot(BinY(:,4,jj),BinRR(:,Rplots(i),jj),'LineWidth',3)
        hold on
    end
    plot(Temp0,RXN_Rate0(:,Rplots(i))/max(RXN_Rate0(:,Rplots(i))),'--k','LineWidth',3)
    plot(Tempm,RXN_Ratem(:,Rplots(i))/max(RXN_Ratem(:,Rplots(i))),':k','LineWidth',3)
    hold on
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/H2/H2_Le1.mat')
    plot(Temp,RXN_Rate(:,Rplots(i))/max(RXN_Rate(:,Rplots(i))),'--b','LineWidth',3)
    clear X Temp AxialVel dist hdot_total HR MW X Y RXN_Rate
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/H2/H2_Le1m.mat')
    plot(Temp,RXN_Rate(:,Rplots(i))/max(RXN_Rate(:,Rplots(i))),':b','LineWidth',3)
    clear X Temp AxialVel dist hdot_total HR MW X Y RXN_Rate
    xlabel('$Temperature(K)$','Interpreter','latex')
%     ylabel('$RR(1/m^3-s)$','Interpreter','latex')
    ylabel('$RR/RR_{max}$','Interpreter','latex')
    str = char(Reactions(i,:));
    title(['$' str '$'],'Interpreter','latex')
    set(gca,'FontSize',24)
    grid on
end
wfuel = 0;
wfuelm = 0;
load('/home/debolina/chemkin/Kinetics/Hydrogen_Air_Dryer/Analysis/coefficients_HydrogenMechanism.mat')

load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/H2/H2_Le1.mat')
wfuelLe1 = 0;
RXN_RateLe1 = RXN_Rate;
TempLe1 = Temp;
clear X Temp AxialVel dist hdot_total HR MW X Y RXN_Rate
load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/H2/H2_Le1m.mat')
wfuelLe1m = 0;
RXN_RateLe1m = RXN_Rate;
TempLe1m = Temp;
clear X Temp AxialVel dist hdot_total HR MW X Y RXN_Rate
for i = 1 : 1 : 21
    
    wfuel = wfuel + destruction_coeff(i,1) * RXN_Rate0(:,i) - formation_coeff(i,1) * RXN_Rate0(:,i);
    wfuelm = wfuelm + destruction_coeff(i,1) * RXN_Ratem(:,i) - formation_coeff(i,1) * RXN_Ratem(:,i);
    wfuelLe1 = wfuelLe1 + destruction_coeff(i,1) * RXN_RateLe1(:,i) - formation_coeff(i,1) * RXN_RateLe1(:,i);
    wfuelLe1m = wfuelLe1m + destruction_coeff(i,1) * RXN_RateLe1m(:,i) - formation_coeff(i,1) * RXN_RateLe1m(:,i);
end

    for jj = 1 : 1 : length(Ka)
        figure(211)
        plot(BinTemp(:,jj),BinWf(:,jj)/max(BinWf(:,jj)),'LineWidth',3)
        hold on
    end
    
    plot(Temp0,wfuel/max(wfuel),'--k','LineWidth',3)
    plot(Tempm,wfuelm/max(wfuelm),':k','LineWidth',3)   
    plot(TempLe1,wfuelLe1/max(wfuelLe1),'--b','LineWidth',3)
    plot(TempLe1m,wfuelLe1m/max(wfuelLe1m),':b','LineWidth',3)
    xlabel('$Temperature(K)$','Interpreter','latex')
    ylabel('$\dot{\omega}_{fuel}(kg/m^3-s)$','Interpreter','latex')
    set(gca,'FontSize',24)
    grid on

    figure(455)
    for jj = 1 : 1 : length(Ka)
        plot(BinTemp(:,jj),BinHR(:,jj)/max(BinHR(:,jj)),'LineWidth',3)
        hold on
    end
    plot(Temp0,hdot_total0/max(hdot_total0),'--k','LineWidth',3)
    plot(Tempm,hdot_totalm/max(hdot_totalm),':k','LineWidth',3)
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/H2/H2_Le1.mat')
    plot(Temp,hdot_total/max(hdot_total),'--b','LineWidth',3)
    clear X Temp AxialVel dist hdot_total HR MW X Y RXN_Rate
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/H2/H2_Le1m.mat')
    plot(Temp,hdot_total/max(hdot_total),':b','LineWidth',3)
    clear X Temp AxialVel dist hdot_total HR MW X Y RXN_Rate
    xlabel('$Temperature(K)$','Interpreter','latex')
    ylabel('$\dot{q}(J/m^3)$','Interpreter','latex')
    set(gca,'FontSize',24)
    grid on

