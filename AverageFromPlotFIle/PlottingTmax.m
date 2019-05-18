% Plotting the maximum of temperature
clear all
clc

workdir='/home/debolina/DNS/c12/';
cd(workdir)

Ka = [1 4 12 36 108];

for jj = 1 : 1 : length(Ka)
    jj
    load([workdir '/Ka' num2str(Ka(jj)) '_Temp_Data/C12Ka' num2str(Ka(jj)) '_StreamData.mat'])
    Tmax = max(Tf);
    Tmean(jj) = mean(Tmax);
    maxT(jj)  = max(Tmax);
    minT(jj) = min(Tmax);
    S(jj) = std(Tmax);
    clear Tmax Tf Gf HRf Kf KSf wf
end

figure(1)
errorbar(Ka,Tmean,S,S,'-o','Color',[0.850980401039124 0.325490206480026 0.0980392172932625],'LineWidth',3,'MarkerSize',8,'MarkerFaceColor',[0.850980401039124 0.325490206480026 0.0980392172932625])
xlabel('$Ka$','Interpreter','latex')
ylabel('$T_{max}(K)$','Interpreter','latex')






set(gca,'FontSize',24,'XScale','log')
grid on
ylim([1400 1900])

figure(2)
errorbar(Ka,Tmean,Tmean-minT,maxT-Tmean,'-o','Color',[0.850980401039124 0.325490206480026 0.0980392172932625],'LineWidth',3,'MarkerSize',8,'MarkerFaceColor',[0.850980401039124 0.325490206480026 0.0980392172932625])
xlabel('$Ka$','Interpreter','latex')
ylabel('$T_{max}(K)$','Interpreter','latex')
set(gca,'FontSize',24,'XScale','log')
grid on
ylim([1400 1900])
