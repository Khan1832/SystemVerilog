class apb_bfm;
//Properties
apb_tx tx;
virtual mem_intf vif;
//Methods

function new();
	vif = top.pif; //copy by handle, pif handle is assigned to the vif.
endfunction

task run();
	$display("\nPrinting  Bus Function Model Fields");
	@(negedge vif.reset_i);
	forever begin
		tx=new();
		gen2bfm.get(tx);
		drive_tx(tx);//pkt or tx to port conversion is happening
		tx.print("BFM");
		apb_common::bfm_count++;//count++ => count=count+1
	end
endtask

task drive_tx(apb_tx tx);
	@(vif.bfm_cb);
	vif.bfm_cb.valid	<=1;
	vif.bfm_cb.wr_rd 	<=tx.wr_rd;
	vif.bfm_cb.addr 	<=tx.addr;
	if(tx.wr_rd==1) vif.bfm_cb.wdata 	<=tx.data;// Write transaction
	wait(vif.bfm_cb.ready==1);
	@(vif.bfm_cb);
	if(tx.wr_rd==0) tx.data=vif.bfm_cb.rdata;// Read tx
	vif.bfm_cb.valid	<=0;
	vif.bfm_cb.wr_rd 	<=0;
	vif.bfm_cb.addr 	<=0;
	vif.bfm_cb.wdata 	<=0;
endtask
//Constraints
endclass

