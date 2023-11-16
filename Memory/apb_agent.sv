class apb_agent;
//Properties
apb_gen gen;
apb_bfm bfm;
apb_mon mon;
mem_cov cov;
//Methods
function new();
	gen=new();
	bfm=new();
	cov=new();
	mon=new();
endfunction

task run();
	fork
		gen.run();
		bfm.run();
		mon.run();
		cov.run();
	join
endtask
//Constraints
endclass
