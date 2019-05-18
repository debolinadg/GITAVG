clear all
clc

load('/home/debolina/DNS/c12/AverageFromPlotFIle/TempBinC12.mat')
load('/home/debolina/DNS/c12/AverageFromPlotFIle/TempStdDevC12.mat')

Ka = [1 4 12 36 108];

RR_Stddev_pos = BinRR + StdDevRR;
RR_Stddev_neg = BinRR - StdDevRR;

NOR = 289;

for k = 1 : 1 : length(Ka)
for j = 1 : 1 : NOR
    Area1(j,k) = 0;
    Area2(j,k) = 0;
    Area3(j,k) = 0;
    
for i = 1 : 1 : max(size(BinTemp))-1
    
    % Area between the Stddev curves
    dT = BinTemp(i+1,k) - BinTemp(i,k);
    RRleft = abs(RR_Stddev_pos(i,j,k));
    RRright = abs(RR_Stddev_pos(i+1,j,k));
    RectHeight = min(RRleft,RRright);
    TriHeight = max(RRleft,RRright) - RectHeight;
    Area1(j,k) = Area1(j,k)+(RectHeight * dT)+(0.5 * dT * TriHeight);
    
    RRleft = abs(RR_Stddev_neg(i,j,k));
    RRright = abs(RR_Stddev_neg(i+1,j,k));
    RectHeight = min(RRleft,RRright);
    TriHeight = max(RRleft,RRright) - RectHeight;
    Area2(j,k) = Area2(j,k)+(RectHeight * dT)+(0.5 * dT * TriHeight);
    
    % Area of the mean RR
    RRleft = abs(BinRR(i,j,k));
    RRright = abs(BinRR(i+1,j,k));
    RectHeight = min(RRleft,RRright);
    TriHeight = max(RRleft,RRright) - RectHeight;
    Area3(j,k) = Area3(j,k)+(RectHeight * dT)+(0.5 * dT * TriHeight);
    
    Area(j,k) = (Area1(j,k) - Area2(j,k))/Area3(j,k);
    
    
end
end
end

for i = 1 : 1 : length(Ka)
    for j = 1 : 1 : NOR
        for k = 1 : 1 : max(size(BinTemp))
            if(BinRR(k,j,i)/max(BinRR(:,j,i)) <= 10^-3)
                BinRR(k,j,i) = 0;
            end
        end
    end
end
AreaTemp = (StdDevRR) ./BinRR;

%% Activation energy 
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
    
   %% Laminar
   
load('/home/debolina/DNS/c12/Data_0.mat')
T = [310.5 510.5 810.5 1010.5 1210.5 1410.5 1610.5 1810.5];
TBinloc =[1 9 21 29 37 45 53 61];
colors = ['y' 'r' 'c' 'b' 'w' 'g' 'k' 'm'];
for j = 1 : 1 : length(T)
for i = 1 : 1 : length(Temp0)
    
    if(abs(Temp0(i)-T(j))<0.05)
        loc(j) = i;
        break
    end
        
end
end

    for j = 1 : 1 : NOR
        for k = 1 : 1 : max(size(RXN_Rate0))
            if(RXN_Rate0(k,j)/max(RXN_Rate0(:,j)) <= 10^-3)
                RXN_Rate0(k,j) = 0;
            end
        end
    end
%% Plotting


% Area1/AreaMean1
% Area108- Area1/RRlamarea
% Area108/Area1

RXN_Rate0 = RXN_Rate0 * 10^6;

% stddev108/RRlam at a given temperature
for j = 1 : 1 : length(T)
for i = 1 : 1 : NOR
    str = char(colors(j));
    if(ActivationTemp(i)<298)
             figure(2)
             plot(ActivationTemp(i),StdDevRR(j,i,5)/RXN_Rate0(loc(j),i),['o' str])
             hold on
     elseif(ActivationTemp(i)>=298 && ActivationTemp(i)<=1898)
             figure(2)
             plot(ActivationTemp(i),StdDevRR(j,i,5)/RXN_Rate0(loc(j),i),['*' str])
             hold on
     elseif(ActivationTemp(i)>=1898)
             figure(2)
             plot(ActivationTemp(i),StdDevRR(j,i,5)/RXN_Rate0(loc(j),i),['^' str])
             hold on
     end
    
end
end

% stddev1/RRlam at a given temperature
for j = 1 : 1 : length(T)
for i = 1 : 1 : NOR
    str = char(colors(j));
    if(ActivationTemp(i)<298)
             figure(3)
             plot(ActivationTemp(i),StdDevRR(j,i,1)/RXN_Rate0(loc(j),i),['o' str])
             hold on
     elseif(ActivationTemp(i)>=298 && ActivationTemp(i)<=1898)
             figure(3)
             plot(ActivationTemp(i),StdDevRR(j,i,1)/RXN_Rate0(loc(j),i),['*' str])
             hold on
     elseif(ActivationTemp(i)>=1898)
             figure(3)
             plot(ActivationTemp(i),StdDevRR(j,i,1)/RXN_Rate0(loc(j),i),['^' str])
             hold on
     end
    
end
end

% stddev108/stddev1 at a given temperature

for j = 1 : 1 : length(T)
for i = 1 : 1 : NOR
    str = char(colors(j));
    if(ActivationTemp(i)<298)
             figure(4)
             plot(ActivationTemp(i),StdDevRR(j,i,5)/StdDevRR(j,i,1),['o' str])
             hold on
     elseif(ActivationTemp(i)>=298 && ActivationTemp(i)<=1898)
             figure(4)
             plot(ActivationTemp(i),StdDevRR(j,i,5)/StdDevRR(j,i,1),['*' str])
             hold on
     elseif(ActivationTemp(i)>=1898)
             figure(4)
             plot(ActivationTemp(i),StdDevRR(j,i,5)/StdDevRR(j,i,1),['^' str])
             hold on
     end
    
end
end

%Area108/Area1

for i = 1 : 1 : NOR
    %str = char(colors(j));
    if(ActivationTemp(i)<298)
             figure(5)
             plot(ActivationTemp(i),Area(i,5)/Area(i,1),'ob')
             hold on
     elseif(ActivationTemp(i)>=298 && ActivationTemp(i)<=1898)
             figure(5)
             plot(ActivationTemp(i),Area(i,5)/Area(i,1),'*g')
             hold on
     elseif(ActivationTemp(i)>=1898)
             figure(5)
             plot(ActivationTemp(i),Area(i,5)/Area(i,1),'^r')
             hold on
     end
    
end
% Area108/AreaMean108
for i = 1 : 1 : NOR
    %str = char(colors(j));
    if(ActivationTemp(i)<298)
             figure(6)
             plot(ActivationTemp(i),Area(i,5),'ob')
             hold on
     elseif(ActivationTemp(i)>=298 && ActivationTemp(i)<=1898)
             figure(6)
             plot(ActivationTemp(i),Area(i,5),'*b')
             hold on
     elseif(ActivationTemp(i)>=1898)
             figure(6)
             plot(ActivationTemp(i),Area(i,5),'^b')
             hold on
     end
    
end

for i = 1 : 1 : NOR
    %str = char(colors(j));
    if(ActivationTemp(i)<298)
             figure(6)
             plot(ActivationTemp(i),Area(i,1),'or')
             hold on
     elseif(ActivationTemp(i)>=298 && ActivationTemp(i)<=1898)
             figure(6)
             plot(ActivationTemp(i),Area(i,1),'*r')
             hold on
     elseif(ActivationTemp(i)>=1898)
             figure(6)
             plot(ActivationTemp(i),Area(i,1),'^r')
             hold on
     end
    
end
