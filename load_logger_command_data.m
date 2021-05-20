function [data] = load_logger_command_data(data_dir, bat_id)
%LOAD_LOGGER_COMMAND_DATA Summary of this function goes here
%   Detailed explanation goes here

%% Parameters


%% Load CSC data
files = dir(fullfile(data_dir, 'extracted_data'));
disp(files);
for i=1:length(files)
    file = files(i);
    fname = file.name;
    
    if regexp(fname, '\d*\_\d*_CSC(\d*)\.mat')
        re_match = regexp(fname, '\d*\_\d*_CSC(\d*)\.mat', 'tokens');
        channel_num = uint8(str2double(re_match{1}{1}))+1;
        disp(channel_num);
        temp_struct = load(fullfile(data_dir, 'extracted_data', fname));
        data.csc(:,channel_num) = temp_struct.AD_count_int16;
        data.timestamps_first_samples_logger_usec{channel_num} = temp_struct.Timestamps_of_first_samples_usec_Logger;
        data.sampling_period_usec = temp_struct.Sampling_period_usec_Logger;
    end
    
    if regexp(fname, '\d*\_\d*_EVENTS.mat')
        temp_struct = load(fullfile(data_dir, 'extracted_data', fname));
        data.event_types = temp_struct.event_types_and_details;
        data.events_timestamps_usec = temp_struct.event_timestamps_usec;
        data.ttl_ind = find(contains(data.event_types,'Digital in'));
        data.ttl_timestamps_usec = data.events_timestamps_usec(data.ttl_ind);
    end
end
figure;
for i=1:size(data.csc,2)
    plot(data.csc(10000:10500,i));
    hold on;
end

figure;
stem(data.ttl_timestamps_usec, ones(size(data.ttl_timestamps_usec)));
end

