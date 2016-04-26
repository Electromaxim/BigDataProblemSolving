function mapper(data, info, intermKVStore)
% Copyright 2015 The MathWorks, Inc.

time = datetime(data.DeviceTime,'InputFormat','dd-MMM-yyyy HH:mm:ss.SSS');

speed = data.Speed_OBD__mph_;
if iscell(speed)
    speed = str2double(speed);
end

% Compute acceleration (mph/s)
acc = diff(speed);

% Set threshold for sudden deceleration
thresh = -5; % -5 mph/s
match = find(acc < thresh);

fileNames = cell(numel(match),1);
fileNames(:) = {info.Filename};
addmulti(intermKVStore,{'timeOfDeceleration','fileName','decelerationAmount'},...
    {time(match), fileNames, acc(match)});
