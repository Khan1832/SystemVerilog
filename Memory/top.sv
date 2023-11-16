module top;
reg clk,rst;

mem_intf pif(clk,rst);// Inputs got passed to the interface
apb_env env;

memory #(.WIDTH(WIDTH),.ADDR_WIDTH(ADDR_WIDTH),.DEPTH(DEPTH))dut (
			.clk_i(pif.clk_i),
			.reset_i(pif.reset_i),
			.valid_i(pif.valid),
			.ready_o(pif.ready),
			.wr_rd_i(pif.wr_rd),
			.addr_i(pif.addr),
			.wdata_i(pif.wdata),
			.rdata_o(pif.rdata)
		);
memory_assert #(.WIDTH(WIDTH),.ADDR_WIDTH(ADDR_WIDTH),.DEPTH(DEPTH))dut_assert (
			.clk_i(pif.clk_i),
			.reset_i(pif.reset_i),
			.valid_i(pif.valid),
			.ready_o(pif.ready),
			.wr_rd_i(pif.wr_rd),
			.addr_i(pif.addr),
			.wdata_i(pif.wdata),
			.rdata_o(pif.rdata)
		);
always #5 clk=~clk;

initial begin;
	clk=0;
	rst=1;
	reset_signals();
	repeat(2)@(posedge clk);
	rst=0;
end

initial begin
	env=new();
	env.run();
end


initial begin
	//#500;
	#10;
	wait(apb_common::tx_count==apb_common::bfm_count);
	$display("Covreage percetage=%f",$get_coverage());
	#100;
	if(apb_common::num_matches==0 && apb_common::num_mismatches!=0)begin
		$display("##############################################################");	
		$display("%0t\tTest Failed with Matches=%0d\tMismatched=%0d",$time,apb_common::num_matches,apb_common::num_mismatches);
		$display("##############################################################");	
	end
	else begin
		$display("##############################################################");	
		$display("%0t\tTest Passed with Matches=%0d\tMismatched=%0d",$time,apb_common::num_matches,apb_common::num_mismatches);
		$display("##############################################################");	
	end
	#100;
	$finish();
end

task reset_signals();
	pif.valid=0;
	pif.wr_rd=0;
	pif.addr=0;
	pif.wdata=0;
endtask
endmodule
