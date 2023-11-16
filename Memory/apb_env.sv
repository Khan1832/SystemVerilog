class apb_env;
//Properties
apb_agent agentDA;
mem_sbd sbd;
//Methods
function new();
	agentDA=new();
	sbd=new();
endfunction

task run();
		fork
			agentDA.run();
			sbd.run();
		join
endtask
//Constraints
endclass
