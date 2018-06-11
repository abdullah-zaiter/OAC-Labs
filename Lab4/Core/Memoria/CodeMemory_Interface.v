`ifndef PARAM
	`include "../Parametros.v"
`endif

module CodeMemory_Interface (
    input wire    			iCLK, iCLKMem,
    //  Barramento de IO
    input wire    			wReadEnable, wWriteEnable,
    input wire  	[3:0]  	wByteEnable,
    input wire		[31:0] 	wAddress, wWriteData,
    output logic 	[31:0] 	wReadData
);

    wire        wMemWriteMB0;
    wire [31:0] wMemDataMB0;
    wire        is_usermem;


UserCodeBlock MB0 (
    .address(wAddress[TEXT_WIDTH-1:2]),
    .byteena(wByteEnable),
    .clock(iCLKMem),
    .data(wWriteData),
    .wren(wMemWriteMB0),
    .q(wMemDataMB0)
);



    reg MemWritten;
    initial MemWritten <= 1'b0;
    always @(iCLKMem) MemWritten <= iCLKMem;


    assign is_usermem   = wAddress >= BEGINNING_TEXT  && wAddress <= END_TEXT;        // Programa usuario .text

    assign wMemWriteMB0 = ~MemWritten && wWriteEnable && is_usermem;

    always @(*)
        if(wReadEnable)
            begin
                if(is_usermem)      wReadData = wMemDataMB0; else
                wReadData = 32'hzzzzzzzz;
            end
        else
            wReadData = 32'hzzzzzzzz;


endmodule
