
%MCSCalculator(D) returns the RSSI achieved with a distance D between the
%Access Point (AP) and the Station (STA) when the AP uses 20 MHz of channel
%bandwidth and 23 dBm of transmission power.
%
%[rssi, mcs, ss, mcs_prob] = MCSCalculator(D) returns the RSSI achieved in
%rssi, the most likely MCS and number of spatial streams in mcs and ss, and
%the MCS probabilities in mcs_prob as a 2 by 10 matrix where the first row
%represents MCS 0-9 with one spatial stream, and the second row represents
%two spatial streams.
%
%[rssi, mcs, ss, mcs_prob] = MCSCalculator(D, BW, PW) uses the distance D,
%the channel bandwidth BW and the transmission power PW used by the AP 
%to get the RSSI and MCS probailities.

function [rssi, mcs, ss, perc] = TMBmodel5GhzWIFI(dist,bw,pw)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ERRORS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
perc='Unavailable';
rssi='Unavailable';
ss='Unavailable';
mcs='Unavailable';
if(nargin==1)
    disp('Bandwidth and transmission power not selected, using default 20 MHz and 23 dBm');
    bw=20;
    pw=23;
else if(nargin~=3)
        disp('Correct usage: MCSSelector(distance, chan. bw, AP transmission power), example: MCSSelector(15.5, 20, 23)');
        return
    end
end

if(dist<1)
    disp('Distance should be 1 or higher')
    return
end
pi=-1;
bi=-1;

switch pw
    case 4
        pi=0;
    case 10
        pi=1;
    case 23
        pi=2;
    otherwise
        pi=-1;
end

switch bw
    case 20
        bi=1;
    case 40
        bi=4;
    case 80
        bi=7;
    otherwise
        bi=-1;
end


if(bi==-1)
    disp('Channel bandwidth should be 20, 40 or 80 MHz');
    return
end

if(pi==-1)
    disp('Transmission power should be 4, 10 or 23 dBm');
    return
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ERRORS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


load('MCSandSS.mat');

L0=54.12;  % Path loss intercept
g=2.06067;  % Attenuation factor
k=5.25;     % Wall attenuation
w=0.1467;   % Average number of traversed walls per meter.


PL_avg=L0 + 10 * g * log10(dist) + k * w * dist;

rssi=pw-PL_avg;
range=-97:-23;
rssi=floor(rssi);
index=find(range==rssi);
if(isempty(index)==1)
    fprintf('The RSSI (%d) is below the sensitivity (-97 dBm), try reducing the distance\n',rssi);
    return
end
stepsNames={'f20MHz4dBm','f20MHz10dBm','f20MHz23dBm','f40MHz4dBm','f40MHz10dBm','f40MHz23dBm','f80MHz4dBm','f80MHz10dBm','f80MHz23dBm'};

steps={'ss1p','ss2p'};

perc=zeros(2,10);

for i=1:length(steps)
    perc(i,:)=db.(stepsNames{bi+pi}).(steps{i})(index,:);
end

if(nansum(nansum(perc))==0)
    n=0;
    while(nansum(nansum(perc))==0 && (index+n-1)>0)
        n=n-1;
        for i=1:length(steps)
            perc(i,:)=db.(stepsNames{bi+pi}).(steps{i})(index+n,:);
        end       
       
    end
    if(index+n==1)
        fprintf('The distance is too high for this configuration, there are no results available \n');
        perc = 'Unavailable';
        return
    else
        fprintf('This configuration has an RSSI of: %d dBm, there are no captures at this RSSI, next possible configuration is for %d dBm \n', range(index), range(index+n));
    end
end
[m, ind]=max(perc,[],2);
[m, indss]=max(m);
ss=indss;
mcs=ind(ss)-1;

end
