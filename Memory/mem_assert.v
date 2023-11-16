// this is black box verification
module memory_assert(clk_i,reset_i,valid_i,addr_i,wdata_i,wr_rd_i,ready_o,rdata_o);

parameter WIDTH=16;
parameter DEPTH=64;
parameter ADDR_WIDTH=$clog2(DEPTH);

input clk_i;
input reset_i;
input valid_i;
input [ADDR_WIDTH-1:0]addr_i;
input [WIDTH-1:0]wdata_i;
input wr_rd_i;

input ready_o;
input [WIDTH-1:0]rdata_o;

// We are writing the concurrent assertios, these need to be written outside procedural block only.

//handshake is happening or not?(if valid issued, in the next clk we get ready or not?)
property handshake;
	@(posedge clk_i)valid_i==1 |-> ##1 ready_o==1;
	//@(posedge clk_i) valid_i==1 |=> ready_o==1;
endproperty
HANDSHAKE: assert property (handshake);

//if handshake happen, wr_rd is issued or not?
property wr_rd_assert;
	@(posedge clk_i) valid_i==1 && ready_o==1 |-> wr_rd_i==1 || wr_rd_i==0;
endproperty
WR_RD: assert property (wr_rd_assert);

//if wr_rd=1, addr and wdata is known or not?
property wr_rd_addr_wdata;
	@(posedge clk_i) wr_rd_i==1 |-> !($isunknown(addr_i)) ##0 !($isunknown(wdata_i));
endproperty
WR_RD_ADDR_WDATA: assert property (wr_rd_addr_wdata);

//if wr_rd=0, addr and rdata is known or not?
property wr_rd_addr_rdata;
	@(posedge clk_i) wr_rd_i==0 |-> !($isunknown(addr_i)) ##1 !($isunknown(rdata_o));
endproperty
WR_RD_ADDR_RDATA: assert property (wr_rd_addr_rdata);


endmodule
