
clear all
clc

load('/home/debolina/DNS/c12/Ka36_Temp_Data/C12Ka36_StreamData.mat')

for i = 1 : 10 : max(size(HRf))
    figure(3)
    scatter(Tf(:,i),HRf(:,i),'or')
    hold on
end

load('/home/debolina/DNS/c12/AverageFromPlotFIle/TempBinC12.mat')
plot(BinTemp(:,4),BinHR(:,4),'-k','LineWidth',6)
xlabel('$Temperature$','Interpreter','latex')
ylabel('$HR$','Interpreter','latex')


plot(ActivationTemp,NormRR_Ka1(1,:),'or')
hold on
plot(ActivationTemp,NormRR_Ka1(2,:),'ob')
plot(ActivationTemp,NormRR_Ka1(3,:),'og')
plot(ActivationTemp,NormRR_Ka1(4,:),'ok')
plot(ActivationTemp,NormRR_Ka1(5,:),'oy')
plot(ActivationTemp,NormRR_Ka1(6,:),'oc')
plot(ActivationTemp,NormRR_Ka1(6,:),'om')


 for i = 1 : 1 : NOR
     if(ActivationTemp(i)<298)
             figure(2)
             plot(ActivationTemp(i),NormRR_Ka1(7,i),'+m')
             hold on
         elseif(ActivationTemp(i)>=298 && ActivationTemp(i)<=1898)
             figure(2)
             plot(ActivationTemp(i),NormRR_Ka1(7,i),'om')
             hold on
         elseif(ActivationTemp(i)>=1898)
             figure(2)
             plot(ActivationTemp(i),NormRR_Ka1(7,i),'^m')
             hold on
      end
     
 end
 
 plot(298+0*[-5000 20000],[0 5],'--k')
 plot(1898+0*[-5000 20000],[0 5],'--k')
 ylim[-0.5 10]
 