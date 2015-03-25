
import Vector::*;
import Portal::*;
import CtrlMux::*;
import HostInterface::*;
import MemPortal::*;
import Connectable::*;
import MemreadEngine::*;
import MemwriteEngine::*;
import MemTypes::*;
import Leds::*;
import LedController::*;
import LedControllerRequest::*;

`ifndef PinType
`define PinType Empty
`endif
typedef `PinType PinType;

typedef enum {LedControllerRequestS2H} IfcNames deriving (Eq,Bits);

module mkConnectalTop
`ifdef IMPORT_HOSTIF
       #(HostType host)
`endif
       (ConnectalTop#(PhysAddrWidth,DataBusWidth,`PinType,`NumberOfMasters));
   Clock defaultClock <- exposeCurrentClock();
   Reset defaultReset <- exposeCurrentReset();
   LedControllerRequestInputPipes lLedControllerRequestInputPipes <- mkLedControllerRequestInputPipes;

   LedController lLedController <- mkLedController();

   mkConnection(lLedControllerRequestInputPipes, lLedController.request);

   Vector#(1,StdPortal) portals;
   let portalEnt_0 <- mkMemPortalIn(extend(pack(LedControllerRequestS2H)), lLedControllerRequestInputPipes.portalIfc.requests);
   portals[0] = portalEnt_0;
   let ctrl_mux <- mkSlaveMux(portals);
   interface interrupt = getInterruptVector(portals);
   interface slave = ctrl_mux;
   interface masters = nil;
   interface pins = lLedController.leds;
endmodule : mkConnectalTop
export mkConnectalTop;
export Leds::*;
