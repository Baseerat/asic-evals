#######################################################################
####                                                               ####
####  The data contained in the file is created for educational    ####
####  and training purposes only and is  not recommended           ####
####  for fabrication                                              ####
####                                                               ####
#######################################################################
####                                                               ####
####  Copyright (C) 2013 Synopsys, Inc.                            ####
####                                                               ####
#######################################################################
####                                                               ####
####  The 32/28nm Generic Library ("Library") is unsupported       ####
####  Confidential Information of Synopsys, Inc. ("Synopsys")      ####
####  provided to you as Documentation under the terms of the      ####
####  End User Software License Agreement between you or your      ####
####  employer and Synopsys ("License Agreement") and you agree    ####
####  not to distribute or disclose the Library without the        ####
####  prior written consent of Synopsys. The Library IS NOT an     ####
####  item of Licensed Software or Licensed Product under the      ####
####  License Agreement.  Synopsys and/or its licensors own        ####
####  and shall retain all right, title and interest in and        ####
####  to the Library and all modifications thereto, including      ####
####  all intellectual property rights embodied therein. All       ####
####  rights in and to any Library modifications you make are      ####
####  hereby assigned to Synopsys. If you do not agree with        ####
####  this notice, including the disclaimer below, then you        ####
####  are not authorized to use the Library.                       ####
####                                                               ####
####                                                               ####
####  THIS LIBRARY IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN   ####
####  "AS IS" BASIS, WITH NO INTELLECUTAL PROPERTY                 ####
####  INDEMNIFICATION AND NO SUPPORT. ANY EXPRESS OR IMPLIED       ####
####  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED       ####
####  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR   ####
####  PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS    ####
####  BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,     ####
####  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT      ####
####  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;     ####
####  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)     ####
####  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN    ####
####  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE    ####
####  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS      ####
####  DOCUMENTATION, EVEN IF ADVISED OF THE POSSIBILITY OF         ####
####  SUCH DAMAGE.                                                 ####
####                                                               ####
#######################################################################

set link_library {* ../models/saed32rvt_tt1p05v25c.db   ../models/saed32rvt_ss0p95v125c.db  ../models/saed32rvt_ff1p16vn40c.db   ../models/SRAM32x256_1rw_typ.db}
set target_library { ../models/saed32rvt_tt1p05v25c.db   ../models/saed32rvt_ss0p95v125c.db  ../models/saed32rvt_ff1p16vn40c.db   ../models/SRAM32x256_1rw_typ.db  }

analyze -library WORK -format verilog {../rtl/baseerat_mux.v}
read_file -format verilog {../rtl/baseerat_mux.v}

source -echo ../input/chiptop+_s0.sdc

set_clock_gating_registers -include_instances [all_registers -clock clock]
#set_clock_gating_registers -include_instances [remove_from_collection  [all_registers -clock clock] [get_cells "MemYHier/MemXb MemYHier/MemXa MemXHier/MemXb MemXHier/MemXa"]]

set_operating_conditions -min ff1p16vn40c -max ss0p95v125c

link
set_fix_multiple_port_nets -all -buffer_constants [get_designs baseerat_mux]


compile	-exact_map -gate_clock

change_names -rules verilog -verbose -hier
report_clock_gating


set_fix_hold [all_clocks]
report_constraints  -min_delay
compile -incremental -only_design



write -f verilog -h -out   ../output/Chip_Top_cgl.v
write -f ddc -h -out       ../output/ChipTop.ddc
