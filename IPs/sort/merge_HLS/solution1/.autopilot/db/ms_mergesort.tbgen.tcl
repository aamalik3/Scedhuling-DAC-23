set moduleName ms_mergesort
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {ms_mergesort}
set C_modelType { void 0 }
set C_modelArgList {
	{ a int 32 regular {axi_slave 2}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "a", "interface" : "axi_slave", "bundle":"BUS_A","type":"ap_memory","bitwidth" : 32, "direction" : "READWRITE", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "a","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}], "offset" : {"in":8192, "out":8192}, "offset_end" : {"in":16383, "out":16383}} ]}
# RTL Port declarations: 
set portNum 20
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ s_axi_BUS_A_AWVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_BUS_A_AWREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_BUS_A_AWADDR sc_in sc_lv 14 signal -1 } 
	{ s_axi_BUS_A_WVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_BUS_A_WREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_BUS_A_WDATA sc_in sc_lv 32 signal -1 } 
	{ s_axi_BUS_A_WSTRB sc_in sc_lv 4 signal -1 } 
	{ s_axi_BUS_A_ARVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_BUS_A_ARREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_BUS_A_ARADDR sc_in sc_lv 14 signal -1 } 
	{ s_axi_BUS_A_RVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_BUS_A_RREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_BUS_A_RDATA sc_out sc_lv 32 signal -1 } 
	{ s_axi_BUS_A_RRESP sc_out sc_lv 2 signal -1 } 
	{ s_axi_BUS_A_BVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_BUS_A_BREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_BUS_A_BRESP sc_out sc_lv 2 signal -1 } 
	{ interrupt sc_out sc_logic 1 signal -1 } 
}
set NewPortList {[ 
	{ "name": "s_axi_BUS_A_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":14, "type": "signal", "bundle":{"name": "BUS_A", "role": "AWADDR" },"address":[{"name":"ms_mergesort","role":"start","value":"0","valid_bit":"0"},{"name":"ms_mergesort","role":"continue","value":"0","valid_bit":"4"},{"name":"ms_mergesort","role":"auto_start","value":"0","valid_bit":"7"},{"name":"a","role":"data","value":"8192"}] },
	{ "name": "s_axi_BUS_A_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "BUS_A", "role": "AWVALID" } },
	{ "name": "s_axi_BUS_A_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "BUS_A", "role": "AWREADY" } },
	{ "name": "s_axi_BUS_A_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "BUS_A", "role": "WVALID" } },
	{ "name": "s_axi_BUS_A_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "BUS_A", "role": "WREADY" } },
	{ "name": "s_axi_BUS_A_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "BUS_A", "role": "WDATA" } },
	{ "name": "s_axi_BUS_A_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "BUS_A", "role": "WSTRB" } },
	{ "name": "s_axi_BUS_A_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":14, "type": "signal", "bundle":{"name": "BUS_A", "role": "ARADDR" },"address":[{"name":"ms_mergesort","role":"start","value":"0","valid_bit":"0"},{"name":"ms_mergesort","role":"done","value":"0","valid_bit":"1"},{"name":"ms_mergesort","role":"idle","value":"0","valid_bit":"2"},{"name":"ms_mergesort","role":"ready","value":"0","valid_bit":"3"},{"name":"ms_mergesort","role":"auto_start","value":"0","valid_bit":"7"},{"name":"a","role":"data","value":"8192"}] },
	{ "name": "s_axi_BUS_A_ARVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "BUS_A", "role": "ARVALID" } },
	{ "name": "s_axi_BUS_A_ARREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "BUS_A", "role": "ARREADY" } },
	{ "name": "s_axi_BUS_A_RVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "BUS_A", "role": "RVALID" } },
	{ "name": "s_axi_BUS_A_RREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "BUS_A", "role": "RREADY" } },
	{ "name": "s_axi_BUS_A_RDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "BUS_A", "role": "RDATA" } },
	{ "name": "s_axi_BUS_A_RRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "BUS_A", "role": "RRESP" } },
	{ "name": "s_axi_BUS_A_BVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "BUS_A", "role": "BVALID" } },
	{ "name": "s_axi_BUS_A_BREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "BUS_A", "role": "BREADY" } },
	{ "name": "s_axi_BUS_A_BRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "BUS_A", "role": "BRESP" } },
	{ "name": "interrupt", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "BUS_A", "role": "interrupt" } }, 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2"],
		"CDFG" : "ms_mergesort",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "a", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "grp_merge_1_fu_78", "Port" : "a"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.BUS_A_s_axi_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_merge_1_fu_78", "Parent" : "0", "Child" : ["3"],
		"CDFG" : "merge_1",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "a", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "start_r", "Type" : "None", "Direction" : "I"},
			{"Name" : "m", "Type" : "None", "Direction" : "I"},
			{"Name" : "stop", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "3", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_merge_1_fu_78.temp_U", "Parent" : "2"}]}


set ArgLastReadFirstWriteLatency {
	ms_mergesort {
		a {Type IO LastRead 3 FirstWrite 6}}
	merge_1 {
		a {Type IO LastRead 3 FirstWrite 6}
		start_r {Type I LastRead 0 FirstWrite -1}
		m {Type I LastRead 0 FirstWrite -1}
		stop {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "-1", "Max" : "-1"}
	, {"Name" : "Interval", "Min" : "0", "Max" : "0"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
}

set busDeadlockParameterList { 
}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
