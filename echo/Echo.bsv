// Copyright (c) 2013 Nokia, Inc.
// Copyright (c) 2013 Quanta Research Cambridge, Inc.

// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use, copy,
// modify, merge, publish, distribute, sublicense, and/or sell copies
// of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
// BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
import FIFO::*;
import Vector::*;

interface EchoIndication;
    method Action heard(Bit#(32) v);
    method Action heard2(Bit#(16) a, Bit#(16) b);
    method Action heard3(Bit#(16) a, Bit#(16) b, Bit#(16) c);
endinterface

interface EchoRequest;
   method Action say(Bit#(32) v);
   method Action say2(Bit#(16) a, Bit#(16) b);
   method Action say3(Bit#(16) a, Bit#(16) b, Bit#(16) c);
   method Action setLeds(Bit#(8) v);
endinterface

interface Echo;
   interface EchoRequest request;
endinterface

typedef struct {
	Bit#(16) a;
	Bit#(16) b;
} EchoPair deriving (Bits);

typedef struct{
        Bit#(16) a;
        Bit#(16) b;
        Bit#(16) c;
}EchoTriple deriving(Bits);

module mkEcho#(EchoIndication indication)(Echo);
    FIFO#(Bit#(32)) delay <- mkSizedFIFO(8);
    FIFO#(EchoPair) delay2 <- mkSizedFIFO(8);
    FIFO#(EchoTriple) delay3 <-mkSizedFIFO(8);
    rule heard;
        delay.deq;
        indication.heard(delay.first);
	$display("mkEcho::heard");
    endrule

    rule heard2;
        delay2.deq;
        indication.heard2(delay2.first.b, delay2.first.a);
	$display("mkEcho::heard2 ");
    endrule
   
   rule heard3;
       delay3.deq;
       indication.heard3(delay3.first.a,delay3.first.b,delay3.first.c);
       $display("mkEcho::heard3" );
   endrule 
   interface EchoRequest request;
      method Action say(Bit#(32) v);
	 delay.enq(v);
      endmethod
      
      method Action say2(Bit#(16) a, Bit#(16) b);
	 delay2.enq(EchoPair { a: a, b: b});
      endmethod
      
      method Action say3(Bit#(16) a,Bit#(16) b,Bit#(16) c);
         delay3.enq(EchoTriple { a:a, b:b,c:c});
      endmethod
      
      method Action setLeds(Bit#(8) v);
      endmethod
   endinterface
endmodule
