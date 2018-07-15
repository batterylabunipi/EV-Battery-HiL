load cycles_artemis
load cycles_epa
load cycles_nedc
load cycles_wltp
load Japan_Light_Duty_Vehicles
load United_States_Light-Duty_Vehicles

%%
fid = fopen('scheduletable.txt','wt');

%%

dur = UDDS.Time(end)/60;
avsp = mean(UDDS.Data);
dist = dur/60*avsp;

fprintf(fid,'UDDS\t&\t%0.0f\t&\t%0.1f\t&\t%0.1f\\\\',dur,dist,avsp);

%%
fprintf(fid,'\n');

dur = HWFET.Time(end)/60;
avsp = mean(HWFET.Data);
dist = dur/60*avsp;

fprintf(fid,'HWFET\t&\t%0.0f\t&\t%0.1f\t&\t%0.1f\\\\',dur,dist,avsp);

%%
fprintf(fid,'\n');

dur = FTP.Time(end)/60;
avsp = mean(FTP.Data);
dist = dur/60*avsp;

fprintf(fid,'FTP\t&\t%0.0f\t&\t%0.1f\t&\t%0.1f\\\\',dur,dist,avsp);

%%
fprintf(fid,'\n');

dur = EUDC.Time(end)/60;
avsp = mean(EUDC.Data);
dist = dur/60*avsp;

fprintf(fid,'EUDC\t&\t%0.0f\t&\t%0.1f\t&\t%0.1f\\\\',dur,dist,avsp);

%%
fprintf(fid,'\n');

dur = NEDC.Time(end)/60;
avsp = mean(NEDC.Data);
dist = dur/60*avsp;

fprintf(fid,'NEDC\t&\t%0.0f\t&\t%0.1f\t&\t%0.1f\\\\',dur,dist,avsp);

%%
fprintf(fid,'\n');

dur = ECE_R15.Time(end)/60;
avsp = mean(ECE_R15.Data);
dist = dur/60*avsp;

fprintf(fid,'ECE R15\t&\t%0.0f\t&\t%0.1f\t&\t%0.1f\\\\',dur,dist,avsp);

%%
fprintf(fid,'\n');

dur = WLTP_class_3.Time(end)/60;
avsp = mean(WLTP_class_3.Data);
dist = dur/60*avsp;

fprintf(fid,'WLTP class 3\t&\t%0.0f\t&\t%0.1f\t&\t%0.1f\\\\',dur,dist,avsp);

%%
fprintf(fid,'\n');

dur = ArtUrban.Time(end)/60;
avsp = mean(ArtUrban.Data);
dist = dur/60*avsp;

fprintf(fid,'ArtUrban\t&\t%0.0f\t&\t%0.1f\t&\t%0.1f\\\\',dur,dist,avsp);

%%
fprintf(fid,'\n');

dur = ArtRoad.Time(end)/60;
avsp = mean(ArtRoad.Data);
dist = dur/60*avsp;

fprintf(fid,'ArtRoad\t&\t%0.0f\t&\t%0.1f\t&\t%0.1f\\\\',dur,dist,avsp);

%%
fprintf(fid,'\n');

dur = ArtMw130.Time(end)/60;
avsp = mean(ArtMw130.Data);
dist = dur/60*avsp;

fprintf(fid,'ArtMw130\t&\t%0.0f\t&\t%0.1f\t&\t%0.1f\\\\',dur,dist,avsp);

%%
fprintf(fid,'\n');

dur = ArtMw150.Time(end)/60;
avsp = mean(ArtMw150.Data);
dist = dur/60*avsp;

fprintf(fid,'ArtMw150\t&\t%0.0f\t&\t%0.1f\t&\t%0.1f\\\\',dur,dist,avsp);

%%
fprintf(fid,'\n');

dur = J1015.Time(end)/60;
avsp = mean(J1015.Data);
dist = dur/60*avsp;

fprintf(fid,'J1015\t&\t%0.0f\t&\t%0.1f\t&\t%0.1f\\\\',dur,dist,avsp);

%%
fprintf(fid,'\n');

dur = IM240.Time(end)/60;
avsp = mean(IM240.Data);
dist = dur/60*avsp;

fprintf(fid,'IM240\t&\t%0.0f\t&\t%0.1f\t&\t%0.1f\\\\',dur,dist,avsp);

%%
fprintf(fid,'\n');

dur = SFTP_US06.Time(end)/60;
avsp = mean(SFTP_US06.Data);
dist = dur/60*avsp;

fprintf(fid,'SFTP US06\t&\t%0.0f\t&\t%0.1f\t&\t%0.1f\\\\',dur,dist,avsp);

%%
fprintf(fid,'\n');

dur = SFTP_SC03.Time(end)/60;
avsp = mean(SFTP_SC03.Data);
dist = dur/60*avsp;

fprintf(fid,'SFTP SC03\t&\t%0.0f\t&\t%0.1f\t&\t%0.1f\\\\',dur,dist,avsp);

%%
fprintf(fid,'\n');

dur = NYCC.Time(end)/60;
avsp = mean(NYCC.Data);
dist = dur/60*avsp;

fprintf(fid,'NYCC\t&\t%0.0f\t&\t%0.1f\t&\t%0.1f\\\\',dur,dist,avsp);

%%
fprintf(fid,'\n');

dur = LA92.Time(end)/60;
avsp = mean(LA92.Data);
dist = dur/60*avsp;

fprintf(fid,'LA92\t&\t%0.0f\t&\t%0.1f\t&\t%0.1f\\\\',dur,dist,avsp);

%%
fprintf(fid,'\n');

dur = LA92short.Time(end)/60;
avsp = mean(LA92short.Data);
dist = dur/60*avsp;

fprintf(fid,'LA92 short\t&\t%0.0f\t&\t%0.1f\t&\t%0.1f\\\\',dur,dist,avsp);

%%
fclose(fid);