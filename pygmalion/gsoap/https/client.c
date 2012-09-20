#include <stdio.h>
#include <stdlib.h>
#include "pmH.h"
//#include "pm.nsmap"
#include "PMBinding.nsmap"

/*
#include <stdio.h>

#include "pmH.h"
#include "pm.nsmap"

struct Namespace * namespaces;
*/
int main(int argc, char * argv[])
{

  if (argc<4) {
    printf("pygmalion-client URL taux nb\n");
    return 0;
  }
  struct soap v_soap;
  double val;
  double taux = atof(argv[2]);
  int nb      = atoi(argv[3]);
  
  //  printf("> %s \n", argv[4]);

  soap_ssl_init(); /* init OpenSSL (just once) */
  soap_init(&v_soap);
  if (soap_ssl_client_context(&v_soap,
			      SOAP_SSL_NO_AUTHENTICATION,
			      // SOAP_SSL_DEFAULT,
			      "client.pem", /* keyfile: required only when client must authenticate to server (see SSL docs on how to obtain this file) */
			      "password", /* password to read the key file */
			      "cacerts.pem", /* cacert file to store trusted certificates (needed to verify server) */    NULL, /* capath to direcoty with trusted certificates */
			      NULL /* if randfile!=NULL: use a file with random data to seed randomness */
			      ))
    {
      soap_print_fault(&v_soap, stderr);
      exit(1);
    }

  //  soap_set_namespaces (&v_soap, pm_namespaces);
  //  soap_call_pmns1__pmConnexion(&v_soap, argv[1], "urn:PygmalionAction", char *login, char *password, struct pmns1__pmConnexionResponse *_param_1);
  int rv = soap_call_pmns1__pmCalcul(&v_soap, argv[1], "urn:PygmalionAction", taux, nb, &val);
  if (v_soap.error)
    soap_print_fault(&v_soap, stderr);
  soap_end(&v_soap);
  
  printf(">> [%d] calcul(%f,%d) = %f\n", rv, taux, nb, val);
  
  return 0;
}
