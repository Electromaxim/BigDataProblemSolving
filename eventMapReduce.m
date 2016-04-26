%% Load file and create datastore

ds = datastore('*.csv');
ds.SelectedVariableNames = {'Speed_OBD__mph_','DeviceTime'};

previewDS = preview(ds);

%% Invoke mapreduce

mr = mapreducer(0); % Serial execution
% mr = mapreducer(); % Parallel execution

result = mapreduce(ds, @mapper, @reducer, mr);

out = readall(result);
fullResults = table(out.Value{1},out.Value{2},out.Value{3},...
    'VariableNames',{out.Key{1},out.Key{2},out.Key{3}})

%% Next step - point to HDFS

% ds = datastore('hdfs://ec2-54-69-190-244.us-west-2.compute.amazonaws.com/user/fleetdata/*.csv');
