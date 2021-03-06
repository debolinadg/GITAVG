clear all
clc

workdir = '/home/debolina/DNS/Methane_DNS/TemperatureAverage';
cd(workdir)

load('TempBinCH4.mat')
load('TempStdDevCH4.mat')


rxn_no=[10 32 33 86 98 176];
Ka = [1 4 36];
colors = char('b','g','r','y','c','m');
Reactions = char('$O+CH_3{\rightarrow}CH_2O+H$','$O_2+CH_2O{\rightarrow}HO_2+HCO$','$H+O_2(+M){\rightarrow}HO_2(+M)$','$HO_2+OH{\rightarrow}H_2O+O_2$','$CO+OH{\rightarrow}CO_2+H$','$O+CH_3{\rightarrow}CO+H+H_2$');
for jj = 6: 1 : 6%length(rxn_no)
    jj
    for kk = 1 : 2 : 3
        figure(kk)
x = BinTemp(:,kk);
curve1 = BinRR(:,rxn_no(jj),kk) + StdDevRR(:,rxn_no(jj),kk);
curve2 = BinRR(:,rxn_no(jj),kk) - StdDevRR(:,rxn_no(jj),kk);
% Plot it.
plot(x, curve1, 'k', 'LineWidth', 0.005,'LineStyle','none');
hold on;
plot(x, curve2, 'k', 'LineWidth', 0.005,'LineStyle','none');
% For column vectors, use flipud(), for row vectors use fliplr().
x2 = [x; flipud(x)]; % Use ; instead of ,
inBetween = [curve1; flipud(curve2)]; % Use ; instead of ,
str = char(Reactions(jj,:));
fill(x2, inBetween, [0.800000011920929 0.800000011920929 0.800000011920929],'LineStyle','none');
grid on;
    
plot(x,BinRR(:,rxn_no(jj),kk),'-k','LineWidth',3)
load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/CH4/CH4_0.mat')
plot(Temp,RXN_Rate(:,rxn_no(jj))*10^6,'--k','LineWidth',3)
clear Temp AxialVel dist RXN_Rate HR hdot_total MW X Y 
load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/CH4/CH4_0m.mat')
plot(Temp,RXN_Rate(:,rxn_no(jj))*10^6,':k','LineWidth',3)
clear Temp AxialVel dist RXN_Rate HR hdot_total MW X Y 
xlabel('$Temperature(K)$','Interpreter','latex')
ylabel('$RR(1/m^3-s)$','Interpreter','latex')
set(gca,'FontSize',24)
title(str,'Interpreter','latex')
figure1 = figure(kk);
annotation(figure1,'textbox',...
    [0.167504381694255 0.792452830188679 0.119740019474197 0.0754716981132075],...
    'String',{['$Ka=' num2str(Ka(kk)) '$']},...
    'Interpreter','latex',...
    'FontSize',18,...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);
    end
end