clear all
clc

Ka = [1 4 12 36 108];

load('/home/debolina/DNS/c12/AverageFromPlotFIle/TempBinC12.mat')

NOR = 289;
NSpecies = 52;

for i = 1 : 1 : NOR
    DiffRR(:,i) = (BinRR(:,i,5)/max(abs(BinRR(:,i,5))))-(BinRR(:,i,1)/max(abs(BinRR(:,i,1))));
end

plot(BinTemp(:,1),DiffRR(:,10))

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

[row,col] = find(Area > 80);

%% Activation Temperature calculation

load('/home/debolina/chemkin/Dodecane/DodecaneAbE.mat')
% Row 1: A
% Row 2: b
% Row 3: Ea
Ru = 1.98588; % Universal gas constant in cal/K 

%Activation temperature: Ea/R

ActivationTemp = DodecaneMech(:,3)/Ru;

% Removing duplicacies:

    % HO2 + OH = O2 + H2O
    ActivationTemp(16) = ActivationTemp(16) + ActivationTemp(17);
    ActivationTemp(17) = 0;
    
    % 2HO2 = O2 + H2O2
    ActivationTemp(18) = ActivationTemp(18) + ActivationTemp(19);
    ActivationTemp(19) = 0;
    
    % H2O2 + OH = HO2 + H2O
    ActivationTemp(23) = ActivationTemp(23) + ActivationTemp(24);
    ActivationTemp(24) = 0;
    
    % CO +OH = CO2 + H
    ActivationTemp(26) = ActivationTemp(26) + ActivationTemp(27);
    ActivationTemp(27) = 0;
    % C2H2 + OH = CH2CO + H
    ActivationTemp(116) = ActivationTemp(116) + ActivationTemp(117);
    ActivationTemp(117) = 0;
 %% Scatter plot
RealArea=sort(Area(find(~isnan(Area))));
MedianVal = median(RealArea);
MeanVal = mean(RealArea);
 
 for i = 1 : 1 : NOR
     
     if(Area(i) > (MeanVal))
         
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
 
plot(MeanVal+0*[0 200],[1 10^5],'--k')
plot([0 200],0*[1 10^5]+298,':k')
plot([0 200],0*[1 10^5]+1898,':k')
xlabel('$Area(K)$','Interpreter','latex')
ylabel('$Activation\ Temperature(K)$','Interpreter','latex')
set(gca,'FontSize',24,'YScale','log')

%% Median
