

##    run: run the program
##         pass parameters to software via 'make RUN_ARGS= run'
#RUN_ARGS=

export DTOP=/home/ubuntu/Projects/leds/zedboard
CONNECTALDIR=/home/ubuntu/connectal
BSVPATH = /home/ubuntu/connectal/lib/bsv:/home/ubuntu/Projects/leds:/home/ubuntu/connectal/generated/xilinx:/home/ubuntu/connectal/generated/altera:/home/ubuntu/Projects/leds/zedboard/generatedbsv:/home/ubuntu/connectal/bsv

BOARD=zedboard
MKTOP=mkZynqTop
OS=android
DUT=mkzynqtop

export INTERFACES = LedControllerRequest
BSVFILES = /home/ubuntu/Projects/leds/LedController.bsv /home/ubuntu/Projects/leds/zedboard/generatedbsv/Top.bsv /home/ubuntu/connectal/bsv/DisplayInd.bsv

BSCFLAGS_PROJECT = 
BSIM_CXX_PROJECT = 
XELABFLAGS = 
XSIMFLAGS  = -R
TOPBSVFILE = /home/ubuntu/connectal/bsv/ZynqTop.bsv
BSVDEFINES =  -D NumberOfMasters=0 -D PinType=LEDS -D MainClockPeriod=10 -D DerivedClockPeriod=5 -D NumberOfTiles=1 -D SlaveDataBusWidth=32 -D BurstLenSize=8 -D project_dir=$(DTOP) -D XILINX=1 -D ZYNQ -D ZynqHostTypeIF -D PhysAddrWidth=32 -D CFGBVS=VCCO -D CONFIG_VOLTAGE=3.3 -D BOARD_zedboard
QTUSED = 
export BSVDEFINES_LIST = NumberOfMasters=0 PinType=LEDS MainClockPeriod=10 DerivedClockPeriod=5 NumberOfTiles=1 SlaveDataBusWidth=32 BurstLenSize=8 project_dir=$(DTOP) XILINX=1 ZYNQ ZynqHostTypeIF PhysAddrWidth=32 CFGBVS=VCCO CONFIG_VOLTAGE=3.3 BOARD_zedboard
export DUT_NAME = mkZynqTop




NumberOfMasters="0"
PinType="LEDS"
MainClockPeriod="10"
DerivedClockPeriod="5"
NumberOfTiles="1"
SlaveDataBusWidth="32"
BurstLenSize="8"
project_dir="$(DTOP)"
XILINX="1"
ZYNQ=""
ZynqHostTypeIF=""
PhysAddrWidth="32"
CFGBVS="VCCO"
CONFIG_VOLTAGE="3.3"
BOARD_zedboard=""


include $(CONNECTALDIR)/scripts/Makefile.connectal.build


FPGAMAKE=$(CONNECTALDIR)/../fpgamake/fpgamake
fpgamake.mk: $(VFILE) Makefile prepare_bin_target
	$(Q)mkdir -p hw
	$(Q)$(FPGAMAKE) $(FPGAMAKE_VERBOSE) -o fpgamake.mk --board=zedboard --part=xc7z020clg484-1  --floorplan= --constraint=/home/ubuntu/connectal/constraints/xilinx/zedboard.xdc --constraint=/home/ubuntu/connectal/constraints/xilinx/zc7z020clg484.xdc     -t $(MKTOP)  -b hw/mkTop.bit verilog $(CONNECTALDIR)/verilog /home/ubuntu/connectal/verilog

hw/mkTop.bit: fpgamake.mk prepare_bin_target
	$(Q)make -f fpgamake.mk
ifneq ($(XILINX),)
	$(Q)cp -f Impl/*/*.rpt bin
else ifneq ($(ALTERA),)
	$(Q)cp -f $(MKTOP).sof bin
endif

