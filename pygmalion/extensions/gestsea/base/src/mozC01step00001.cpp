#include "mozC01step.h"

NS_IMETHODIMP mozC01step::Get(nsAString & aMasterIndex, PRUint32 * aIndex,nsAString & aDetailKey)
{
  
  aMasterIndex  = mMasterIndex;
  *aIndex       = mIndex;
  aDetailKey    = mDetailKey;
  return NS_OK;
}

NS_IMETHODIMP mozC01step::Set(const nsAString & aMasterIndex, PRUint32 aIndex,const nsAString & aDetailKey)
{
  
  mMasterIndex = aMasterIndex;
  mIndex       = aIndex;
  mDetailKey   = aDetailKey;
  return NS_OK;
}

