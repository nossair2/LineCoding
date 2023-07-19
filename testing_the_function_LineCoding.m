clear all; close all; clc;
%Made by : EL KATOURI nossair - OUTARI Ntissar - ELOUARDI Yasmine.
%% entering the digital signal :
data = [0 1 0 1 0 0 1 1 0 1 1 0 0 1 1 1 0 1];

%% chosing the line coding method :
disp('Enter the line coding method :')
disp('   - for Unipolar Non Return to Zero write UNRZ.')
disp('   - for Unipolar Return to Zero write URZ.')
disp('   - for Polar Non Return to Zero write PNRZ.')
disp('   - for Polar Return to Zero write PRZ.')
disp('   - for Bipolar Non Return to Zero write BNRZ.')
disp('   - for Bipolar Return to Zero write BRZ.')
disp('   - for Manchester write M.')
LineCoder = input('     => The line coding method :','s');

%% chosing bit duration, the sampling frequency and the amplitude:
A  = input('Enter the signal amplitude (V)   : ');
T  = input('Enter the bit duration (s)       : ');
fs = input('Enter the samling frequency (Hz) : ');

%% chosing the 
[t,Xanalog]=LineCoding(data,LineCoder,A,T,fs);
tit = strcat('the analog signal by the line coding method :',LineCoder);
plot(t,Xanalog,'linewidth',2)
title(tit);  xlabel('time (s)');  ylabel('amplitude (V)');
axis([0 length(data)*T -A-1 A+1])
grid on