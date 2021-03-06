/* Copyright (c) 2014 Quanta Research Cambridge, Inc
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

#include <stdio.h>
#include "EchoIndication.h"
#include "EchoRequest.h"
#include "GeneratedTypes.h"

static sem_t sem;

class EchoIndication : public EchoIndicationWrapper
{
public:
    virtual void heard(uint32_t v) {
        printf("heard an echo: %d\n", v);
        sem_post(&sem);
    }
    virtual void heard2(uint16_t a, uint16_t b) {
        printf("heard an echo2: %d %d\n", a, b);
        sem_post(&sem);
    }
    virtual void heard3(uint16_t a, uint16_t b, uint16_t c){
        printf("heard an echo3: %d %d %d\n",a,b,c);
        sem_post(&sem);
	}
    EchoIndication(unsigned int id) : EchoIndicationWrapper(id) {}
};

int main(int argc, const char **argv)
{
    EchoIndication *echoIndication = new EchoIndication(IfcNames_EchoIndicationH2S);
    EchoRequestProxy *echoRequestProxy = new EchoRequestProxy(IfcNames_EchoRequestS2H);
//    SwallowProxy *swallowProxy = new SwallowProxy(IfcNames_Swallow);

    portalExec_start(); // start the "indication" thread

    int v = 42;
    echoRequestProxy->say(v);
    sem_wait(&sem);
    echoRequestProxy->say2(v, v);
    sem_wait(&sem);
    echoRequestProxy->say3(v,v,v);
    sem_wait(&sem);
    echoRequestProxy->setLeds(9);
    return 0;
}
