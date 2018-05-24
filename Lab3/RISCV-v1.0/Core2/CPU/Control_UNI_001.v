                    oOrigALU            = 2'b00;
                    oMemparaReg         = 3'b000;
                    oEscreveReg         = 1'b0;
                    oLeMem              = 1'b0;
                    oEscreveMem         = 1'b0;
                    oOrigPC             = 3'b000;
                    oOpALU              = 2'b00;
                    oEscreveRegFPU      = 1'b0;
                    oDataRegFPU         = 2'b00;
                    oRegDstFPU          = 2'b00;
                    oFPUparaMem         = 2'b00;
                    oFPFlagWrite        = 1'b0;
                    oEscreveRegCOP0     = 1'b0;
                    oEretCOP0           = 1'b0;
                    oExcOccurredCOP0    = wNotExcLevel;
                    oBranchDelayCOP0    = 1'b0;
                    oExcCodeCOP0        = EXCODEINSTR;
                end
            endcase
        end
 
        // instrucao invalida
        default:
        begin
            oRegDst             = 2'b00;
            oOrigALU            = 2'b00;
            oMemparaReg         = 3'b000;
            oEscreveReg         = 1'b0;
            oLeMem              = 1'b0;
            oEscreveMem         = 1'b0;
            oOrigPC             = 3'b000;
            oOpALU              = 2'b00;
            oEscreveRegFPU      = 1'b0;
            oRegDstFPU          = 2'b00;
            oFPUparaMem         = 2'b00;
            oDataRegFPU         = 2'b00;
            oFPFlagWrite        = 1'b0;
            oEscreveRegCOP0     = 1'b0;
            oEretCOP0           = 1'b0;
            oExcOccurredCOP0    = wNotExcLevel;
            oBranchDelayCOP0    = 1'b0;
            oExcCodeCOP0        = EXCODEINSTR;
        end
    endcase
end
 
endmodule