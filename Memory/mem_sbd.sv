class mem_sbd;
	apb_tx tx;
	bit [WIDTH-1:0]sbd_mem[int];//associative array

	task run();
		forever begin
			tx=new();
			mon2sbd.get(tx);
			//write
			if(tx.wr_rd==1)begin
				sbd_mem[tx.addr]=tx.data;// tx.addr=50 and tx.data=100 at writes here tx.data is wdata
			end
			//read
			else begin //reads
				if(sbd_mem[tx.addr]==tx.data)begin // tx.data is rdata
					// tx.addr=50 , and tx.data =100 i.e., i got rdata as 100
					apb_common::num_matches++;
					$display("%0t\tnum_match=%0d",$time,apb_common::num_matches);
				end
				else begin
					apb_common::num_mismatches++;
					$display("%0t\tnum_mismatch=%0d",$time,apb_common::num_mismatches);
					//$display("num_mismatch=%0d",apb_common::num_mismatches);
				end
			end
		end
	endtask
endclass
