clear all
clc
Ka=[1 12 36];
for jj = 1 : 1 : length(Ka)
    
    A = dlmread(['/home/debolina/DNS/Hydrogen/TemperatureAverage/' num2str(Ka(jj)) '/New/CM_temp_Reacs1.dat'],' ');
    % The colums have A have the following format
    % Binned Temp(1) Sum(n) SumSq(n) Avg(n) StdDev(n) binHits(1) binHits/ntot(1)
    % Total columns: 1+4n+2 = 4n+3
    % 1: Temp
    % 2:n+1 : Sums
    % n+2:2n+1 : SumSq
    % 2n+2:3n+1 : Avg
    % 3n+2:4n+1 : Std Dev
    % 4n+2:4n+3 : binHits, avgbinHits
    n = 12;
    BinTemp(:,jj) = A(:,1);
    BinWf(:,jj) = A(:,2*n+2);
    StdDevWf(:,jj) = A(:,3*n+2);
    BinHR(:,jj) = A(:,2*n+3);
    StdDevHR(:,jj) = A(:,3*n+3);
    BinRR(:,1:10,jj) = A(:,2*n+4:3*n+1);
    StdDevRR(:,1:10,jj) = A(:,3*n+4:4*n+1);
    clear A
    n = 11;
    A = dlmread(['/home/debolina/DNS/Hydrogen/TemperatureAverage/' num2str(Ka(jj)) '/New/CM_temp_Reacs2.dat'],' ');
    BinRR(:,11:21,jj) = A(:,2*n+2:3*n+1);
    StdDevRR(:,11:21,jj) = A(:,3*n+2:4*n+1);
    clear A
    n = 9;
    A = dlmread(['/home/debolina/DNS/Hydrogen/TemperatureAverage/' num2str(Ka(jj)) '/New/CM_temp_Species.dat'],' ');
    BinY(:,1:9,jj) = A(:,2*n+2:3*n+1);
    StdDevY(:,1:9,jj) = A(:,3*n+2:4*n+1);
    clear A

%     A = dlmread(['/home/debolina/DNS/Hydrogen/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs1.dat'],' ');
%     The colums have A have the following format
%     Binned Temp(1) Sum(n) SumSq(n) Avg(n) StdDev(n) binHits(1) binHits/ntot(1)
%     Total columns: 1+4n+2 = 4n+3
%     1: Temp
%     2:n+1 : Sums
%     n+2:2n+1 : SumSq
%     2n+2:3n+1 : Avg
%     3n+2:4n+1 : Std Dev
%     4n+2:4n+3 : binHits, avgbinHits
%     n = 12;
%     BinTemp(:,jj) = A(:,1);
%     BinWf(:,jj) = A(:,2*n+2);
%     StdDevWf(:,jj) = A(:,3*n+2);
%     BinHR(:,jj) = A(:,2*n+3);
%     StdDevHR(:,jj) = A(:,3*n+3);
%     BinRR(:,1:10,jj) = A(:,2*n+4:3*n+1);
%     StdDevRR(:,1:10,jj) = A(:,3*n+4:4*n+1);
%     clear A
%     n = 5;
%     A = dlmread(['/home/debolina/DNS/Hydrogen/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Reacs2.dat'],' ');
%     BinRR(:,11:15,jj) = A(:,2*n+2:3*n+1);
%     StdDevRR(:,11:15,jj) = A(:,3*n+2:4*n+1);
%     clear A
%     n=4;
%     BinRR(:,16:19,jj) = A(:,2*n+2:3*n+1);
%     StdDevRR(:,16:19,jj) = A(:,3*n+2:4*n+1);
%     clear A
%     n = 9;
%     A = dlmread(['/home/debolina/DNS/Hydrogen/TemperatureAverage/' num2str(Ka(jj)) '/CM_temp_Species.dat'],' ');
%     BinY(:,1:9,jj) = A(:,2*n+2:3*n+1);
%     StdDevY(:,1:9,jj) = A(:,3*n+2:4*n+1);
%     clear A

    
     %% Removing duplicacies in data from mechanism
    
    % HO2 + HO2 = H2O2 + O2
    BinRR(:,14,jj) = BinRR(:,14,jj) + BinRR(:,15,jj);
    BinRR(:,15,jj) = 0;
    StdDevRR(:,14,jj) = sqrt((StdDevRR(:,15,jj).^2)+(StdDevRR(:,14,jj).^2));
    StdDevRR(:,15,jj) = 0;
    
    % H2O2 + OH = HO2 + H2O
    BinRR(:,20,jj) = BinRR(:,20,jj) + BinRR(:,21,jj);
    BinRR(:,21,jj) = 0;
    StdDevRR(:,20,jj) = sqrt((StdDevRR(:,20,jj).^2)+(StdDevRR(:,21,jj).^2));
    StdDevRR(:,21,jj) = 0;
    
end
save('TempBinH2.mat','BinRR','BinWf','BinTemp','BinHR','BinY')
save('TempStdDevH2.mat','StdDevRR','StdDevWf','BinTemp','StdDevHR','StdDevY')
