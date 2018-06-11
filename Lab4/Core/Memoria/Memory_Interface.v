`ifndef PARAM
	`include "../Parametros.v"
`endif

module Memory_Interface (
    input wire        iCLK, iCLKMem,
    //  Barramento de IO
    input wire        		wReadEnable, wWriteEnable,
    input wire  	[3:0]  	wByteEnable,
    input wire 	[31:0] 	wAddress, wWriteData,
    output logic 	[31:0] 	wReadData
);


    wire        wMemWrite_UserCode, wMemWrite_UserData;
    wire [31:0] wMemData_UserCode, wMemData_UserData;
    wire        is_usercode, is_userdata;


UserCodeBlock UCodeMem (
    .address(wAddress[TEXT_WIDTH-1:2]),           //em words
    .byteena(wByteEnable),
    .clock(iCLKMem),
    .data(wWriteData),
    .wren(wMemWrite_UserCode),
    .q(wMemData_UserCode)
);


UserDataBlock UDataMem (
    .address(wAddress[DATA_WIDTH-1:2]),           //em words
    .byteena(wByteEnable),
    .clock(iCLKMem),
    .data(wWriteData),
    .wren(wMemWrite_UserData),
    .q(wMemData_UserData)
);


    reg MemWritten = 1'b0;
//    initial MemWritten <= 1'b0;
//    always @(iCLKMem) MemWritten <= iCLKMem;



    assign is_usercode          = wAddress >= BEGINNING_TEXT    &&  wAddress <= END_TEXT;
    assign is_userdata          = wAddress >= BEGINNING_DATA    &&  wAddress <= END_DATA;

    assign wMemWrite_UserCode   = ~MemWritten && wWriteEnable && is_usercode;
    assign wMemWrite_UserData   = ~MemWritten && wWriteEnable && is_userdata;

    always @(*)
    if(wReadEnable)
        begin
            if(is_usercode)     wReadData = wMemData_UserCode; else
            if(is_userdata)     wReadData = wMemData_UserData; else
            wReadData   = 32'hzzzzzzzz;
        end
    else
        wReadData   = 32'hzzzzzzzz;

endmodule
