clear all
clc

workdir = '/home/debolina/DNS/Methane_DNS/TemperatureAverage/';
cd(workdir)

Ka = [1 4];% 12 36 108];
%n = 50; % Number of components extracted: Y(35) RR(289) Wf(1) HR(1)
NReacs = 217;
NSpecies = 35;

for jj = 1 : 1 : length(Ka)
    
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs1.dat'],' ');
    % The colums have A have the following format
    % Binned Temp(1) Sum(n) SumSq(n) Avg(n) StdDev(n) binHits(1) binHits/ntot(1)
    % Total columns: 1+4n+2 = 4n+3
    % 1: Temp
    % 2:n+1 : Sums
    % n+2:2n+1 : SumSq
    % 2n+2:3n+1 : Avg
    % 3n+2:4n+1 : Std Dev
    % 4n+2:4n+3 : binHits, avgbinHits
    n = 50;
    BinTemp(:,jj) = A(:,1);
    BinWf(:,jj) = A(:,2*n+2);
    StdDevWf(:,jj) = A(:,3*n+2);
    BinHR(:,jj) = A(:,2*n+3);
    StdDevHR(:,jj) = A(:,3*n+3);
    BinRR(:,1:48,jj) = A(:,2*n+4:2*n+51);
    StdDevRR(:,1:48,jj) = A(:,3*n+4:3*n+51);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs2.dat'],' ');
    BinRR(:,49:98,jj) = A(:,2*n+2:2*n+51);
    StdDevRR(:,49:98,jj) = A(:,3*n+2:3*n+51);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs3.dat'],' ');
    BinRR(:,99:148,jj) = A(:,2*n+2:2*n+51);
    StdDevRR(:,99:148,jj) = A(:,3*n+2:3*n+51);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs4.dat'],' ');
    BinRR(:,149:198,jj) = A(:,2*n+2:2*n+51);
    StdDevRR(:,149:198,jj) = A(:,3*n+2:3*n+51);
    clear A
    n = 19;
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs5.dat'],' ');
    BinRR(:,199:217,jj) = A(:,2*n+2:2*n+20);
    StdDevRR(:,199:217,jj) = A(:,3*n+2:3*n+20);
    clear A
    n = 35;
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Species.dat'],' ');
    BinY(:,:,jj) = A(:,2*n+2:3*n+1);
    StdDevY(:,:,jj) = A(:,3*n+2:4*n+1);
    clear A
     %% Removing duplicacies in data from mechanism
    
    % H + O2 = HO2
    BinRR(:,33,jj) = BinRR(:,33,jj) + BinRR(:,34,jj) + BinRR(:,35,jj) +BinRR(:,36,jj);
    BinRR(:,34,jj) = 0;
    BinRR(:,35,jj) = 0;
    BinRR(:,36,jj) = 0;
    StdDevRR(:,33,jj) = sqrt((StdDevRR(:,33,jj).^2)+(StdDevRR(:,34,jj).^2)+(StdDevRR(:,35,jj).^2)+(StdDevRR(:,36,jj).^2));
    StdDevRR(:,34,jj) = 0;
    StdDevRR(:,35,jj) = 0;
    StdDevRR(:,36,jj) = 0;
    
    % 2H = H2
    BinRR(:,38,jj) = BinRR(:,38,jj) + BinRR(:,39,jj) + BinRR(:,40,jj) +BinRR(:,41,jj);
    BinRR(:,39,jj) = 0;
    BinRR(:,40,jj) = 0;
    BinRR(:,41,jj) = 0;
    StdDevRR(:,38,jj) = sqrt((StdDevRR(:,38,jj).^2)+(StdDevRR(:,39,jj).^2)+(StdDevRR(:,40,jj).^2)+(StdDevRR(:,41,jj).^2));
    StdDevRR(:,39,jj) = 0;
    StdDevRR(:,40,jj) = 0;
    StdDevRR(:,41,jj) = 0;
    
    % OH HO2 = O2 + H2O
    BinRR(:,86,jj) = BinRR(:,86,jj) + BinRR(:,179,jj);
    BinRR(:,179,jj) = 0;
    StdDevRR(:,86,jj) = sqrt((StdDevRR(:,86,jj).^2)+(StdDevRR(:,179,jj).^2));
    StdDevRR(:,179,jj) = 0;
    
    % OH + H2O2 = HO2 + H2O
    BinRR(:,87,jj) = BinRR(:,87,jj) + BinRR(:,88,jj);
    BinRR(:,88,jj) = 0;
    StdDevRR(:,87,jj) = sqrt((StdDevRR(:,87,jj).^2)+(StdDevRR(:,88,jj).^2));
    StdDevRR(:,88,jj) = 0;
    
    % 2HO2 = O2 + H2O2
    BinRR(:,114,jj) = BinRR(:,114,jj) + BinRR(:,115,jj);
    BinRR(:,115,jj) = 0;
    StdDevRR(:,114,jj) = sqrt((StdDevRR(:,114,jj).^2)+(StdDevRR(:,115,jj).^2));
    StdDevRR(:,115,jj) = 0;
    
    % HCO + M = H + CO + M
    BinRR(:,164,jj) = BinRR(:,164,jj) + BinRR(:,165,jj);
    BinRR(:,165,jj) = 0;
    StdDevRR(:,164,jj) = sqrt((StdDevRR(:,164,jj).^2)+(StdDevRR(:,165,jj).^2));
    StdDevRR(:,165,jj) = 0;
    
    % CH2(S) + M = CH2 + M
    BinRR(:,141,jj) = BinRR(:,141,jj) + BinRR(:,146,jj) + BinRR(:,149,jj) +BinRR(:,150,jj);
    BinRR(:,146,jj) = 0;
    BinRR(:,149,jj) = 0;
    BinRR(:,150,jj) = 0;
    StdDevRR(:,141,jj) = sqrt((StdDevRR(:,141,jj).^2)+(StdDevRR(:,146,jj).^2)+(StdDevRR(:,149,jj).^2)+(StdDevRR(:,150,jj).^2));
    StdDevRR(:,146,jj) = 0;
    StdDevRR(:,149,jj) = 0;
    StdDevRR(:,150,jj) = 0;
    
end
save('TempBinCH4.mat','BinRR','BinWf','BinTemp','BinHR','BinY')
save('TempStdDevCH4.mat','StdDevRR','StdDevWf','BinTemp','StdDevHR','StdDevY')