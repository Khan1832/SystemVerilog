class mem_cov;
	apb_tx tx;
	covergroup cg;
		option.per_instance=1;
		option.name="Covergroup CG";
		WR_RD:coverpoint tx.wr_rd
		{
			//explicit bins
			bins WRITE= {1'b1};
			bins READ= {1'b0};
			//option.weight = 2;
			type_option.weight = 2;
		}
		ADDR:coverpoint tx.addr //iff(top.pif.reset==0)
		{
			//explicit bins
			bins b1 = {[7:0]};
			bins b2 = {[15:8]};
			bins b3 = {[23:16]};
			bins b4 = {[31:24]};
			bins b5 = {[39:32]};
			bins b6 = {[47:40]};
			bins b7 = {[55:48]};
			bins b8 = {[63:56]};
			//option.weight = 4;
			type_option.weight = 4;
			option.comment="Address coverpoint";

			//ignore_bins b7 = {[55:48]};
			//illegal_bins b8 = {[63:56]};

			//creating bins using option
			//option.auto_bin_max=8;
		}
		WR_RD_X_ADDR:cross WR_RD,ADDR
		{
			option.weight = 5;
			//type_option.weight = 5;
		}//implicit bins
	endgroup

	covergroup cg2;
		option.per_instance=1;
		option.name="Covergroup 2 Targeted for DATA";
		WR_RD_CP: coverpoint tx.wr_rd
		{
			bins W={1'b1};
			bins R={1'b0};
			option.comment="WR_RD_Coverpoint";
			option.goal=100;
			option.at_least=20;
			option.weight=2;
		}
		DATA_CP:coverpoint tx.data
		{
			option.comment="DATA_Coverpoint";
			option.auto_bin_max=8;
			option.weight=3;
		}

		WR_RD_X_DATA:cross WR_RD_CP,DATA_CP
		{
			option.comment="DATA_CROSS_WITH_WR_RD";
			option.weight=4;
		}
	endgroup

	function new();
		cg=new();
		cg2=new();
	endfunction
	
	task run();
		forever begin
			tx=new();
			mon2cov.get(tx);
			cg.sample();
			cg2.sample();
		end
	endtask
endclass
