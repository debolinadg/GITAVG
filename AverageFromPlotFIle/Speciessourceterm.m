clear all
clc

Ka = [1 4 12 36 108];
load('/home/debolina/DNS/c12/Data_0.mat')
load('/home/debolina/chemkin/Transport/LeanC12/LE1/DataC12_Le1.mat')
load('/home/debolina/DNS/c12/AverageFromPlotFIle/TempBinC12.mat')
load('/home/debolina/chemkin/Dodecane/Dodecane_coeff.mat')
load('/home/debolina/DNS/c12/Data_121.mat')
load('/home/debolina/chemkin/Dodecane/Le1/Analysis/Data_125.mat')
load('/home/debolina/chemkin/Transport/LeanC12/DataC12_LeC.mat')
load('/home/debolina/chemkin/Transport/LeanC12/DataC12_LeCm.mat')


Nspecies = 56;
Nreacs = 289;
formation_coeff(:,Nspecies)=0;
consumption_coeff(:,Nspecies)=0;

omegadot0(1:length(Temp0),1:Nspecies) = 0;
omegadotm(1:length(Tempm),1:Nspecies) = 0;
omegadotLe(1:length(TempLe),1:Nspecies) = 0;
omegadotLem(1:length(Temp),1:Nspecies) = 0;
omegadotLeC(1:length(TempLeC),1:Nspecies) = 0;
omegadotLeCm(1:length(TempLeC_235),1:Nspecies) = 0;
omegadotKa(1:length(BinTemp),1:Nspecies,1:length(Ka)) = 0;


for i = 1 : 1 : Nspecies
    
    for j = 1 : 1 : Nreacs
        
        omegadot0(:,i) = omegadot0(:,i) + (formation_coeff(j,i)-consumption_coeff(j,i))*RXN_Rate0(:,j);
        omegadotLe(:,i) = omegadotLe(:,i) + (formation_coeff(j,i)-consumption_coeff(j,i))*RXN_RateLe(:,j);
        omegadotLeC(:,i) = omegadotLeC(:,i) + (formation_coeff(j,i)-consumption_coeff(j,i))*RXN_RateLeC(:,j);
        omegadotm(:,i) = omegadotm(:,i) + (formation_coeff(j,i)-consumption_coeff(j,i))*RXN_Ratem(:,j);
        omegadotLem(:,i) = omegadotLem(:,i) + (formation_coeff(j,i)-consumption_coeff(j,i))*RXN_Rate(:,j);
        omegadotLeCm(:,i) = omegadotLeCm(:,i) + (formation_coeff(j,i)-consumption_coeff(j,i))*RXN_RateLeC_235(:,j);
        for k = 1 : 1 : length(Ka)
            omegadotKa(:,i,k) = omegadotKa(:,i,k) + (formation_coeff(j,i)-consumption_coeff(j,i))*BinRR(:,j,k);
        end
    end
end

%% Plotting
%%Species to plot: HO2, H, H2O, OH, CH3, HCO, CO CO2
species = char('HO_2','H','H_2O','OH','CH_3','CO','CO_2','C_{12}H_{26}');
index = [4 1 6 3 12 19 20 52];

for i = 1 : 1 : length(index)
    figure(i)
%     plot(BinTemp(:,1),omegadotKa(:,index(i),1),'LineWidth',3)
%     hold on
%     plot(BinTemp(:,2),omegadotKa(:,index(i),2),'LineWidth',3)
%     plot(BinTemp(:,3),omegadotKa(:,index(i),3),'LineWidth',3)
%     plot(BinTemp(:,4),omegadotKa(:,index(i),4),'LineWidth',3)
%     plot(BinTemp(:,5),omegadotKa(:,index(i),5),'LineWidth',3)
    plot(Temp0,omegadot0(:,index(i))*10^6,'--k','LineWidth',3)
    hold on
    plot(TempLe,omegadotLe(:,index(i))*10^6,'--m','LineWidth',3)
    plot(TempLeC,omegadotLeC(:,index(i))*10^6,'--g','LineWidth',3)
    plot(Tempm,omegadotm(:,index(i))*10^6,':k','LineWidth',3)
    plot(Temp,omegadotLem(:,index(i))*10^6,':m','LineWidth',3)
    plot(TempLeC_235,omegadotLeCm(:,index(i))*10^3,':g','LineWidth',3)
    grid on
    set(gca,'FontSize',24)
    xlabel('$Temperature(K)$','Interpreter','latex')
    str = char(species(i,:));
    ylabel(['$\dot{\omega}_{' str '}$'],'Interpreter','latex')
end

for i = 1 : 1 : length(index)
    figure(i+length(index))
%     plot(BinY(:,8,1),omegadotKa(:,index(i),1),'LineWidth',3)
%     hold on
%     plot(BinY(:,8,2),omegadotKa(:,index(i),2),'LineWidth',3)
%     plot(BinY(:,8,3),omegadotKa(:,index(i),3),'LineWidth',3)
%     plot(BinY(:,8,4),omegadotKa(:,index(i),4),'LineWidth',3)
%     plot(BinY(:,8,5),omegadotKa(:,index(i),5),'LineWidth',3)
    plot(Y0(:,8),omegadot0(:,index(i))*10^6,'--k','LineWidth',3)
    hold on
    plot(YLe(:,8),omegadotLe(:,index(i))*10^6,'--m','LineWidth',3)
    plot(YLeC(:,8),omegadotLeC(:,index(i))*10^6,'--g','LineWidth',3)
    plot(Ym(:,8),omegadotm(:,index(i))*10^6,':k','LineWidth',3)
    plot(Y(:,8),omegadotLem(:,index(i))*10^6,':m','LineWidth',3)
    plot(YLeC_235(:,8),omegadotLeCm(:,index(i))*10^3,':g','LineWidth',3)
    grid on
    set(gca,'FontSize',24)
    xlabel('$Y_{O_2}$','Interpreter','latex')
    str = char(species(i,:));
    ylabel(['$\dot{\omega}_{' str '}$'],'Interpreter','latex')
end
