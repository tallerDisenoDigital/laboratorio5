	module vgaController #(parameter HACTIVE = 10'd635,
											HFP 	  = 10'd15,
											HSYN    = 10'd95,
											HBP     = 10'd48,
											HMAX    = HACTIVE + HFP + HSYN + HBP,
											HSS     = HACTIVE + HFP,
											HSE     = HACTIVE + HFP + HSYN,
											
											VACTIVE = 10'd480,
											VFP     = 10'd10,
											VSYN    = 10'd2,
											VBP     = 10'd33,
											VMAX    = VACTIVE + VFP + VSYN + VBP,
											VSS     = VACTIVE + VFP,
											VSE     = VACTIVE + VFP + VSYN)
	(input logic i_clk, i_rst,
	output logic o_hs, o_vs, o_sync_n, o_blank_n,
	output logic [9:0] o_x, o_y); 	
	
	logic hRstF, vRstF, hSyncSF, hSyncEF, vSyncSF, vSyncEF,  hBlankF, vBlankF = 0;
	logic [9:0] hCnt, vCnt;
	
	//	Pixel Counter
	counter#(10) horizontalPixelCounter(i_clk, (i_rst | hRstF), 1, hCnt);
	counter#(10) VerticalPixelCounter(i_clk, (i_rst | hRstF & vRstF), hRstF, vCnt);
	
	//	Max Line Comparator
	comparator#(10) hMaxComparator(.a(hCnt), .b(HMAX - 1), .gte(hRstF));
	comparator#(10) vMaxComparator(.a(vCnt), .b(VMAX - 1), .gte(vRstF));
	
	
	//	H-Sync Comparator
	comparator#(10) hSSComparator(.a(hCnt), .b(HSS), .gte(hSyncSF));
	comparator#(10) hSEComparator(.a(hCnt), .b(HSE), .lt(hSyncEF));
	
	//	V-Sync Comparator
	comparator#(10) vVSComparator(.a(vCnt), .b(VSS), .gte(vSyncSF));
	comparator#(10) vSEComparator(.a(vCnt), .b(VSE), .lt(vSyncEF));
	
	//	Blank Comparator
	comparator#(10) bHComparator(.a(hCnt), .b(HACTIVE), .lt(hBlankF));
	comparator#(10) bVComparator(.a(vCnt), .b(VACTIVE), .lt(vBlankF));
	
	//	Sync Active Low Signals
   assign o_hs = ~(hSyncSF & hSyncEF);
   assign o_vs = ~(vSyncSF & vSyncEF);
	assign o_sync_n = o_hs & o_vs;
	
	assign o_blank_n = hBlankF & vBlankF;
	
	
   assign o_x = (hBlankF) ? hCnt : HACTIVE - 1;
   assign o_y = (vBlankF) ? vCnt : VACTIVE - 1;
	
endmodule
