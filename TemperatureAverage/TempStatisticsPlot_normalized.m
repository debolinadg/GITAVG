% Time to plot
% What do you want to plot? 
% Mass fractions: H(2) OH(5) HO2(7) H2O(6) H2O2(8) CH3(13) CH4(14) HCO(17) CH2O(18)
% CO(15) CO2(16) C2H4(25) C2H6(27) 
% Reactions: 1,3,7,8,10,14,16,26,33,35,45,64,65,70,75,258-279
clear all
clc
Yplots = [2 5 6 7 8 13 14 15 16 17 18 25 27];
Rplots = [3 10 11 13 15 17 32 33 42 44 45 51 52 86 97 98 156 165 166 176];
load('Data_0.mat') % Load laminar data
load('Data_605.mat') % Maximum stretch data
load('TempBinMethane.mat')
Ka = [1 4 36];


%% Plotting for Reactions
Reactions = char('O+H_2{\rightarrow}H+OH','O+CH_3{\rightarrow}CH_2O+H','O+CH_4{\rightarrow}CH_3+OH','O+HCO{\rightarrow}OH+CO', ...
    'O+CH_2O{\rightarrow}OH+HCO)','O+CH_3O{\rightarrow}OH+CH_2O','O_2+CH_2O{\rightarrow}HO_2+HCO','H+O_2(+M){\rightarrow}HO_2(+M)','H+OH+M{\rightarrow}H_2O+M','H+HO_2{\rightarrow}O_2+H_2', ...
    'H+HO_2{\rightarrow}2OH','H+CH_3(+M){\rightarrow}CH_4(+M)','H+CH_4{\rightarrow}CH_3+H_2','OH+HO_2{\rightarrow}O_2+H_2O','OH+CH_4{\rightarrow}CH_3+H_2O','OH+CO{\rightarrow}CO_2+H', ...
    '2CH_3(+M){\rightarrow}C_2H_6(+M)','HCO+M{\rightarrow}H+CO+M','HCO+O_2{\rightarrow}HO_2+CO','O+CH_3{\rightarrow}H+H_2+CO');

for i = 1 : 1 : length(Rplots)
    figure(Rplots(i))
    for jj = 1 : 1 : length(Ka)
        plot(BinTemp(:,jj),BinRR(:,Rplots(i),jj)/max(BinRR(:,Rplots(i),jj)),'LineWidth',3)
%         plot(BinY(:,4,jj),BinRR(:,Rplots(i),jj),'LineWidth',3)
        hold on
    end
    plot(Temp0,RXN_Rate0(:,Rplots(i))/max(RXN_Rate0(:,Rplots(i))),'--k','LineWidth',3)
    plot(Tempm,RXN_Ratem(:,Rplots(i))/max(RXN_Ratem(:,Rplots(i))),':k','LineWidth',3)
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/CH4/CH4_Le1.mat')
    plot(Temp,RXN_Rate(:,Rplots(i))/max(RXN_Rate(:,Rplots(i))),'--b','LineWidth',3)
    clear X Temp AxialVel dist hdot_total HR MW X Y RXN_Rate
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/CH4/CH4_Le1m.mat')
    plot(Temp,RXN_Rate(:,Rplots(i))/max(RXN_Rate(:,Rplots(i))),':b','LineWidth',3)
    clear X Temp AxialVel dist hdot_total HR MW X Y RXN_Rate
    hold on
    xlabel('$Temperature(K)$','Interpreter','latex')
    ylabel('$RR/RR_{max}$','Interpreter','latex')
    str = char(Reactions(i,:));
    title(['$' str '$'],'Interpreter','latex')
    set(gca,'FontSize',24)
    grid on
end
wfuel = 0;
wfuelm = 0;
load('/home/debolina/chemkin/Methane_Kinetics/Analysis/coefficients_MethaneMechanism.mat')
load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/CH4/CH4_Le1.mat')
wfuelLe1 = 0;
RXN_RateLe1 = RXN_Rate;
TempLe1 = Temp;
clear X Temp AxialVel dist hdot_total HR MW X Y RXN_Rate
load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/CH4/CH4_Le1m.mat')
wfuelLe1m = 0;
RXN_RateLe1m = RXN_Rate;
TempLe1m = Temp;
clear X Temp AxialVel dist hdot_total HR MW X Y RXN_Rate
for i = 1 : 1 : 217
    
    wfuel = wfuel + destruction_coeff(i,14) * RXN_Rate0(:,i) - formation_coeff(i,14) * RXN_Rate0(:,i);
    wfuelm = wfuelm + destruction_coeff(i,14) * RXN_Ratem(:,i) - formation_coeff(i,14) * RXN_Ratem(:,i);
    wfuelLe1 = wfuelLe1 + destruction_coeff(i,14) * RXN_RateLe1(:,i) - formation_coeff(i,14) * RXN_RateLe1(:,i);
    wfuelLe1m = wfuelLe1m + destruction_coeff(i,14) * RXN_RateLe1m(:,i) - formation_coeff(i,14) * RXN_RateLe1m(:,i);
end
 figure(567)
    for jj = 1 : 1 : length(Ka)
        plot(BinTemp(:,jj),BinWf(:,jj)/max(BinWf(:,jj)),'LineWidth',3)
        hold on
    end
    plot(Temp0,wfuel/max(wfuel),'--k','LineWidth',3)
    plot(Tempm,wfuelm/max(wfuelm),':k','LineWidth',3)
    plot(TempLe1,wfuelLe1/max(wfuelLe1),'--b','LineWidth',3)
    plot(TempLe1m,wfuelLe1m/max(wfuelLe1m),':b','LineWidth',3)
    xlabel('$Temperature(K)$','Interpreter','latex')
    ylabel('$\dot{\omega}_{fuel}/\dot{\omega}_{fuel,max}$','Interpreter','latex')
    set(gca,'FontSize',24)
    grid on

    
    figure(455) 
    for jj = 1 : 1 : length(Ka)
        plot(BinTemp(:,jj),BinHR(:,jj)/max(BinHR(:,jj)),'LineWidth',3)
        hold on
    end
    plot(Temp0,hdot_total0/max(hdot_total0),'--k','LineWidth',3)
    plot(Tempm,hdot_totalm/max(hdot_totalm),':k','LineWidth',3)
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/CH4/CH4_Le1.mat')
    plot(Temp,hdot_total/max(hdot_total),'--b','LineWidth',3)
    clear X Temp AxialVel dist hdot_total HR MW X Y RXN_Rate
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/CH4/CH4_Le1m.mat')
    plot(Temp,hdot_total/max(hdot_total),':b','LineWidth',3)
    clear X Temp AxialVel dist hdot_total HR MW X Y RXN_Rate
    xlabel('$Temperature(K)$','Interpreter','latex')
    ylabel('$\dot{q}/\dot{q}_{max}$','Interpreter','latex')
    set(gca,'FontSize',24)
    grid on