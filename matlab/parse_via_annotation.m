function [outputArg1] = parse_via_annotation(filepath)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%% Parse VIA annotation metadata
fid = fopen(filepath);
tline = fgetl(fid);
for i=1:10
    if(i==7) % SHAPE_ID
        %disp(tline)
        match = regexp(tline, '{.*}', 'match');
        shape_id = jsondecode(match{1});
    elseif(i==8) % FLAG_ID
        match = regexp(tline, '{.*}', 'match');
        flag_id = jsondecode(match{1});
    elseif(i==9) % ATTRIBUTE
        match = regexp(tline, '{.*}', 'match');
        attribute = jsondecode(match{1});
    elseif(i==10) % CSV_HEADER
        match = regexp(tline, '(\w*)', 'match');
        csv_header = match(2:end);
    end
        
    tline = fgetl(fid);
end
fclose(fid);

%% Parse VIA annotations
T = readtable(filepath,'NumHeaderLines',10);
T.Properties.VariableNames = csv_header;
disp(T);



%outputArg1 = inputArg1;
%outputArg2 = inputArg2;
end

