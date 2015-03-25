#ifndef __GENERATED_TYPES__
#define __GENERATED_TYPES__
#include "portal.h"
#ifdef __cplusplus
extern "C" {
#endif
typedef struct LedControllerCmd {
    uint8_t leds : 8;
    uint32_t duration : 32;
} LedControllerCmd;
typedef enum IfcNames { IfcNames_LedControllerRequestS2H } IfcNames;


int LedControllerRequest_setLeds ( struct PortalInternal *p, const uint8_t v, const uint32_t duration );
enum { CHAN_NUM_LedControllerRequest_setLeds};
#define LedControllerRequest_reqinfo 0x1000c

typedef struct {
    uint8_t v;
    uint32_t duration;
} LedControllerRequest_setLedsData;
typedef union {
    LedControllerRequest_setLedsData setLeds;
} LedControllerRequestData;
int LedControllerRequest_handleMessage(struct PortalInternal *p, unsigned int channel, int messageFd);
typedef struct {
    int (*setLeds) (  struct PortalInternal *p, const uint8_t v, const uint32_t duration );
} LedControllerRequestCb;
extern LedControllerRequestCb LedControllerRequestProxyReq;

int LedControllerRequestJson_setLeds ( struct PortalInternal *p, const uint8_t v, const uint32_t duration );
int LedControllerRequestJson_handleMessage(struct PortalInternal *p, unsigned int channel, int messageFd);
extern LedControllerRequestCb LedControllerRequestJsonProxyReq;
#ifdef __cplusplus
}
#endif
#endif //__GENERATED_TYPES__
