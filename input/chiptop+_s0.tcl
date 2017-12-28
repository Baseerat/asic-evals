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


set PERIOD  7.0
set INPUT_DELAY  1.0
set OUTPUT_DELAY  1.0
set CLOCK_LATENCY 1.5
set MIN_IO_DELAY 1.0
set MAX_TRANSITION 0.5


## CLOCK BASICS
create_clock -name "clock" -period $PERIOD [get_ports clock]
set_clock_latency $CLOCK_LATENCY [get_clocks clock]
set_clock_uncertainty 0.3 [get_clocks clock]
set_clock_transition 0.4 [get_clocks clock]


## GROUPING
group_path  -name CLOCK\
            -to clock\
            -weight 1


## IN/OUT
set INPUTPORTS [remove_from_collection [all_inputs] [get_ports clock]]
set OUTPUTPORTS [all_outputs]
  
set_input_delay -clock "clock" -max $INPUT_DELAY $INPUTPORTS 
set_output_delay -clock "clock" -max $OUTPUT_DELAY $OUTPUTPORTS
set_input_delay -clock "clock" -min $MIN_IO_DELAY $INPUTPORTS 
set_output_delay -clock "clock" -min $MIN_IO_DELAY $OUTPUTPORTS
