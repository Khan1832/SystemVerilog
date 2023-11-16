mailbox gen2bfm=new();
mailbox mon2cov=new();
mailbox mon2sbd=new();
parameter WIDTH=16;
parameter DEPTH=64;
parameter ADDR_WIDTH=$clog2(DEPTH);

class apb_common;
static virtual mem_intf vif;
static int count=3;
static string testcase="test_wr_rd_ntx";
static int bfm_count;
static int tx_count;
static int num_matches=0;
static int num_mismatches=0;
endclass
