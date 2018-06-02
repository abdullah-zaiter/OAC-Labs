transcript on
if ![file isdirectory TopDE_iputf_libs] {
	file mkdir TopDE_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog "D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/VGA/VgaPll_sim/VgaPll.vo"      
vlog "D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo/PLL_Main_sim/PLL_Main.vo"

vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo/PLL_Main.vo}
vlib PLL_Main
vmap PLL_Main PLL_Main
vlog -sv -work PLL_Main +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo/PLL_Main.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/CPU {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/CPU/Parametros.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Memoria {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Memoria/BootBlock.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Memoria {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Memoria/SysCodeBlock.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Memoria {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Memoria/SysDataBlock.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Memoria {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Memoria/UserCodeBlock.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Memoria {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Memoria/UserDataBlock.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/VGA {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/VGA/RegDisplay.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/VGA {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/VGA/HexFont.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/VGA {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/VGA/MemoryVGA.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo/reset_delay.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo/oneshot.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo/CLOCK_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo/mono.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/stopwatch {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/stopwatch/Stopwatch_divider_clk.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador/SineTable.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador/NoteTable.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/PS2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/PS2/scan2ascii.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/PS2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/PS2/PS2_Controller.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/PS2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/PS2/mouse_hugo.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/PS2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/PS2/keyscan.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/PS2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/PS2/Altera_UP_PS2_Data_In.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/PS2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/PS2/Altera_UP_PS2_Command_Out.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/PS2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/PS2/keyboard.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/lfsr {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/lfsr/ifsr_word.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/IrDA {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/IrDA/IrDA_receiver.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/IrDA {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/IrDA/IrDA_parameters.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Display7 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Display7/Display7_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Display7 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Display7/decoder7.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/AudioCODEC {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/AudioCODEC/I2C_Controller.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/AudioCODEC {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/AudioCODEC/I2C_AV_Config.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/AudioCODEC {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/AudioCODEC/audio_converter.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/AudioCODEC {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/AudioCODEC/audio_clock.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo/breaker.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/CPU {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/CPU/Imm_Generator.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/CPU {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/CPU/Ctrl_Transf.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/CPU {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/CPU/Control.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/TopDE.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/CPU {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/CPU/Datapath_UNI.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/CPU {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/CPU/ALU.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/CPU {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/CPU/ALUControl.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/CPU {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/CPU/Registers.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Memoria {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Memoria/MemStore.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Memoria {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Memoria/MemLoad.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Memoria {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Memoria/DataMemory_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Memoria {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Memoria/CodeMemory_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/VGA {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/VGA/VgaAdapter.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/VGA {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/VGA/VGA_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo/Break_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/stopwatch {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/stopwatch/STOPWATCH_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador/Sintetizador_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/PS2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/PS2/MousePS2_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/PS2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/PS2/TecladoPS2_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/lfsr {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/lfsr/lfsr_interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/IrDA {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/IrDA/IrDA_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/IrDA {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/IrDA/IrDA_decoder.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/AudioCODEC {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/AudioCODEC/AudioCODEC_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/CPU {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/CPU/CPU.v}
vlog -sv -work PLL_Main +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo/PLL_Main {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Tempo/PLL_Main/PLL_Main_0002.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador/Sintetizador.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador/SyscallSynthControl.sv}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador/Synthesizer.sv}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador/SineCalculator.sv}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador/Oscillator.sv}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador/Note.sv}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador/Filter.sv}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador/Envelope.sv}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/Sintetizador/Channel.sv}

vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/CoreNowOrNever/TopDE_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -L PLL_Main -voptargs="+acc"  TopDE_tb

add wave *
view structure
view signals
run -all
