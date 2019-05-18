clear all
clc

workdir = '/home/debolina/DNS/c12/AverageFromPlotFIle/';
cd(workdir)

Ka = [1 4 12 36 108];
n = 347; % Number of components extracted: Y(56) RR(289) Wf(1) HR(1)
NReacs = 289;
NSpecies = 56;
% CAREFUL::::::: Remember to use the reaction map
load('/home/debolina/DNS/c12/ReactionMap.mat')


% for jj = 1 : 1 : length(Ka)
%     
%     A = dlmread(['/home/debolina/DNS/c12/AverageFromPlotFIle/C12Ka' num2str(Ka(jj)) 'Average_temp.dat'],' ');
%     The colums have A have the following format
%     Binned Temp(1) Sum(n) SumSq(n) Avg(n) StdDev(n) binHits(1) binHits/ntot(1)
%     Total columns: 1+4n+2 = 4n+3
%     1: Temp
%     2:n+1 : Sums
%     n+2:2n+1 : SumSq
%     2n+2:3n+1 : Avg
%     3n+2:4n+1 : Std Dev
%     4n+2:4n+3 : binHits, avgbinHits
%     
%     BinTemp(:,jj) = A(:,1);
%     
%     BinY(:,:,jj) = A(:,2*n+2:2*n+57); % First 56 columns are Mass fractions
%     StdDevY(:,:,jj) = A(:,3*n+2:3*n+57);
%     
%     BinWf(:,jj) =  A(:,2*n+58); % next is fuel consumption
%     StdDevWf(:,jj) = A(:,3*n+58);
%     
%     BinHR(:,jj) = A(:,2*n+59); % next is total heat release
%     StdDevHR(:,jj) = A(:,3*n+59);
%     
%     BinRR_old(:,:,jj) = A(:,2*n+60:3*n+1); % next 289 are reaction rates
%     StdDevRR_old(:,:,jj) = A(:,3*n+60:4*n+1);
%     
%     clear A
%     
%      for i = 1 : 1 : NReacs
%         BinRR(:,rxn_map(i),jj) = BinRR_old(:,i,jj);
%         StdDevRR(:,rxn_map(i),jj) = StdDevRR_old(:,i,jj);
%      end
%      
%     BinRR(:,5,jj) = BinRR(:,5,jj) + BinRR(:,6,jj);
%     BinRR(:,6,jj) = 0;
%     StdDevRR(:,5,jj) = sqrt((StdDevRR(:,5,jj).^2)+(StdDevRR(:,6,jj).^2));
%     StdDevRR(:,6,jj) = 0;
%     
%     HO2 + OH = O2 + H2O
%     BinRR(:,16,jj) = BinRR(:,16,jj) + BinRR(:,17,jj);
%     BinRR(:,17,jj) = 0;
%     StdDevRR(:,16,jj) = sqrt((StdDevRR(:,16,jj).^2)+(StdDevRR(:,17,jj).^2));
%     StdDevRR(:,17,jj) = 0;
%     
%     2HO2 = O2 + H2O2
%     BinRR(:,18,jj) = BinRR(:,18,jj) + BinRR(:,19,jj);
%     BinRR(:,19,jj) = 0;
%     StdDevRR(:,18,jj) = sqrt((StdDevRR(:,18,jj).^2)+(StdDevRR(:,19,jj).^2));
%     StdDevRR(:,19,jj) = 0;
%     
%     H2O2 + OH = HO2 + H2O
%     BinRR(:,23,jj) = BinRR(:,23,jj) + BinRR(:,24,jj);
%     BinRR(:,24,jj) = 0;
%     StdDevRR(:,23,jj) = sqrt((StdDevRR(:,23,jj).^2)+(StdDevRR(:,24,jj).^2));
%     StdDevRR(:,24,jj) = 0;
%     
%     CO +OH = CO2 + H
%     BinRR(:,26,jj) = BinRR(:,26,jj) + BinRR(:,27,jj);
%     BinRR(:,27,jj) = 0;
%     StdDevRR(:,26,jj) = sqrt((StdDevRR(:,26,jj).^2)+(StdDevRR(:,27,jj).^2));
%     StdDevRR(:,27,jj) = 0;
%     
%     HCO + M = H + CO + M
%     BinRR(:,33,jj) = BinRR(:,33,jj) + BinRR(:,34,jj);
%     BinRR(:,34,jj) = 0;
%     StdDevRR(:,33,jj) = sqrt((StdDevRR(:,33,jj).^2)+(StdDevRR(:,34,jj).^2));
%     StdDevRR(:,34,jj) = 0;
%     
%     CH2(S) + M = CH2 + M
%     BinRR(:,50,jj) = BinRR(:,50,jj) + BinRR(:,57,jj) + BinRR(:,58,jj) +BinRR(:,59,jj);
%     BinRR(:,57,jj) = 0;
%     BinRR(:,58,jj) = 0;
%     BinRR(:,59,jj) = 0;
%     StdDevRR(:,50,jj) = sqrt((StdDevRR(:,50,jj).^2)+(StdDevRR(:,57,jj).^2)+(StdDevRR(:,58,jj).^2)+(StdDevRR(:,59,jj).^2));
%     StdDevRR(:,57,jj) = 0;
%     StdDevRR(:,58,jj) = 0;
%     StdDevRR(:,59,jj) = 0;
%     
%     C2H2 + OH = CH2CO + H
%     BinRR(:,116,jj) = BinRR(:,116,jj) + BinRR(:,117,jj);
%     BinRR(:,117,jj) = 0;
%     StdDevRR(:,116,jj) = sqrt((StdDevRR(:,116,jj).^2)+(StdDevRR(:,117,jj).^2));
%     StdDevRR(:,117,jj) = 0;
%     
%     pC3H4 + M = aC3H4 + M
%     BinRR(:,195,jj) = BinRR(:,196,jj) + BinRR(:,195,jj);
%     BinRR(:,196,jj) = 0;
%     StdDevRR(:,195,jj) = sqrt((StdDevRR(:,195,jj).^2)+(StdDevRR(:,196,jj).^2));
%     StdDevRR(:,196,jj) = 0;
%     
% end

% save('TempBinC12.mat','BinRR','BinWf','BinHR','BinTemp','BinY')
% save('StdDevC12.mat','StdDevRR','StdDevWf','StdDevHR','BinTemp','StdDevY')
load('TempBinC12.mat')
% Time to plot
% What do you want to plot? 
% Mass fractions: H(1) OH(3) HO2(4) H2O(6) CH3(12) CH4(13) HCO(14) CH2O(15)
% CO(19) C2H4(24) C2H6(26) C3H6(37) nC3H7(38) NC12H26(52) C6H12(53)
% C5H10(55)
% Reactions: 1,3,7,8,10,14,16,26,33,35,45,64,65,70,75,258-279

Yplots = [1 3 4 5 6 7 8 12 13 14 15 19 24 26 37 38 52 53 55];
Rplots = [1 3 7 8 10 14 16 26 33 35 45 64 65 70 75 258:279];
load('/home/debolina/DNS/c12/Data_0.mat') % Load laminar data
load('/home/debolina/DNS/c12/Data_121.mat') % Maximum stretch data
Species = char('H', 'OH' ,'HO_2', 'H2', 'H_2O', 'H_2O_2', 'O_2', 'CH_3','CH_4', 'HCO', 'CH_2O', 'CO', 'C_2H_4','C_2H_6' ,'C_3H_6','nC_3H_7', 'nC_{12}H_{26}','C_6H_{12}','C_5H_{10}');
% for i = 1 : 1 : length(Yplots)
%     
%     figure(Yplots(i))
%     for jj = 1 : 1 : length(Ka)
%         plot(BinTemp(:,jj),BinY(:,Yplots(i),jj),'LineWidth',3)
%         hold on
%     end
%     plot(Temp0,Y0(:,Yplots(i)),'--k','LineWidth',3)
%     plot(Tempm,Ym(:,Yplots(i)),':k','LineWidth',3)
%     hold on
%     xlabel('$Temperature(K)$','Interpreter','latex')
%     str = char(Species(i,:));
%     ylabel(['$Y_{' str '}$'],'Interpreter','latex')
%     set(gca,'FontSize',24)
%     grid on
% end

Reactions = char('H+O_2{\rightarrow}O+OH','OH+O_2{\rightarrow}H+H_2O','H+OH+M{\rightarrow}H_2O+M','O+H+M{\rightarrow}OH+M', ...
    'H+O_2(+M){\rightarrow}HO_2(+M)','HO_2+H{\rightarrow}2OH','HO_2+OH{\rightarrow}O_2+H_2O','CO+OH{\rightarrow}CO_2+H','HCO+M{\rightarrow}CO+H+M','HCO+O_2{\rightarrow}CO+HO_2', ...
    'CH_2+H_2{\rightarrow}H+CH_3','CH_2O+O{\rightarrow}HCO+OH','CH_2O+OH{\rightarrow}HCO+H_2O','CH_3+O{\rightarrow}CH_2O+H','CH_3+O_2{\rightarrow}OH+CH_2O','nC_{12}H_{26}{\rightarrow}3C_2H_4+2nC_3H_7', ...
    'nC_{12}H_{26}{\rightarrow}2C_2H_4+2pC_4H_9','nC_{12}H_{26}+H{\rightarrow}4C_2H_4+pC_4H_9+H_2','nC_{12}H_{26}+H{\rightarrow}C_4H_8-1+2C_2H_4+pC_4H_9+H_2','nC_{12}H_{26}+H{\rightarrow}C_3H_6+C_6H_{12}+nC_3H_7+H_2', ...
    'nC_{12}H_{26}+H{\rightarrow}C_5H_{10}+2C_2H_4+nC_3H_7+H_2','nC_{12}H_{26}+H{\rightarrow}C_6H_{12}+C_2H_4+pC_4H_9+H_2','nC_{12}H_{26}+CH3{\rightarrow}4C_2H_4+pC_4H_9+CH_4','nC_{12}H_{26}+CH_3{\rightarrow}C_4H_8-1+2C_2H_4+pC_4H_9+CH_4','nC_{12}H_{26}+CH_3{\rightarrow}C_3H_6+C_6H_{12}+nC_3H_7+CH_4','nC_{12}H_{26}+CH_3{\rightarrow}C_5H_{10}+2C_2H_4+nC_3H_7+CH_4','nC_{12}H_{26}+CH_3{\rightarrow}C_6H_{12}+C_2H_4+pC_4H_9+CH_4' ...
    ,'nC_{12}H_{26}+O{\rightarrow}4C_2H_4+pC_4H_9+OH','nC_{12}H_{26}+O{\rightarrow}C_4H_8-1+2C_2H_4+pC_4H_9+OH','nC_{12}H_{26}+O{\rightarrow}C_3H_6+C_6H_{12}+nC_3H_7+OH','nC_{12}H_{26}+O{\rightarrow}C_5H_{10}+2C_2H_4+nC_3H_7+OH','nC_{12}H_{26}+O{\rightarrow}C_6H_{12}+C_2H_4+pC_4H_9+OH','nC_{12}H_{26}+OH{\rightarrow}4C_2H_4+pC_4H_9+H_2O','nC_{12}H_{26}+OH{\rightarrow}C_4H_8-1+2C_2H_4+pC_4H_9+H_2O' ...
    ,'nC_{12}H_{26}+OH{\rightarrow}C_3H_6+C_6H_{12}+nC_3H_7+H_2O','nC_{12}H_{26}+OH{\rightarrow}C_5H_{10}+2C_2H_4+nC_3H_7+H_2O','nC_{12}H_{26}+OH{\rightarrow}C_6H_{12}+C_2H_4+pC_4H_9+H_2O');

% for i = 1 : 1 : length(Rplots)
%     figure(Rplots(i))
%     figure(i)
%     for jj = 1 : 1 : length(Ka)
%         plot(BinTemp(:,jj),BinRR(:,Rplots(i),jj),'LineWidth',3)
%         hold on
%     end
%     plot(Temp0,RXN_Rate0(:,Rplots(i))*10^6,'--k','LineWidth',3)
%     plot(Tempm,RXN_Ratem(:,Rplots(i))*10^6,':k','LineWidth',3)
%     hold on
%     xlabel('$Temperature(K)$','Interpreter','latex')
%     ylabel('$RR(1/m^3-s)$','Interpreter','latex')
%     str = char(Reactions(i,:));
%     title(['$' str '$'],'Interpreter','latex')
%     set(gca,'FontSize',24)
%     grid on
% end
% 
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
        plot(BinTemp(:,jj),BinWf(:,jj),'LineWidth',3)
        hold on
    end
    plot(Temp0,wfuel*170*10^3,'--k','LineWidth',3)
    plot(Tempm,wfuelm*170*10^3,':k','LineWidth',3)
    plot(TempLe1,wfuelLe1*170*10^3,'--b','LineWidth',3)
    plot(TempLe1m,wfuelLe1m*170*10^3,':b','LineWidth',3)
    xlabel('$Temperature(K)$','Interpreter','latex')
    ylabel('$\dot{\omega}_{fuel}(kg/m^3-s)$','Interpreter','latex')
    set(gca,'FontSize',24)
    grid on
figure(255)
    for jj = 1 : 1 : length(Ka)
        plot(BinTemp(:,jj),BinHR(:,jj),'LineWidth',3)
        hold on
    end
    plot(Temp0,hdot_total0*0.1,'--k','LineWidth',3)
    plot(Tempm,hdot_totalm*0.1,':k','LineWidth',3)
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/C12/C12_Le1.mat')
    plot(Temp,hdot_total*0.1,'--b','LineWidth',3)
    clear X Temp AxialVel dist hdot_total HR MW X Y RXN_Rate
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/C12/C12_Le1m.mat')
    plot(Temp,hdot_total*0.1,':b','LineWidth',3)
    xlabel('$Temperature(K)$','Interpreter','latex')
    ylabel('$\dot{q}(J/m^3)$','Interpreter','latex')
    set(gca,'FontSize',24)
    grid on

%% pLOTS TO GET DIFFERENCE

% REACTION CONSIDERED: 70, 26, 16 ,10 7, 35
rxn_no = [7 10 16 26 35 70];
figure(2)
for i = 1 : 1 : length(rxn_no)
    max1 = max(BinRR(:,rxn_no(i),1));
%     plot(BinTemp(:,1),(BinRR(:,rxn_no(i),5)/max(BinRR(:,rxn_no(i),5)))-(BinRR(:,rxn_no(i),1)/max(BinRR(:,rxn_no(i),1))),'LineWidth',3)
    plot(BinTemp(:,1),(BinRR(:,rxn_no(i),4)/max1)-(BinRR(:,rxn_no(i),1)/max1),'LineWidth',3)
    hold on
    xlabel('$Temperature(K)$','Interpreter','latex')
    ylabel('$\Delta RR$','Interpreter','latex')
    set(gca,'FontSize',24)
    grid on
end
