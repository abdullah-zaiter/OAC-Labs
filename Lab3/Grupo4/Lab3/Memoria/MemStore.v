/* Controlador da memoria de escrita */
/* define a partir do opcode qual a forma de acesso a memoria sb, sh, sw e ByteEnable*/

module MemStore(
	input [1:0] iAlignment,
	input [1:0] iWriteTypeF,
	input [2:0] iFunct3,
	input [31:0] iData,
	output [31:0] oData,
	output [3:0] oByteEnable,
	output oException
);


/* Para poder usar no Multiciclo e no Uniciclo que recebe Opcode */
wire [1:0] iWriteType;
always @(*)
begin
	case(iFunct3)
		F3_SW:		iWriteType = STORE_TYPE_SW;
		F3_SH:		iWriteType = STORE_TYPE_SH;
		F3_SB:		iWriteType = STORE_TYPE_SB;
		//OPCDUMMY:	iWriteType = iWriteTypeF;   //So para o PIPELINEM
		default:		iWriteType = STORE_TYPE_DUMMY;
	endcase
end


// Alignment exception
assign oException = (iWriteType == STORE_TYPE_SW && iAlignment != 2'b00)
                  | (iWriteType == STORE_TYPE_SH && iAlignment[0] != 1'b0);


always @(*) begin
	case (iWriteType)
		STORE_TYPE_SW:   oData = iData;
		STORE_TYPE_SH:   oData = {iData[15:0], iData[15:0]};
		STORE_TYPE_SB:   oData = {iData[7:0], iData[7:0], iData[7:0], iData[7:0]};
		default: oData = iData;
	endcase
end


always @(*) begin
	case (iWriteType)
		STORE_TYPE_SW: // Word
			begin
				case (iAlignment)
					2'b00:   oByteEnable = 4'b1111; // 4-aligned
					default: oByteEnable = 4'b0000; // Not aligned
				endcase
			end
		STORE_TYPE_SH: // Halfword
			begin
				case (iAlignment)
					2'b00:   oByteEnable = 4'b0011; // 2-aligned (lower)
					2'b10:   oByteEnable = 4'b1100; // 2-aligned (upper)
					default: oByteEnable = 4'b0000; // Not aligned
				endcase
			end
		STORE_TYPE_SB: // Byte
			begin
				case (iAlignment)
					2'b00: oByteEnable = 4'b0001;
					2'b01: oByteEnable = 4'b0010;
					2'b10: oByteEnable = 4'b0100;
					2'b11: oByteEnable = 4'b1000;
				endcase
			end
		default:
			oByteEnable = 4'b0000;
	endcase
end

endmodule
