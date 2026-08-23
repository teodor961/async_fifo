1. Realized the previos problems I was having were with the wr\_driver and rd\_driver analysis and implementation ports.
To handle automated checking properly, I need to create a wr_monitor monitoring the input interface and a rd_monitor,
monitoring the output interface. These should then feed sequence items to the scoreboard for comparison.

2. It seems I have started working on some variable delays in the wr driver. I need to finish cleaning that up and get it working correctly

3. There are unexpected overflows and underflows due to latency in the write and read drivers. Need to investigate this
