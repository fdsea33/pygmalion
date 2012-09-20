#include "mozC00gestsea.h"

NS_IMETHODIMP mozC00gestsea::Load(const nsAString & aKey)
{
  return NS_OK;

}

NS_IMETHODIMP mozC00gestsea::SetTransportURI(const nsAString & aTransportURI)
{
  mTransportURI = aTransportURI;
  return NS_OK;
}

NS_IMETHODIMP mozC00gestsea::GetTransportURI(nsAString & aTransportURI)
{
  aTransportURI = mTransportURI;
  return NS_OK;
}

NS_IMETHODIMP mozC00gestsea::Connect(const nsAString & aLogin, const nsAString & aPassword, const nsAString & aDatabase, nsAString & aKey)
{
  nsresult rv;
  nsISOAPParameter ** pParameters = NS_STATIC_CAST(nsISOAPParameter**, nsMemory::Alloc(3 * sizeof(nsISOAPParameter)));
  if (!pParameters) return NS_ERROR_OUT_OF_MEMORY;

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[0]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock0 = do_QueryInterface(pParameters[0], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock0->SetName(NS_LITERAL_STRING("login"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant0 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant0->SetAsAString(aLogin);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock0->SetValue(pVariant0);
  NS_ENSURE_SUCCESS(rv, rv);

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[1]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock1 = do_QueryInterface(pParameters[1], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock1->SetName(NS_LITERAL_STRING("password"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant1 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant1->SetAsAString(aPassword);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock1->SetValue(pVariant1);
  NS_ENSURE_SUCCESS(rv, rv);

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[2]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock2 = do_QueryInterface(pParameters[2], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock2->SetName(NS_LITERAL_STRING("database"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant2 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant2->SetAsAString(aDatabase);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock2->SetValue(pVariant2);
  NS_ENSURE_SUCCESS(rv, rv);

    printf("3");
  nsCOMPtr<nsISOAPCall> pSOAPCall = do_CreateInstance(NS_SOAPCALL_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsISOAPEncoding> pEncoding = do_CreateInstance(NS_SOAPENCODING_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  pSOAPCall->SetEncoding(pEncoding);

  rv = pSOAPCall->SetTransportURI(mTransportURI);
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pSOAPCall->Encode(nsISOAPMessage::VERSION_1_1, NS_LITERAL_STRING("Connect"), NS_LITERAL_STRING("urn:pygen1"), 0, 0, 3, pParameters);
  NS_ENSURE_SUCCESS(rv, rv);

    printf("4");
  /* Synchrone Call */
  nsCOMPtr<nsISOAPResponse> pSOAPResponse;
  rv = pSOAPCall->Invoke(getter_AddRefs(pSOAPResponse));
  NS_ENSURE_SUCCESS(rv, rv);

    printf("5");
  nsCOMPtr<nsISOAPFault> pSOAPFault;
  rv = pSOAPResponse->GetFault(getter_AddRefs(pSOAPFault));
  NS_ENSURE_SUCCESS(rv, rv);
  if (pSOAPFault) {
    nsAutoString pFaute, pDetail, pTitle;
    nsCOMPtr<nsIDOMElement> pTheDetail;
    nsCOMPtr<nsIDOMNode> pNode;
    rv = pSOAPFault->GetDetail(getter_AddRefs(pTheDetail));
    NS_ENSURE_SUCCESS(rv,rv);
    rv = pTheDetail->GetFirstChild(getter_AddRefs(pNode));
    NS_ENSURE_SUCCESS(rv,rv);
    if (pNode) {
      nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
      NS_ENSURE_SUCCESS(rv, rv);
      pSerializer->SerializeToString(pNode, pDetail);
    } else pDetail = NS_LITERAL_STRING("-");
    pFaute += pDetail;
    rv = pSOAPFault->GetFaultString(pTitle);
    NS_ENSURE_SUCCESS(rv,rv);
    nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pPrompt->Alert(nsnull, ToNewUnicode(pTitle), ToNewUnicode(pFaute));
    return NS_ERROR_FAILURE;
  }
  else {
    nsAutoString pMessage;
    nsCOMPtr<nsIDOMDocument> pMesg;
    pSOAPResponse->GetMessage(getter_AddRefs(pMesg));
    nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pSerializer->SerializeToString(pMesg, pMessage);
    printf("%s\n\n", ToNewCString(pMessage));
    nsISOAPParameter ** pResults;
    PRUint32 pTotal;
    rv = pSOAPResponse->GetParameters(PR_FALSE, &pTotal, &pResults);
    NS_ENSURE_SUCCESS(rv,rv);
    if (pTotal==1) {
      nsCOMPtr<nsIVariant> pValue;
      rv = pResults[0]->GetValue(getter_AddRefs(pValue));
      NS_ENSURE_SUCCESS(rv,rv);
      printf(".");
      rv = pValue->GetAsAString(aKey);
      NS_ENSURE_SUCCESS(rv,rv);
    } else { printf("ERROR"); }
  }
  return NS_OK;
}

NS_IMETHODIMP mozC00gestsea::Finish(const nsAString & aKey, PRUint32 * aResult)
{
  nsresult rv;
  nsISOAPParameter ** pParameters = NS_STATIC_CAST(nsISOAPParameter**, nsMemory::Alloc(1 * sizeof(nsISOAPParameter)));
  if (!pParameters) return NS_ERROR_OUT_OF_MEMORY;

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[0]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock0 = do_QueryInterface(pParameters[0], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock0->SetName(NS_LITERAL_STRING("key"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant0 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant0->SetAsAString(aKey);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock0->SetValue(pVariant0);
  NS_ENSURE_SUCCESS(rv, rv);

    printf("3");
  nsCOMPtr<nsISOAPCall> pSOAPCall = do_CreateInstance(NS_SOAPCALL_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsISOAPEncoding> pEncoding = do_CreateInstance(NS_SOAPENCODING_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  pSOAPCall->SetEncoding(pEncoding);

  rv = pSOAPCall->SetTransportURI(mTransportURI);
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pSOAPCall->Encode(nsISOAPMessage::VERSION_1_1, NS_LITERAL_STRING("Finish"), NS_LITERAL_STRING("urn:pygen1"), 0, 0, 1, pParameters);
  NS_ENSURE_SUCCESS(rv, rv);

    printf("4");
  /* Synchrone Call */
  nsCOMPtr<nsISOAPResponse> pSOAPResponse;
  rv = pSOAPCall->Invoke(getter_AddRefs(pSOAPResponse));
  NS_ENSURE_SUCCESS(rv, rv);

    printf("5");
  nsCOMPtr<nsISOAPFault> pSOAPFault;
  rv = pSOAPResponse->GetFault(getter_AddRefs(pSOAPFault));
  NS_ENSURE_SUCCESS(rv, rv);
  if (pSOAPFault) {
    nsAutoString pFaute, pDetail, pTitle;
    nsCOMPtr<nsIDOMElement> pTheDetail;
    nsCOMPtr<nsIDOMNode> pNode;
    rv = pSOAPFault->GetDetail(getter_AddRefs(pTheDetail));
    NS_ENSURE_SUCCESS(rv,rv);
    rv = pTheDetail->GetFirstChild(getter_AddRefs(pNode));
    NS_ENSURE_SUCCESS(rv,rv);
    if (pNode) {
      nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
      NS_ENSURE_SUCCESS(rv, rv);
      pSerializer->SerializeToString(pNode, pDetail);
    } else pDetail = NS_LITERAL_STRING("-");
    pFaute += pDetail;
    rv = pSOAPFault->GetFaultString(pTitle);
    NS_ENSURE_SUCCESS(rv,rv);
    nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pPrompt->Alert(nsnull, ToNewUnicode(pTitle), ToNewUnicode(pFaute));
    return NS_ERROR_FAILURE;
  }
  else {
    nsAutoString pMessage;
    nsCOMPtr<nsIDOMDocument> pMesg;
    pSOAPResponse->GetMessage(getter_AddRefs(pMesg));
    nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pSerializer->SerializeToString(pMesg, pMessage);
    printf("%s\n\n", ToNewCString(pMessage));
    nsISOAPParameter ** pResults;
    PRUint32 pTotal;
    rv = pSOAPResponse->GetParameters(PR_FALSE, &pTotal, &pResults);
    NS_ENSURE_SUCCESS(rv,rv);
    if (pTotal==1) {
      nsCOMPtr<nsIVariant> pValue;
      rv = pResults[0]->GetValue(getter_AddRefs(pValue));
      NS_ENSURE_SUCCESS(rv,rv);
      printf(".");
      rv = pValue->GetAsUint32(aResult);
      NS_ENSURE_SUCCESS(rv,rv);
    } else { printf("ERROR"); }
  }
  return NS_OK;
}

NS_IMETHODIMP mozC00gestsea::Setup(const nsAString & aKey, nsAString & aName, nsAString & aUuid, nsAString & aVersion, nsAString & aState, nsAString & aUserType)
{
  nsresult rv;
  nsISOAPParameter ** pParameters = NS_STATIC_CAST(nsISOAPParameter**, nsMemory::Alloc(1 * sizeof(nsISOAPParameter)));
  if (!pParameters) return NS_ERROR_OUT_OF_MEMORY;

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[0]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock0 = do_QueryInterface(pParameters[0], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock0->SetName(NS_LITERAL_STRING("key"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant0 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant0->SetAsAString(aKey);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock0->SetValue(pVariant0);
  NS_ENSURE_SUCCESS(rv, rv);

    printf("3");
  nsCOMPtr<nsISOAPCall> pSOAPCall = do_CreateInstance(NS_SOAPCALL_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsISOAPEncoding> pEncoding = do_CreateInstance(NS_SOAPENCODING_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  pSOAPCall->SetEncoding(pEncoding);

  rv = pSOAPCall->SetTransportURI(mTransportURI);
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pSOAPCall->Encode(nsISOAPMessage::VERSION_1_1, NS_LITERAL_STRING("Setup"), NS_LITERAL_STRING("urn:pygen1"), 0, 0, 1, pParameters);
  NS_ENSURE_SUCCESS(rv, rv);

    printf("4");
  /* Synchrone Call */
  nsCOMPtr<nsISOAPResponse> pSOAPResponse;
  rv = pSOAPCall->Invoke(getter_AddRefs(pSOAPResponse));
  NS_ENSURE_SUCCESS(rv, rv);

    printf("5");
  nsCOMPtr<nsISOAPFault> pSOAPFault;
  rv = pSOAPResponse->GetFault(getter_AddRefs(pSOAPFault));
  NS_ENSURE_SUCCESS(rv, rv);
  if (pSOAPFault) {
    nsAutoString pFaute, pDetail, pTitle;
    nsCOMPtr<nsIDOMElement> pTheDetail;
    nsCOMPtr<nsIDOMNode> pNode;
    rv = pSOAPFault->GetDetail(getter_AddRefs(pTheDetail));
    NS_ENSURE_SUCCESS(rv,rv);
    rv = pTheDetail->GetFirstChild(getter_AddRefs(pNode));
    NS_ENSURE_SUCCESS(rv,rv);
    if (pNode) {
      nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
      NS_ENSURE_SUCCESS(rv, rv);
      pSerializer->SerializeToString(pNode, pDetail);
    } else pDetail = NS_LITERAL_STRING("-");
    pFaute += pDetail;
    rv = pSOAPFault->GetFaultString(pTitle);
    NS_ENSURE_SUCCESS(rv,rv);
    nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pPrompt->Alert(nsnull, ToNewUnicode(pTitle), ToNewUnicode(pFaute));
    return NS_ERROR_FAILURE;
  }
  else {
    nsAutoString pMessage;
    nsCOMPtr<nsIDOMDocument> pMesg;
    pSOAPResponse->GetMessage(getter_AddRefs(pMesg));
    nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pSerializer->SerializeToString(pMesg, pMessage);
    printf("%s\n\n", ToNewCString(pMessage));
    nsISOAPParameter ** pResults;
    PRUint32 pTotal;
    rv = pSOAPResponse->GetParameters(PR_FALSE, &pTotal, &pResults);
    NS_ENSURE_SUCCESS(rv,rv);
    if (pTotal==5) {
      nsCOMPtr<nsIVariant> pValue;
      rv = pResults[0]->GetValue(getter_AddRefs(pValue));
      NS_ENSURE_SUCCESS(rv,rv);
      printf(".");
      rv = pValue->GetAsAString(aName);
      NS_ENSURE_SUCCESS(rv,rv);
      rv = pResults[1]->GetValue(getter_AddRefs(pValue));
      NS_ENSURE_SUCCESS(rv,rv);
      printf(".");
      rv = pValue->GetAsAString(aUuid);
      NS_ENSURE_SUCCESS(rv,rv);
      rv = pResults[2]->GetValue(getter_AddRefs(pValue));
      NS_ENSURE_SUCCESS(rv,rv);
      printf(".");
      rv = pValue->GetAsAString(aVersion);
      NS_ENSURE_SUCCESS(rv,rv);
      rv = pResults[3]->GetValue(getter_AddRefs(pValue));
      NS_ENSURE_SUCCESS(rv,rv);
      printf(".");
      rv = pValue->GetAsAString(aState);
      NS_ENSURE_SUCCESS(rv,rv);
      rv = pResults[4]->GetValue(getter_AddRefs(pValue));
      NS_ENSURE_SUCCESS(rv,rv);
      printf(".");
      rv = pValue->GetAsAString(aUserType);
      NS_ENSURE_SUCCESS(rv,rv);
    } else { printf("ERROR"); }
  }
  return NS_OK;
}

NS_IMETHODIMP mozC00gestsea::Prepare(const nsAString & aKey, const nsAString & aQuery, const nsAString & aName, PRUint32 aArity, PRUint32 * aResult)
{
  nsresult rv;
  nsISOAPParameter ** pParameters = NS_STATIC_CAST(nsISOAPParameter**, nsMemory::Alloc(4 * sizeof(nsISOAPParameter)));
  if (!pParameters) return NS_ERROR_OUT_OF_MEMORY;

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[0]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock0 = do_QueryInterface(pParameters[0], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock0->SetName(NS_LITERAL_STRING("key"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant0 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant0->SetAsAString(aKey);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock0->SetValue(pVariant0);
  NS_ENSURE_SUCCESS(rv, rv);

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[1]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock1 = do_QueryInterface(pParameters[1], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock1->SetName(NS_LITERAL_STRING("query"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant1 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant1->SetAsAString(aQuery);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock1->SetValue(pVariant1);
  NS_ENSURE_SUCCESS(rv, rv);

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[2]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock2 = do_QueryInterface(pParameters[2], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock2->SetName(NS_LITERAL_STRING("name"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant2 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant2->SetAsAString(aName);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock2->SetValue(pVariant2);
  NS_ENSURE_SUCCESS(rv, rv);

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[3]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock3 = do_QueryInterface(pParameters[3], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock3->SetName(NS_LITERAL_STRING("arity"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant3 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant3->SetAsUint32(aArity);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock3->SetValue(pVariant3);
  NS_ENSURE_SUCCESS(rv, rv);

    printf("3");
  nsCOMPtr<nsISOAPCall> pSOAPCall = do_CreateInstance(NS_SOAPCALL_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsISOAPEncoding> pEncoding = do_CreateInstance(NS_SOAPENCODING_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  pSOAPCall->SetEncoding(pEncoding);

  rv = pSOAPCall->SetTransportURI(mTransportURI);
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pSOAPCall->Encode(nsISOAPMessage::VERSION_1_1, NS_LITERAL_STRING("Prepare"), NS_LITERAL_STRING("urn:pygen1"), 0, 0, 4, pParameters);
  NS_ENSURE_SUCCESS(rv, rv);

    printf("4");
  /* Synchrone Call */
  nsCOMPtr<nsISOAPResponse> pSOAPResponse;
  rv = pSOAPCall->Invoke(getter_AddRefs(pSOAPResponse));
  NS_ENSURE_SUCCESS(rv, rv);

    printf("5");
  nsCOMPtr<nsISOAPFault> pSOAPFault;
  rv = pSOAPResponse->GetFault(getter_AddRefs(pSOAPFault));
  NS_ENSURE_SUCCESS(rv, rv);
  if (pSOAPFault) {
    nsAutoString pFaute, pDetail, pTitle;
    nsCOMPtr<nsIDOMElement> pTheDetail;
    nsCOMPtr<nsIDOMNode> pNode;
    rv = pSOAPFault->GetDetail(getter_AddRefs(pTheDetail));
    NS_ENSURE_SUCCESS(rv,rv);
    rv = pTheDetail->GetFirstChild(getter_AddRefs(pNode));
    NS_ENSURE_SUCCESS(rv,rv);
    if (pNode) {
      nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
      NS_ENSURE_SUCCESS(rv, rv);
      pSerializer->SerializeToString(pNode, pDetail);
    } else pDetail = NS_LITERAL_STRING("-");
    pFaute += pDetail;
    rv = pSOAPFault->GetFaultString(pTitle);
    NS_ENSURE_SUCCESS(rv,rv);
    nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pPrompt->Alert(nsnull, ToNewUnicode(pTitle), ToNewUnicode(pFaute));
    return NS_ERROR_FAILURE;
  }
  else {
    nsAutoString pMessage;
    nsCOMPtr<nsIDOMDocument> pMesg;
    pSOAPResponse->GetMessage(getter_AddRefs(pMesg));
    nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pSerializer->SerializeToString(pMesg, pMessage);
    printf("%s\n\n", ToNewCString(pMessage));
    nsISOAPParameter ** pResults;
    PRUint32 pTotal;
    rv = pSOAPResponse->GetParameters(PR_FALSE, &pTotal, &pResults);
    NS_ENSURE_SUCCESS(rv,rv);
    if (pTotal==1) {
      nsCOMPtr<nsIVariant> pValue;
      rv = pResults[0]->GetValue(getter_AddRefs(pValue));
      NS_ENSURE_SUCCESS(rv,rv);
      printf(".");
      rv = pValue->GetAsUint32(aResult);
      NS_ENSURE_SUCCESS(rv,rv);
    } else { printf("ERROR"); }
  }
  return NS_OK;
}

NS_IMETHODIMP mozC00gestsea::PrepareList(const nsAString & aKey, nsIDOMElement * aQueries, PRUint32 * aResult)
{
  nsresult rv;
  nsISOAPParameter ** pParameters = NS_STATIC_CAST(nsISOAPParameter**, nsMemory::Alloc(2 * sizeof(nsISOAPParameter)));
  if (!pParameters) return NS_ERROR_OUT_OF_MEMORY;

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[0]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock0 = do_QueryInterface(pParameters[0], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock0->SetName(NS_LITERAL_STRING("key"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant0 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant0->SetAsAString(aKey);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock0->SetValue(pVariant0);
  NS_ENSURE_SUCCESS(rv, rv);

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[1]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock1 = do_QueryInterface(pParameters[1], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock1->SetName(NS_LITERAL_STRING("queries"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock1->SetElement(aQueries);
    printf("*");
  NS_ENSURE_SUCCESS(rv, rv);
    printf("3");
  nsCOMPtr<nsISOAPCall> pSOAPCall = do_CreateInstance(NS_SOAPCALL_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsISOAPEncoding> pEncoding = do_CreateInstance(NS_SOAPENCODING_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  pSOAPCall->SetEncoding(pEncoding);

  rv = pSOAPCall->SetTransportURI(mTransportURI);
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pSOAPCall->Encode(nsISOAPMessage::VERSION_1_1, NS_LITERAL_STRING("PrepareList"), NS_LITERAL_STRING("urn:pygen1"), 0, 0, 2, pParameters);
  NS_ENSURE_SUCCESS(rv, rv);

    printf("4");
  /* Synchrone Call */
  nsCOMPtr<nsISOAPResponse> pSOAPResponse;
  rv = pSOAPCall->Invoke(getter_AddRefs(pSOAPResponse));
  NS_ENSURE_SUCCESS(rv, rv);

    printf("5");
  nsCOMPtr<nsISOAPFault> pSOAPFault;
  rv = pSOAPResponse->GetFault(getter_AddRefs(pSOAPFault));
  NS_ENSURE_SUCCESS(rv, rv);
  if (pSOAPFault) {
    nsAutoString pFaute, pDetail, pTitle;
    nsCOMPtr<nsIDOMElement> pTheDetail;
    nsCOMPtr<nsIDOMNode> pNode;
    rv = pSOAPFault->GetDetail(getter_AddRefs(pTheDetail));
    NS_ENSURE_SUCCESS(rv,rv);
    rv = pTheDetail->GetFirstChild(getter_AddRefs(pNode));
    NS_ENSURE_SUCCESS(rv,rv);
    if (pNode) {
      nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
      NS_ENSURE_SUCCESS(rv, rv);
      pSerializer->SerializeToString(pNode, pDetail);
    } else pDetail = NS_LITERAL_STRING("-");
    pFaute += pDetail;
    rv = pSOAPFault->GetFaultString(pTitle);
    NS_ENSURE_SUCCESS(rv,rv);
    nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pPrompt->Alert(nsnull, ToNewUnicode(pTitle), ToNewUnicode(pFaute));
    return NS_ERROR_FAILURE;
  }
  else {
    nsAutoString pMessage;
    nsCOMPtr<nsIDOMDocument> pMesg;
    pSOAPResponse->GetMessage(getter_AddRefs(pMesg));
    nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pSerializer->SerializeToString(pMesg, pMessage);
    printf("%s\n\n", ToNewCString(pMessage));
    nsISOAPParameter ** pResults;
    PRUint32 pTotal;
    rv = pSOAPResponse->GetParameters(PR_FALSE, &pTotal, &pResults);
    NS_ENSURE_SUCCESS(rv,rv);
    if (pTotal==1) {
      nsCOMPtr<nsIVariant> pValue;
      rv = pResults[0]->GetValue(getter_AddRefs(pValue));
      NS_ENSURE_SUCCESS(rv,rv);
      printf(".");
      rv = pValue->GetAsUint32(aResult);
      NS_ENSURE_SUCCESS(rv,rv);
    } else { printf("ERROR"); }
  }
  return NS_OK;
}

NS_IMETHODIMP mozC00gestsea::ExecPreparedSelect(const nsAString & aKey, const nsAString & aName, nsIDOMElement * aParams, nsIDOMElement ** aResult)
{
  nsresult rv;
  nsISOAPParameter ** pParameters = NS_STATIC_CAST(nsISOAPParameter**, nsMemory::Alloc(3 * sizeof(nsISOAPParameter)));
  if (!pParameters) return NS_ERROR_OUT_OF_MEMORY;

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[0]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock0 = do_QueryInterface(pParameters[0], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock0->SetName(NS_LITERAL_STRING("key"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant0 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant0->SetAsAString(aKey);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock0->SetValue(pVariant0);
  NS_ENSURE_SUCCESS(rv, rv);

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[1]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock1 = do_QueryInterface(pParameters[1], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock1->SetName(NS_LITERAL_STRING("name"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant1 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant1->SetAsAString(aName);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock1->SetValue(pVariant1);
  NS_ENSURE_SUCCESS(rv, rv);

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[2]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock2 = do_QueryInterface(pParameters[2], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock2->SetName(NS_LITERAL_STRING("params"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock2->SetElement(aParams);
    printf("*");
  NS_ENSURE_SUCCESS(rv, rv);
    printf("3");
  nsCOMPtr<nsISOAPCall> pSOAPCall = do_CreateInstance(NS_SOAPCALL_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsISOAPEncoding> pEncoding = do_CreateInstance(NS_SOAPENCODING_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  pSOAPCall->SetEncoding(pEncoding);

  rv = pSOAPCall->SetTransportURI(mTransportURI);
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pSOAPCall->Encode(nsISOAPMessage::VERSION_1_1, NS_LITERAL_STRING("ExecPreparedSelect"), NS_LITERAL_STRING("urn:pygen1"), 0, 0, 3, pParameters);
  NS_ENSURE_SUCCESS(rv, rv);

    printf("4");
  /* Synchrone Call */
  nsCOMPtr<nsISOAPResponse> pSOAPResponse;
  rv = pSOAPCall->Invoke(getter_AddRefs(pSOAPResponse));
  NS_ENSURE_SUCCESS(rv, rv);

    printf("5");
  nsCOMPtr<nsISOAPFault> pSOAPFault;
  rv = pSOAPResponse->GetFault(getter_AddRefs(pSOAPFault));
  NS_ENSURE_SUCCESS(rv, rv);
  if (pSOAPFault) {
    nsAutoString pFaute, pDetail, pTitle;
    nsCOMPtr<nsIDOMElement> pTheDetail;
    nsCOMPtr<nsIDOMNode> pNode;
    rv = pSOAPFault->GetDetail(getter_AddRefs(pTheDetail));
    NS_ENSURE_SUCCESS(rv,rv);
    rv = pTheDetail->GetFirstChild(getter_AddRefs(pNode));
    NS_ENSURE_SUCCESS(rv,rv);
    if (pNode) {
      nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
      NS_ENSURE_SUCCESS(rv, rv);
      pSerializer->SerializeToString(pNode, pDetail);
    } else pDetail = NS_LITERAL_STRING("-");
    pFaute += pDetail;
    rv = pSOAPFault->GetFaultString(pTitle);
    NS_ENSURE_SUCCESS(rv,rv);
    nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pPrompt->Alert(nsnull, ToNewUnicode(pTitle), ToNewUnicode(pFaute));
    return NS_ERROR_FAILURE;
  }
  else {
    nsAutoString pMessage;
    nsCOMPtr<nsIDOMDocument> pMesg;
    pSOAPResponse->GetMessage(getter_AddRefs(pMesg));
    nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pSerializer->SerializeToString(pMesg, pMessage);
    printf("%s\n\n", ToNewCString(pMessage));
    nsISOAPParameter ** pResults;
    PRUint32 pTotal;
    rv = pSOAPResponse->GetParameters(PR_FALSE, &pTotal, &pResults);
    NS_ENSURE_SUCCESS(rv,rv);
    if (pTotal==1) {
      nsCOMPtr<nsIVariant> pValue;
      rv = pResults[0]->GetElement(aResult);
      NS_ENSURE_SUCCESS(rv,rv);
    } else { printf("ERROR"); }
  }
  return NS_OK;
}

NS_IMETHODIMP mozC00gestsea::ExecPreparedUpdate(const nsAString & aKey, const nsAString & aName, nsIDOMElement * aParams, nsAString & aResult)
{
  nsresult rv;
  nsISOAPParameter ** pParameters = NS_STATIC_CAST(nsISOAPParameter**, nsMemory::Alloc(3 * sizeof(nsISOAPParameter)));
  if (!pParameters) return NS_ERROR_OUT_OF_MEMORY;

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[0]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock0 = do_QueryInterface(pParameters[0], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock0->SetName(NS_LITERAL_STRING("key"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant0 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant0->SetAsAString(aKey);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock0->SetValue(pVariant0);
  NS_ENSURE_SUCCESS(rv, rv);

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[1]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock1 = do_QueryInterface(pParameters[1], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock1->SetName(NS_LITERAL_STRING("name"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant1 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant1->SetAsAString(aName);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock1->SetValue(pVariant1);
  NS_ENSURE_SUCCESS(rv, rv);

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[2]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock2 = do_QueryInterface(pParameters[2], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock2->SetName(NS_LITERAL_STRING("params"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock2->SetElement(aParams);
    printf("*");
  NS_ENSURE_SUCCESS(rv, rv);
    printf("3");
  nsCOMPtr<nsISOAPCall> pSOAPCall = do_CreateInstance(NS_SOAPCALL_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsISOAPEncoding> pEncoding = do_CreateInstance(NS_SOAPENCODING_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  pSOAPCall->SetEncoding(pEncoding);

  rv = pSOAPCall->SetTransportURI(mTransportURI);
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pSOAPCall->Encode(nsISOAPMessage::VERSION_1_1, NS_LITERAL_STRING("ExecPreparedUpdate"), NS_LITERAL_STRING("urn:pygen1"), 0, 0, 3, pParameters);
  NS_ENSURE_SUCCESS(rv, rv);

    printf("4");
  /* Synchrone Call */
  nsCOMPtr<nsISOAPResponse> pSOAPResponse;
  rv = pSOAPCall->Invoke(getter_AddRefs(pSOAPResponse));
  NS_ENSURE_SUCCESS(rv, rv);

    printf("5");
  nsCOMPtr<nsISOAPFault> pSOAPFault;
  rv = pSOAPResponse->GetFault(getter_AddRefs(pSOAPFault));
  NS_ENSURE_SUCCESS(rv, rv);
  if (pSOAPFault) {
    nsAutoString pFaute, pDetail, pTitle;
    nsCOMPtr<nsIDOMElement> pTheDetail;
    nsCOMPtr<nsIDOMNode> pNode;
    rv = pSOAPFault->GetDetail(getter_AddRefs(pTheDetail));
    NS_ENSURE_SUCCESS(rv,rv);
    rv = pTheDetail->GetFirstChild(getter_AddRefs(pNode));
    NS_ENSURE_SUCCESS(rv,rv);
    if (pNode) {
      nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
      NS_ENSURE_SUCCESS(rv, rv);
      pSerializer->SerializeToString(pNode, pDetail);
    } else pDetail = NS_LITERAL_STRING("-");
    pFaute += pDetail;
    rv = pSOAPFault->GetFaultString(pTitle);
    NS_ENSURE_SUCCESS(rv,rv);
    nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pPrompt->Alert(nsnull, ToNewUnicode(pTitle), ToNewUnicode(pFaute));
    return NS_ERROR_FAILURE;
  }
  else {
    nsAutoString pMessage;
    nsCOMPtr<nsIDOMDocument> pMesg;
    pSOAPResponse->GetMessage(getter_AddRefs(pMesg));
    nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pSerializer->SerializeToString(pMesg, pMessage);
    printf("%s\n\n", ToNewCString(pMessage));
    nsISOAPParameter ** pResults;
    PRUint32 pTotal;
    rv = pSOAPResponse->GetParameters(PR_FALSE, &pTotal, &pResults);
    NS_ENSURE_SUCCESS(rv,rv);
    if (pTotal==1) {
      nsCOMPtr<nsIVariant> pValue;
      rv = pResults[0]->GetValue(getter_AddRefs(pValue));
      NS_ENSURE_SUCCESS(rv,rv);
      printf(".");
      rv = pValue->GetAsAString(aResult);
      NS_ENSURE_SUCCESS(rv,rv);
    } else { printf("ERROR"); }
  }
  return NS_OK;
}

NS_IMETHODIMP mozC00gestsea::ExecSelect(const nsAString & aKey, const nsAString & aQuery, nsIDOMElement * aParams, nsIDOMElement ** aResult)
{
  nsresult rv;
  nsISOAPParameter ** pParameters = NS_STATIC_CAST(nsISOAPParameter**, nsMemory::Alloc(3 * sizeof(nsISOAPParameter)));
  if (!pParameters) return NS_ERROR_OUT_OF_MEMORY;

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[0]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock0 = do_QueryInterface(pParameters[0], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock0->SetName(NS_LITERAL_STRING("key"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant0 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant0->SetAsAString(aKey);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock0->SetValue(pVariant0);
  NS_ENSURE_SUCCESS(rv, rv);

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[1]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock1 = do_QueryInterface(pParameters[1], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock1->SetName(NS_LITERAL_STRING("query"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant1 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant1->SetAsAString(aQuery);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock1->SetValue(pVariant1);
  NS_ENSURE_SUCCESS(rv, rv);

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[2]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock2 = do_QueryInterface(pParameters[2], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock2->SetName(NS_LITERAL_STRING("params"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock2->SetElement(aParams);
    printf("*");
  NS_ENSURE_SUCCESS(rv, rv);
    printf("3");
  nsCOMPtr<nsISOAPCall> pSOAPCall = do_CreateInstance(NS_SOAPCALL_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsISOAPEncoding> pEncoding = do_CreateInstance(NS_SOAPENCODING_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  pSOAPCall->SetEncoding(pEncoding);

  rv = pSOAPCall->SetTransportURI(mTransportURI);
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pSOAPCall->Encode(nsISOAPMessage::VERSION_1_1, NS_LITERAL_STRING("ExecSelect"), NS_LITERAL_STRING("urn:pygen1"), 0, 0, 3, pParameters);
  NS_ENSURE_SUCCESS(rv, rv);

    printf("4");
  /* Synchrone Call */
  nsCOMPtr<nsISOAPResponse> pSOAPResponse;
  rv = pSOAPCall->Invoke(getter_AddRefs(pSOAPResponse));
  NS_ENSURE_SUCCESS(rv, rv);

    printf("5");
  nsCOMPtr<nsISOAPFault> pSOAPFault;
  rv = pSOAPResponse->GetFault(getter_AddRefs(pSOAPFault));
  NS_ENSURE_SUCCESS(rv, rv);
  if (pSOAPFault) {
    nsAutoString pFaute, pDetail, pTitle;
    nsCOMPtr<nsIDOMElement> pTheDetail;
    nsCOMPtr<nsIDOMNode> pNode;
    rv = pSOAPFault->GetDetail(getter_AddRefs(pTheDetail));
    NS_ENSURE_SUCCESS(rv,rv);
    rv = pTheDetail->GetFirstChild(getter_AddRefs(pNode));
    NS_ENSURE_SUCCESS(rv,rv);
    if (pNode) {
      nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
      NS_ENSURE_SUCCESS(rv, rv);
      pSerializer->SerializeToString(pNode, pDetail);
    } else pDetail = NS_LITERAL_STRING("-");
    pFaute += pDetail;
    rv = pSOAPFault->GetFaultString(pTitle);
    NS_ENSURE_SUCCESS(rv,rv);
    nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pPrompt->Alert(nsnull, ToNewUnicode(pTitle), ToNewUnicode(pFaute));
    return NS_ERROR_FAILURE;
  }
  else {
    nsAutoString pMessage;
    nsCOMPtr<nsIDOMDocument> pMesg;
    pSOAPResponse->GetMessage(getter_AddRefs(pMesg));
    nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pSerializer->SerializeToString(pMesg, pMessage);
    printf("%s\n\n", ToNewCString(pMessage));
    nsISOAPParameter ** pResults;
    PRUint32 pTotal;
    rv = pSOAPResponse->GetParameters(PR_FALSE, &pTotal, &pResults);
    NS_ENSURE_SUCCESS(rv,rv);
    if (pTotal==1) {
      nsCOMPtr<nsIVariant> pValue;
      rv = pResults[0]->GetElement(aResult);
      NS_ENSURE_SUCCESS(rv,rv);
    } else { printf("ERROR"); }
  }
  return NS_OK;
}

NS_IMETHODIMP mozC00gestsea::ExecUpdate(const nsAString & aKey, const nsAString & aQuery, nsIDOMElement * aParams, nsAString & aResult)
{
  nsresult rv;
  nsISOAPParameter ** pParameters = NS_STATIC_CAST(nsISOAPParameter**, nsMemory::Alloc(3 * sizeof(nsISOAPParameter)));
  if (!pParameters) return NS_ERROR_OUT_OF_MEMORY;

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[0]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock0 = do_QueryInterface(pParameters[0], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock0->SetName(NS_LITERAL_STRING("key"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant0 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant0->SetAsAString(aKey);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock0->SetValue(pVariant0);
  NS_ENSURE_SUCCESS(rv, rv);

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[1]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock1 = do_QueryInterface(pParameters[1], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock1->SetName(NS_LITERAL_STRING("query"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant1 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant1->SetAsAString(aQuery);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock1->SetValue(pVariant1);
  NS_ENSURE_SUCCESS(rv, rv);

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[2]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock2 = do_QueryInterface(pParameters[2], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock2->SetName(NS_LITERAL_STRING("params"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock2->SetElement(aParams);
    printf("*");
  NS_ENSURE_SUCCESS(rv, rv);
    printf("3");
  nsCOMPtr<nsISOAPCall> pSOAPCall = do_CreateInstance(NS_SOAPCALL_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsISOAPEncoding> pEncoding = do_CreateInstance(NS_SOAPENCODING_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  pSOAPCall->SetEncoding(pEncoding);

  rv = pSOAPCall->SetTransportURI(mTransportURI);
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pSOAPCall->Encode(nsISOAPMessage::VERSION_1_1, NS_LITERAL_STRING("ExecUpdate"), NS_LITERAL_STRING("urn:pygen1"), 0, 0, 3, pParameters);
  NS_ENSURE_SUCCESS(rv, rv);

    printf("4");
  /* Synchrone Call */
  nsCOMPtr<nsISOAPResponse> pSOAPResponse;
  rv = pSOAPCall->Invoke(getter_AddRefs(pSOAPResponse));
  NS_ENSURE_SUCCESS(rv, rv);

    printf("5");
  nsCOMPtr<nsISOAPFault> pSOAPFault;
  rv = pSOAPResponse->GetFault(getter_AddRefs(pSOAPFault));
  NS_ENSURE_SUCCESS(rv, rv);
  if (pSOAPFault) {
    nsAutoString pFaute, pDetail, pTitle;
    nsCOMPtr<nsIDOMElement> pTheDetail;
    nsCOMPtr<nsIDOMNode> pNode;
    rv = pSOAPFault->GetDetail(getter_AddRefs(pTheDetail));
    NS_ENSURE_SUCCESS(rv,rv);
    rv = pTheDetail->GetFirstChild(getter_AddRefs(pNode));
    NS_ENSURE_SUCCESS(rv,rv);
    if (pNode) {
      nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
      NS_ENSURE_SUCCESS(rv, rv);
      pSerializer->SerializeToString(pNode, pDetail);
    } else pDetail = NS_LITERAL_STRING("-");
    pFaute += pDetail;
    rv = pSOAPFault->GetFaultString(pTitle);
    NS_ENSURE_SUCCESS(rv,rv);
    nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pPrompt->Alert(nsnull, ToNewUnicode(pTitle), ToNewUnicode(pFaute));
    return NS_ERROR_FAILURE;
  }
  else {
    nsAutoString pMessage;
    nsCOMPtr<nsIDOMDocument> pMesg;
    pSOAPResponse->GetMessage(getter_AddRefs(pMesg));
    nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pSerializer->SerializeToString(pMesg, pMessage);
    printf("%s\n\n", ToNewCString(pMessage));
    nsISOAPParameter ** pResults;
    PRUint32 pTotal;
    rv = pSOAPResponse->GetParameters(PR_FALSE, &pTotal, &pResults);
    NS_ENSURE_SUCCESS(rv,rv);
    if (pTotal==1) {
      nsCOMPtr<nsIVariant> pValue;
      rv = pResults[0]->GetValue(getter_AddRefs(pValue));
      NS_ENSURE_SUCCESS(rv,rv);
      printf(".");
      rv = pValue->GetAsAString(aResult);
      NS_ENSURE_SUCCESS(rv,rv);
    } else { printf("ERROR"); }
  }
  return NS_OK;
}

NS_IMETHODIMP mozC00gestsea::Init(const nsAString & aKey, const nsAString & aDatabase, PRBool aForce, PRUint32 * aResult)
{
  nsresult rv;
  nsISOAPParameter ** pParameters = NS_STATIC_CAST(nsISOAPParameter**, nsMemory::Alloc(3 * sizeof(nsISOAPParameter)));
  if (!pParameters) return NS_ERROR_OUT_OF_MEMORY;

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[0]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock0 = do_QueryInterface(pParameters[0], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock0->SetName(NS_LITERAL_STRING("key"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant0 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant0->SetAsAString(aKey);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock0->SetValue(pVariant0);
  NS_ENSURE_SUCCESS(rv, rv);

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[1]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock1 = do_QueryInterface(pParameters[1], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock1->SetName(NS_LITERAL_STRING("database"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant1 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant1->SetAsAString(aDatabase);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock1->SetValue(pVariant1);
  NS_ENSURE_SUCCESS(rv, rv);

  rv = CallCreateInstance(NS_SOAPPARAMETER_CONTRACTID, &pParameters[2]);
  if (NS_FAILED(rv)) {
    printf("0");
    NS_FREE_XPCOM_ISUPPORTS_POINTER_ARRAY(0, pParameters);
    return rv;
  }
  nsCOMPtr<nsISOAPBlock> pRequestBlock2 = do_QueryInterface(pParameters[2], &rv);
    printf("1");
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pRequestBlock2->SetName(NS_LITERAL_STRING("force"));
    printf("2");
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsIWritableVariant> pVariant2 = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv); 
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pVariant2->SetAsBool(aForce);
  NS_ENSURE_SUCCESS(rv, rv);
  rv =  pRequestBlock2->SetValue(pVariant2);
  NS_ENSURE_SUCCESS(rv, rv);

    printf("3");
  nsCOMPtr<nsISOAPCall> pSOAPCall = do_CreateInstance(NS_SOAPCALL_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  nsCOMPtr<nsISOAPEncoding> pEncoding = do_CreateInstance(NS_SOAPENCODING_CONTRACTID, &rv);
  NS_ENSURE_SUCCESS(rv, rv);
  pSOAPCall->SetEncoding(pEncoding);

  rv = pSOAPCall->SetTransportURI(mTransportURI);
  NS_ENSURE_SUCCESS(rv, rv);
  rv = pSOAPCall->Encode(nsISOAPMessage::VERSION_1_1, NS_LITERAL_STRING("Init"), NS_LITERAL_STRING("urn:pygen1"), 0, 0, 3, pParameters);
  NS_ENSURE_SUCCESS(rv, rv);

    printf("4");
  /* Synchrone Call */
  nsCOMPtr<nsISOAPResponse> pSOAPResponse;
  rv = pSOAPCall->Invoke(getter_AddRefs(pSOAPResponse));
  NS_ENSURE_SUCCESS(rv, rv);

    printf("5");
  nsCOMPtr<nsISOAPFault> pSOAPFault;
  rv = pSOAPResponse->GetFault(getter_AddRefs(pSOAPFault));
  NS_ENSURE_SUCCESS(rv, rv);
  if (pSOAPFault) {
    nsAutoString pFaute, pDetail, pTitle;
    nsCOMPtr<nsIDOMElement> pTheDetail;
    nsCOMPtr<nsIDOMNode> pNode;
    rv = pSOAPFault->GetDetail(getter_AddRefs(pTheDetail));
    NS_ENSURE_SUCCESS(rv,rv);
    rv = pTheDetail->GetFirstChild(getter_AddRefs(pNode));
    NS_ENSURE_SUCCESS(rv,rv);
    if (pNode) {
      nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
      NS_ENSURE_SUCCESS(rv, rv);
      pSerializer->SerializeToString(pNode, pDetail);
    } else pDetail = NS_LITERAL_STRING("-");
    pFaute += pDetail;
    rv = pSOAPFault->GetFaultString(pTitle);
    NS_ENSURE_SUCCESS(rv,rv);
    nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pPrompt->Alert(nsnull, ToNewUnicode(pTitle), ToNewUnicode(pFaute));
    return NS_ERROR_FAILURE;
  }
  else {
    nsAutoString pMessage;
    nsCOMPtr<nsIDOMDocument> pMesg;
    pSOAPResponse->GetMessage(getter_AddRefs(pMesg));
    nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);
    NS_ENSURE_SUCCESS(rv, rv);
    pSerializer->SerializeToString(pMesg, pMessage);
    printf("%s\n\n", ToNewCString(pMessage));
    nsISOAPParameter ** pResults;
    PRUint32 pTotal;
    rv = pSOAPResponse->GetParameters(PR_FALSE, &pTotal, &pResults);
    NS_ENSURE_SUCCESS(rv,rv);
    if (pTotal==1) {
      nsCOMPtr<nsIVariant> pValue;
      rv = pResults[0]->GetValue(getter_AddRefs(pValue));
      NS_ENSURE_SUCCESS(rv,rv);
      printf(".");
      rv = pValue->GetAsUint32(aResult);
      NS_ENSURE_SUCCESS(rv,rv);
    } else { printf("ERROR"); }
  }
  return NS_OK;
}

