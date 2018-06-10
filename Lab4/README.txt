Para rodar as simulações no waveform:

	- Abra o Quartus
	- Project -> Restore Archived project
	- Escolher o arquivo Core.qar
	- Apagar _restored da pasta
	- Descomentar no TOPDE.v SIMULATION
	- Compilar Analysis
	- No arquivo Waveform
		- Waveform Settings, muda os 3 diretórios
	- Gerar TestBench files
	- Criar uma pasta qsim no diretório simulation/
	- Copiar os arquivos de /simulation/modelsim para /simulation/qsim
	- Rodar Simulação funcional