clear all
clc

workdir = '/home/debolina/DNS/Methane_DNS/TemperatureAverage/';
cd(workdir)

Ka = [1 4 36];
%n = 50; % Number of components extracted: Y(56) RR(289) Wf(1) HR(1)
NReacs = 217;
NSpecies = 35;
load('TempBinCH4.mat')
load('TempStdDevCH4.mat')
for jj = 3 : 1 : length(Ka)
 
    % The colums have A have the following format
    % Binned Temp(1) Sum(n) SumSq(n) Avg(n) StdDev(n) binHits(1) binHits/ntot(1)
    % Total columns: 1+4n+2 = 4n+3
    % 1: Temp
    % 2:n+1 : Sums
    % n+2:2n+1 : SumSq
    % 2n+2:3n+1 : Avg
    % 3n+2:4n+1 : Std Dev
    % 4n+2:4n+3 : binHits, avgbinHits
    n = 10;
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs1.dat'],' ');
    BinTemp(:,jj) = A(:,1);
    BinWf(:,jj) = A(:,2*n+2);
    StdDevWf(:,jj) = A(:,3*n+2);
    BinHR(:,jj) = A(:,2*n+3);
    StdDevHR(:,jj) = A(:,3*n+3);
    BinRR(:,1:8,jj) = A(:,2*n+4:3*n+1); 
    StdDevRR(:,1:8,jj) = A(:,3*n+4:4*n+1);
    
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs2.dat'],' ');
    BinRR(:,9:18,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,9:18,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs3.dat'],' ');
    BinRR(:,19:28,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,19:28,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs4.dat'],' ');
    BinRR(:,29:38,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,29:38,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs5.dat'],' ');
    BinRR(:,39:48,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,39:48,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs6.dat'],' ');
    BinRR(:,49:58,jj) = A(:,2*n+2:3*n+1); 
    StdDevRR(:,49:58,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs7.dat'],' ');
    BinRR(:,59:68,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,59:68,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs8.dat'],' ');
    BinRR(:,69:78,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,69:78,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs9.dat'],' ');
    BinRR(:,79:88,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,79:88,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs10.dat'],' ');
    BinRR(:,89:98,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,89:98,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs11.dat'],' ');
    BinRR(:,99:108,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,99:108,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs12.dat'],' ');
    BinRR(:,109:118,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,109:118,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs13.dat'],' ');
    BinRR(:,119:128,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,119:128,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs14.dat'],' ');
    BinRR(:,129:138,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,129:138,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs15.dat'],' ');
    BinRR(:,139:148,jj) = A(:,2*n+2:3*n+1); 
    StdDevRR(:,139:148,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs16.dat'],' ');
    BinRR(:,149:158,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,149:158,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs17.dat'],' ');
    BinRR(:,159:168,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,159:168,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs18.dat'],' ');
    BinRR(:,169:178,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,169:178,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs19.dat'],' ');
    BinRR(:,179:188,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,179:188,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs20.dat'],' ');
    BinRR(:,189:198,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,189:198,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs21.dat'],' ');
    BinRR(:,199:208,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,199:208,jj) = A(:,3*n+2:4*n+1);
    clear A
    n = 9;
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs22.dat'],' ');
    BinRR(:,209:217,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,209:217,jj) = A(:,3*n+2:4*n+1);
    clear A
    % Species
    n = 10;
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Species1.dat'],' ');
    BinY(:,1:10,jj) = A(:,2*n+2:3*n+1);
    StdDevY(:,1:10,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Species2.dat'],' ');
    BinY(:,11:20,jj) = A(:,2*n+2:3*n+1);
    StdDevY(:,11:20,jj) = A(:,3*n+2:4*n+1);
    clear A
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Species3.dat'],' ');
    BinY(:,21:30,jj) = A(:,2*n+2:3*n+1);
    StdDevY(:,21:30,jj) = A(:,3*n+2:4*n+1);
    clear A
    n = 5;
    A = dlmread(['/home/debolina/DNS/Methane_DNS/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Species4.dat'],' ');
    BinY(:,31:35,jj) = A(:,2*n+2:3*n+1);
    StdDevY(:,31:35,jj) = A(:,3*n+2:4*n+1);
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