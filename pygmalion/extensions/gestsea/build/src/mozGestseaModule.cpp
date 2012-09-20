#include "nsIGenericFactory.h"

#include "mozC00gestsea.h"
#include "mozC01step.h"
#include "mozC02gestsea.h"

NS_GENERIC_FACTORY_CONSTRUCTOR(mozC00gestsea)
NS_GENERIC_FACTORY_CONSTRUCTOR(mozC01step)
NS_GENERIC_FACTORY_CONSTRUCTOR(mozC02gestsea)

static const nsModuleComponentInfo components[] =
{
  { MOZ_C00GESTSEA_CLASSNAME,
    MOZ_C00GESTSEA_CID,
    MOZ_C00GESTSEA_CONTRACTID,
    mozC00gestseaConstructor },
  { MOZ_C01STEP_CLASSNAME,
    MOZ_C01STEP_CID,
    MOZ_C01STEP_CONTRACTID,
    mozC01stepConstructor },
  { MOZ_C02GESTSEA_CLASSNAME,
    MOZ_C02GESTSEA_CID,
    MOZ_C02GESTSEA_CONTRACTID,
    mozC02gestseaConstructor }
};

NS_IMPL_NSGETMODULE("mozGestseaModule", components)

