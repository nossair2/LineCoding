function [taxis, Xanalog]=LineCoding(data,lineCoder,amplitude,T,fs)
% Made by   : EL KATOURI nossair - OUTARI Ntissar - ELOUARDI YASMINE.
% This function taks the digital signal vector 'data' and generate an analog 
% signal vector 'Xanalog' using the chosen line coder 'lineCoder'.
%lineCoder : the choised line coding method, it can be 'UNRZ','URZ','PNRZ','PRZ','BNRZ','BRZ' or 'M' (string).
%%% UNRZ : Unipolar Non Return to Zero.
%%% URZ  : Unipolar Return to Zero.
%%% PNRZ : Polar Non Return to Zero.
%%% PRZ  : Polar Return to Zero.
%%% BNRZ : Bipolar Non Return to Zero.
%%% BRZ  : Bipolar Return to Zero.
%%% M    : Manchester.
% data      : is the digital signal (vector)
% amplitude : the signal amplitude.
% T         : the duration of eache bit.
% fs        : sampling frequncy.

% DEFINING THE ANALOG SIGNAL :
m  = length(data);
dt = 1/fs;
taxis  = 0 : dt : m*T - dt;
n  = length(taxis);
Xanalog = zeros(1,n);

% GENERATING ANALOG SIGNAL :
switch lineCoder

% Unipolar Non Return to Zero____________________________________(verified)
    case 'UNRZ'
        for a = 1:m
           if data(a) == 1
              Xanalog( (a-1)*fs*T+1 : a*fs*T ) = amplitude;
           end
        end

% Unipolar Return to Zero________________________________________(verified)
    case 'URZ'
        for a = 1:m
           if data(a) == 1
              Xanalog( (a-1)*fs*T+1 : floor(a*fs*T + (1-fs*T)/2) ) = amplitude;
           end
        end
        
% Polar Non Return to Zero_______________________________________(verified)
    case 'PNRZ'
        Xanalog = Xanalog - amplitude;
        for a = 1:m
           if data(a) == 1
              Xanalog( (a-1)*fs*T+1 : a*fs*T ) =  amplitude;
           end
        end
        
% Polar Return to Zero___________________________________________(verified)
    case 'PRZ'
         for a = 1:m
           if data(a) == 1
              Xanalog( (a-1)*fs*T+1 : floor(a*fs*T + (1-fs*T)/2) ) = amplitude;
           else
              Xanalog( (a-1)*fs*T+1 : floor(a*fs*T + (1-fs*T)/2) ) = -amplitude;
           end
         end
         
% Bipolar Non Return to Zero_____________________________________(verified)
    case 'BNRZ'
         last = -amplitude;
         for a = 1:m
             if data(a) == 1   
                 if last == amplitude
                     Xanalog( (a-1)*fs*T+1 : a*fs*T ) = -amplitude;
                     last = -amplitude;
                 else
                     Xanalog( (a-1)*fs*T+1 : a*fs*T ) = amplitude;
                     last = amplitude;
                 end
             end
         end
         
% Bipolar Return to Zero_________________________________________(verified)
    case 'BRZ'
         last = -amplitude;
         for a = 1:m
             if data(a) == 1   
                 if last == amplitude
                     Xanalog( (a-1)*fs*T+1 : floor(a*fs*T + (1-fs*T)/2) ) = -amplitude;
                     last = -amplitude;
                 else
                     Xanalog( (a-1)*fs*T+1 : floor(a*fs*T + (1-fs*T)/2) ) = amplitude;
                     last = amplitude;
                 end
             end
         end
         
% Manchester_____________________________________________________(verified)  
    case 'M'
        for a = 1:m
           if data(a) == 1
              Xanalog( (a-1)*fs*T+1 : floor(a*fs*T + (1-fs*T)/2) ) = amplitude;
              Xanalog( floor(a*fs*T + (1-fs*T)/2) + 1 : a*fs*T )   = -amplitude;
           else
              Xanalog( (a-1)*fs*T+1 : floor(a*fs*T + (1-fs*T)/2) ) = -amplitude;
              Xanalog( floor(a*fs*T + (1-fs*T)/2) + 1 : a*fs*T )   = amplitude;
           end
        end
end
end