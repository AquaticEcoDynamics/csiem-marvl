function create_interpolated_BC_for_inflow_Canning(swan,headers,datearray,shift_AHD)


ISOTime = datearray;

%load canning.mat;


filename = 'Canning_Inflow_H.csv';
outdir = 'BCs/Tide/';



if ~exist(outdir,'dir')
    mkdir(outdir);
end


%__________________________________________________________________________

varname = 'height';


[t_date,ind] = unique(swan.DOT_PTBAR02.H.Date);
t_data = swan.DOT_PTBAR02.H.Data(ind);

[t_date1,ind] = unique(swan.DOT_FFFBH01.H.Date);
t_data1 = swan.DOT_FFFBH01.H.Data(ind);

ss = find(~isnan(t_data) == 1);
sss = find(~isnan(t_data1) == 1);

wl = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));

wl1 = interp1(t_date1(sss),t_data1(sss),datearray,'linear',mean(t_data1(sss)));

ttt = find(wl < -50);
wl(ttt) = wl1(ttt);

if shift_AHD% AHD shift
    wl = wl - (0.756 + 0.29) ;
else
    wl(wl < 0.18) = 0.18;
end

wl(wl < -50) = 0;


figure;plot(wl);title('wl');
%__________________________________________________________________________

% Tracers

SS2(1:length(datearray)) = 0;
SS3(1:length(datearray)) = 0;
SS4(1:length(datearray)) = 0;
SS5(1:length(datearray)) = 0;
SS6(1:length(datearray)) = 0;
SS7(1:length(datearray)) = 1;
SS8(1:length(datearray)) = 0;
SS9(1:length(datearray)) = 0;
%__________________________________________________________________________
% varname = 'Level';
% 
% t_depth = swan.DWER_616094.(varname).Depth;
% tt = find(t_depth > -0.3);
% 
% [t_date,ind] = unique(swan.DWER_616094.(varname).Date(tt));
% t_data = swan.DWER_616094.(varname).Data(tt(ind));
% 
% ss = find(~isnan(t_data) == 1);
% 
% wl = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));
% 
% figure;plot(wl);title('wl');
% 
% clear t_date t_data;

%__________________________________________________________________________
varname = 'SAL';%Changed from s6162994


Sal = create_interpolated_dataset(swan,varname,'DWER_6162994','Surface',datearray);


% t_depth = swan.DWER_6161838.(varname).Depth;
% tt = find(t_depth > -0.3);
% 
% [t_date,ind] = unique(swan.DWER_6161838.(varname).Date(tt));
% t_data = swan.DWER_6161838.(varname).Data(tt(ind));
% 
% ss = find(~isnan(t_data) == 1);
% 
% Sal = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));

figure;plot(Sal);title('Sal');

clear t_date t_data;

%__________________________________________________________________________

varname = 'TEMP';%Changed from s6162994

t_depth = swan.DWER_6161838.(varname).Depth;
tt = find(t_depth > -0.3);

[t_date,ind] = unique(swan.DWER_6161838.(varname).Date(tt));
t_data = swan.DWER_6161838.(varname).Data(tt(ind));

ss = find(~isnan(t_data) == 1);

Temp = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));

figure;plot(Temp);title('Temp');

clear t_date t_data;

%__________________________________________________________________________

varname = 'WQ_OXY_OXY';

t_depth = swan.DWER_6161838.(varname).Depth; %Changed from s6162994
tt = find(t_depth > -0.3);

[t_date,ind] = unique(swan.DWER_6161838.(varname).Date(tt));
t_data = swan.DWER_6161838.(varname).Data(tt(ind));

ss = find(~isnan(t_data) == 1);

Oxy = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));

figure;plot(Oxy);title('Oxygen');

clear t_date t_data;

%__________________________________________________________________________

varname = 'WQ_SIL_RSI';

t_depth = swan.DWER_6161838.(varname).Depth;
tt = find(t_depth > -0.3);

[t_date,ind] = unique(swan.DWER_6161838.(varname).Date(tt));
t_data = swan.DWER_6161838.(varname).Data(tt(ind));

ss = find(~isnan(t_data) == 1);

Sil = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));

figure;plot(Sil);title('Silica');

clear t_date t_data;

%__________________________________________________________________________

varname = 'WQ_NIT_AMM';

t_depth = swan.DWER_6161838.(varname).Depth;
tt = find(t_depth > -0.3);

[t_date,ind] = unique(swan.DWER_6161838.(varname).Date(tt));
t_data = swan.DWER_6161838.(varname).Data(tt(ind));

ss = find(~isnan(t_data) == 1);

Amm = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));

figure;plot(Amm);title('Amm');

clear t_date t_data;

%__________________________________________________________________________

varname = 'WQ_DIAG_TOT_TN';

t_depth = swan.DWER_6161838.(varname).Depth;
tt = find(t_depth > -0.3);

[t_date,ind] = unique(swan.DWER_6161838.(varname).Date(tt));
t_data = swan.DWER_6161838.(varname).Data(tt(ind));

ss = find(~isnan(t_data) == 1);

TN = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));

figure;plot(TN);title('TN');

clear t_date t_data;



%__________________________________________________________________________

varname = 'WQ_PHS_FRP';

t_depth = swan.DWER_6161838.(varname).Depth;
tt = find(t_depth > -0.3);

[t_date,ind] = unique(swan.DWER_6161838.(varname).Date(tt));
t_data = swan.DWER_6161838.(varname).Data(tt(ind));

ss = find(~isnan(t_data) == 1);

FRP = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));

figure;plot(FRP);title('FRP');

clear t_date t_data;


%__________________________________________________________________________
%BB

varname = 'FRP_ADS';


FRP_ADS = FRP .* 0.1;

figure;plot(FRP_ADS);title('FRP_ADS');

clear t_date t_data;




%__________________________________________________________________________
%BB

varname = 'WQ_OGM_DON';

t_depth = swan.DWER_6161838.(varname).Depth;
tt = find(t_depth > -0.3);

[t_date,ind] = unique(swan.DWER_6161838.(varname).Date(tt));
t_data = swan.DWER_6161838.(varname).Data(tt(ind));

ss = find(~isnan(t_data) == 1);

DON_T = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));

DON = DON_T .* 0.3;

figure;plot(DON);title('DON');

clear t_date t_data;



%__________________________________________________________________________

varname = 'WQ_DIAG_TOT_TKN';

t_depth = swan.DWER_6161838.(varname).Depth;
tt = find(t_depth > -0.3);

[t_date,ind] = unique(swan.DWER_6161838.(varname).Date(tt));
t_data = swan.DWER_6161838.(varname).Data(tt(ind));

ss = find(~isnan(t_data) == 1);

TKN = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));

figure;plot(TKN);title('TKN');

clear t_date t_data;

%__________________________________________________________________________

varname = 'TON';

TON = TKN-Amm;

figure;plot(TON);title('TON');

%__________________________________________________________________________

varname = 'WQ_NIT_NIT';

t_depth = swan.DWER_6161838.(varname).Depth;
tt = find(t_depth > -0.3);

[t_date,ind] = unique(swan.DWER_6161838.(varname).Date(tt));
t_data = swan.DWER_6161838.(varname).Data(tt(ind));

ss = find(~isnan(t_data) == 1);

Nit = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));

figure;plot(Nit);title('NIT');

clear t_date t_data;


%__________________________________________________________________________

varname = 'PON';

%PON = (TKN-Amm)-DON;
PON = TN - Amm - Nit - DON;

PON(PON < 0) = 0;

figure;plot(PON);title('PON');

%__________________________________________________________________________

varname = 'WQ_DIAG_TOT_TP';

t_depth = swan.DWER_6161838.(varname).Depth;
tt = find(t_depth > -0.3);

[t_date,ind] = unique(swan.DWER_6161838.(varname).Date(tt));
t_data = swan.DWER_6161838.(varname).Data(tt(ind));

ss = find(~isnan(t_data) == 1);

TP = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));

figure;plot(TP);title('TP');

clear t_date t_data;


%__________________________________________________________________________

varname = 'DOP';

DOP = (TP-FRP-FRP_ADS).* 0.4;

DOP(DOP < 0) = 0;


figure;plot(DOP);title('DOP');

%__________________________________________________________________________

varname = 'POP';

POP = (TP-FRP-FRP_ADS).* 0.5;

POP(POP < 0) = 0;


figure;plot(POP);title('POP');

%__________________________________________________________________________

varname = 'WQ_OGM_DOC';

t_depth = swan.DWER_6161838.(varname).Depth;
tt = find(t_depth > -0.3);

[t_date,ind] = unique(swan.DWER_6161838.(varname).Date(tt));
t_data = swan.DWER_6161838.(varname).Data(tt(ind));

ss = find(~isnan(t_data) == 1);

DOC_T = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));

DOC = DOC_T .* 0.1;

DOC(DOC < 0) = 0;

        TOC_Calc = (DOC .* 1.1) + 46;
        
        
        POC = TOC_Calc - DOC;

figure;plot(DOC);title('DOC');

clear t_date t_data;

%__________________________________________________________________________

varname = 'WQ_OGM_POC';

% t_depth = swan.DWER_6161838.(varname).Depth;
% tt = find(t_depth > -0.3);
% 
% [t_date,ind] = unique(swan.DWER_6161838.(varname).Date(tt));
% t_data = swan.DWER_6161838.(varname).Data(tt(ind));
% 
% ss = find(~isnan(t_data) == 1);
% 
% POC = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));
% 
% POC(POC < 0) = 0;

%POC Factor
POC = POC .* 2;


figure;plot(POC);title('POC');

clear t_date t_data;


%__________________________________________________________________________

varname = 'WQ_DIAG_TOT_TSS';

t_depth = swan.DWER_6160262.(varname).Depth;
tt = find(t_depth > -0.3);

[t_date,ind] = unique(swan.DWER_6160262.(varname).Date(tt));
t_data = swan.DWER_6160262.(varname).Data(tt(ind));

ss = find(~isnan(t_data) == 1);

SS1_T = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));

SS1 = SS1_T * 0.9;
SS2 = SS1_T * 0.1;

figure;plot(SS1);title('SS1');

clear t_date t_data;

% ______________________________________________________________________

varname = 'WQ_DIAG_PHY_TCHLA';

t_depth = swan.DWER_6161086.(varname).Depth;
tt = find(t_depth > -0.3);

[t_date,ind] = unique(swan.DWER_6161086.(varname).Date(tt));
t_data = swan.DWER_6161086.(varname).Data(tt(ind));

ss = find(~isnan(t_data) == 1);

CHLA = interp1(t_date(ss),t_data(ss),datearray,'linear',mean(t_data(ss)));

GRN = CHLA .* 0.15;


GRN(GRN < 0) = 0;


figure;plot(GRN);title('GRN');

clear t_date t_data;


% ______________________________________________________________________

varname = 'BGA';

%BGA(1:length(GRN),1) = 0;
BGA = CHLA .* 0.10;

BGA(BGA < 0) = 0;


figure;plot(BGA);title('BGA');

% ______________________________________________________________________

varname = 'FDIAT';

%FDIAT(1:length(GRN),1) = 0;
FDIAT = CHLA .* 0.10;

FDIAT(FDIAT < 0) = 0;


figure;plot(FDIAT);title('FDIAT');

% ______________________________________________________________________

varname = 'MDIAT';

MDIAT = CHLA .* 0.15;


figure;plot(MDIAT);title('MDIAT');

% ______________________________________________________________________

varname = 'KARLO';

%KARLO(1:length(GRN),1) = 0;
KARLO = CHLA .* 0.5;

KARLO(KARLO < 0) = 0;


figure;plot(KARLO);title('KARLO');

% ______________________________________________________________________

varname = 'TRACE_1';

TRACE_1(1:length(GRN),1) = 1;


figure;plot(TRACE_1);title('TRACE_1');

% ______________________________________________________________________

varname = 'RET';

RET(1:length(GRN),1) = 0;


figure;plot(RET);title('RET');

% ______________________________________________________________________

varname = 'AGE';

AGE(1:length(GRN),1) = 0;


figure;plot(AGE);title('AGE');
% ______________________________________________________________________

varname = 'DOCR';

DOCR = DOC_T .* 0.9;

DOCR(DOCR < 0) = 0;

figure;plot(DOCR);title('DOCR');

% ______________________________________________________________________

varname = 'DONR';

DONR = DON_T .* 0.7;

DONR(DONR < 0) = 0;

figure;plot(DONR);title('DONR');

% ______________________________________________________________________

varname = 'DOPR';

DOPR = (TP - FRP - FRP_ADS) .* 0.1;

DOPR(DOPR < 0) = 0;

figure;plot(DOPR);title('DOPR');

% ______________________________________________________________________

varname = 'CPOM';

CPOM = POC .* 0.1;

CPOM(CPOM < 0) = 0;

figure;plot(CPOM);title('CPOM');

% ______________________________________________________________________

CRYPT = FDIAT; 

DIATOM = MDIAT;

DINO = KARLO; 
%_______________________________________________________________________

%Reduced totals for replication

ones(1:length(datearray)) = 1;
zeroes(1:length(datearray)) = 0;
CHLA(CHLA < 0) = 0;
POC_T = POC;
POC_T(POC_T < 0) = 0;
PON_T = PON;
PON_T(PON_T < 0) = 0;
TSS = SS1_T;
TSS(TSS < 0) = 0;
OP = (TP-FRP-FRP_ADS);
OP(OP < 0) = 0;

% ________________________________

FDIAT_IN = FDIAT * 16/106;
FDIAT_IP = FDIAT * 1/106;
FDIAT_RHO(1:length(GRN)) = 1000;

MDIAT_IN = MDIAT * 16/106;
MDIAT_IP = MDIAT * 1/106;
MDIAT_RHO(1:length(GRN)) = 1000;

KARLO_IN = KARLO * 16/106;
KARLO_IP = KARLO * 1/106;
KARLO_RHO(1:length(GRN)) = 1000;

DINO_IN = DINO * 16/106;
DINO_IP = DINO * 1/106;
DINO_RHO(1:length(GRN)) = 1000;

DIATOM_IN = DIATOM * 16/106;
DIATOM_IP = DIATOM * 1/106;
DIATOM_RHO(1:length(GRN)) = 1000;

CRYPT_IN = CRYPT * 16/106;
CRYPT_IP = CRYPT * 1/106;
CRYPT_RHO(1:length(GRN)) = 1000;

CHLA_IN = CHLA * 16/106;
CHLA_IP = CHLA * 1/106;
CHLA_RHO(1:length(GRN)) = 1000;

BGA_IN = BGA * 16/106;
BGA_IP = BGA * 1/106;
BGA_RHO(1:length(GRN)) = 1000;

GRN_IN = GRN * 16/106;
GRN_IP = GRN * 1/106;
GRN_RHO(1:length(GRN)) = 1000;
% EXPORT ROUTINE___________________________________________________________

disp('Writing the inflow file');


fid = fopen([outdir,filename],'wt');

% Headers

for i = 1:length(headers)
    if i == length(headers)
        fprintf(fid,'%s\n',headers{i});
    else
        fprintf(fid,'%s,',headers{i});
    end
end


for j = 1:length(ISOTime)
    for i = 1:length(headers)
        if i == length(headers)
            eval(['fprintf(fid,','''','%4.6f\n','''',',',headers{i},'(j));']);
        else
            if i == 1
                eval(['fprintf(fid,','''','%s,','''',',datestr(',headers{i},'(j),','''','dd/mm/yyyy HH:MM:SS','''','));']);
            else
                eval(['fprintf(fid,','''','%4.6f,','''',',',headers{i},'(j));']);
            end
        end
    end
end

fclose(fid);









