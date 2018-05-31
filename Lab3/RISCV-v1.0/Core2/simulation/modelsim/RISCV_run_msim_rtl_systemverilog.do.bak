transcript on
if ![file isdirectory RISCV_iputf_libs] {
	file mkdir RISCV_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog "D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo/PLL_Main_sim/PLL_Main.vo"

vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo/PLL_Main.vo}
vlib PLL_Main
vmap PLL_Main PLL_Main
vlog -sv -work PLL_Main +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo/PLL_Main.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/VGA {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/VGA/RegDisplay.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/VGA {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/VGA/MemoryVGA.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/VGA {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/VGA/HexFont.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo/reset_delay.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo/oneshot.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo/mono.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo/CLOCK_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo/break.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/stopwatch {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/stopwatch/Stopwatch_divider_clk.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador/SineTable.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador/NoteTable.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/PS2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/PS2/scan2ascii.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/PS2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/PS2/PS2_Controller.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/PS2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/PS2/mouse_hugo.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/PS2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/PS2/keyscan.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/PS2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/PS2/keyboard.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/PS2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/PS2/Altera_UP_PS2_Data_In.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/PS2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/PS2/Altera_UP_PS2_Command_Out.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Memoria {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Memoria/UserDataBlock.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Memoria {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Memoria/UserCodeBlock.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Memoria {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Memoria/SysDataBlock.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Memoria {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Memoria/SysCodeBlock.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Memoria {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Memoria/BootBlock.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/lfsr {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/lfsr/ifsr_word.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/IrDA {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/IrDA/IrDA_receiver.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/IrDA {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/IrDA/IrDA_parameters.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Display7 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Display7/Display7_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Display7 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Display7/decoder7.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/AudioCODEC {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/AudioCODEC/I2C_Controller.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/AudioCODEC {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/AudioCODEC/I2C_AV_Config.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/AudioCODEC {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/AudioCODEC/audio_converter.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/AudioCODEC {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/AudioCODEC/audio_clock.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/CPU {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/CPU/Parametros.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/CPU {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/CPU/CPU.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/VGA {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/VGA/VgaAdapter.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/VGA {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/VGA/VGA_Interface.v}
vlog -sv -work PLL_Main +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo/PLL_Main {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo/PLL_Main/PLL_Main_0002.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Tempo/Break_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/stopwatch {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/stopwatch/STOPWATCH_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador/Sintetizador_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/PS2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/PS2/TecladoPS2_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/PS2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/PS2/MousePS2_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Memoria {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Memoria/DataMemory_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Memoria {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Memoria/CodeMemory_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/lfsr {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/lfsr/lfsr_interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/IrDA {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/IrDA/IrDA_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/IrDA {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/IrDA/IrDA_decoder.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/AudioCODEC {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/AudioCODEC/AudioCODEC_Interface.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2 {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/TopDE.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador/Sintetizador.v}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador/SyscallSynthControl.sv}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador/Synthesizer.sv}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador/SineCalculator.sv}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador/Oscillator.sv}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador/Note.sv}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador/Filter.sv}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador/Envelope.sv}
vlog -sv -work work +incdir+D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador {D:/Documents/OAC-Labs/Lab3/RISCV-v1.0/Core2/Sintetizador/Channel.sv}

