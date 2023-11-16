class apb_gen;
//Properties
apb_tx tx,tx_temp,txQ[$];

//Methods
task run();
	$display("\nPrinting Generator Fields");
	case(apb_common::testcase)
	"test_wr_rd_ntx":begin
		apb_common::tx_count=2*apb_common::count;
		repeat(apb_common::count)begin
			//writes
			tx=new();
			assert(tx.randomize with {wr_rd==1;}); //addr=100
			gen2bfm.put(tx);
			tx_temp = new tx;
			txQ.push_back(tx_temp);
			//tx_t.print("GEN");
		end
		repeat(apb_common::count)begin
			//reads
			tx=new();
			tx_temp=txQ.pop_front();
			assert(tx.randomize with {wr_rd==0;addr==tx_temp.addr;});//addr=100
			gen2bfm.put(tx);
			//tx.print("GEN");
		end
	end
	"test_wr_rd_1tx":begin
			repeat(50)begin
				tx=new();
				assert(tx.randomize with {wr_rd==1;});
				gen2bfm.put(tx);
				tx_temp=new tx;
				assert(tx_temp.randomize with {wr_rd==0;addr==tx.addr;});
				gen2bfm.put(tx_temp);
			end
	end
	"test_hardcoded":begin
			repeat(5)begin
				tx=new();
				assert(tx.randomize with {wr_rd==1;data==16'b0000_0000_0011_0000;});
				gen2bfm.put(tx);
				tx_temp=new tx;
				assert(tx_temp.randomize with {wr_rd==0;addr==tx.addr;});
				gen2bfm.put(tx_temp);
			end
	end
	"test_rd_1tx":begin
			tx=new();
			assert(tx.randomize with {wr_rd==0;});
			gen2bfm.put(tx);
	end
	endcase
endtask

//Constraints
endclass
