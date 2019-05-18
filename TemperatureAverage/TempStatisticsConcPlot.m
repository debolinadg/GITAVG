clear all
clc

workdir = '/home/debolina/DNS/Methane_DNS/TemperatureAverage/';
cd(workdir)

Ka = [1 4 36];
load('TempBinCH4.mat')
Yplots = [13 18 7 2 5 15 20 14];

load('/home/debolina/DNS/MeThane_DNS/TemperatureAverage/Data_0.mat') % Load laminar data
load('/home/debolina/DNS/Methane_DNS/TemperatureAverage/Data_605.mat') % Maximum stretch data
Species = char('CH_3', 'CH_2O' ,'HO_2', 'H', 'OH', 'CO','CH_3O', 'CH_4');

MWsp =[2 1 16 32 17 18 33 34 12 13 14 14 15 16 28 44 29 30 31 31 32 25 26 27 28 29 30 41 42 42 28 43 44 43 44];
MWsp =[2 1 16 32 17 18 33 34 12 13 14 14 15 16 28 44 29 30 31 31 32 25 26 27 28 29 30 41 42 42 28 43 44 43 44];
for k = 1 : 1 : length(Ka)
    MWmix(1:length(BinTemp),k) = 0;
for i = 1 : 1 : 35
    
    MWmix(:,k) = MWmix(:,k) + BinY(:,i,k)/MWsp(i);
end

    MWmix(:,k) = 1 ./ MWmix(:,k);
end


for k = 1 : 1 : length(Ka)
    for j = 1 : 1 : 35
        
        BinX(:,j,k) = BinY(:,j,k) .* MWmix(:,k)/MWsp(j);
    end
end

for i = 1 : 1 : length(Yplots)
    
    figure(Yplots(i))
    
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/CH4/CH4_0.mat')
    plot(Temp,X(:,Yplots(i))*(101325/8.314)./Temp,'--k','LineWidth',3)
    hold on
    clear X Temp
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/CH4/CH4_0m.mat')
    plot(Temp,X(:,Yplots(i))*(101325/8.314)./Temp,':k','LineWidth',3)
    clear X Temp
%     plot(Temp0,X0(:,Yplots(i))*(101325/8.314)./Temp0,'--k','LineWidth',3)
%     plot(Tempm,Xm(:,Yplots(i))*(101325/8.314)./Tempm,':k','LineWidth',3)
    hold on
         load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/CH4/CH4_Le1.mat')
    plot(Temp,X(:,Yplots(i))*(101325/8.315)./Temp,'--b','LineWidth',3)
    clear X Temp AxialVel dist hdot_total HR MW X Y
    hold on
    load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/CH4/CH4_Le1m.mat')
    plot(Temp,X(:,Yplots(i))*(101325/8.315)./Temp,':b','LineWidth',3)
    clear X Temp AxialVel dist hdot_total HR MW X Y
    hold on
    for jj = 1 : 1 : length(Ka)
        plot(BinTemp(:,jj),BinX(:,Yplots(i),jj)*(101325/8.314)./BinTemp(:,jj),'LineWidth',3)
        hold on
    end
    xlabel('$Temperature(K)$','Interpreter','latex')
    str = char(Species(i,:));
    ylabel(['$[' str ']$'],'Interpreter','latex')
    set(gca,'FontSize',24)
    grid on

end