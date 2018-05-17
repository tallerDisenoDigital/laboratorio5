module vgaController_tb;


	// Vertical and Horizontal counter registers.
	logic o_hs, o_vs, o_sync_n, o_blank_n;
	logic [9:0] x, y;
	
	//	Vertical and Horizontal counter signals.
	logic clk, rst;
	
	initial begin
		clk = 0;
		rst = 1;
		#40000 rst = 0;
	end
	always #20000 clk = ~clk;
	

	vgaController uut(clk, rst, o_hs, o_vs, o_sync_n, o_blank_n, x, y);
endmodule
