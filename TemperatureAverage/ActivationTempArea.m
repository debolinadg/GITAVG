clear all
clc

Ka = [1 4 12 36];

load('/home/debolina/DNS/Methane_DNS/TemperatureAverage/TempBinMethane.mat')

NOR = 217;
NSpecies = 35;

for i = 1 : 1 : NOR
    DiffRR(:,i) = (BinRR(:,i,length(Ka))/max(abs(BinRR(:,i,length(Ka)))))-(BinRR(:,i,1)/max(abs(BinRR(:,i,1))));
end

%plot(BinTemp(:,1),DiffRR(:,10))

% Implementing area calculations as a combination of right angled triangle
% and a rectangle
dT = 25; % Set from earlier: Can be calculated from BinTemp(i+1,1)-BinTemp(i,1)
Area = zeros(NOR,1);

for j = 1 : 1 : NOR
for i = 1 : 1 : max(size(BinTemp))-1
    dT = BinTemp(i+1,1) - BinTemp(i,1); % General Implementation
    RRleft = abs(DiffRR(i,j));
    RRright = abs(DiffRR(i+1,j));
    RectHeight = min(RRleft,RRright);
    TriHeight = max(RRleft,RRright) - RectHeight;
    Area(j) = Area(j)+(RectHeight * dT)+(0.5 * dT * TriHeight);
end
end

%% Activation Temperature calculation

load('/home/debolina/chemkin/Methane_Kinetics/MethaneAbE.mat')
% Row 1: A
% Row 2: b
% Row 3: Ea
Ru = 1.98588; % Universal gas constant in cal/K 

%Activation temperature: Ea/R

ActivationTemp = MethaneMech(:,3)/Ru;

% Removing duplicacies:

    ActivationTemp(33) = ActivationTemp(33) + ActivationTemp(34) + ActivationTemp(35) +ActivationTemp(36);
    ActivationTemp(34) = 0;
    ActivationTemp(35) = 0;
    ActivationTemp(36) = 0;
    
    % 2H = H2
    ActivationTemp(38) = ActivationTemp(38) + ActivationTemp(39) + ActivationTemp(40) +ActivationTemp(41);
    ActivationTemp(39) = 0;
    ActivationTemp(40) = 0;
    ActivationTemp(41) = 0;
    
    % OH HO2 = O2 + H2O
    ActivationTemp(86) = ActivationTemp(86) + ActivationTemp(179);
    ActivationTemp(179) = 0;
    
    % OH + H2O2 = HO2 + H2O
    ActivationTemp(87) = ActivationTemp(87) + ActivationTemp(88);
    ActivationTemp(88) = 0;
    
    % 2HO2 = O2 + H2O2
    ActivationTemp(114) = ActivationTemp(114) + ActivationTemp(115);
    ActivationTemp(115) = 0;
    
    % HCO + M = H + CO + M
    ActivationTemp(165) = ActivationTemp(164) + ActivationTemp(165);
    ActivationTemp(164) = 0;
    
    % CH2(S) + M = CH2 + M
    ActivationTemp(141) = ActivationTemp(141) + ActivationTemp(146) + ActivationTemp(149) +ActivationTemp(150);
    ActivationTemp(146) = 0;
    ActivationTemp(149) = 0;
    ActivationTemp(150) = 0;
 %% Scatter plot
RealArea=sort(Area(find(~isnan(Area))));
MedianVal = median(RealArea);
MeanVal = mean(RealArea);
 
 for i = 1 : 1 : NOR
     
     if(Area(i) > (max(Area)/4))
         
         if(ActivationTemp(i)<298)
             plot(Area(i),ActivationTemp(i),'+r')
             hold on
         elseif(ActivationTemp(i)>=298 && ActivationTemp(i)<=1898)
             plot(Area(i),ActivationTemp(i),'or')
             hold on
         elseif(ActivationTemp(i)>=1898)
             plot(Area(i),ActivationTemp(i),'*r')
             hold on
         end
             
     else
         if(ActivationTemp(i)<298)
             plot(Area(i),ActivationTemp(i),'+b')
             hold on
         elseif(ActivationTemp(i)>=298 && ActivationTemp(i)<=1898)
             plot(Area(i),ActivationTemp(i),'ob')
             hold on
         elseif(ActivationTemp(i)>=1898)
             plot(Area(i),ActivationTemp(i),'*b')
             hold on
         end
         
     end
      
 end
 
plot(max(Area)/4+0*[0 150],[1 10^5],'--k')
plot([0 150],0*[1 10^5]+298,':k')
plot([0 150],0*[1 10^5]+1898,':k')
xlabel('$Area(K)$','Interpreter','latex')
ylabel('$Activation\ Temperature(K)$','Interpreter','latex')
set(gca,'FontSize',24,'YScale','log')
