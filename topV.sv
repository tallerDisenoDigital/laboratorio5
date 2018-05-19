module topV (
    input logic clk, rst,
    output logic[7:0] r, g, b,
	 output logic o_hs, o_vs, o_sync, o_blank);
	 
	 logic [9:0] x, y;
	 logic p_clk = 0;
	 
	 frequencyDivider ffd(clk, rst, p_clk);
	 
	 vgaController v0(p_clk, rst, o_hs, o_vs, o_sync, o_blank, x, y);
	 
	 assign r = o_blank ? 8'd255 : 8'd0;
	 assign g = 8'd0;
	 assign b = 8'd0;
	 
endmodule

