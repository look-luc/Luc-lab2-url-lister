# 2 workers
## part-r-00000
- \#       18
- https://en.wikipedia.org/wiki/ISBN_(identifier) 18
- https://en.wikipedia.org/wiki/S2CID_(identifier)        12
- mw-data:TemplateStyles:r1295599781      33

## part-r-00001
- mw-data:TemplateStyles:r886049734       12

## part-r-00002
- https://en.wikipedia.org/wiki/Doi_(identifier)  16
- mw-data:TemplateStyles:r1333433106      121

## Time
real    0m6.928s
user    0m10.386s
sys     0m0.661s

# 4 workers
## part-r-00000
-https://en.wikipedia.org/wiki/Doi_(identifier)  16

## part-r-00001
- mw-data:TemplateStyles:r886049734       12

## part-r-00002
- https://en.wikipedia.org/wiki/ISBN_(identifier) 18
- mw-data:TemplateStyles:r1295599781      33

## part-r-00003
- \#       18
- https://en.wikipedia.org/wiki/S2CID_(identifier)        12

## part-r-00004
- empty

## part-r-00005
- empty

## part-r-00006
- mw-data:TemplateStyles:r1333433106      121

## Time
real    0m8.267s
user    0m12.032s
sys     0m0.815s

# Time comparision
The 4 workers performed longer for both the map and the reduce since there were twice as many workers compared to the 2 workers given the amount of data. When running the 4 workers, we do see an improvement in the mapping somewhat but it seems like it is dependent on the size of the data when allocating the number of workers. It is suprising that for the 4 workers, there are two workers that have no outputs.
