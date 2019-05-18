% clear all
% clc

work_dir = '/home/debolina/DNS/Methane_DNS/Methane';
cd(work_dir)

load('/home/debolina/chemkin/Methane_Kinetics/Analysis/coefficients_MethaneMechanism.mat')
load('LaminarUnstretched_HR.mat')
Ka = [0 1 4 36];

NOR = 217;

Nspecies = 34;

for jj = 2 : 1 : length(Ka)
    Ka(jj)
    load(['CH4Ka' num2str(Ka(jj))]);
    
    i=1;
     %% Removing duplicacies in data from mechanism
    
    % H + O2 = HO2
    RR_nn(33) = RR_nn(33) + RR_nn(34) + RR_nn(35) +RR_nn(36);
    RR_nn(34) = 0;
    RR_nn(35) = 0;
    RR_nn(36) = 0;
    
    % 2H = H2
    RR_nn(38) = RR_nn(38) + RR_nn(39) + RR_nn(40) +RR_nn(41);
    RR_nn(39) = 0;
    RR_nn(40) = 0;
    RR_nn(41) = 0;
    
    % OH HO2 = O2 + H2O
    RR_nn(86) = RR_nn(86) + RR_nn(179);
    RR_nn(179) = 0;
    
    % OH + H2O2 = HO2 + H2O
    RR_nn(87) = RR_nn(87) + RR_nn(88);
    RR_nn(88) = 0;
    
    % 2HO2 = O2 + H2O2
    RR_nn(114) = RR_nn(114) + RR_nn(115);
    RR_nn(115) = 0;
    
    % HCO + M = H + CO + M
    RR_nn(165) = RR_nn(164) + RR_nn(165);
    RR_nn(164) = 0;
    
    % CH2(S) + M = CH2 + M
    RR_nn(141) = RR_nn(141) + RR_nn(146) + RR_nn(149) +RR_nn(150);
    RR_nn(146) = 0;
    RR_nn(149) = 0;
    RR_nn(150) = 0;
    
    ind(1,jj) = 0;
    for j = 1:1:NOR
        if(RR_nn(j) < 0)
            ind(i,jj) = j;
            i=i+1;
        end
    end
    
    
    formation_coeff_N = formation_coeff;
    destruction_coeff_N = destruction_coeff;
    
    if(min(size(ind))>1)
    for j = 1:1:max(size(ind))
        temp(:,1) = formation_coeff(ind(j,jj),:);
        formation_coeff_N(ind(j,jj),:) = 0;
        formation_coeff_N(ind(j,jj),:) = -1 * destruction_coeff(ind(j,jj),:);
        destruction_coeff_N(ind(j,jj),:) = 0;
        destruction_coeff_N(ind(j,jj),:) = -1 * temp;
    end
    end

    
    hfo = [0 217.94456 249.1572 0 38.99488 -241.8352 10.46 -136.10552 716.67736 594.128 386.93632 424.676 145.68688...
    -74.8936 -110.54128 -393.5052 43.5136 -115.8968 -17.1544 16.27576 -201.08304 564.84 226.73096 286.22744...
    52.46736 117.19384 -83.84736 177.56896 -51.8816 85.47912 94.5584 -103.84688 25.104 -165.30984];

hfo = hfo * 1000;

for i = 1 : 1 : NOR
    
    coeff = 0;
    
    for j = 1 : 1 : Nspecies
        
        coeff = coeff + ((destruction_coeff_N(i,j)-formation_coeff_N(i,j))*hfo(j));
        
    end
    
    INHR_n(jj,i) = RR_nn(i) * coeff;  % Total HR from every reaction
    TotalHR(jj,i) =  RR_all(i) * coeff;
end
   
 clear RR_nn
    
end

for jj = 1 : 1 : length(Ka)
    
    INHR_nn(jj,:)=INHR_n(jj,:)/sum(INHR_n(jj,:));
    
end
for ii=1:1:4
    all(ii)=0;
for jj = 1:1:217
    if(jj~=10 && jj~=33 && jj~=86 && jj~=98 && jj~=176)
        all(ii)=all(ii)+INHR_nn(ii,jj);
    end
end
end
% for j = 1 : 1: NOR
%     
%     figure(1)
%     if(abs(sum(INHR_nn(:,j))) > 0.05)
%     j
%     plot(Ka,INHR_nn(:,j),'LineWidth',3,'Marker','o')
%     hold on
%     set(gca,'FontSize',24,'FontName','Times')
%     grid on
%     xlabel('$Ka$', 'Interpreter','Latex','FontSize',30)
%     ylabel('$\dot{q}_{k}/\dot{q}$',  'Interpreter','Latex','FontSize',30)
%     end
%     
% end


%save('Methane_All_HR.mat','INHR_nn','INHR_n')

