#include "GeneratedTypes.h"
#ifndef _LEDCONTROLLERREQUEST_H_
#define _LEDCONTROLLERREQUEST_H_
#include "portal.h"

class LedControllerRequestProxy : public Portal {
    LedControllerRequestCb *cb;
public:
    LedControllerRequestProxy(int id, int tile = 0, LedControllerRequestCb *cbarg = &LedControllerRequestProxyReq, int bufsize = LedControllerRequest_reqinfo, PortalPoller *poller = 0) :
        Portal(id, tile, bufsize, NULL, NULL, poller), cb(cbarg) {};
    LedControllerRequestProxy(int id, PortalItemFunctions *item, void *param, LedControllerRequestCb *cbarg = &LedControllerRequestProxyReq, int bufsize = LedControllerRequest_reqinfo, PortalPoller *poller = 0) :
        Portal(id, 0, bufsize, NULL, NULL, item, param, poller), cb(cbarg) {};
    int setLeds ( const uint8_t v, const uint32_t duration ) { return cb->setLeds (&pint, v, duration); };
};

extern LedControllerRequestCb LedControllerRequest_cbTable;
class LedControllerRequestWrapper : public Portal {
public:
    LedControllerRequestWrapper(int id, int tile = 0, PORTAL_INDFUNC cba = LedControllerRequest_handleMessage, int bufsize = LedControllerRequest_reqinfo, PortalPoller *poller = 0) :
           Portal(id, tile, bufsize, cba, (void *)&LedControllerRequest_cbTable, poller) {
        pint.parent = static_cast<void *>(this);
    };
    LedControllerRequestWrapper(int id, PortalItemFunctions *item, void *param, PORTAL_INDFUNC cba = LedControllerRequest_handleMessage, int bufsize = LedControllerRequest_reqinfo, PortalPoller *poller=0):
           Portal(id, 0, bufsize, cba, (void *)&LedControllerRequest_cbTable, item, param, poller) {
        pint.parent = static_cast<void *>(this);
    };
    LedControllerRequestWrapper(int id, PortalPoller *poller) :
           Portal(id, 0, LedControllerRequest_reqinfo, LedControllerRequest_handleMessage, (void *)&LedControllerRequest_cbTable, poller) {
        pint.parent = static_cast<void *>(this);
    };
    LedControllerRequestWrapper(int id, PortalItemFunctions *item, void *param, PortalPoller *poller):
           Portal(id, 0, LedControllerRequest_reqinfo, LedControllerRequest_handleMessage, (void *)&LedControllerRequest_cbTable, item, param, poller) {
        pint.parent = static_cast<void *>(this);
    };
    virtual void setLeds ( const uint8_t v, const uint32_t duration ) = 0;
};
#endif // _LEDCONTROLLERREQUEST_H_
