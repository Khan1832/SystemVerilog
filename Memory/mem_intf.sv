//Interface contains only input ports where as module contains both input and output ports
interface mem_intf(input reg clk_i,reset_i);
//signals of the design

parameter WIDTH=16;
parameter DEPTH=64;
parameter ADDR_WIDTH=$clog2(DEPTH);
//valid,ready,wr_rd,addr,wdata,rdata
bit valid;
bit ready;
bit wr_rd;
bit [ADDR_WIDTH-1:0] addr;
bit [WIDTH-1:0] wdata;
bit [WIDTH-1:0] rdata;

//clocking blocks
clocking bfm_cb@(posedge clk_i);
	default input #0 output #1;//default skew
	//#0 at the posedge
	//#3 for outputs => sample the signals 3ns after +ve
	//#3 for inputs => sample 3ns before +ve
	//inputs to the bfm
	input  ready;
	input  rdata;
	//outputs from the bfm
	output valid;
	output wr_rd;
	output addr;
	output wdata;
endclocking

clocking mon_cb@(posedge clk_i);
	default input #1;//default skew
	//#0 at the posedge
	input  ready;
	input  rdata;
	input valid;
	input wr_rd;
	input addr;
	input wdata;
endclocking
//always
//assertion
//task or functions

endinterface
