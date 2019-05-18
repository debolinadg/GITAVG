clear all
clc

workdir = '/home/debolina/DNS/Hydrogen/TemperatureAverage/';
cd(workdir)

Ka = [1 4 12 36];
load('TempBinH2.mat')
Yplots = [1 3 5 6 7 8];

load('/home/debolina/DNS/Hydrogen/TemperatureAverage/Data_0.mat') % Load laminar data
load('/home/debolina/DNS/Hydrogen/TemperatureAverage/Data_4730.mat') % Maximum stretch data
Species = char('O_2', 'H_2' ,'H', 'OH', 'HO_2', 'O');

MWsp =[2 32 18 1 16 17 33 34 28];

for k = 1 : 1 : length(Ka)
    MWmix(1:length(BinTemp),k) = 0;
for i = 1 : 1 : 9
    
    MWmix(:,k) = MWmix(:,k) + BinY(:,i,k)/MWsp(i);
end

    MWmix(:,k) = 1 ./ MWmix(:,k);
end




for k = 1 : 1 : length(Ka)
    for j = 1 : 1 : 9
        
        BinX(:,j,k) = BinY(:,j,k) .* MWmix(:,k)/MWsp(j);
    end
end


YplotsKa = [2 1 4 6 7 5];
for i = 1 : 1 : length(Yplots)
    
    figure(Yplots(i))
    for jj = 1 : 1 : length(Ka)
        
        plot(BinTemp(:,jj),(BinX(:,YplotsKa(i),jj)*(101325/8.314)./BinTemp(:,jj))/max((BinX(1:125,YplotsKa(i),jj)*(101325/8.314)./BinTemp(1:125,jj))),'LineWidth',3)
        hold on
    end
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/H2/H2_0.mat')
    plot(Temp,(X(:,Yplots(i))*(101325/8.314)./Temp)/max((X(:,Yplots(i))*(101325/8.314)./Temp)),'--k','LineWidth',3)
    clear X Temp
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/H2/H2_0m.mat')
    plot(Temp,(X(:,Yplots(i))*(101325/8.314)./Temp)/max((X(:,Yplots(i))*(101325/8.314)./Temp)),':k','LineWidth',3)
    clear X Temp
%     plot(Temp0,X0(:,Yplots(i))*(101325/8.314)./Temp0,'--k','LineWidth',3)
%     plot(Tempm,Xm(:,Yplots(i))*(101325/8.314)./Tempm,':k','LineWidth',3)
    hold on
    xlabel('$Temperature(K)$','Interpreter','latex')
    str = char(Species(i,:));
    ylabel(['$[' str ']$'],'Interpreter','latex')
    set(gca,'FontSize',24)
    grid on
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/H2/H2_Le1.mat')
    plot(Temp,(X(:,Yplots(i))*(101325/8.314)./Temp)/max((X(:,Yplots(i))*(101325/8.314)./Temp)),'--b','LineWidth',3)
    clear X Temp
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/H2/H2_Le1m.mat')
    plot(Temp,(X(:,Yplots(i))*(101325/8.314)./Temp)/max((X(:,Yplots(i))*(101325/8.314)./Temp)),':b','LineWidth',3)
end