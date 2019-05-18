clear all
clc

workdir = '/home/debolina/DNS/c12/AverageFromPlotFIle/';
cd(workdir)

Ka = [1 4 12 36 108];
load('TempBinC12.mat')
Yplots = [1 3 4 5 6 7 8 12 13 14 15 19 24 26 37 38 52 53 55 51];
Rplots = [1 3 7 8 10 14 16 26 33 35 45 64 65 70 75 258:279];
load('/home/debolina/DNS/c12/Data_0.mat') % Load laminar data
load('/home/debolina/DNS/c12/Data_121.mat') % Maximum stretch data
Species = char('H', 'OH' ,'HO_2', 'H2', 'H_2O', 'H_2O_2', 'O_2', 'CH_3','CH_4', 'HCO', 'CH_2O', 'CO', 'C_2H_4','C_2H_6' ,'C_3H_6','nC_3H_7', 'nC_{12}H_{26}','C_6H_{12}','C_5H_{10}', 'pC_4H_9');

MWsp =[2.016/2 31.9988/2 17.01 33 2 18 34 32 13 14 14 15 16 29 30 31 31 32 28 44 ...
        25 26 27 28 29 30 41 42 43 43 44 39 40 40 41 41 42 43 43 56 ...
        50 51 52 53 53 54 54 54 55 56 57 170 84 83 70 28];
for k = 1 : 1 : length(Ka)
    MWmix(1:length(BinTemp),k) = 0;
for i = 1 : 1 : 56
    
    MWmix(:,k) = MWmix(:,k) + BinY(:,i,k)/MWsp(i);
end

    MWmix(:,k) = 1 ./ MWmix(:,k);
end



for k = 1 : 1 : length(Ka)
    for j = 1 : 1 : 56
        
        BinX(:,j,k) = BinY(:,j,k) .* MWmix(:,k)/MWsp(j);
    end
end


for i = 1 : 1 : length(Yplots)
    
    figure(Yplots(i))
    for jj = 1 : 1 : length(Ka)
        plot(BinTemp(:,jj),BinX(:,Yplots(i),jj)*(101325/8.314)./BinTemp(:,jj),'LineWidth',3)
        hold on
    end
    plot(Temp0,X0(:,Yplots(i))*(101325/8.314)./Temp0,'--k','LineWidth',3)
    plot(Tempm,Xm(:,Yplots(i))*(101325/8.314)./Tempm,':k','LineWidth',3)
    hold on
    xlabel('$Temperature(K)$','Interpreter','latex')
    str = char(Species(i,:));
    ylabel(['$[' str ']$'],'Interpreter','latex')
    set(gca,'FontSize',24)
    grid on
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/C12/C12_Le1.mat')
    plot(Temp,X(:,Yplots(i))*(101325/8.314)./Temp,'--b','LineWidth',3)
    clear X Temp
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/C12/C12_Le1m.mat')
    plot(Temp,X(:,Yplots(i))*(101325/8.314)./Temp,':b','LineWidth',3)
end
