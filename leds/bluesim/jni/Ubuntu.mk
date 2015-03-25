
CONNECTALDIR?=/home/ubuntu/connectal
DTOP?=/home/ubuntu/Projects/leds/bluesim
export V=0
ifeq ($(V),0)
Q=@
else
Q=
endif

CFLAGS_COMMON = -O -g -I$(DTOP)/jni -I$(CONNECTALDIR) -I$(CONNECTALDIR)/cpp -I$(CONNECTALDIR)/lib/cpp -I/home/ubuntu/Projects/leds  -DNumberOfMasters=0 -DPinType=LEDS -DMainClockPeriod=10 -DDerivedClockPeriod=5 -DNumberOfTiles=1 -DSlaveDataBusWidth=32 -DBurstLenSize=8 -Dproject_dir=$(DTOP) -DBsimHostTypeIF -DPhysAddrWidth=40 -DBOARD_bluesim
CFLAGS = $(CFLAGS_COMMON)
CFLAGS2 = 

PORTAL_CPP_FILES = $(addprefix $(CONNECTALDIR)/cpp/, portal.c portalPrintf.c portalSocket.c portalJson.c poller.cpp sock_utils.c timer.c)
include $(DTOP)/jni/Makefile.generated_files
include $(DTOP)/Makefile.autotop
SOURCES = $(addprefix $(DTOP)/jni/,  $(GENERATED_CPP)) /home/ubuntu/Projects/leds/testleds.cpp $(PORTAL_CPP_FILES)
SOURCES2 = $(addprefix $(DTOP)/jni/,  $(GENERATED_CPP))  $(PORTAL_CPP_FILES)
LDLIBS :=    -pthread 

BSIM_EXE_CXX_FILES = TlpReplay.cxx
BSIM_EXE_CXX = $(addprefix $(CONNECTALDIR)/cpp/, $(BSIM_EXE_CXX_FILES))

ubuntu.exe: $(SOURCES)
	$(Q)g++ $(CFLAGS) -o ubuntu.exe $(SOURCES) $(LDLIBS)
	$(Q)[ ! -f ../bin/mkTop.bin.gz ] || objcopy --add-section fpgadata=../bin/mkTop.bin.gz ubuntu.exe

connectal.so: $(SOURCES)
	$(Q)g++ -shared -fpic $(CFLAGS) -o connectal.so -DBSIM $(BSIM_EXE_CXX) $(SOURCES) $(LDLIBS)

ubuntu.exe2: $(SOURCES2)
	$(Q)g++ $(CFLAGS) $(CFLAGS2) -o ubuntu.exe2 $(SOURCES2) $(LDLIBS)

bsim_exe: $(SOURCES)
	$(Q)g++ $(CFLAGS_COMMON) -o bsim_exe -DBSIM $(SOURCES) $(BSIM_EXE_CXX) $(LDLIBS)

bsim_exe2: $(SOURCES2)
	$(Q)g++ $(CFLAGS_COMMON) $(CFLAGS2) -o bsim_exe2 -DBSIM $(SOURCES2) $(BSIM_EXE_CXX) $(LDLIBS)
