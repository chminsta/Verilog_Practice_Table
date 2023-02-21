always @(posedge clk, posedge async_reset)
if (async_reset) {E,D,C,B}<=0;
else    {E,D,C,B}<={D,C,B,A};