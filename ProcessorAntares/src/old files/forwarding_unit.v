//-----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Antares-R2 2016.1
//
// Module: forwarding_unit.v
// Desc:
// Inputs:
// 	rsID:
// 	rtID:
// 	rsEX:
// 	rtEX:
// 	rdMEM:
// 	rdWB:
//  regWriteMEM:
//  regWriteWB:
// Outputs:
//  dataSelectorID1:
//	dataSelectorID2:
//	dataSelectorEX1:
//  dataSelectorEX2:
//-----------------------------------------------------------------------------

module forwarding_unit(
	input [4:0] rsEX,rtEX,rdMEM,rdWB,
	input regWriteMEM,regWriteWB,
	output reg [1:0] dataSelectorEX1,dataSelectorEX2
);

	always @(rsEX,rtEX,rdMEM,rdWB,regWriteMEM,regWriteWB) begin

		if (rsEX == rdMEM && regWriteMEM == 1) begin
			dataSelectorEX1 <= 1; //stage 4
		end
    else if (rsEX == rdWB && regWriteWB == 1) begin
			dataSelectorEX1 <= 2; //stage 5
		end
    else begin
			dataSelectorEX1 <= 0; //no fowarding
		end

		if (rtEX == rdMEM && regWriteMEM == 1) begin
			dataSelectorEX2 <= 1;
		end
    else if (rtEX == rdWB && regWriteWB == 1) begin
			dataSelectorEX2 <= 2;
		end
    else begin
			dataSelectorEX2 <= 0;
		end

	end
endmodule
