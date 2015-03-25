#include "GeneratedTypes.h"

static ConnectalMethodJsonInfo LedControllerRequestInfo[] = {
    {"setLeds", ((ConnectalParamJsonInfo[]){
        {"v", Connectaloffsetof(LedControllerRequest_setLedsData,v), ITYPE_other},
        {"duration", Connectaloffsetof(LedControllerRequest_setLedsData,duration), ITYPE_uint32_t},
        {NULL, CHAN_NUM_LedControllerRequest_setLeds}}) },{}};

int LedControllerRequestJson_setLeds ( struct PortalInternal *p, const uint8_t v, const uint32_t duration )
{
    LedControllerRequest_setLedsData tempdata;
    memcpy(&tempdata.v, &v, sizeof(tempdata.v));
    tempdata.duration = duration;
    connectalJsonEncode(p, &tempdata, &LedControllerRequestInfo[CHAN_NUM_LedControllerRequest_setLeds]);
    return 0;
};

LedControllerRequestCb LedControllerRequestJsonProxyReq = {
    LedControllerRequestJson_setLeds,
};
int LedControllerRequestJson_handleMessage(struct PortalInternal *p, unsigned int channel, int messageFd)
{
    static int runaway = 0;
    int tmpfd;
    unsigned int tmp;
    LedControllerRequestData tempdata;
    channel = connnectalJsonDecode(p, channel, &tempdata, LedControllerRequestInfo);
    switch (channel) {
    case CHAN_NUM_LedControllerRequest_setLeds:
        ((LedControllerRequestCb *)p->cb)->setLeds(p, tempdata.setLeds.v, tempdata.setLeds.duration);
        break;
    default:
        PORTAL_PRINTF("LedControllerRequestJson_handleMessage: unknown channel 0x%x\n", channel);
        if (runaway++ > 10) {
            PORTAL_PRINTF("LedControllerRequestJson_handleMessage: too many bogus indications, exiting\n");
#ifndef __KERNEL__
            exit(-1);
#endif
        }
        return 0;
    }
    return 0;
}
