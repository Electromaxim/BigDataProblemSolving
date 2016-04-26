function s = GenerateBSFCPlot(axh, drawPowerLines, s, ffGalMin, engineRPMrpm, torqueNm, varargin) %#ok<STOUT>
% GENERATEBSFCPLOT Generate a plot of BSFC showing the operating points 
% 
% GenerateBSFCPlot(Fuelflowrateminutegalmin, EngineRPMrpm, TorqueNM);
% 
% Auth/Revision:  Arvind Hosagrahara 
%                 Copyright 2014 The MathWorks Consulting Group 
%                 $Id: GenerateBSFCPlot.m 12 2014-05-12 20:47:51Z ahosagra $
%
%   Copyright 2015 The MathWorks, Inc.

% Convert Fuel flow from Gal/min to grams per second
fuelFlow = ffGalMin*3.78*737/60;

% Compute engine speed in radians per second (rad/s)
N = engineRPMrpm*2*pi/60;

% Compute BSFC in grams per kilowatt-hour
% BSFC = (fuelFlow./(N.*torqueNm))*3.6*10e6;
rawBSFC = fuelFlow*1000*3600./(N.*torqueNm);

% Throwout all unreasonable points
goodPoints = rawBSFC<1000 & rawBSFC>200;

% Remove missing data
TQ = torqueNm(goodPoints);
N = engineRPMrpm(goodPoints);
BSFC = rawBSFC(goodPoints);

% Clean out NaNs
TQ(isnan(BSFC))=[];
N(isnan(BSFC))=[];
BSFC(isnan(BSFC))=[];

% Load the BSFC Test18 data to overlay the data

axes(axh);

hold on;

% Generate lines of constant power
powerContours = 5:1:30;

speedbp=linspace(1000,5000,10000);
cumulativeSpeed = repmat(speedbp,length(powerContours),1);
cumulativeTorque = bsxfun(@times,powerContours',1000./(speedbp*2*pi/60));

if drawPowerLines
    for i = 1:length(powerContours)
        plot(cumulativeSpeed(i,:),cumulativeTorque(i,:),'color','b','linewidth',1);
        if i < 10
            text(speedbp(1),cumulativeTorque(i,1)+3,[num2str(powerContours(i)),' Kw']);
        end
    end
end

if ~isempty(N)
    % Discretize
    [~,nearestSpeed] = min(abs(bsxfun(@minus,N,speedbp)),[],2);
    [~,nearestTorque] = min(abs(cumulativeTorque(:,nearestSpeed) - ...
        repmat(TQ',length(powerContours),1)),[],1);
    idx = sub2ind(size(cumulativeSpeed),nearestTorque',nearestSpeed);
    pointsToPlot = [cumulativeSpeed(idx),...
        cumulativeTorque(idx)];
end

% Plot on graph
if isempty(s)
    s = scatter(pointsToPlot(:,1),pointsToPlot(:,2),'Marker','o','MarkerFaceColor','r','MarkerEdgeColor','r');
else
    if ~isempty(N)
        s.XData = pointsToPlot(:,1);
        s.YData = pointsToPlot(:,2);
    end
end

grid off;

end %function