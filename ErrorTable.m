%% Cretion of the SOC error table for Latex document
% Create file and intestation of the table
fid = fopen('errtable.txt','wt');
fprintf(fid,'\\begin{table}\n');
fprintf(fid,'\t\\centering\n');
fprintf(fid,'\t\\caption{\\soc estimation error}\\label{tab:err}\n');
fprintf(fid,'\t\\begin{tabular}{lcccc}\n');
fprintf(fid,'\t\\toprule\n');
fprintf(fid,'\t\\multicolumn{1}{l}{Driving}\t&\t\\multicolumn{2}{c}{AMA}\t&\t\\multicolumn{2}{c}{DEKF}\\\\\n');
fprintf(fid,'\t\\multicolumn{1}{l}{Schedule}\t&\tMax (\\%%)\t&\trms (\\%%)\t&\tMax (\\%%)\t&\trms (\\%%)\\\\\n');
fprintf(fid,'\t\\midrule\n');

%% Insert test rows results

test = './Simulation/wltp_class_3/';
load([test,'results_cell1']);
fprintf(fid,'\tWLTP class 3\t& %0.1f & %0.1f\t& %0.1f & %0.1f\\\\\n',socerr.amamax,socerr.amarms,socerr.ekfmax,socerr.ekfrms);

test = './Simulation/udds/';
load([test,'results_cell1']);
fprintf(fid,'\tUDDS\t& %0.1f & %0.1f\t& %0.1f & %0.1f\\\\\n',socerr.amamax,socerr.amarms,socerr.ekfmax,socerr.ekfrms);

test = './Simulation/hwfet/';
load([test,'results_cell1']);
fprintf(fid,'\tHWFET\t& %0.1f & %0.1f\t& %0.1f & %0.1f\\\\\n',socerr.amamax,socerr.amarms,socerr.ekfmax,socerr.ekfrms);

test = './Simulation/ftp/';
load([test,'results_cell1']);
fprintf(fid,'\tFTP\t& %0.1f & %0.1f\t& %0.1f & %0.1f\\\\\n',socerr.amamax,socerr.amarms,socerr.ekfmax,socerr.ekfrms);

test = './Simulation/im240/';
load([test,'results_cell1']);
fprintf(fid,'\tIM240\t& %0.1f & %0.1f\t& %0.1f & %0.1f\\\\\n',socerr.amamax,socerr.amarms,socerr.ekfmax,socerr.ekfrms);

test = './Simulation/sftp_us06/';
load([test,'results_cell1']);
fprintf(fid,'\tSFTP US06\t& %0.1f & %0.1f\t& %0.1f & %0.1f\\\\\n',socerr.amamax,socerr.amarms,socerr.ekfmax,socerr.ekfrms);

test = './Simulation/sftp_sc03/';
load([test,'results_cell1']);
fprintf(fid,'\tSFTP SC03\t& %0.1f & %0.1f\t& %0.1f & %0.1f\\\\\n',socerr.amamax,socerr.amarms,socerr.ekfmax,socerr.ekfrms);

test = './Simulation/nycc/';
load([test,'results_cell1']);
fprintf(fid,'\tNYCC\t& %0.1f & %0.1f\t& %0.1f & %0.1f\\\\\n',socerr.amamax,socerr.amarms,socerr.ekfmax,socerr.ekfrms);

test = './Simulation/la92/';
load([test,'results_cell1']);
fprintf(fid,'\tLA92\t& %0.1f & %0.1f\t& %0.1f & %0.1f\\\\\n',socerr.amamax,socerr.amarms,socerr.ekfmax,socerr.ekfrms);

test = './Simulation/la92short/';
load([test,'results_cell1']);
fprintf(fid,'\tLA92 short\t& %0.1f & %0.1f\t& %0.1f & %0.1f\\\\\n',socerr.amamax,socerr.amarms,socerr.ekfmax,socerr.ekfrms);

test = './Simulation/eudc/';
load([test,'results_cell1']);
fprintf(fid,'\tEUDC\t& %0.1f & %0.1f\t& %0.1f & %0.1f\\\\\n',socerr.amamax,socerr.amarms,socerr.ekfmax,socerr.ekfrms);

test = './Simulation/nedc/';
load([test,'results_cell1']);
fprintf(fid,'\tNEDC\t& %0.1f & %0.1f\t& %0.1f & %0.1f\\\\\n',socerr.amamax,socerr.amarms,socerr.ekfmax,socerr.ekfrms);

test = './Simulation/ece_r15/';
load([test,'results_cell1']);
fprintf(fid,'\tECE R15\t& %0.1f & %0.1f\t& %0.1f & %0.1f\\\\\n',socerr.amamax,socerr.amarms,socerr.ekfmax,socerr.ekfrms);

test = './Simulation/arturban/';
load([test,'results_cell1']);
fprintf(fid,'\tArtUrban\t& %0.1f & %0.1f\t& %0.1f & %0.1f\\\\\n',socerr.amamax,socerr.amarms,socerr.ekfmax,socerr.ekfrms);

test = './Simulation/artroad/';
load([test,'results_cell1']);
fprintf(fid,'\tArtRoad\t& %0.1f & %0.1f\t& %0.1f & %0.1f\\\\\n',socerr.amamax,socerr.amarms,socerr.ekfmax,socerr.ekfrms);

test = './Simulation/artmw130/';
load([test,'results_cell1']);
fprintf(fid,'\tArtMw130\t& %0.1f & %0.1f\t& %0.1f & %0.1f\\\\\n',socerr.amamax,socerr.amarms,socerr.ekfmax,socerr.ekfrms);

test = './Simulation/artmw150/';
load([test,'results_cell1']);
fprintf(fid,'\tArtMw150\t& %0.1f & %0.1f\t& %0.1f & %0.1f\\\\\n',socerr.amamax,socerr.amarms,socerr.ekfmax,socerr.ekfrms);

test = './Simulation/j1015/'; % window 240
load([test,'results_cell1']);
fprintf(fid,'\tJ1015\t& %0.1f & %0.1f\t& %0.1f & %0.1f\\\\\n',socerr.amamax,socerr.amarms,socerr.ekfmax,socerr.ekfrms);

%% Foot and close file

fprintf(fid,'\t\\bottomrule\n');
fprintf(fid,'\t\\end{tabular}\n');
fprintf(fid,'\\end{table}\n');
fclose(fid);
