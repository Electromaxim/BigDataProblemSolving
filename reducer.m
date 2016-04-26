function reducer(intermKeysIn, intermValsIter, outKVStore)
% Copyright 2015 The MathWorks, Inc.

values = [];
while hasnext(intermValsIter)
    value = getnext(intermValsIter);
    values = [values; value]; %#ok<AGROW>
end
add(outKVStore, intermKeysIn, values);
