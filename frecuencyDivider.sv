module frequencyDivider (
	input logic i_clk, i_rst,
	output logic o_clk);
	
	logic [1:0] cntClk;
	
	counter#(2) c0(i_clk, i_rst, 1, cntClk);
	
	assign o_clk = (cntClk < 2'd2) ? 1'b0 : 1'b1;
	
endmodule
