% ts_002_plot_3D_variable_timeseries.m
%
% This script takes a profile .nc file and plots timeseries of a 3D
% variable at a given site with specified depth averaging settings
%
%
% SDE 2018

clear
close 

% ------------------- User Input ------------------

tfv_profile = '../../../../Complete_Model/TUFLOWFV/results/HYD_002_PROFILES.nc';                     % Profiles file created by ts_000_create_profile_file.m
site_plot   = 'Point_3';                                                    % Site name from profile file
var3d       = 'V';                                                          % 3D variable from profile file
ref         = {'sigma','depth','height','sigma','elevation'};               % Model reference (TFV convention)
range       = {[0 1];[0 1]; [0 1]; [0.49 0.51];[-5 -3]};                    % Model range (TFV convention)
davg_name   = {'Depth Averaged','Top','Bottom','Middle','-5 to 3m elevation'};                   % Depth averaging name

plot_xlimit = [datenum(2011,5,2) datenum(2011,5,7)];                       % Xlimit for the plot

save_png    = true;                                                         % Choose to save the figure (true|false)
out_plotdir = './plots/';                                                   % Plot output directory


% ------------- Advanced Plot Settings ------------

line_color  = [ 1.0000    0.4078         0
                0.1020    0.7412    0.7882
                0.0431    0.6588    0.0627
                0.0784    0.0784    0.7843
                0.7098    0.9020    0.0784];                                % Colour for the line being plotted [r,g,b]
plot_ylabel = 'Current Magnitude [m/s]';

%---------------- Initialise a figure --------------

f   = myfigure(2);                                                          % initilise a figure
ax  = myaxes(f,1,1,'Left_buff',0.07);                                       % place a axis on the figure

%---------------- Extract Data to plot --------------
for aa = 1:length(ref)
    if strcmpi(var3d,'V')                                                               % Special case of V to get the magnitude of V_x and V_y
        [y{aa},x{aa}] = gettseries(tfv_profile,site_plot,'hypot(V_x,V_y)',ref{aa},range{aa});   % script to extract the data from the profiles file
    else
        [y{aa},x{aa}] = gettseries(tfv_profile,site_plot,var3d,ref{aa},range{aa});              % script to extract the data from the profiles file
    end
end
%------------------- Plot the data ------------------

for aa = 1:length(ref)
    h(aa) = line(x{aa},y{aa},'parent',ax,'color',line_color(aa,:),'displayname',davg_name{aa});    % Plotting the line
end

%----------------------- Formating ------------------
set(ax,'XLim',plot_xlimit,...
       'xgrid','on',...
       'ygrid','on')
dynamicDateTicks(ax,[],'dd/mm')                                             % adds dates on the xaxis
ylabel(ax,plot_ylabel,'fontsize',9);                                        % adds in the ylabel
h_leg = legend(ax,h);
set(h_leg,'fontsize',8,'box','on');

%-----------------Save the output ------------------
if save_png
    outname = sprintf('TS_3D_%s_at_%s',var3d,site_plot);                    % output name
    print(f,[out_plotdir outname],'-dpng','-r200');                         % saves the plot
end
