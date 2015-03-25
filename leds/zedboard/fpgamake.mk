

TCLDIR=/home/ubuntu/fpgamake/tcl
BUILDCACHE=/home/ubuntu/buildcache/buildcache
CACHEDIR = /home/ubuntu/Projects/leds/zedboard/Cache
FLOORPLAN=
FPGAMAKE_PARTNAME=xc7z020clg484-1
FPGAMAKE_BOARDNAME=zedboard
FPGAMAKE_TOPMODULE=mkZynqTop
FPGAMAKE_FAMILY="Virtex 7"
VERILOG_DEFINES=""
PRESERVE_CLOCK_GATES?=0
REPORT_NWORST_TIMING_PATHS?=
include $(TCLDIR)/Makefile.fpgamake.common

mkZynqTop_HEADERFILES = 
mkZynqTop_VFILES = verilog/mkZynqTop.v /home/ubuntu/connectal/verilog/CONNECTNET2.v verilog/SyncResetA.v verilog/SizedFIFO.v verilog/ResetInverter.v verilog/FIFO2.v verilog/FIFO1.v verilog/mkLedControllerRequestInputPipes.v verilog/FIFO10.v
mkZynqTop_VHDFILES = 
mkZynqTop_VHDL_LIBRARIES = 
mkZynqTop_STUBS = 
mkZynqTop_IP = 
mkZynqTop_SUBINST = 
mkZynqTop_PATH = verilog/mkZynqTop.v
mkZynqTop_USER_TCL_SCRIPT = 
mkZynqTop_XDC = /home/ubuntu/connectal/constraints/xilinx/zedboard.xdc /home/ubuntu/connectal/constraints/xilinx/zc7z020clg484.xdc

$(eval $(call SYNTH_RULE,mkZynqTop))

top_XDC = /home/ubuntu/connectal/constraints/xilinx/zedboard.xdc /home/ubuntu/connectal/constraints/xilinx/zc7z020clg484.xdc
top_OOCXDC = 
top_NETLISTS = 
top_BITFILE = hw/mkTop.bit

$(eval $(call IMPL_RULE,top,mkZynqTop))

TopDown_XDC = /home/ubuntu/connectal/constraints/xilinx/zedboard.xdc /home/ubuntu/connectal/constraints/xilinx/zc7z020clg484.xdc
TopDown_NETLISTS = 
TopDown_SUBINST = 

$(eval $(call TOP_RULE,top,mkZynqTop,hw/mkTop.bit,hw/mkTop))

everything: $(SYNTH_NETLISTS) hw/mkTop.bit

