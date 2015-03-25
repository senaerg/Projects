
include $(CLEAR_VARS)
DTOP?=/home/ubuntu/Projects/leds/zedboard
CONNECTALDIR?=/home/ubuntu/connectal
LOCAL_ARM_MODE := arm
include $(DTOP)/jni/Makefile.generated_files
APP_SRC_FILES := $(addprefix $(DTOP)/jni/,  $(GENERATED_CPP)) /home/ubuntu/Projects/leds/testleds.cpp
PORTAL_SRC_FILES := $(addprefix $(CONNECTALDIR)/cpp/, portal.c portalSocket.c portalJson.c portalPrintf.c poller.cpp sock_utils.c timer.c)
LOCAL_SRC_FILES := $(APP_SRC_FILES) $(PORTAL_SRC_FILES)

LOCAL_PATH :=
LOCAL_MODULE := android.exe
LOCAL_MODULE_TAGS := optional
LOCAL_LDLIBS := -llog   
LOCAL_CPPFLAGS := "-march=armv7-a"
LOCAL_CFLAGS := -DZYNQ -I$(DTOP)/jni -I$(CONNECTALDIR) -I$(CONNECTALDIR)/cpp -I$(CONNECTALDIR)/lib/cpp -I/home/ubuntu/Projects/leds  -DNumberOfMasters=0 -DPinType=LEDS -DMainClockPeriod=10 -DDerivedClockPeriod=5 -DNumberOfTiles=1 -DSlaveDataBusWidth=32 -DBurstLenSize=8 -Dproject_dir=$(DTOP) -DXILINX=1 -DZYNQ -DZynqHostTypeIF -DPhysAddrWidth=32 -DCFGBVS=VCCO -DCONFIG_VOLTAGE=3.3 -DBOARD_zedboard
LOCAL_CXXFLAGS := -DZYNQ -I$(DTOP)/jni -I$(CONNECTALDIR) -I$(CONNECTALDIR)/cpp -I$(CONNECTALDIR)/lib/cpp -I/home/ubuntu/Projects/leds  -DNumberOfMasters=0 -DPinType=LEDS -DMainClockPeriod=10 -DDerivedClockPeriod=5 -DNumberOfTiles=1 -DSlaveDataBusWidth=32 -DBurstLenSize=8 -Dproject_dir=$(DTOP) -DXILINX=1 -DZYNQ -DZynqHostTypeIF -DPhysAddrWidth=32 -DCFGBVS=VCCO -DCONFIG_VOLTAGE=3.3 -DBOARD_zedboard
LOCAL_CFLAGS2 := $(cdefines2)s

include $(BUILD_EXECUTABLE)
