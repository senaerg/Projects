#include "GeneratedTypes.h"

#ifndef NO_CPP_PORTAL_CODE

/************** Start of LedControllerRequestWrapper CPP ***********/
#include "LedControllerRequest.h"
int LedControllerRequestsetLeds_cb (  struct PortalInternal *p, const uint8_t v, const uint32_t duration ) {
    (static_cast<LedControllerRequestWrapper *>(p->parent))->setLeds ( v, duration);
};
LedControllerRequestCb LedControllerRequest_cbTable = {
    LedControllerRequestsetLeds_cb,
};
#endif //NO_CPP_PORTAL_CODE
