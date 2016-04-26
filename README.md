# BigDataProblemSolving
 different ways to visualize and explore data that came from a vehicle merging onto a highway
There are 3 demos included in this package.  These were all tested using MATLAB
R2014b.

1) MergingOntoRoute9

To run this example, run the "DemoLeavingMWontoRt9.m file.  The data can be 
imported in the Import Tool, by first choosing "Table" as the format to import
the data, and then choosing "Import Selection".  The data is visualized on a 
webmap, which requires Mapping Toolbox.

The second file to run for this example is BSFC_Analysis.m.  This will bring
up an app that can be used to explore the vehicle log data.

2) DeerIncident

Run the file eventMapReduce.m.  This runs a mapreduce job on a selection of 
data in order to identify when a sudden deceleration occurs.  

3) cylinderfailuredemo

Run the file cylinderFailureDemo.m.  This will try a few different techniques
for analyzing and visualizing data from a small aircraft engine.  The last
technique - computing a rolling standard deviation - makes it obvious that 
the 4th cylinder has an issue (in this case, a burnt exhaust valve).
