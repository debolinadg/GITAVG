clear all
clc

workdir = '/home/debolina/DNS/Hydrogen/TemperatureAverage';
cd(workdir)

load('TempBinH2.mat')
load('TempStdDevH2.mat')


rxn_no=[1 3 8 9 11 12 13];
Ka = [1 4 12 36];
colors = char('b','g','r','y','c','m');
Reactions = char('$O+H_2{\rightarrow}H+OH$','$H_2+OH{\rightarrow}H_2O+H$','$H+OH+M{\rightarrow}H_2O+M$','$H+O_2(+M){\rightarrow}HO_2(+M)$', ...
    '$HO_2+H{\rightarrow}OH+OH$','$HO_2+O{\rightarrow}O_2+H_2O$','$HO_2+OH{\rightarrow}H_2O+O_2$');

for jj = 7: 1 : 7%length(rxn_no)
    jj
    for kk = 1 : 3 : 4
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
load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/H2/H2_0.mat')
plot(Temp,RXN_Rate(:,rxn_no(jj))*10^6,'--k','LineWidth',3)
clear Temp AxialVel dist RXN_Rate HR hdot_total MW X Y 
load('/home/debolina/Cantera_Diffusivity/cantera/interfaces/cython/cantera/examples/onedim/H2/H2_0m.mat')
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