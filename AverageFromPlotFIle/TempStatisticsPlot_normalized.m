clear all
clc

workdir = '/home/debolina/DNS/c12/AverageFromPlotFIle/';
cd(workdir)

Ka = [1 4 12 36 108];
n = 347; % Number of components extracted: Y(56) RR(289) Wf(1) HR(1)
NReacs = 289;
NSpecies = 56;

load('TempBinC12.mat')
Rplots = [7 10 16 26 35 70 235 256];
load('/home/debolina/DNS/c12/Data_0.mat') % Load laminar data
load('/home/debolina/DNS/c12/Data_121.mat') % Maximum stretch data

Reactions = char('H+OH+M{\rightarrow}H_2O+M', ...
    'H+O_2(+M){\rightarrow}HO_2(+M)','HO_2+OH{\rightarrow}O_2+H_2O','CO+OH{\rightarrow}CO_2+H','HCO+O_2{\rightarrow}CO+HO_2', ...
    'CH_3+O{\rightarrow}CH_2O+H','pC_4H_9+HO_2{\rightarrow}nC_3H_7+OH+CH_2O','nC_3H_7+O_2{\rightarrow}C_3H_6+HO_2');

for i = 1 : 1 : length(Rplots)
    figure(Rplots(i))
    
    for jj = 1 : 1 : length(Ka)
        plot(BinTemp(:,jj),BinRR(:,Rplots(i),jj)/max(BinRR(:,Rplots(i),jj)),'LineWidth',3)
        hold on
    end
    plot(Temp0,RXN_Rate0(:,Rplots(i))/max(RXN_Rate0(:,Rplots(i))),'--k','LineWidth',3)
    plot(Tempm,RXN_Ratem(:,Rplots(i))/max(RXN_Ratem(:,Rplots(i))),':k','LineWidth',3)
    hold on
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/C12/C12_Le1.mat')
    plot(Temp,RXN_Rate(:,Rplots(i))/max(RXN_Rate(:,Rplots(i))),'--b','LineWidth',3)
    clear X Temp AxialVel dist hdot_total HR MW X Y RXN_Rate
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/C12/C12_Le1m.mat')
    plot(Temp,RXN_Rate(:,Rplots(i))/max(RXN_Rate(:,Rplots(i))),':b','LineWidth',3)
    xlabel('$Temperature(K)$','Interpreter','latex')
    ylabel('$RR/RR_{max}$','Interpreter','latex')
    str = char(Reactions(i,:));
    title(['$' str '$'],'Interpreter','latex')
    set(gca,'FontSize',24)
    grid on
end

load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/C12/C12_Le1.mat')
wfuelLe1 = 0;
RXN_RateLe1 = RXN_Rate;
TempLe1 = Temp;
clear X Temp AxialVel dist hdot_total HR MW X Y RXN_Rate
load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/C12/C12_Le1m.mat')
wfuelLe1m = 0;
RXN_RateLe1m = RXN_Rate;
TempLe1m = Temp;
wfuel = 0;
wfuelm = 0;
load('/home/debolina/chemkin/Dodecane/Dodecane_coeff.mat')
for i = 1 : 1 : 289
    
    wfuel = wfuel + consumption_coeff(i,52) * RXN_Rate0(:,i) - formation_coeff(i,52) * RXN_Rate0(:,i);
    wfuelm = wfuelm + consumption_coeff(i,52) * RXN_Ratem(:,i) - formation_coeff(i,52) * RXN_Ratem(:,i);
    wfuelLe1 = wfuelLe1 + consumption_coeff(i,52) * RXN_RateLe1(:,i) - formation_coeff(i,52) * RXN_RateLe1(:,i);
    wfuelLe1m = wfuelLe1m + consumption_coeff(i,52) * RXN_RateLe1m(:,i) - formation_coeff(i,52) * RXN_RateLe1m(:,i);
end
clear X Temp AxialVel dist hdot_total HR MW X Y RXN_Rate
figure(456)
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
figure(255)
    for jj = 1 : 1 : length(Ka)
        plot(BinTemp(:,jj),BinHR(:,jj)/max(BinHR(:,jj)),'LineWidth',3)
        hold on
    end
    plot(Temp0,hdot_total0/max(hdot_total0),'--k','LineWidth',3)
    plot(Tempm,hdot_totalm/max(hdot_totalm),':k','LineWidth',3)
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/C12/C12_Le1.mat')
    plot(Temp,hdot_total/max(hdot_total),'--b','LineWidth',3)
    clear X Temp AxialVel dist hdot_total HR MW X Y RXN_Rate
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/C12/C12_Le1m.mat')
    plot(Temp,hdot_total/max(hdot_total),':b','LineWidth',3)
    xlabel('$Temperature(K)$','Interpreter','latex')
    ylabel('$\dot{q}/\dot{q}_{max}$','Interpreter','latex')
    set(gca,'FontSize',24)
    grid on