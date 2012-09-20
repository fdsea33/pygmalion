#include <stdio.h>

#include "pmH.h"
#include "pm.nsmap"

struct Namespace * namespaces;

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

  soap_init(&v_soap);
  soap_set_namespaces (&v_soap, pm_namespaces);
  //  soap_call_pmns1__pmConnexion(&v_soap, argv[1], "urn:PygmalionAction", char *login, char *password, struct pmns1__pmConnexionResponse *_param_1);
  int rv = soap_call_pmns1__pmCalcul(&v_soap, argv[1], "urn:PygmalionAction", taux, nb, &val);
  if (v_soap.error)
    soap_print_fault(&v_soap, stderr);
  soap_end(&v_soap);

  printf(">> [%d] calcul(%f,%d) = %f\n",rv, taux, nb, val);

  return 0;
}
