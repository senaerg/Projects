package LedControllerRequest;

import FIFO::*;
import FIFOF::*;
import GetPut::*;
import Connectable::*;
import Clocks::*;
import FloatingPoint::*;
import Adapter::*;
import Leds::*;
import Vector::*;
import SpecialFIFOs::*;
import ConnectalMemory::*;
import Portal::*;
import MemPortal::*;
import MemTypes::*;
import Pipe::*;
import LedController::*;
import FIFO::*;
import GetPut::*;
import Leds::*;
import Vector::*;
import Portal::*;
import CtrlMux::*;
import HostInterface::*;
import MemPortal::*;
import Connectable::*;
import MemreadEngine::*;
import MemwriteEngine::*;
import MemTypes::*;
import LedController::*;




typedef struct {
    Bit#(8) v;
    Bit#(32) duration;
} SetLeds_Message deriving (Bits);

// exposed wrapper portal interface
interface LedControllerRequestInputPipes;
    interface PipePortal#(1, 0, 32) portalIfc;
    interface PipeOut#(SetLeds_Message) setLeds_PipeOut;

endinterface
interface LedControllerRequestWrapperPortal;
    interface PipePortal#(1, 0, 32) portalIfc;
endinterface
// exposed wrapper MemPortal interface
interface LedControllerRequestWrapper;
    interface StdPortal portalIfc;
endinterface

instance Connectable#(LedControllerRequestInputPipes,LedControllerRequest);
   module mkConnection#(LedControllerRequestInputPipes pipes, LedControllerRequest ifc)(Empty);

    rule handle_setLeds_request;
        let request <- toGet(pipes.setLeds_PipeOut).get();
        ifc.setLeds(request.v, request.duration);
    endrule

   endmodule
endinstance

// exposed wrapper Portal implementation
(* synthesize *)
module mkLedControllerRequestInputPipes(LedControllerRequestInputPipes);
    Vector#(1, PipeIn#(Bit#(32))) requestPipeIn = newVector();

    AdapterFromBus#(32,SetLeds_Message) setLeds_requestFifo <- mkAdapterFromBus();
    requestPipeIn[0] = setLeds_requestFifo.in;

    interface PipePortal portalIfc;
        method Bit#(16) messageSize(Bit#(16) methodNumber);
            case (methodNumber)
            0: return fromInteger(valueOf(SizeOf#(SetLeds_Message)));
            endcase
        endmethod
        interface Vector requests = requestPipeIn;
        interface Vector indications = nil;
        interface PortalInterrupt intr;
           method Bool status();
              return False;
           endmethod
           method Bit#(dataWidth) channel();
              return -1;
           endmethod
        endinterface
    endinterface
    interface setLeds_PipeOut = setLeds_requestFifo.out;
endmodule

module mkLedControllerRequestWrapperPortal#(LedControllerRequest ifc)(LedControllerRequestWrapperPortal);
    let pipes <- mkLedControllerRequestInputPipes;
    mkConnection(pipes, ifc);
    interface PipePortal portalIfc = pipes.portalIfc;
endmodule

interface LedControllerRequestWrapperMemPortalPipes;
    interface LedControllerRequestInputPipes pipes;
    interface StdPortal portalIfc;
endinterface

(* synthesize *)
module mkLedControllerRequestWrapperMemPortalPipes#(Bit#(32) id)(LedControllerRequestWrapperMemPortalPipes);

  let p <- mkLedControllerRequestInputPipes;
  let memPortal <- mkMemPortalIn(id, p.portalIfc.requests);
  interface LedControllerRequestInputPipes pipes = p;
  interface MemPortal portalIfc = memPortal;
endmodule

// exposed wrapper MemPortal implementation
module mkLedControllerRequestWrapper#(idType id, LedControllerRequest ifc)(LedControllerRequestWrapper)
   provisos (Bits#(idType, a__),
	     Add#(b__, a__, 32));
  let dut <- mkLedControllerRequestWrapperMemPortalPipes(zeroExtend(pack(id)));
  mkConnection(dut.pipes, ifc);
  interface MemPortal portalIfc = dut.portalIfc;
endmodule

// exposed proxy interface
interface LedControllerRequestOutputPipes;
    interface PipePortal#(0, 1, 32) portalIfc;
    interface LedController::LedControllerRequest ifc;
endinterface
interface LedControllerRequestProxy;
    interface StdPortal portalIfc;
    interface LedController::LedControllerRequest ifc;
endinterface

(* synthesize *)
module  mkLedControllerRequestOutputPipes(LedControllerRequestOutputPipes);
    Vector#(1, PipeOut#(Bit#(32))) indicationPipes = newVector();

    AdapterToBus#(32,SetLeds_Message) setLeds_responseFifo <- mkAdapterToBus();
    indicationPipes[0] = setLeds_responseFifo.out;

    PortalInterrupt#(32) intrInst <- mkPortalInterrupt(indicationPipes);
    interface LedController::LedControllerRequest ifc;

    method Action setLeds(Bit#(8) v, Bit#(32) duration);
        setLeds_responseFifo.in.enq(SetLeds_Message {v: v, duration: duration});
        //$display("indicationMethod 'setLeds' invoked");
    endmethod
    endinterface
    interface PipePortal portalIfc;
        method Bit#(16) messageSize(Bit#(16) methodNumber);
            case (methodNumber)
            0: return fromInteger(valueOf(SizeOf#(SetLeds_Message)));
            endcase
        endmethod
        interface Vector requests = nil;
        interface Vector indications = indicationPipes;
        interface PortalInterrupt intr = intrInst;
    endinterface
endmodule

// synthesizeable proxy MemPortal
(* synthesize *)
module mkLedControllerRequestProxySynth#(Bit#(32) id)(LedControllerRequestProxy);
  let dut <- mkLedControllerRequestOutputPipes();
  let memPortal <- mkMemPortalOut(id, dut.portalIfc.indications, dut.portalIfc.intr);
  interface MemPortal portalIfc = memPortal;
  interface LedController::LedControllerRequest ifc = dut.ifc;
endmodule

// exposed proxy MemPortal
module mkLedControllerRequestProxy#(idType id)(LedControllerRequestProxy)
   provisos (Bits#(idType, a__),
	     Add#(b__, a__, 32));
   let rv <- mkLedControllerRequestProxySynth(extend(pack(id)));
   return rv;
endmodule
endpackage: LedControllerRequest
