#include "GeneratedTypes.h"

int LedControllerRequest_setLeds ( struct PortalInternal *p, const uint8_t v, const uint32_t duration )
{
    volatile unsigned int* temp_working_addr_start = p->item->mapchannelReq(p, CHAN_NUM_LedControllerRequest_setLeds);
    volatile unsigned int* temp_working_addr = temp_working_addr_start;
    if (p->item->busywait(p, CHAN_NUM_LedControllerRequest_setLeds, "LedControllerRequest_setLeds")) return 1;
    p->item->write(p, &temp_working_addr, v);
    p->item->write(p, &temp_working_addr, duration);
    p->item->send(p, temp_working_addr_start, (CHAN_NUM_LedControllerRequest_setLeds << 16) | 3, -1);
    return 0;
};

LedControllerRequestCb LedControllerRequestProxyReq = {
    LedControllerRequest_setLeds,
};
int LedControllerRequest_handleMessage(struct PortalInternal *p, unsigned int channel, int messageFd)
{
    static int runaway = 0;
    int tmpfd;
    unsigned int tmp;
    LedControllerRequestData tempdata;
    volatile unsigned int* temp_working_addr = p->item->mapchannelInd(p, channel);
    switch (channel) {
    case CHAN_NUM_LedControllerRequest_setLeds:
        
        p->item->recv(p, temp_working_addr, 2, &tmpfd);
        tmp = p->item->read(p, &temp_working_addr);
        tempdata.setLeds.v = (uint8_t)(((tmp)&0xfful));
        tmp = p->item->read(p, &temp_working_addr);
        tempdata.setLeds.duration = (uint32_t)(((tmp)&0xfffffffful));((LedControllerRequestCb *)p->cb)->setLeds(p, tempdata.setLeds.v, tempdata.setLeds.duration);
        break;
    default:
        PORTAL_PRINTF("LedControllerRequest_handleMessage: unknown channel 0x%x\n", channel);
        if (runaway++ > 10) {
            PORTAL_PRINTF("LedControllerRequest_handleMessage: too many bogus indications, exiting\n");
#ifndef __KERNEL__
            exit(-1);
#endif
        }
        return 0;
    }
    return 0;
}
